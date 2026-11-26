package com.trifork.itb.preview;

import static org.junit.jupiter.api.Assertions.*;

import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.stream.Stream;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

/** The generic structured view of the entries of every non-questionnaire CDA document. */
class CdaEntriesViewTest {
    private static final Path SAMPLES = Path.of("..", "samples");
    private static CdaRenderer renderer;

    @BeforeAll
    static void setup() throws Exception {
        renderer = new CdaRenderer();
    }

    private static Document render(String sample) throws Exception {
        return Jsoup.parse(renderer.render(Files.readAllBytes(SAMPLES.resolve(sample))));
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
    void everySampleRendersAndAnyDocumentWithEntriesGetsAStructuredView() throws Exception {
        List<Path> files;
        try (Stream<Path> walk = Files.walk(SAMPLES)) {
            files = walk.filter(p -> p.toString().endsWith(".xml")).sorted().toList();
        }
        assertFalse(files.isEmpty());
        int withView = 0;
        for (Path file : files) {
            String xml = Files.readString(file);
            Document page;
            try {
                page = Jsoup.parse(renderer.render(Files.readAllBytes(file)));
            } catch (org.xml.sax.SAXException notRenderable) {
                // Deliberately broken official examples are rejected, as for any preview.
                continue;
            }
            boolean hasEntries = xml.contains("<entry");
            boolean questionnaire =
                    xml.contains("code=\"74465-6\"") || xml.contains("code=\"74468-0\"");
            if (hasEntries && !questionnaire) {
                assertNotNull(page.selectFirst("div.qv table.qv-table tbody tr"), file.toString());
                withView++;
            }
            assertTrue(
                    page.select("script,iframe,object,embed,form,a[href]").isEmpty(),
                    file.toString());
        }
        assertTrue(withView > 50, "expected most profile samples to have entries: " + withView);
    }

    @Test
    void phmrMeasurementsShowTheirValuesUnitsAndTimes() throws Exception {
        String text = structured(render("phmr/PHMR-example-11.xml"));
        assertTrue(text.contains("Blodtryk systolisk;Arm (DNK05472, NPU terminologien)"), text);
        assertTrue(text.contains("120 mmHg"), text);
        assertTrue(text.contains("2025-01-01 09:00:00 +01:00"), "the measurement time");
    }

    @Test
    void anAppointmentShowsItsTimeStatusAndParticipants() throws Exception {
        String text = structured(render("apd/2.0_DK-APD_Example_1_5_apd_region.xml"));
        assertTrue(text.contains("Encounter (appointment)"), text);
        assertTrue(text.contains("2026-03-07 08:00:00 +01:00 – 2026-03-07 09:30:00 +01:00"), text);
        assertTrue(text.contains("status: active"), text);
        assertTrue(text.contains("performer (PRF)"), "who performs it");
        assertTrue(text.contains("participant (LOC)"), "where it takes place");
    }

    @Test
    void aCarePlanShowsGoalRangesWithTheirUnitsAndCodedValues() throws Exception {
        String text = structured(render("cpd/CPD-DK_Ex_Version 2.0 Diabetes.xml"));
        assertTrue(text.contains("below 5 mmol/L"), "an open interval with its unit");
        assertTrue(text.contains("Diabetes Type 2 (T90, ICPC-2-DK)"), "a coded value");
        assertTrue(text.contains("Observation (goal)"), "the mood of the entry");
        assertTrue(text.contains("91 kg"), text);
    }

    @Test
    void aCitizenRecordShowsNamesAddressesAndIdentifiers() throws Exception {
        String text =
                structured(
                        render(
                                "pdc/2.0_PDC-DK_2_0_Testprotokol_v1.1.1_PDC20_Example-maximum_data_differentNarrativeText.xml"));
        assertTrue(text.contains("Forældremyndighed over (ChildCustody"), text);
        assertTrue(text.contains("CPR 1.2.208.176.1.2 / 9999999999"), "an identifier");
        assertTrue(text.contains("Hans Jensens Stræde 45"), "an address");
        assertTrue(text.contains("Odense"), "an address");
    }

    @Test
    void pregnancyDocumentsShowCodesFromBothTerminologiesAndNestedEntries() throws Exception {
        String pmr = structured(render("pmr/PMR-DK 2.0 example 1 max.xml"));
        assertTrue(pmr.contains("systolisk blodtryk (271649006, SNOMED CT)"), pmr);
        assertTrue(pmr.contains("also: Blodtryk systolisk;Arm (DNK05472"), "the translation");
        assertTrue(pmr.contains("subject: Foster 1"), "the participant of a foetus");
        String prf = structured(render("prf/PRF-DK v3.0 example 3.xml"));
        assertTrue(prf.contains("Italiensk (it, ISO 639-1 Alpha 2)"), prf);
        assertTrue(prf.contains("negated"), "a negated observation");
        assertTrue(prf.contains("[component of parent]"), "a nested observation");
        String pscr = structured(render("pscr/PSCR-DK v2.0 example 3.xml"));
        assertTrue(pscr.contains("2025-03-04"), "a date with day precision");
        assertTrue(pscr.contains("26 – 27"), "an integer interval");
    }

    @Test
    void aDocumentWithoutEntriesGetsNoStructuredView() throws Exception {
        assertNull(
                render("phad/PHAD-DK_Ex_v1.0 Rasmus Test Lauridsen Netværksmøde.xml")
                        .selectFirst(".qv"));
    }

    @Test
    void questionnairesKeepTheirOwnViewInsteadOfTheGenericOne() throws Exception {
        var page = render("qrd/qrd_alle_inputtyper.xml");
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
