package com.trifork.ihexdsapi.service;

import static org.junit.jupiter.api.Assertions.*;

import java.nio.charset.StandardCharsets;
import org.junit.jupiter.api.Test;

public class CdaMetadataTest {
    public static final String HEADER =
            """
            <?xml version="1.0" encoding="UTF-8"?>
            <ClinicalDocument xmlns="urn:hl7-org:v3">
              <id root="1.2.3.4.5" extension="abc"/>
              <code code="74468-0" codeSystem="2.16.840.1.113883.6.1" displayName="QFDD"/>
              <title> Form </title>
              <effectiveTime value="20250513120000+0200"/>
              <confidentialityCode code="R" codeSystem="2.16.840.1.113883.5.25"/>
              <languageCode code="en-US"/>
              <recordTarget><patientRole>
                <id root="9.9.9" extension="1111111111"/>
                <id root="1.2.208.176.1.2" extension="0103660140"/>
              </patientRole></recordTarget>
              <author><assignedAuthor><assignedPerson><name><given>Anne</given><family>Test</family></name></assignedPerson></assignedAuthor></author>
            </ClinicalDocument>""";

    private static byte[] bytes(String xml) {
        return xml.getBytes(StandardCharsets.UTF_8);
    }

    @Test
    void readsEverythingTheHeaderStates() {
        var cda = CdaMetadata.parse(bytes(HEADER));
        assertEquals("1.2.3.4.5^abc", cda.uniqueId());
        assertEquals("0103660140", cda.patientId());
        assertEquals("Form", cda.title());
        assertEquals("74468-0", cda.typeCode());
        assertEquals("2.16.840.1.113883.6.1", cda.typeScheme());
        assertEquals("QFDD", cda.typeDisplayName());
        assertEquals("R", cda.confidentialityCode());
        assertEquals("en-US", cda.languageCode());
        assertEquals("20250513120000+0200", cda.creationTime());
        assertEquals("Test", cda.authorFamilyName());
        assertEquals("Anne", cda.authorGivenName());
    }

    @Test
    void appliesDanishDefaultsAndUsesTheRootAloneWithoutAnExtension() {
        var cda =
                CdaMetadata.parse(
                        bytes(
                                """
                <ClinicalDocument xmlns="urn:hl7-org:v3">
                  <id root="1.2.3"/>
                  <code code="53576-5" codeSystem="2.16.840.1.113883.6.1"/>
                  <confidentialityCode nullFlavor="NI"/>
                  <recordTarget><patientRole><id root="1.2.208.176.1.2" extension="0103660140"/></patientRole></recordTarget>
                </ClinicalDocument>"""));
        assertEquals("1.2.3", cda.uniqueId());
        assertEquals("N", cda.confidentialityCode());
        assertEquals("2.16.840.1.113883.5.25", cda.confidentialityScheme());
        assertEquals("da-DK", cda.languageCode());
        assertEquals("", cda.title());
        assertEquals("", cda.creationTime());
        assertEquals("", cda.authorFamilyName());
        assertEquals("", cda.typeDisplayName());
    }

    private static void rejected(String xml, String reason) {
        var content = bytes(xml);
        var failure =
                assertThrows(IllegalArgumentException.class, () -> CdaMetadata.parse(content));
        assertTrue(failure.getMessage().contains(reason), failure.getMessage());
        // A rejection never repeats document content.
        assertFalse(failure.getMessage().contains("0103660140"));
    }

    @Test
    void rejectsDocumentsThatCannotBeSubmittedWithoutEchoingContent() {
        rejected("<html/>", "not well-formed CDA");
        rejected("<ClinicalDocument/>", "not well-formed CDA");
        rejected("<ClinicalDocument xmlns=\"urn:hl7-org:v3\"", "not well-formed CDA");
        rejected(
                "<!DOCTYPE a [<!ENTITY e SYSTEM \"file:///etc/passwd\">]><ClinicalDocument xmlns=\"urn:hl7-org:v3\"/>",
                "not well-formed CDA");
        rejected(
                HEADER.replace("<id root=\"1.2.3.4.5\" extension=\"abc\"/>", ""), "no document id");
        rejected(
                HEADER.replace("extension=\"abc\"", "extension=\"" + "x".repeat(130) + "\""),
                "longer than 128");
        rejected(
                HEADER.replace("extension=\"0103660140\"", "extension=\"12345\""),
                "no ten-digit CPR");
        rejected(
                HEADER.replace(" codeSystem=\"2.16.840.1.113883.6.1\"", ""),
                "no document type code");
        rejected(
                HEADER.replace("<recordTarget>", "<recordTarget x=\"0103660140\">")
                        .replace("<patientRole>", "<other>")
                        .replace("</patientRole>", "</other>"),
                "no ten-digit CPR");
        assertThrows(IllegalArgumentException.class, () -> CdaMetadata.parse(null));
        assertThrows(IllegalArgumentException.class, () -> CdaMetadata.parse(new byte[0]));
        var tooBig = new byte[CdaMetadata.MAX_BYTES + 1];
        assertThrows(IllegalArgumentException.class, () -> CdaMetadata.parse(tooBig));
    }
}
