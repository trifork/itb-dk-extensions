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

    private static String resource(String path) throws Exception {
        try (var input = CdaRendererTest.class.getResourceAsStream(path)) {
            assertNotNull(input, path);
            return new String(input.readAllBytes(), StandardCharsets.UTF_8);
        }
    }

    /** The narrative is removed, so everything shown must come from the structured entries. */
    private static byte[] withoutNarrative(String xml) {
        return xml.replaceAll("(?s)<text>.*?</text>", "").getBytes(StandardCharsets.UTF_8);
    }

    @Test
    void listsTheAnswersOfAResponseFromItsEntries() throws Exception {
        var html =
                Jsoup.parse(
                        renderer.render(
                                withoutNarrative(resource("/pair/qrd_overekstremitet.xml"))));
        assertFalse(html.select("table.qv-table").isEmpty());
        String text = html.text();
        assertTrue(text.contains("Q00001"), "the question code");
        assertTrue(text.contains("Hvor svært har du haft ved at tage et par bukser på"));
        assertTrue(text.contains("Moderat svært (A00001_3)"), "the chosen answer");
        assertTrue(text.contains("6069bddf-b6ae-4e64-833e-ad2ba8b5c6b2"), "the QFDD reference");
        assertTrue(text.contains("options: at least 0, at most 1"), "the copied limits");
    }

    @Test
    void listsTheQuestionsOfAFormDefinitionFromItsEntries() throws Exception {
        var html =
                Jsoup.parse(
                        renderer.render(
                                withoutNarrative(
                                        resource(
                                                "/qfdd-embedded/6069bddf-b6ae-4e64-833e-ad2ba8b5c6b2.xml"))));
        String text = html.text();
        assertTrue(text.contains("Q00001"));
        assertTrue(text.contains("Umuligt at gøre (A00001_1)"), "an option of the question");
        assertTrue(text.contains("multiple choice"));
        assertTrue(text.contains("always"), "a question without preconditions");
    }

    @Test
    void showsWhichPreconditionsDecideWhetherAQuestionIsAsked() throws Exception {
        var html =
                Jsoup.parse(
                        renderer.render(
                                withoutNarrative(
                                        resource(
                                                "/qfdd-embedded/2c8f8bd7-059d-410d-aed9-afe37ce389ed.xml"))));
        assertTrue(html.text().contains("Q311 = A311_3"), html.text());
    }

    @Test
    void aDocumentThatIsNotAQuestionnaireGetsNoQuestionnaireView() throws Exception {
        var html = Jsoup.parse(renderer.render(xml("<paragraph>Plain narrative</paragraph>")));
        assertTrue(html.select(".qv").isEmpty());
    }

    @Test
    void questionnaireTextIsNeverRenderedAsMarkup() throws Exception {
        String hostile =
                resource("/pair/qrd_overekstremitet.xml")
                        .replace(
                                "<originalText>Hvor svært",
                                "<originalText>&lt;script&gt;alert(1)&lt;/script&gt;"
                                        + "&lt;img src=x onerror=alert(2)&gt;Hvor svært");
        var html = Jsoup.parse(renderer.render(withoutNarrative(hostile)));
        assertTrue(html.text().contains("<script>alert(1)</script>"), "shown as text");
        assertTrue(html.select("script,[onerror],img[src=x]").isEmpty());
    }

    @Test
    void danishDocumentsGetDanishLabelsAndDateOrder() throws Exception {
        var html =
                Jsoup.parse(
                        renderer.render(
                                resource("/pair/qrd_overekstremitet.xml")
                                        .getBytes(StandardCharsets.UTF_8)));
        String text = html.text();
        assertTrue(text.contains("Fødselsdato"), text);
        assertTrue(text.contains("Køn"));
        assertTrue(text.contains("Forfatter"));
        assertTrue(text.contains("25. december 1948"), "Danish date order");
        assertFalse(text.contains("Date of Birth"));
        assertFalse(text.contains("December 25"));
    }

    @Test
    void englishDocumentsKeepTheirLabelsAndDateOrder() throws Exception {
        String english =
                resource("/pair/qrd_overekstremitet.xml")
                        .replace(
                                "<languageCode code=\"da-DK\"/>", "<languageCode code=\"en-US\"/>");
        String text = Jsoup.parse(renderer.render(english.getBytes(StandardCharsets.UTF_8))).text();
        assertTrue(text.contains("Date of Birth"), text);
        assertTrue(text.contains("December 25, 1948"));
        assertFalse(text.contains("Fødselsdato"));
    }

    @Test
    void datesWithReducedPrecisionAreNotMangled() throws Exception {
        String xml =
                "<ClinicalDocument xmlns=\"urn:hl7-org:v3\"><languageCode code=\"da-DK\"/>"
                        + "<title>t</title><effectiveTime value=\"202611\"/>"
                        + "<component><structuredBody><component><section><title>s</title>"
                        + "<text>x</text></section></component></structuredBody></component></ClinicalDocument>";
        String text = Jsoup.parse(renderer.render(xml.getBytes(StandardCharsets.UTF_8))).text();
        assertTrue(text.contains("november 2026"), text);
        assertFalse(text.contains(". 2026"), text);
    }

    @Test
    void mergingAddsDanishValuesWithoutChangingAnyUpstreamValue() throws Exception {
        byte[] upstream = resource("/rendering/cda_l10n.xml").getBytes(StandardCharsets.UTF_8);
        byte[] danish = resource("/rendering/cda_l10n_da.xml").getBytes(StandardCharsets.UTF_8);
        var merged =
                Jsoup.parse(
                        new String(
                                CdaRenderer.mergeLabels(upstream, danish), StandardCharsets.UTF_8),
                        "",
                        org.jsoup.parser.Parser.xmlParser());
        var original =
                Jsoup.parse(
                        new String(upstream, StandardCharsets.UTF_8),
                        "",
                        org.jsoup.parser.Parser.xmlParser());
        for (String lang : new String[] {"en-us", "nl-nl", "de-ch", "fr-ch", "it-ch"}) {
            assertEquals(
                    original.select("value[lang=" + lang + "]").size(),
                    merged.select("value[lang=" + lang + "]").size(),
                    lang);
        }
        assertEquals("January", merged.select("translation[key=January] value[lang=en-us]").text());
        assertEquals("januar", merged.select("translation[key=January] value[lang=da-dk]").text());
        assertEquals(
                "CPR-nummer",
                merged.select("translation[key=1.2.208.176.1.2] value[lang=da-dk]").text(),
                "a key that upstream does not have is added");
    }

    @Test
    void theDanishLabelFileIsComplete() throws Exception {
        var labels =
                Jsoup.parse(
                        resource("/rendering/cda_l10n_da.xml"),
                        "",
                        org.jsoup.parser.Parser.xmlParser());
        var keys = new java.util.HashSet<String>();
        for (var translation : labels.select("translation")) {
            assertTrue(
                    keys.add(translation.attr("key")), "duplicate key " + translation.attr("key"));
            var values = translation.select("value");
            assertEquals(1, values.size(), translation.attr("key"));
            assertEquals("da-dk", values.first().attr("lang"));
            assertFalse(values.first().text().isBlank(), translation.attr("key"));
        }
        assertTrue(keys.size() > 100);
    }

    @Test
    void theDanishDatePatchRefusesAStylesheetItDoesNotFit() {
        byte[] other = "<xsl:stylesheet/>".getBytes(StandardCharsets.UTF_8);
        assertThrows(IllegalStateException.class, () -> CdaRenderer.withDanishDates(other));
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
