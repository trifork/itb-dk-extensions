package com.trifork.ihexdsapi.integration;

import static com.trifork.ihexdsapi.integration.ItbClient.*;
import static org.junit.jupiter.api.Assertions.*;

import com.fasterxml.jackson.databind.JsonNode;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/** Real ITB workflows against compose.mock.yml; all patient/document data is synthetic. */
class ItbFlowIT {
    private static final String TYPE_CODE_FIELD = "Type code (multiple allowed)";
    private static final String FORMAT_CODE_FIELD = "Format code (multiple allowed)";
    private static final String DOCUMENT_FIELD = "Document";
    private static final String BACK_TO_RESULTS = "Back to results";
    private static ItbClient client;
    private String session;
    private final List<String> createdSessions = new ArrayList<>();

    @BeforeAll
    static void login() throws Exception {
        client = new ItbClient();
    }

    @BeforeEach
    void start() throws Exception {
        session = client.start();
        createdSessions.add(session);
    }

    @AfterEach
    void stop() throws Exception {
        for (String id : createdSessions)
            if (!client.status(id, false, false).hasNonNull("endTime")) client.stop(id);
    }

    private JsonNode interaction(String title) {
        return client.interaction(session, title);
    }

    private void submit(String title, Map<String, ?> values) throws Exception {
        client.submit(session, interaction(title), values);
    }

    private JsonNode step(String description) throws Exception {
        return client.stepReport(session, description);
    }

    private void chooseXds() throws Exception {
        chooseXds("Synthetic registry One");
    }

    private void chooseXds(String registry) throws Exception {
        submit("Document source", Map.of("Document source", "IHE XDS (DDS) retrieval"));
        chooseRegistry(registry);
    }

    private void chooseRegistry(String registry) throws Exception {
        submit("Choose XDS registry", Map.of("Registry", registry));
    }

    private void search() throws Exception {
        search("2512489996", "");
    }

    private void search(String patient) throws Exception {
        search(patient, "");
    }

    private void search(String patient, String unique) throws Exception {
        JsonNode form = interaction("Find in XDS");
        client.submit(
                session,
                form,
                Map.of(
                        "Test CPR (10 digits)",
                        patient,
                        "Signing identity",
                        option(form, "Signing identity", "Synthetic test professional"),
                        TYPE_CODE_FIELD,
                        "Any",
                        FORMAT_CODE_FIELD,
                        "Any",
                        "Unique ID (optional exact match)",
                        unique));
    }

    private List<String> select() throws Exception {
        return select("phmr-2.1.0", false);
    }

    private JsonNode documentForm() throws Exception {
        JsonNode action = interaction("XDS documents");
        for (JsonNode item : action.get("interactions"))
            assertNotEquals(DOCUMENT_FIELD, item.path("desc").asText());
        client.submit(
                session,
                action,
                Map.of(
                        "Next step",
                        option(action, "Next step", "View documents and choose one (")));
        JsonNode form = interaction("Select XDS document");
        assertTrue(field(form, DOCUMENT_FIELD).path("required").asBoolean());
        return form;
    }

    private List<String> select(String doc, boolean searchAgain) throws Exception {
        if (searchAgain) {
            submit("XDS documents", Map.of("Next step", "Search again"));
            chooseRegistry("Synthetic registry One");
            return List.of();
        }
        JsonNode form = documentForm();
        List<String> documents = documents(form);
        String selected = documents.stream().filter(s -> s.contains(doc)).findFirst().orElseThrow();
        client.submit(session, form, Map.of(DOCUMENT_FIELD, selected));
        return documents;
    }

    private static List<String> documents(JsonNode form) {
        return options(field(form, DOCUMENT_FIELD)).stream()
                .filter(value -> !BACK_TO_RESULTS.equals(value))
                .toList();
    }

    private void finish(String expected) throws Exception {
        submit("validation completed", Map.of());
        assertEquals(expected, client.ended(session, 30).get("result").asText());
    }

    private void failedBeforeValidation(String code) throws Exception {
        assertEquals("FAILURE", client.ended(session, 60).get("result").asText());
        var report = client.report(session);
        assertTrue(nodes(report, "//*[local-name()='profileID']").isEmpty());
        assertTrue(
                nodes(report, "//*[local-name()='assertionID']").stream()
                        .anyMatch(n -> code.equals(n.getTextContent())));
        String logs = client.logs(session);
        assertTrue(logs.contains(code + ":"));
        assertEquals(1, occurrences(logs, "CDA validation has not run."));
        assertFalse(logs.contains("synthetic-access-error"));
        assertFalse(logs.contains("000000000"));
        for (JsonNode item : client.interactions(session))
            assertFalse(item.path("inputTitle").asText().contains("validation completed"));
    }

