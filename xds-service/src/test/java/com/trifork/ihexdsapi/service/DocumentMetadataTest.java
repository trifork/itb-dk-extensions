package com.trifork.ihexdsapi.service;

import static org.junit.jupiter.api.Assertions.*;

import java.nio.charset.StandardCharsets;
import org.junit.jupiter.api.Test;

public class DocumentMetadataTest {
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
        var cda = DocumentMetadata.parse(bytes(HEADER));
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
                DocumentMetadata.parse(
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
                assertThrows(IllegalArgumentException.class, () -> DocumentMetadata.parse(content));
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
        assertThrows(IllegalArgumentException.class, () -> DocumentMetadata.parse(null));
        assertThrows(IllegalArgumentException.class, () -> DocumentMetadata.parse(new byte[0]));
        var tooBig = new byte[DocumentMetadata.MAX_BYTES + 1];
        assertThrows(IllegalArgumentException.class, () -> DocumentMetadata.parse(tooBig));
    }

    @Test
    void recognisesCdasIncludingBrokenOnesButNotOtherFiles() {
        assertTrue(DocumentMetadata.looksLikeCda(bytes(HEADER)));
        assertTrue(
                DocumentMetadata.looksLikeCda(bytes("<ClinicalDocument xmlns=\"urn:hl7-org:v3\"")));
        assertFalse(
                DocumentMetadata.looksLikeCda(
                        bytes(
                                "<html><body>ClinicalDocument</body></html>x"
                                        .replace("<html>", "text <html>"))));
        assertFalse(DocumentMetadata.looksLikeCda(bytes("%PDF-1.7")));
        assertFalse(DocumentMetadata.looksLikeCda(bytes("{\"resourceType\":\"Patient\"}")));
        assertFalse(DocumentMetadata.looksLikeCda(new byte[0]));
        assertFalse(DocumentMetadata.looksLikeCda(null));
    }

    @Test
    void describesAFileFromWhatTheUploaderSupplies() {
        var content = bytes("hello");
        var file =
                DocumentMetadata.forFile(
                        content,
                        "0103660140",
                        " Scan ",
                        " application/pdf ",
                        "74468-0",
                        "1.2.3",
                        "QFDD");
        assertEquals("0103660140", file.patientId());
        assertEquals("Scan", file.title());
        assertEquals("application/pdf", file.mimeType());
        assertEquals("N", file.confidentialityCode());
        assertEquals("da-DK", file.languageCode());
        assertTrue(file.uniqueId().startsWith("2.25."));
        assertNotEquals(
                file.uniqueId(),
                DocumentMetadata.forFile(content, "0103660140", "", "text/plain", "c", "1.2", "")
                        .uniqueId());
        assertEquals(
                "Uploaded document",
                DocumentMetadata.forFile(
                                content, "0103660140", null, "text/plain", "c", "1.2", null)
                        .title());
        assertEquals("text/xml", DocumentMetadata.parse(bytes(HEADER)).mimeType());
        // A file always gets an author, because registries expect one: the default or the given
        // name.
        assertEquals("ITB upload test", file.authorFamilyName());
        var named =
                DocumentMetadata.forFile(
                        content, "0103660140", "", "text/plain", "c", "1.2", "", " Jens ");
        assertEquals("Jens", named.authorFamilyName());
        var longAuthor = "x".repeat(300);
        assertThrows(
                IllegalArgumentException.class,
                () ->
                        DocumentMetadata.forFile(
                                content,
                                "0103660140",
                                "",
                                "text/plain",
                                "c",
                                "1.2",
                                "",
                                longAuthor));
    }

    @Test
    void refusesAnIncompleteFileDescription() {
        var content = bytes("hello");
        var tooBig = new byte[DocumentMetadata.MAX_BYTES + 1];
        for (var bad :
                java.util.List.<Runnable>of(
                        () ->
                                DocumentMetadata.forFile(
                                        new byte[0], "0103660140", "", "text/plain", "c", "1", ""),
                        () ->
                                DocumentMetadata.forFile(
                                        tooBig, "0103660140", "", "text/plain", "c", "1", ""),
                        () ->
                                DocumentMetadata.forFile(
                                        content, "123", "", "text/plain", "c", "1", ""),
                        () ->
                                DocumentMetadata.forFile(
                                        content, null, "", "text/plain", "c", "1", ""),
                        () ->
                                DocumentMetadata.forFile(
                                        content, "0103660140", "", "plain", "c", "1", ""),
                        () ->
                                DocumentMetadata.forFile(
                                        content, "0103660140", "", null, "c", "1", ""),
                        () ->
                                DocumentMetadata.forFile(
                                        content, "0103660140", "", "text/plain", "", "1", ""),
                        () ->
                                DocumentMetadata.forFile(
                                        content, "0103660140", "", "text/plain", "c", null, ""),
                        () ->
                                DocumentMetadata.forFile(
                                        content,
                                        "0103660140",
                                        "x".repeat(300),
                                        "text/plain",
                                        "c",
                                        "1",
                                        "")))
            assertThrows(IllegalArgumentException.class, bad::run);
    }
}
