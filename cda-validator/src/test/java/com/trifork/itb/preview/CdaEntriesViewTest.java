package com.trifork.itb.preview;

import static org.junit.jupiter.api.Assertions.*;

import java.nio.charset.StandardCharsets;
import java.util.List;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

/** The generic structured view of the entries of every non-questionnaire CDA document. */
class CdaEntriesViewTest {
    private static CdaRenderer renderer;

    @BeforeAll
    static void setup() throws Exception {
        renderer = new CdaRenderer();
    }

    private static Document renderXml(String xml) throws Exception {
        return Jsoup.parse(renderer.render(xml.getBytes(StandardCharsets.UTF_8)));
    }

    private static String structured(Document page) {
        var view = page.selectFirst("div.qv");
        assertNotNull(view, "the document has structured entries but no structured view");
        return view.text();
    }

    private static String withEntries(String entries) {
        return """
                <ClinicalDocument xmlns="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                  <title>Entries</title>
                  <component><structuredBody><component><section>
                    <title>Measurements</title>
                    %s
                  </section></component></structuredBody></component>
                </ClinicalDocument>
                """
                .formatted(entries);
    }

    @Test
    void aDocumentWithoutEntriesGetsNoStructuredView() throws Exception {
        assertNull(renderXml(withEntries("")).selectFirst(".qv"));
    }

    @Test
    void questionnairesKeepTheirOwnViewInsteadOfTheGenericOne() throws Exception {
        byte[] qrd;
        try (var input = getClass().getResourceAsStream("/pair/qrd_overekstremitet.xml")) {
            qrd = input.readAllBytes();
        }
        var page = Jsoup.parse(renderer.render(qrd));
        assertTrue(structured(page).contains("Questionnaire response: structured answers"));
        assertFalse(page.text().contains("Structured entries"));
    }

    @Test
    void valuesAreFormattedByTheirDataType() throws Exception {
        var page =
                renderXml(
                        withEntries(
                                """
                                <entry><observation classCode="OBS" moodCode="EVN">
                                  <code code="X1" displayName="Quantity" codeSystem="2.16.840.1.113883.6.1"/>
                                  <effectiveTime value="20250627123443+0200"/>
                                  <value xsi:type="PQ" value="5.5" unit="mmol/L"/>
                                  <value xsi:type="INT" value="7"/>
                                  <value xsi:type="BL" value="true"/>
                                  <value xsi:type="ST">plain text</value>
                                  <value xsi:type="CD" code="C1" displayName="Coded" codeSystemName="Local"/>
                                  <value xsi:type="TS" value="20240102"/>
                                  <value xsi:type="IVL_PQ" unit="mg"><low value="1"/><high value="3" inclusive="false"/></value>
                                  <value xsi:type="PN"><given>Anna</given><family>Hansen</family></value>
                                  <value xsi:type="TEL" value="tel:12345678" use="MC"/>
                                  <value xsi:type="ED" mediaType="image/png">AAAA</value>
                                  <value nullFlavor="NI"/>
                                  <referenceRange><observationRange><value xsi:type="IVL_PQ"><low value="4" unit="mmol/L"/><high value="6" unit="mmol/L"/></value></observationRange></referenceRange>
                                </observation></entry>
                                """));
        String text = structured(page);
        for (String expected :
                List.of(
                        "Quantity (X1, LOINC)",
                        "2025-06-27 12:34:43 +02:00",
                        "5.5 mmol/L",
                        "plain text",
                        "Coded (C1, Local)",
                        "2024-01-02",
                        "1 – 3 mg",
                        "Anna Hansen",
                        "tel:12345678 (MC)",
                        "embedded image/png (not shown)",
                        "not provided (NI)",
                        "reference range: 4 – 6 mmol/L")) {
            assertTrue(text.contains(expected), expected + " in " + text);
        }
        assertFalse(text.contains("AAAA"), "embedded binary data is not dumped into the page");
    }

    @Test
    void documentTextIsNeverRenderedAsMarkupOrMadeActive() throws Exception {
        var page =
                renderXml(
                        withEntries(
                                """
                                <entry><observation classCode="OBS" moodCode="EVN">
                                  <code code="X" displayName="&lt;script&gt;alert(1)&lt;/script&gt;"/>
                                  <value xsi:type="ST">&lt;img src=x onerror=alert(2)&gt;&lt;a href="http://evil.example/"&gt;go&lt;/a&gt;</value>
                                  <value xsi:type="TEL" value="javascript:alert(3)"/>
                                </observation></entry>
                                """));
        String text = structured(page);
        assertTrue(text.contains("<script>alert(1)</script>"), "shown as text");
        assertTrue(text.contains("<img src=x onerror=alert(2)>"), "shown as text");
        assertTrue(page.select("script,[onerror],img,a[href],[href]").isEmpty());
    }

    @Test
    void veryDeepNestingIsCappedInsteadOfExhaustingTheStack() throws Exception {
        // The XML parser itself rejects documents nested deeper than 100 elements.
        int depth = 40;
        String open =
                "<organizer classCode=\"CLUSTER\" moodCode=\"EVN\"><statusCode code=\"completed\"/><component>";
        String close = "</component></organizer>";
        var page =
                renderXml(
                        withEntries(
                                "<entry>"
                                        + open.repeat(depth)
                                        + "<observation classCode=\"OBS\" moodCode=\"EVN\"><code code=\"deep\"/></observation>"
                                        + close.repeat(depth)
                                        + "</entry>"));
        String text = structured(page);
        assertTrue(text.contains("Further nested entries are not shown."));
        assertFalse(text.contains("deep"), "the capped part is not drawn");
        assertTrue(page.select("tr").size() < 40);
    }
}