    private static int occurrences(String text, String needle) {
        return (text.length() - text.replace(needle, "").length()) / needle.length();
    }

    private String diagnosticLog(String... expected) throws Exception {
        String text = client.logs(session);
        for (String message : expected)
            assertTrue(text.contains(message), "Missing diagnostic: " + message);
        assertFalse(text.contains("synthetic-private-context"));
        assertEquals(1, occurrences(text, "CDA validation has not run."));
        return text;
    }

    private byte[] originalAttachment() throws Exception {
        for (JsonNode item : step("Retrieve selected CDA document").get("context").get("item"))
            if ("retrieved-document".equals(item.get("name").asText()))
                return client.attachment(session, item);
        throw new AssertionError("Missing retrieved document attachment");
    }

    private void filter(String mode, String... repositories) throws Exception {
        submit("XDS documents", Map.of("Next step", "Filter repositories"));
        JsonNode form = interaction("Filter repositories");
        List<String> choices = new ArrayList<>();
        for (String repository : repositories)
            choices.add(option(form, "Repositories (optional)", repository));
        client.submit(
                session,
                form,
                Map.of(
                        "Repository filter",
                        mode,
                        "Repositories (optional)",
                        String.join(",", choices)));
    }

    private List<String> documentOptions() throws Exception {
        JsonNode form = documentForm();
        List<String> documents = documents(form);
        client.submit(session, form, Map.of(DOCUMENT_FIELD, BACK_TO_RESULTS));
        interaction("XDS documents");
        return documents;
    }

    @Test
    void registryChoiceIsReportedAndUsedForRetrievalAfterFiltering() throws Exception {
        chooseXds("Synthetic registry Two");
        search("0000000010");
        filter("All repositories");
        select();
        finish("SUCCESS");
        var report = step("Retrieve selected CDA document");
        boolean found = false;
        for (var item : report.path("context").path("item"))
            if ("Registry".equals(item.path("name").asText())) {
                assertEquals("Synthetic registry Two", item.path("value").asText());
                found = true;
            }
        assertTrue(found, "Selected registry is present in the retrieval report");
    }

    @Test
    void uploadAndRetrievalHaveIdenticalFindingsAndLocations() throws Exception {
        submit("Document source", Map.of("Document source", "Local file upload"));
        submit(
                "Upload PHMR-DK",
                Map.of(
                        "PHMR-DK 2.1.0 document",
                        Files.readAllBytes(ROOT.resolve("samples/phmr/phmr_v1_3_weight.xml"))));
        finish("FAILURE");
        List<Object> upload = client.signature(session);
        start();
        chooseXds();
        search("2512489996", "phmr-1.3");
        select("phmr-1.3", false);
        finish("FAILURE");
        assertEquals(upload, client.signature(session));
    }

    @Test
    void upload() throws Exception {
        submit("Document source", Map.of("Document source", "Local file upload"));
        submit(
                "Upload PHMR-DK",
                Map.of(
                        "PHMR-DK 2.1.0 document",
                        Files.readAllBytes(ROOT.resolve("samples/phmr/phmr_example01.xml"))));
        finish("SUCCESS");
        assertEquals(
                "Local file upload",
                step("Choose document source")
                        .get("context")
                        .get("item")
                        .get(0)
                        .get("value")
                        .asText());
    }

    @Test
    void multipleResultsAndSelection() throws Exception {
        chooseXds();
        search();
        assertEquals(2, select().size());
        finish("SUCCESS");
        assertArrayEquals(
                Files.readAllBytes(ROOT.resolve("samples/phmr/phmr_example01.xml")),
                originalAttachment());
        Map<String, String> selected = context(step("Choose a document"));
        assertEquals(
                "View documents and choose one (2 available)",
                context(step("Choose next action")).get("Next step"));
        assertTrue(selected.get(DOCUMENT_FIELD).contains("phmr-2.1.0"));
        for (String description : List.of("Search XDS registry", "Filter fetched documents")) {
            Map<String, String> details = context(step(description));
            assertEquals(List.of("Results", "Registry"), new ArrayList<>(details.keySet()));
            assertEquals("Synthetic registry One", details.get("Registry"));
            assertTrue(details.get("Results").contains("2 of 2 fetched documents"));
            assertFalse(details.toString().contains("phmr-1.3"));
        }
        String metadata = context(step("Retrieve selected CDA document")).get("Selected document");
        assertTrue(metadata.contains("Unique ID: phmr-2.1.0"));
        assertFalse(metadata.contains("phmr-1.3"));
    }

