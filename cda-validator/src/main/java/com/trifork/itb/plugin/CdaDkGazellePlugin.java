package com.trifork.itb.plugin;

import com.gitb.core.AnyContent;
import com.gitb.core.ValidationModule;
import com.gitb.tr.BAR;
import com.gitb.tr.ObjectFactory;
import com.gitb.tr.TAR;
import com.gitb.tr.TestAssertionGroupReportsType;
import com.gitb.tr.TestResultType;
import com.gitb.tr.ValidationCounters;
import com.gitb.vs.GetModuleDefinitionResponse;
import com.gitb.vs.ValidateRequest;
import com.gitb.vs.ValidationResponse;
import com.gitb.vs.ValidationService;
import com.gitb.vs.Void;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;
import net.ihe.gazelle.validation.DetailedResult;
import net.ihe.gazelle.validation.Notification;
import net.ihe.gazelle.validation.XSDMessage;

/**
 * ITB validator plugin that reproduces the Gazelle-based validation of MedCom's CDA validator
 * (https://cda.medcom.dk / KvalitetsIT/cda-validator):
 *
 * <p>- every validation type is checked with the Gazelle ObjectsChecker "CDA basic" engine
 * (net.ihe.gazelle.cdabasic.validator:cdabasicapp-validator-jar:1.0.0), except - "phmr", which uses
 * the ccdav21 ObjectsChecker (net.ihe.gazelle:ccdav21-validator-jar:0.0.2) plus the hardcoded
 * PHMR-DK rules from PHMRDKSpecificEngine (see {@link PhmrDkRules}).
 *
 * <p>The engine/type mapping follows dk.medcom.cda.CDAServlet and
 * dk.medcom.cda.validation.validationengine.IHEObjectsCheckerEngine. Result severity comes from
 * Gazelle notification types, preserving the historical UUID-rule exception.
 */
public class CdaDkGazellePlugin implements ValidationService {

    private static final String ERROR = "ERROR";
    private static final String INPUT_CONTENT_TO_VALIDATE = "contentToValidate";
    private static final String INPUT_VALIDATION_TYPE = "validationType";

    /** Same special case as IHEObjectsCheckerEngine: this II rule is reported as a note. */
    private static final String II_SPEC_RULE = "cdadt-IISpec-cdadt011";

    // PHMR-DK 1.3 sections 2.2–2.3 and 2.1.0 section 2.1 require PHMR document
    // templates. The reused C-CDA engine's document-type whitelist is inapplicable;
    // release Schematrons enforce PHMR membership. All template-specific checks remain.
    private static final String CCDA_DOCUMENT_TYPE_RULE =
            "ccdav21-CCDAV21ClinicalDocumentSpec-ccdav215689";

    // Hoisted out of the per-validation path: newInstance() runs a ServiceLoader scan each
    // call, which the plugin's isolated classloader cannot cache. DatatypeFactory is thread-safe.
    private static final DatatypeFactory DATATYPE_FACTORY = createDatatypeFactory();

    private final ObjectFactory objectFactory = new ObjectFactory();

    private static DatatypeFactory createDatatypeFactory() {
        try {
            return DatatypeFactory.newInstance();
        } catch (DatatypeConfigurationException e) {
            throw new IllegalStateException("Unable to construct date factory", e);
        }
    }

    @Override
    public GetModuleDefinitionResponse getModuleDefinition(Void aVoid) {
        GetModuleDefinitionResponse response = new GetModuleDefinitionResponse();
        response.setModule(new ValidationModule());
        response.getModule().setId("CdaDkGazellePlugin");
        return response;
    }

    @Override
    public ValidationResponse validate(ValidateRequest request) {
        // The validator loads plugins in an isolated classloader (parent = null). The Gazelle
        // and JAXB code resolves factories (Saxon XPath, JAXBContext) through the thread
        // context classloader, so point it at the plugin's own classloader while validating.
        ClassLoader previousContextClassLoader = Thread.currentThread().getContextClassLoader();
        Thread.currentThread().setContextClassLoader(getClass().getClassLoader());
        try {
            return doValidate(request);
        } finally {
            Thread.currentThread().setContextClassLoader(previousContextClassLoader);
        }
    }

