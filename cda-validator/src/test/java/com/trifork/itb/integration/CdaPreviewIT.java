package com.trifork.itb.integration;

import static org.junit.jupiter.api.Assertions.*;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Duration;
import java.util.List;
import org.jsoup.Jsoup;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;

/** Exercises the thin extension in the actual upstream Boot/Saxon runtime. */
class CdaPreviewIT {
    private static final String BASE =
            System.getenv().getOrDefault("BASE_URL", "http://localhost:8091");
    private static final HttpClient HTTP =
            HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(10)).build();

    static List<Path> sampleFiles() throws Exception {
        try (var files = Files.walk(ValidatorClient.ROOT.resolve("samples"))) {
            return files.filter(p -> p.toString().endsWith(".xml")).sorted().toList();
        }
    }

    @ParameterizedTest(name = "Preview {0}")
    @MethodSource("sampleFiles")
    void rendersEveryRepositorySample(Path file) throws Exception {
        byte[] xml = Files.readAllBytes(file);
        var response = post(xml);
        assertEquals(200, response.statusCode(), file + ": " + response.body());
        var html = Jsoup.parse(response.body());
        assertFalse(html.select("body").text().isBlank());
        var titles = ValidatorClient.parse(xml).getElementsByTagNameNS("urn:hl7-org:v3", "title");
        if (titles.getLength() > 0) {
            String title = titles.item(0).getTextContent().replaceAll("\\s+", " ").trim();
            assertTrue(html.text().contains(title), "Preview must preserve the document title");
        }
    }

    private static String structuredText(String sample) throws Exception {
        var response = post(Files.readAllBytes(ValidatorClient.ROOT.resolve("samples/" + sample)));
        assertEquals(200, response.statusCode(), sample + ": " + response.body());
        var view = Jsoup.parse(response.body()).selectFirst("div.qv");
        assertNotNull(view, sample + " has structured entries but no structured view");
        return view.text();
    }

    @ParameterizedTest(name = "Structured entries {0}")
    @MethodSource("sampleFiles")
    void everySampleWithEntriesShowsThemUnlessItIsAQuestionnaire(Path file) throws Exception {
        String xml = Files.readString(file);
        if (!xml.contains("<entry")) return;
        var html = Jsoup.parse(post(xml.getBytes(StandardCharsets.UTF_8)).body());
        boolean questionnaire =
                xml.contains("code=\"74465-6\"") || xml.contains("code=\"74468-0\"");
        assertNotNull(html.selectFirst("div.qv table.qv-table tbody tr"), file.toString());
        assertEquals(
                !questionnaire,
                html.text().contains("Structured entries"),
                "only non-questionnaires get the generic view: " + file);
    }

    @Test
    void profileSamplesShowTheirStructuredData() throws Exception {
        String phmr = structuredText("phmr/PHMR-example-11.xml");
        assertTrue(phmr.contains("Blodtryk systolisk;Arm (DNK05472, NPU terminologien)"), phmr);
        assertTrue(phmr.contains("120 mmHg") && phmr.contains("2025-01-01 09:00:00 +01:00"), phmr);

        String apd = structuredText("apd/2.0_DK-APD_Example_1_5_apd_region.xml");
        assertTrue(apd.contains("Encounter (appointment)"), apd);
        assertTrue(apd.contains("2026-03-07 08:00:00 +01:00 – 2026-03-07 09:30:00 +01:00"), apd);
        assertTrue(apd.contains("status: active") && apd.contains("performer (PRF)"), apd);
        assertTrue(apd.contains("participant (LOC)"), apd);

        String cpd = structuredText("cpd/CPD-DK_Ex_Version 2.0 Diabetes.xml");
        assertTrue(cpd.contains("below 5 mmol/L"), "an open interval with its unit");
        assertTrue(cpd.contains("Diabetes Type 2 (T90, ICPC-2-DK)") && cpd.contains("91 kg"), cpd);
        assertTrue(cpd.contains("Observation (goal)"), cpd);

        String pdc =
                structuredText(
                        "pdc/2.0_PDC-DK_2_0_Testprotokol_v1.1.1_PDC20_Example-maximum_data_differentNarrativeText.xml");
        assertTrue(pdc.contains("CPR 1.2.208.176.1.2 / 9999999999"), "an identifier");
        assertTrue(pdc.contains("Hans Jensens Stræde 45") && pdc.contains("Odense"), pdc);

        String pmr = structuredText("pmr/PMR-DK 2.0 example 1 max.xml");
        assertTrue(pmr.contains("systolisk blodtryk (271649006, SNOMED CT)"), pmr);
        assertTrue(pmr.contains("also: Blodtryk systolisk;Arm (DNK05472"), "the translation");
        assertTrue(pmr.contains("subject: Foster 1"), pmr);

        String prf = structuredText("prf/PRF-DK v3.0 example 3.xml");
        assertTrue(prf.contains("Italiensk (it, ISO 639-1 Alpha 2)"), prf);
        assertTrue(prf.contains("negated") && prf.contains("[component of parent]"), prf);

        String pscr = structuredText("pscr/PSCR-DK v2.0 example 3.xml");
        assertTrue(pscr.contains("2025-03-04") && pscr.contains("26 – 27"), pscr);
    }

    @Test
    void aDocumentWithoutEntriesGetsNoStructuredView() throws Exception {
        var response =
                post(
                        Files.readAllBytes(
                                ValidatorClient.ROOT.resolve(
                                        "samples/phad/PHAD-DK_Ex_v1.0 Rasmus Test Lauridsen Netværksmøde.xml")));
        assertEquals(200, response.statusCode());
        assertNull(Jsoup.parse(response.body()).selectFirst(".qv"));
    }

    @Test
    void uploadPageLoadsPreviewExtension() throws Exception {
        var page = get("/cda-dk/upload");
        assertEquals(200, page.statusCode());
        assertTrue(page.body().contains("preview.js"));
        var script = get("/cda-dk/preview.js");
        assertEquals(200, script.statusCode());
        assertTrue(script.body().contains("View CDA"));
        assertTrue(script.body().contains("sandbox=\"\""));
        assertTrue(script.body().contains("cda-group"));
    }

    @Test
    void rendersCdaWithoutSuccessfulValidation() throws Exception {
        var response =
                post(
                        """
                <ClinicalDocument xmlns="urn:hl7-org:v3"><title>Preview æøå</title>
                <component><structuredBody><component><section><title>Results</title>
                <text><paragraph>Document narrative</paragraph></text>
                </section></component></structuredBody></component></ClinicalDocument>
                """);
        assertEquals(200, response.statusCode(), response.body());
        assertEquals("no-store", response.headers().firstValue("Cache-Control").orElseThrow());
        assertTrue(
                response.headers()
                        .firstValue("Content-Security-Policy")
                        .orElseThrow()
                        .contains("sandbox"));
        var html = Jsoup.parse(response.body());
        assertTrue(html.text().contains("Preview æøå"));
        assertTrue(html.text().contains("Document narrative"));
        assertTrue(
                html.selectFirst("meta[http-equiv]")
                        .attr("content")
                        .contains("default-src 'none'"));
    }

    @Test
    void rejectsNonCdaAndExternalEntitiesWithoutEchoingInput() throws Exception {
        for (String xml :
                new String[] {
                    "<private-data/>", "<!DOCTYPE x SYSTEM 'file:///etc/passwd'><x/>", "<"
                }) {
            var response = post(xml);
            assertEquals(400, response.statusCode());
            assertEquals("no-store", response.headers().firstValue("Cache-Control").orElseThrow());
            assertFalse(response.body().contains(xml));
        }
    }

    @Test
    void limitsPreviewSize() throws Exception {
        assertEquals(413, post(" ".repeat(10 * 1024 * 1024 + 1)).statusCode());
    }

    @Test
    void distinguishesInputErrorsFromTransformationErrors() throws Exception {
        var malformed = post("<ClinicalDocument>");
        assertEquals(400, malformed.statusCode());
        assertTrue(malformed.body().contains("line 1, column"));
        assertFalse(malformed.body().contains("DOCTYPE"));
        var doctype = post("<!DOCTYPE x><x/>");
        assertEquals(400, doctype.statusCode());
        assertTrue(doctype.body().contains("DOCTYPE declarations"));
        var nonCda = post("<x/>");
        assertEquals(400, nonCda.statusCode());
        assertTrue(nonCda.body().contains("ClinicalDocument"));
        // Upstream stylesheet deliberately terminates on script-like table attribute values.
        var unsupported =
                post(
                        """
                <ClinicalDocument xmlns="urn:hl7-org:v3"><component><structuredBody><component>
                <section><text><table border="javascript:blocked"/></text></section>
                </component></structuredBody></component></ClinicalDocument>
                """);
        assertEquals(422, unsupported.statusCode());
        assertTrue(unsupported.body().contains("display stylesheet could not render"));
        assertFalse(unsupported.body().contains("DOCTYPE"));
        assertFalse(unsupported.body().contains("javascript:blocked"));
    }

    private static HttpResponse<String> get(String path) throws Exception {
        return HTTP.send(
                HttpRequest.newBuilder(URI.create(BASE + path))
                        .timeout(Duration.ofSeconds(30))
                        .GET()
                        .build(),
                HttpResponse.BodyHandlers.ofString());
    }

    private static HttpResponse<String> post(String xml) throws Exception {
        return post(xml.getBytes(StandardCharsets.UTF_8));
    }

    private static HttpResponse<String> post(byte[] xml) throws Exception {
        return HTTP.send(
                HttpRequest.newBuilder(URI.create(BASE + "/cda-dk/preview"))
                        .timeout(Duration.ofSeconds(30))
                        .header("Content-Type", "application/xml")
                        .POST(HttpRequest.BodyPublishers.ofByteArray(xml))
                        .build(),
                HttpResponse.BodyHandlers.ofString());
    }
}