    @Test
    void repositoryIncludeExcludeAndClear() throws Exception {
        chooseXds();
        search("0000000009");
        List<String> original = documentOptions();
        assertEquals(3, original.size());
        assertTrue(original.stream().allMatch(label -> label.length() < 120));
        filter("Only selected repositories", "PRODTEST", "2.999.1");
        assertEquals(List.of(original.get(0), original.get(2)), documentOptions());
        JsonNode form = interaction("XDS documents");
        assertTrue(
                form.toString()
                        .contains(
                                "Included repositories: KIH Repository · TEST1 / PRODTEST; 2.999.1."));
        assertTrue(form.toString().contains("Excluded repositories: KIH Repository · TEST2."));
        for (JsonNode field : form.get("interactions"))
            assertNotEquals("Selection", field.path("desc").asText());
        filter("Exclude selected repositories", "PRODTEST", "2.999.1");
        assertEquals(List.of(original.get(1)), documentOptions());
        filter("All repositories", "PRODTEST");
        assertEquals(original, documentOptions());
        filter("Only selected repositories");
        assertEquals(original, documentOptions());
        select("phmr-test2", false);
        finish("SUCCESS");
    }

    @Test
    void excludingAllRepositoriesCanRestoreOrSearchAgain() throws Exception {
        chooseXds();
        search("0000000009");
        List<String> original = documentOptions();
        filter("Exclude selected repositories", "PRODTEST", "TEST2", "2.999.1");
        submit(
                "No documents in selected repositories",
                Map.of("Next step", "Show all repositories"));
        assertEquals(original, documentOptions());
        filter("Exclude selected repositories", "PRODTEST", "TEST2", "2.999.1");
        submit("No documents in selected repositories", Map.of("Next step", "Search again"));
        chooseRegistry("Synthetic registry One");
        search();
        select();
        finish("SUCCESS");
    }

    @Test
    void missingRequiredDocumentIsRejectedEvenWhenSubmittedThroughApi() throws Exception {
        chooseXds();
        search();
        client.submit(session, documentForm(), Map.of());
        assertTrue(
                interaction("XDS documents")
                        .toString()
                        .contains("Choose a document before validating"));
        select();
        // Bypassing the UI required-field check records an ITB interaction failure.
        finish("FAILURE");
    }

    @Test
    void multipleTypeAndFormatCodesReachBackend() throws Exception {
        chooseXds();
        JsonNode form = interaction("Find in XDS");
        Map<String, String> values = new java.util.LinkedHashMap<>();
        values.put("Test CPR (10 digits)", "0000000005");
        values.put(
                "Signing identity",
                option(form, "Signing identity", "Synthetic test professional"));
        for (String description : List.of(TYPE_CODE_FIELD, FORMAT_CODE_FIELD))
            values.put(
                    description,
                    String.join(
                            ",",
                            options(field(form, description)).stream()
                                    .filter(s -> !"Any".equals(s))
                                    .toList()));
        client.submit(session, form, values);
        select();
        finish("SUCCESS");
        Map<String, String> recorded = context(step("Search DDS"));
        for (String description : List.of("Signing identity", TYPE_CODE_FIELD, FORMAT_CODE_FIELD))
            assertEquals(values.get(description), recorded.get(description));
        assertTrue(recorded.get(TYPE_CODE_FIELD).contains("test-code; scheme: test-scheme"));
    }

    @Test
    void expiredIdentityIsLabelledAndRejectedBeforeSearch() throws Exception {
        chooseXds();
        JsonNode form = interaction("Find in XDS");
        options(field(form, "Signing identity"));
        assertTrue(
                option(form, "Signing identity", "Synthetic test professional").contains("MOCES"));
        String expired = option(form, "Signing identity", "Expired fixture");
        assertTrue(expired.contains("EXPIRED — 2000-01-01"));
        assertTrue(option(form, "Signing identity", "System fixture").contains("FOCES"));
        client.submit(
                session,
                form,
                Map.of("Test CPR (10 digits)", "2512489996", "Signing identity", expired));
        failedBeforeValidation("XDS-CERTIFICATE-EXPIRED");
        assertEquals(expired, context(step("Search DDS")).get("Signing identity"));
    }

