package com.trifork.itb.preview;

import static org.junit.jupiter.api.Assertions.*;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.HexFormat;
import javax.xml.transform.TransformerException;
import org.jsoup.Jsoup;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

class CdaRendererTest {
    private static CdaRenderer renderer;

    @BeforeAll
    static void setup() throws Exception {
        renderer = new CdaRenderer();
    }

    @Test
    void stylesheetResolverRejectsEveryOtherResource() {
        for (String uri :
                new String[] {"file:///etc/passwd", "https://example.com/a.xml", "other.xsl", ""}) {
            assertThrows(
                    TransformerException.class,
                    () -> renderer.resolveStylesheet(uri, "untrusted-base"));
        }
    }

    /**
     * Provenance of the bundled display stylesheet: MedCom publishes the HL7 SDWG "CDA R2
     * StyleSheet" 4.0.2 beta 2 at https://svn.medcom.dk/svn/drafts/Standarder/HL7/CDA-Stylesheet/
     * HL7_CDA/. Update the hashes only together with a reviewed upstream change.
     */
    @Test
    void bundledStylesheetFilesAreThePinnedUpstreamFiles() throws Exception {
        assertEquals(
                "d2c9857f44408513761475c54545ec08218518a207985d418dc03e23cf9cada5",
                sha256("/rendering/HL7_CDA_stylesheet.xsl"));
        assertEquals(
                "6a8328dc6f62bdf9aa806ac2ee86694b8b4ef2b73119f2fc0213e0a30e254f37",
                sha256("/rendering/cda_l10n.xml"));
    }

    @Test
    void stylesheetResolverServesOnlyTheStylesheetAndItsLabelFile() throws Exception {
        assertNotNull(renderer.resolveStylesheet("cda_l10n.xml", CdaRenderer.STYLESHEET_URI));
        assertNotNull(renderer.resolveStylesheet("", CdaRenderer.STYLESHEET_URI));
        // A label file reference is only honoured relative to the bundled stylesheet.
        assertThrows(
                TransformerException.class,
                () -> renderer.resolveStylesheet("cda_l10n.xml", "untrusted-base"));
        assertThrows(
                TransformerException.class,
                () -> renderer.resolveStylesheet("../cda_l10n.xml", CdaRenderer.STYLESHEET_URI));
    }

    @Test
    void rendersAQuestionnaireResponseWithItsQuestionsAndAnswers() throws Exception {
        byte[] qrd;
        try (var input = getClass().getResourceAsStream("/pair/qrd_overekstremitet.xml")) {
            qrd = input.readAllBytes();
        }
        var html = Jsoup.parse(renderer.render(qrd));
        assertTrue(html.text().contains("Besvarelse: Spørgeskema overekstremitet"));
        assertTrue(
                html.text().contains("Hvor svært har du haft ved at tage et par bukser på"),
                "The questions of the narrative must be displayed");
        assertTrue(html.select("script,iframe,object,embed,form,a[href]").isEmpty());
    }

    @Test
    void displaysNarrativeWithoutRequiringAValidProfile() throws Exception {
        var html = Jsoup.parse(renderer.render(xml("<paragraph>Blodtryk: æøå</paragraph>")));
        assertTrue(html.text().contains("Blodtryk: æøå"));
        assertTrue(html.text().contains("Home measurements"));
        assertEquals(CdaRenderer.POLICY, html.selectFirst("meta[http-equiv]").attr("content"));
    }

    @Test
    void rendersTableAttributesUsingTheStylesheetsOwnAllowlist() throws Exception {
        var html =
                Jsoup.parse(
                        renderer.render(
                                xml(
                                        """
                <table border="1" width="100%"><tbody><tr><td colspan="2">Table narrative</td></tr></tbody></table>
                """)));
        var cell = html.selectFirst("td[colspan=2]");
        assertNotNull(cell);
        assertEquals("Table narrative", cell.text());
    }

    @Test
    void removesActiveContentAndExternalNavigation() throws Exception {
        var html =
                Jsoup.parse(
                        renderer.render(
                                xml(
                                        """
                <paragraph><linkHtml href="https://example.com/secret">link</linkHtml></paragraph>
                <script>alert('bad')</script><iframe src="https://example.com"/>
                """)));
        assertTrue(html.select("script,iframe,object,embed,form,a[href]").isEmpty());
    }

    @Test
    void rejectsDoctypeAndExternalEntities() {
        byte[] input =
                ("<!DOCTYPE ClinicalDocument [<!ENTITY secret SYSTEM 'file:///etc/passwd'>]>"
                                + "<ClinicalDocument xmlns='urn:hl7-org:v3'><title>&secret;</title></ClinicalDocument>")
                        .getBytes(StandardCharsets.UTF_8);
        assertThrows(Exception.class, () -> renderer.render(input));
    }

    @Test
    void rejectsMalformedAndNonCdaXml() {
        for (String input :
                new String[] {"<", "<ClinicalDocument/>", "<other xmlns='urn:hl7-org:v3'/>"}) {
            assertThrows(
                    Exception.class, () -> renderer.render(input.getBytes(StandardCharsets.UTF_8)));
        }
    }

    private static String sha256(String resource) throws Exception {
        try (var input = CdaRendererTest.class.getResourceAsStream(resource)) {
            assertNotNull(input, resource);
            return HexFormat.of()
                    .formatHex(MessageDigest.getInstance("SHA-256").digest(input.readAllBytes()));
        }
    }

    private static byte[] xml(String narrative) {
        return ("""
                <ClinicalDocument xmlns="urn:hl7-org:v3">
                  <title>Home measurements</title>
                  <component><structuredBody><component><section><title>Results</title><text>
                """
                        + narrative
                        + "</text></section></component></structuredBody></component></ClinicalDocument>")
                .getBytes(StandardCharsets.UTF_8);
    }
}