    private ValidationResponse doValidate(ValidateRequest request) {
        String inputFilePath = requiredInput(request, INPUT_CONTENT_TO_VALIDATE);
        String validationType = requiredInput(request, INPUT_VALIDATION_TYPE);
        List<Finding> findings = new ArrayList<>();
        ValidationProfile profile;
        try {
            profile = ValidationProfile.resolve(validationType);
        } catch (IllegalArgumentException e) {
            findings.add(
                    new Finding(
                            Finding.Level.ERROR,
                            e.getMessage(),
                            null,
                            "CDA-DK-UNSUPPORTED-RULESET"));
            ValidationResponse response = new ValidationResponse();
            response.setReport(toTAR(findings));
            return response;
        }
        findings.add(
                new Finding(
                        Finding.Level.INFO,
                        "Validation target: "
                                + profile.label
                                + " ("
                                + profile.fullType
                                + "). Coverage is partial: shared CDA checks plus release-specific Schematron; see coverage documentation."
                                + " See the ruleset catalogue for sources and remaining coverage work.",
                        null,
                        "CDA-DK-RULESET"));
        try {
            byte[] documentBytes = Files.readAllBytes(Path.of(inputFilePath));
            String document = new String(documentBytes, java.nio.charset.StandardCharsets.UTF_8);
            DetailedResult result;
            if (profile.usesPhmrEngine) {
                result =
                        net.ihe.gazelle.assembler.ccdav21.MicroDocumentValidationWrapper.validate(
                                document, GazelleResources.pathsFor(profile));
                findings.addAll(PhmrDkRules.validate(documentBytes));
            } else {
                result =
                        net.ihe.gazelle.cdabasic.validator.MicroDocumentValidationWrapper.validate(
                                document, GazelleResources.pathsFor(profile));
            }
            collectXsdMessages(result, findings);
            collectMdaFindings(result, profile, findings);
        } catch (Exception e) {
            // Mirrors IHEObjectsCheckerEngine's catch-all behaviour.
            findings.add(
                    new Finding(
                            Finding.Level.ERROR,
                            "Internal IHE Validation error: " + rootMessage(e),
                            null,
                            "Internal IHE Validation error"));
        }
        ValidationResponse response = new ValidationResponse();
        response.setReport(toTAR(findings));
        return response;
    }

    /** XSD and well-formedness messages reported by the Gazelle engine. */
    private void collectXsdMessages(DetailedResult result, List<Finding> findings) {
        if (result == null) {
            return;
        }
        if (result.getDocumentValidXSD() != null) {
            addXsdMessages(
                    result.getDocumentValidXSD().getXSDMessage(),
                    "Gazelle CDA document check",
                    findings);
        }
        if (result.getDocumentWellFormed() != null) {
            addXsdMessages(
                    result.getDocumentWellFormed().getXSDMessage(),
                    "Gazelle CDA schema violation",
                    findings);
        }
    }

    private void addXsdMessages(
            List<XSDMessage> messages, String category, List<Finding> findings) {
        if (messages == null) {
            return;
        }
        for (XSDMessage message : messages) {
            Finding.Level level = null;
            if ("error".equalsIgnoreCase(message.getSeverity())) level = Finding.Level.ERROR;
            else if ("warning".equalsIgnoreCase(message.getSeverity()))
                level = Finding.Level.WARNING;
            if (level != null) {
                String location = message.getLineNumber() + ":" + message.getColumnNumber();
                findings.add(new Finding(level, message.getMessage(), location, category));
            }
        }
    }