    @Test
    void systemIdentityHasAnExplanatoryError() throws Exception {
        chooseXds();
        JsonNode form = interaction("Find in XDS");
        client.submit(
                session,
                form,
                Map.of(
                        "Test CPR (10 digits)",
                        "2512489996",
                        "Signing identity",
                        option(form, "Signing identity", "System fixture")));
        failedBeforeValidation("XDS-IDENTITY-TYPE");
    }

    @Test
    void noResultsThenSearchAgain() throws Exception {
        chooseXds();
        search("0000000000");
        submit("No matching DDS documents", Map.of());
        chooseRegistry("Synthetic registry One");
        search("0000000001");
        assertEquals(1, select().size());
        finish("SUCCESS");
    }

    @Test
    void uniqueIdAndWrongRelease() throws Exception {
        chooseXds();
        search("2512489996", "phmr-1.3");
        assertEquals(1, select("phmr-1.3", false).size());
        finish("FAILURE");
    }

    @Test
    void searchAgainFromResults() throws Exception {
        chooseXds();
        search();
        select("phmr-2.1.0", true);
        search("2512489996", "phmr-2.1.0");
        assertEquals(1, select().size());
        finish("SUCCESS");
    }

    @Test
    void registryError() throws Exception {
        chooseXds();
        search("0000000002");
        failedBeforeValidation("XDS-REGISTRY");
    }

    @Test
    void retrievalGatewayErrorIsExplainedInSessionLog() throws Exception {
        chooseXds();
        search("0000000006");
        select();
        failedBeforeValidation("XDS-REGISTRY");
        diagnosticLog(
                "ITI-43) failed.",
                "XDSUnavailableCommunity",
                "gateway is unavailable",
                "Retry later",
                "Selected repository: 1.2.208.176.43210.8.1.30 (KIH Repository, TEST1 / PRODTEST).");
        assertTrue(
                step("Retrieve selected CDA document")
                        .get("reports")
                        .get("assertionReports")
                        .get(0)
                        .get("value")
                        .get("description")
                        .asText()
                        .contains("1.2.208.176.43210.8.1.30 (KIH Repository, TEST1 / PRODTEST)"));
    }

    @Test
    void searchErrorIncludesRegistryCode() throws Exception {
        chooseXds();
        search("0000000007");
        failedBeforeValidation("XDS-REGISTRY");
        diagnosticLog("ITI-18) failed.", "XDSRegistryBusy", "registry is busy");
    }

    @Test
    void unknownErrorDoesNotExtractCodesFromArbitraryText() throws Exception {
        chooseXds();
        search("0000000008");
        failedBeforeValidation("XDS-BACKEND");
        assertFalse(
                diagnosticLog("ITI-18) failed.", "No recognised XDS error code")
                        .contains("XDSUnavailableCommunity"));
    }

    @Test
    void nonCda() throws Exception {
        chooseXds();
        search("0000000003");
        select("non-cda", false);
        failedBeforeValidation("XDS-CONTENT");
        assertEquals(
                "IHE XDS (DDS) retrieval",
                step("Choose document source")
                        .get("context")
                        .get("item")
                        .get(0)
                        .get("value")
                        .asText());
        Map<String, String> query = context(step("Search DDS"));
        assertTrue(query.get("Signing identity").contains("MOCES — Synthetic test professional"));
        assertEquals("Any", query.get(TYPE_CODE_FIELD));
        assertEquals("Any", query.get(FORMAT_CODE_FIELD));
        assertTrue(
                context(step("Load XDS identities and search codes")).values().stream()
                        .anyMatch(v -> v.contains("No patient search has run yet")));
        String logs = client.logs(session);
        assertTrue(logs.contains("--- BEGIN RETRIEVED DOCUMENT ---"));
        assertTrue(logs.contains("<html/>"));
        assertTrue(logs.indexOf("--- BEGIN RETRIEVED DOCUMENT ---") < logs.indexOf("XDS-CONTENT:"));
        assertArrayEquals(
                "<html/>".getBytes(java.nio.charset.StandardCharsets.UTF_8), originalAttachment());
    }

    @Test
    void accessDenied() throws Exception {
        chooseXds();
        search("0000000004");
        failedBeforeValidation("XDS-ACCESS");
    }
}
