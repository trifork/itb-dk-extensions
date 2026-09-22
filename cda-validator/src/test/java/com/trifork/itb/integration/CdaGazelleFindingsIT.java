package com.trifork.itb.integration;

import static com.trifork.itb.integration.ValidatorClient.*;
import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

class CdaGazelleFindingsIT {
    private static final String HL7 = "urn:hl7-org:v3";
    private static final String RULE = "ccdav21-VitalSignsOrganizerV3-ccdav211617";
    private static final String CCDA_DOCUMENT_TYPE_RULE =
            "ccdav21-CCDAV21ClinicalDocumentSpec-ccdav215689";

    @ParameterizedTest
    @CsvSource({
        "phmr.v1.3, samples/phmr/phmr_v1_3_weight.xml",
        "phmr.v2.1.0, samples/phmr/phmr_example01.xml"
    })
    void reportsCcdav21ErrorsOnlyWhileConstraintIsViolated(String target, String sample)
            throws Exception {
        Document document = document(sample);
        Element organizer = node(document, "//c:organizer");
        Element template = document.createElementNS(HL7, "templateId");
        template.setAttribute("root", "2.16.840.1.113883.10.20.22.4.26");
        organizer.insertBefore(template, organizer.getFirstChild());
        for (Element id : nodes(organizer, "c:id")) organizer.removeChild(id);

        // C-CDA 2.1 Vital Signs Organizer V3, CONF:1198-7282: at least one id.
        Document report = validate(bytes(document), target);
        assertEquals("FAILURE", summary(report).get("result"));
        assertTrue(
                ruleFindings(report, CCDA_DOCUMENT_TYPE_RULE).isEmpty(),
                "PHMR does not require a C-CDA document template");
        List<Element> matches = ruleFindings(report, RULE);
        assertEquals(1, matches.size(), "The Gazelle error must survive the TAR mapping");
        assertEquals("error", matches.getFirst().getLocalName());
        assertTrue(text(matches.getFirst(), "description").contains("/organizer"));

        Element id = document.createElementNS(HL7, "id");
        id.setAttribute("root", "1.2.3.4");
        organizer.insertBefore(id, node(organizer, "c:statusCode"));
        assertTrue(
                ruleFindings(validate(bytes(document), target), RULE).isEmpty(),
                "The satisfied constraint must not be reported as an error");
    }

    @ParameterizedTest
    @CsvSource({
        "phmr.v1.3, samples/phmr/phmr_v1_3_weight.xml",
        "phmr.v2.1.0, samples/phmr/phmr_example01.xml"
    })
    void stillRequiresPhmrDocumentTemplate(String target, String sample) throws Exception {
        Document document = document(sample);
        for (Element template :
                nodes(document, "/c:ClinicalDocument/c:templateId[@root='1.2.208.184.11.1']")) {
            template.getParentNode().removeChild(template);
        }
        requireRule(bytes(document), target, "CDA-DK-PROFILE-TEMPLATE");
    }

    private static List<Element> ruleFindings(Document report, String rule) throws Exception {
        List<Element> matches = new java.util.ArrayList<>();
        for (Element finding : findings(report)) {
            if (rule.equals(text(finding, "assertionID"))) matches.add(finding);
        }
        return matches;
    }
}
