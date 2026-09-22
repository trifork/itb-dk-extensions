package com.trifork.itb.plugin;

import java.io.ByteArrayInputStream;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamReader;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 * Port of the hardcoded PHMR-DK checks from KvalitetsIT/cda-validator's {@code
 * PHMRDKSpecificEngine} ({@code RuleConfPhmrDk1} and {@code RuleConfPhmrDk4and5}), reimplemented
 * with DOM/StAX instead of MDHT to keep the plugin lightweight. Messages and rule identifiers are
 * kept identical to the original.
 */
final class PhmrDkRules {

    private static final String HL7_NS = "urn:hl7-org:v3";
    private static final String SSN_ROOT_ID = "1.2.208.176.1.2";
    private static final String INVALID_SSN_MESSAGE =
            "Social security number conforms to neither social security replacement number or social security number";

    // Factories are hoisted out of the per-validation path: newInstance() runs a
    // ServiceLoader scan each call, which the plugin's isolated classloader cannot cache.
    private static final XMLInputFactory XML_INPUT_FACTORY = createXmlInputFactory();
    private static final DocumentBuilderFactory DOCUMENT_BUILDER_FACTORY =
            createDocumentBuilderFactory();

    private PhmrDkRules() {}

    private static XMLInputFactory createXmlInputFactory() {
        XMLInputFactory factory = XMLInputFactory.newInstance();
        factory.setProperty(XMLInputFactory.SUPPORT_DTD, false);
        return factory;
    }

    private static DocumentBuilderFactory createDocumentBuilderFactory() {
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);
            factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);
            return factory;
        } catch (Exception e) {
            throw new IllegalStateException("Unable to configure DocumentBuilderFactory", e);
        }
    }

    static List<Finding> validate(byte[] documentBytes) {
        List<Finding> findings = new ArrayList<>();
        checkEncoding(documentBytes, findings);
        checkPatientIds(documentBytes, findings);
        return findings;
    }

    /** CONF-PHMR-DK-1: the encoding of a PHM report SHALL be UTF-8. */
    private static void checkEncoding(byte[] documentBytes, List<Finding> findings) {
        boolean utf8 = false;
        try {
            XMLStreamReader reader =
                    XML_INPUT_FACTORY.createXMLStreamReader(
                            new ByteArrayInputStream(documentBytes));
            String detected = reader.getEncoding();
            String declared = reader.getCharacterEncodingScheme();
            utf8 = "UTF-8".equals(declared) && (detected == null || "UTF-8".equals(detected));
            reader.close();
        } catch (Exception _) {
            // Fall through to the error below, as the original rule does.
        }
        if (!utf8) {
            findings.add(
                    new Finding(
                            Finding.Level.ERROR,
                            "The encoding of a PHM report SHALL be a UTF-8",
                            null,
                            "CONF-PHMR-DK-1"));
        }
    }

    /** CONF-PHMR-DK-4/5: patient id presence and Danish CPR number format checks. */
    private static void checkPatientIds(byte[] documentBytes, List<Finding> findings) {
        Document doc;
        try {
            doc =
                    DOCUMENT_BUILDER_FACTORY
                            .newDocumentBuilder()
                            .parse(new ByteArrayInputStream(documentBytes));
        } catch (Exception _) {
            findings.add(new Finding(Finding.Level.ERROR, "Internal error", null, "Custom schema"));
            return;
        }
        NodeList recordTargets = doc.getElementsByTagNameNS(HL7_NS, "recordTarget");
        for (int i = 0; i < recordTargets.getLength(); i++) {
            Element patientRole = childElement((Element) recordTargets.item(i), "patientRole");
            if (patientRole == null) {
                continue;
            }
            checkPatientRole(patientRole, findings);
        }
    }

    private static void checkPatientRole(Element patientRole, List<Finding> findings) {
        List<Element> ids = childElements(patientRole, "id");
        if (ids.isEmpty()) {
            findings.add(
                    new Finding(
                            Finding.Level.ERROR,
                            "The ID element shall be present",
                            null,
                            "CONF-PHMR-DK-5"));
        }
        for (Element id : ids) {
            if (!SSN_ROOT_ID.equals(id.getAttribute("root"))) {
                continue;
            }
            String authority =
                    id.hasAttribute("assigningAuthorityName")
                            ? id.getAttribute("assigningAuthorityName")
                            : null;
            if (!"CPR".equals(authority)) {
                findings.add(
                        new Finding(
                                Finding.Level.WARNING,
                                "ID with valid root "
                                        + SSN_ROOT_ID
                                        + " has AssigningAuthorityName "
                                        + authority
                                        + " that differs from CPR.",
                                null,
                                "CONF-PHMR-DK-5"));
            }
            checkCprNumber(id.getAttribute("extension"), findings);
        }
    }

    private static void checkCprNumber(String ssn, List<Finding> findings) {
        if (ssn != null && ssn.length() == 10 && ssn.chars().allMatch(Character::isDigit)) {
            int date = Integer.parseInt(ssn.substring(0, 2));
            int month = Integer.parseInt(ssn.substring(2, 4));
            // As in the original rule: adding 1900 is better than nothing.
            int year = Integer.parseInt(ssn.substring(4, 6)) + 1900;
            // Replacement CPR number detection (day offset by 60).
            if (date > 60 && date < 92) {
                date -= 60;
                if (Integer.parseInt(ssn.substring(6, 10)) > 5999) {
                    findings.add(
                            new Finding(
                                    Finding.Level.ERROR,
                                    "Replacement Social security serial number is out of range and does not conform to the scheme specified @ "
                                            + "https://cpr.dk/cpr-systemet/erstatningspersonnummer-i-eksterne-systemer/",
                                    null,
                                    "CONF-PHMR-DK-4/CONF-PHMR-DK-5"));
                }
            }
            try {
                if (!YearMonth.of(year, month).isValidDay(date)) addInvalidSsnFinding(findings);
            } catch (Exception _) {
                addInvalidSsnFinding(findings);
            }
        } else {
            addInvalidSsnFinding(findings);
        }
    }

    private static void addInvalidSsnFinding(List<Finding> findings) {
        findings.add(
                new Finding(
                        Finding.Level.ERROR,
                        INVALID_SSN_MESSAGE,
                        null,
                        "CONF-PHMR-DK-4/CONF-PHMR-DK-5"));
    }

    private static Element childElement(Element parent, String localName) {
        List<Element> children = childElements(parent, localName);
        return children.isEmpty() ? null : children.get(0);
    }

    private static List<Element> childElements(Element parent, String localName) {
        List<Element> result = new ArrayList<>();
        for (Node n = parent.getFirstChild(); n != null; n = n.getNextSibling()) {
            if (n.getNodeType() == Node.ELEMENT_NODE
                    && HL7_NS.equals(n.getNamespaceURI())
                    && localName.equals(n.getLocalName())) {
                result.add((Element) n);
            }
        }
        return result;
    }
}
