package com.trifork.itb.integration;

import static com.trifork.itb.integration.SpgdefCatalogue.*;
import static com.trifork.itb.integration.ValidatorClient.*;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.DynamicTest;
import org.junit.jupiter.api.TestFactory;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.parallel.Execution;
import org.junit.jupiter.api.parallel.ExecutionMode;

/** Opt-in live checks, deliberately excluded from ordinary container integration runs. */
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@Execution(ExecutionMode.SAME_THREAD)
class SpgdefQfddIT {
    private final Path output =
            Path.of(
                    System.getenv()
                            .getOrDefault(
                                    "CDA_TEST_RESULTS_DIR",
                                    ROOT.resolve("test-results/spgdef-qfdd").toString()));
    private final List<Map<String, Object>> results = new ArrayList<>();
    private final Instant started = Instant.now();
    private String discoveryError = "";

    @TestFactory
    Stream<DynamicTest> allPublishedDocuments() throws Exception {
        Files.createDirectories(output.resolve("documents"));
        Files.createDirectories(output.resolve("reports"));
        try {
            byte[] html = download(INDEX);
            Files.write(output.resolve("catalogue.html"), html);
            List<Entry> entries = SpgdefCatalogue.parse(html);
            for (Entry entry : entries) {
                Map<String, Object> result = new LinkedHashMap<>();
                result.put("name", entry.name());
                result.put("url", entry.url().toString());
                result.put("status", "NOT_RUN");
                results.add(result);
            }
            saveReports();
            return java.util.stream.IntStream.range(0, entries.size())
                    .mapToObj(
                            index ->
                                    DynamicTest.dynamicTest(
                                            entries.get(index).name()
                                                    + " ["
                                                    + entries.get(index).url()
                                                    + "]",
                                            () ->
                                                    validateEntry(
                                                            entries.get(index),
                                                            results.get(index))));
        } catch (Exception exception) {
            discoveryError = exception.toString();
            throw exception;
        }
    }

    private void validateEntry(Entry entry, Map<String, Object> result) throws Exception {
        String id = entry.url().getPath().substring("/qfdd/".length());
        String stage = "DOWNLOAD";
        try {
            byte[] xml = download(entry.url());
            Files.write(output.resolve("documents").resolve(id + ".xml"), xml);
            result.put("sha256", sha256(xml));
            result.put("downloadedAt", Instant.now().toString());
            stage = "VALIDATION";
            var response = request(xml, TARGET);
            Files.write(output.resolve("reports").resolve(id + ".xml"), response.body());
            if (response.statusCode() != 200)
                throw new IOException("Validator HTTP " + response.statusCode());
            var outcome = SpgdefCatalogue.outcome(response.body());
            result.putAll(outcome);
            result.put("status", outcome.get("result"));
            result.put("validatedAt", Instant.now().toString());
        } catch (Exception exception) {
            result.put("status", stage + "_ERROR");
            result.put("error", exception.toString());
            throw exception;
        } finally {
            saveReports();
        }
        assertEquals(
                "SUCCESS",
                result.get("status"),
                entry.name()
                        + ": "
                        + result.get("errors")
                        + " errors, "
                        + result.get("warnings")
                        + " warnings; see reports/"
                        + id
                        + ".xml");
    }

    // This is intentional HTTP retry backoff, not a delay used to synchronise a test assertion.
    @SuppressWarnings("java:S2925")
    private static byte[] download(URI uri) throws IOException, InterruptedException {
        // Sequential requests, finite timeouts and bounded retries avoid flooding the publisher.
        // Redirects are not followed: a changed catalogue location needs explicit review.
        try (var client = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(20)).build()) {
            IOException failure = new IOException("Download failed: " + uri);
            for (int attempt = 1; attempt <= 3; attempt++) {
                try {
                    var response =
                            client.send(
                                    HttpRequest.newBuilder(uri)
                                            .timeout(Duration.ofSeconds(60))
                                            .header(
                                                    "User-Agent",
                                                    "itb-dk-extensions-qfdd-validation")
                                            .GET()
                                            .build(),
                                    HttpResponse.BodyHandlers.ofByteArray());
                    if (response.statusCode() == 200) return response.body();
                    failure =
                            new IOException("Download HTTP " + response.statusCode() + ": " + uri);
                    if (response.statusCode() < 500 && response.statusCode() != 429) break;
                } catch (IOException exception) {
                    failure = exception;
                }
                if (attempt < 3) Thread.sleep(Duration.ofSeconds(attempt * 2L));
            }
            throw failure;
        }
    }

    @AfterAll
    void saveReports() throws IOException {
        Files.createDirectories(output);
        Map<String, Object> manifest = new LinkedHashMap<>();
        manifest.put("source", INDEX.toString());
        manifest.put("validationType", TARGET);
        manifest.put("startedAt", started.toString());
        manifest.put("updatedAt", Instant.now().toString());
        manifest.put("discoveryError", discoveryError);
        manifest.put("documents", results);
        JSON.writerWithDefaultPrettyPrinter()
                .writeValue(output.resolve("results.json").toFile(), manifest);
        long passed = count("SUCCESS");
        long failed = count("FAILURE");
        long notRun = count("NOT_RUN");
        long errors = results.size() - passed - failed - notRun;
        StringBuilder summary =
                new StringBuilder("# Daily public QFDD validation\n\n")
                        .append("Source: ")
                        .append(INDEX)
                        .append(" — target: **QFDD-DK 1.2** (`")
                        .append(TARGET)
                        .append("`).\n\n")
                        .append("Discovered: ")
                        .append(results.size())
                        .append("; passed: ")
                        .append(passed)
                        .append("; validation failures: ")
                        .append(failed)
                        .append("; download/service errors: ")
                        .append(errors)
                        .append("; not run: ")
                        .append(notRun)
                        .append(".\n\n")
                        .append(
                                "Conformance coverage is partial. A passing result covers only the implemented rules.\n\n");
        if (!discoveryError.isEmpty())
            summary.append("**Catalogue discovery failed:** ")
                    .append(markdown(discoveryError))
                    .append("\n\n");
        summary.append(
                        "The artifact contains the catalogue snapshot, original documents, SHA-256 hashes, raw validation reports and JUnit results.\n\n")
                .append(
                        "| Questionnaire | Status | Errors | Warnings | Details |\n| --- | --- | --- | --- | --- |\n");
        for (var result : results) {
            summary.append("| [")
                    .append(markdown(result.get("name").toString()))
                    .append("](")
                    .append(result.get("url"))
                    .append(") | ")
                    .append(result.get("status"))
                    .append(" | ")
                    .append(result.getOrDefault("errors", "—"))
                    .append(" | ")
                    .append(result.getOrDefault("warnings", "—"))
                    .append(" | ")
                    .append(markdown(result.getOrDefault("error", "").toString()))
                    .append(" |\n");
        }
        Files.writeString(output.resolve("summary.md"), summary);
    }

    private long count(String status) {
        return results.stream().filter(result -> status.equals(result.get("status"))).count();
    }
}