    /** Model-based findings use typed severity; C-CDA descriptions have no severity prefix. */
    static void collectMdaFindings(
            DetailedResult result, ValidationProfile profile, List<Finding> findings) {
        if (result == null || result.getMDAValidation() == null) {
            return;
        }
        for (Object item : result.getMDAValidation().getWarningOrErrorOrNote()) {
            if (item instanceof Notification notification) {
                collectMdaFinding(notification, profile, findings);
            }
        }
    }

    private static void collectMdaFinding(
            Notification notification, ValidationProfile profile, List<Finding> findings) {
        String identifier = notification.getIdentifiant();
        if (profile.usesPhmrEngine && CCDA_DOCUMENT_TYPE_RULE.equals(identifier)) {
            return;
        }
        String description =
                notification.getDescription() == null ? "" : notification.getDescription();
        String location = notification.getLocation();
        String text =
                location == null || location.isBlank()
                        ? description
                        : description + " [at " + location + "]";
        if (notification instanceof net.ihe.gazelle.validation.Error
                && II_SPEC_RULE.equalsIgnoreCase(identifier)) {
            findings.add(
                    new Finding(Finding.Level.INFO, text.replace(ERROR, "Note"), null, identifier));
        } else if (notification instanceof net.ihe.gazelle.validation.Error) {
            findings.add(new Finding(Finding.Level.ERROR, text, null, identifier));
        } else if (notification instanceof net.ihe.gazelle.validation.Warning) {
            findings.add(new Finding(Finding.Level.WARNING, text, null, identifier));
        }
        // Other notifications (notes/reports) are ignored, as in the original engine.
    }

    private String requiredInput(ValidateRequest request, String name) {
        return request.getInput().stream()
                .filter(input -> name.equals(input.getName()))
                .findFirst()
                .orElseThrow(
                        () -> new IllegalArgumentException("The [" + name + "] input is required"))
                .getValue();
    }

    private static String rootMessage(Throwable t) {
        Throwable root = com.google.common.base.Throwables.getRootCause(t);
        return root.getMessage() == null ? root.getClass().getSimpleName() : root.getMessage();
    }

    private TAR toTAR(List<Finding> findings) {
        TAR report = new TAR();
        report.setDate(now());
        report.setCounters(new ValidationCounters());
        report.setReports(new TestAssertionGroupReportsType());
        report.setContext(new AnyContent());
        long errors = 0;
        long warnings = 0;
        long infos = 0;
        for (Finding finding : findings) {
            BAR item = new BAR();
            item.setDescription(finding.description);
            item.setAssertionID(finding.assertionId);
            if (finding.lineLocation != null) {
                item.setLocation(INPUT_CONTENT_TO_VALIDATE + ":" + finding.lineLocation);
            }
            switch (finding.level) {
                case ERROR:
                    errors++;
                    report.getReports()
                            .getInfoOrWarningOrError()
                            .add(objectFactory.createTestAssertionGroupReportsTypeError(item));
                    break;
                case WARNING:
                    warnings++;
                    report.getReports()
                            .getInfoOrWarningOrError()
                            .add(objectFactory.createTestAssertionGroupReportsTypeWarning(item));
                    break;
                case INFO:
                    infos++;
                    report.getReports()
                            .getInfoOrWarningOrError()
                            .add(objectFactory.createTestAssertionGroupReportsTypeInfo(item));
                    break;
            }
        }
        TestResultType result = TestResultType.SUCCESS;
        if (errors > 0) result = TestResultType.FAILURE;
        else if (warnings > 0) result = TestResultType.WARNING;
        report.setResult(result);
        report.getCounters().setNrOfErrors(BigInteger.valueOf(errors));
        report.getCounters().setNrOfWarnings(BigInteger.valueOf(warnings));
        report.getCounters().setNrOfAssertions(BigInteger.valueOf(infos));
        return report;
    }

    private XMLGregorianCalendar now() {
        return DATATYPE_FACTORY.newXMLGregorianCalendar(Instant.now().toString());
    }
}
