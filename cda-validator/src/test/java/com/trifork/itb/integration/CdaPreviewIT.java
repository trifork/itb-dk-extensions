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

    @Test
    void uploadPageLoadsPreviewExtension() throws Exception {
        var page = get("/cda-dk/upload");
        assertEquals(200, page.statusCode());
        assertTrue(page.body().contains("preview.js"));
        var script = get("/cda-dk/preview.js");
        assertEquals(200, script.statusCode());
        assertTrue(script.body().contains("View CDA"));
        assertTrue(script.body().contains("sandbox=\"\""));
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
