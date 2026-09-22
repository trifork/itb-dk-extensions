package com.trifork.ihexdsapi.gitb;

import static org.junit.jupiter.api.Assertions.*;

import com.fasterxml.jackson.databind.JsonNode;
import com.gitb.core.AnyContent;
import com.gitb.ps.*;
import com.gitb.tr.TestResultType;
import jakarta.xml.ws.Endpoint;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.time.*;
import java.util.*;
import org.junit.jupiter.api.*;

class XdsProcessingServiceTest {
    private GitbXdsAccess access;
    private XdsProcessingService service;
    private String session;
    private String rows;
    private byte[] document;
    private JsonNode lastSearch, lastRetrieve;
    private int status;
    private int searchCalls;
    private long delay;
    private String error;
    private String errorBody;
    private String identities;
    private List<com.trifork.ihexdsapi.service.RegistryRouting.Choice> registryChoices;
    private MutableClock clock;

    @BeforeEach
    void setup() {
        registryChoices =
                List.of(
                        new com.trifork.ihexdsapi.service.RegistryRouting.Choice(
                                "default", "Configured XDS registry"));
        status = 200;
        delay = 0;
        error = "";
        errorBody = "sensitive-STStoken-DO-NOT-REPORT";
        identities =
                "[{\"id\":\"professional-1\",\"displayName\":\"Test professional\",\"credentialType\":\"HEALTHCAREPROFESSIONAL\",\"certificateKind\":\"MOCES\",\"validFrom\":\"2025-01-01T00:00:00Z\",\"validUntil\":\"2028-01-01T00:00:00Z\"}]";
        document =
                "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<ClinicalDocument xmlns=\"urn:hl7-org:v3\">\r\n<!-- æøå -->\r\n</ClinicalDocument>"
                        .getBytes(StandardCharsets.ISO_8859_1);
        rows =
                "[{\"patientId\":\"2512489996\",\"documentId\":\"doc-1\",\"repositoryID\":\"repo-1\",\"documentType\":\"PHMR\",\"serviceStart\":1704067200000}]";
        clock = new MutableClock();
        var operations =
                new com.trifork.ihexdsapi.service.XdsOperations() {
                    public java.util.List<com.trifork.ihexdsapi.service.RegistryRouting.Choice>
                            registries() {
                        return registryChoices;
                    }

                    private void before(String operation)
                            throws com.trifork.ihexdsapi.dgws.DgwsSecurityException {
                        if (delay > 0) {
                            try {
                                new java.util.concurrent.CountDownLatch(1)
                                        .await(delay, java.util.concurrent.TimeUnit.MILLISECONDS);
                            } catch (InterruptedException e) {
                                Thread.currentThread().interrupt();
                                throw new IllegalStateException(e);
                            }
                        }
                        if (status == 403)
                            throw new com.trifork.ihexdsapi.dgws.DgwsSecurityException(
                                    1000, errorBody);
                        if (status != 200) {
                            if (operation.equals("search")
                                    && errorBody.contains("SoapFault: Ingen aktive registries\""))
                                throw new org.apache.cxf.binding.soap.SoapFault(
                                        "Ingen aktive registries",
                                        org.apache.cxf.binding.soap.SoapFault.FAULT_CODE_SERVER);
                            if (errorBody.contains(
                                    "XDSUnavailableCommunity , UNAVAILABLE_COMMUNITY")) return;
                            throw new IllegalStateException(errorBody);
                        }
                    }

                    public java.util.List<org.openapitools.model.CredentialInfoResponse>
                            identities() {
                        try {
                            before("identities");
                            return java.util.Arrays.asList(
                                    GitbXdsAccess.JSON.readValue(
                                            identities,
                                            org.openapitools.model.CredentialInfoResponse[].class));
                        } catch (Exception e) {
                            throw new IllegalStateException(e);
                        }
                    }

                    public java.util.List<org.openapitools.model.Code> codes(boolean format) {
                        return java.util.List.of(
                                new org.openapitools.model.Code()
                                        .code("code-1")
                                        .name("Test, with comma")
                                        .scheme("scheme-1"),
                                new org.openapitools.model.Code()
                                        .code("code-2")
                                        .name("Second code")
                                        .scheme("scheme-2"));
                    }

                    public org.openehealth.ipf.commons.ihe.xds.core.responses.QueryResponse search(
                            org.openapitools.model.Iti18Request request)
                            throws com.trifork.ihexdsapi.dgws.DgwsSecurityException {
                        searchCalls++;
                        lastSearch = GitbXdsAccess.JSON.valueToTree(request);
                        before("search");
                        return FixtureData.search("{\"queryResponse\":" + rows + error + "}");
                    }

                    public com.trifork.ihexdsapi.service.RetrievedBytes retrieve(
                            org.openapitools.model.Iti43Request request)
                            throws com.trifork.ihexdsapi.dgws.DgwsSecurityException {
                        lastRetrieve = GitbXdsAccess.JSON.valueToTree(request);
                        before("retrieve");
                        var errors =
                                status == 400
                                        ? java.util.List.of(
                                                FixtureData.error(
                                                        org.openehealth.ipf.commons.ihe.xds.core
                                                                .responses.ErrorCode
                                                                .UNAVAILABLE_COMMUNITY,
                                                        "private-repository",
                                                        false))
                                        : java.util.List
                                                .<org.openehealth.ipf.commons.ihe.xds.core.responses
                                                                .ErrorInfo>
                                                        of();
                        return new com.trifork.ihexdsapi.service.RetrievedBytes(
                                status == 200 ? document : null, errors);
                    }
                };
        access = new GitbXdsAccess(operations, Duration.ofMillis(500));
        service = new XdsProcessingService(access, "Læge", "test-auth", clock);
        session = service.beginTransaction(new BeginTransactionRequest()).getSessionId();
    }

    @AfterEach
    void stop() {
        access.close();
    }

    private ProcessResponse call(String operation, String... inputs) {
        return callFor(service, session, operation, inputs);
    }

    private static ProcessResponse callFor(
            ProcessingService target, String session, String operation, String... inputs) {
        var r = new ProcessRequest();
        r.setSessionId(session);
        r.setOperation(operation);
        for (int i = 0; i < inputs.length; i += 2)
            r.getInput().add(XdsProcessingService.value(inputs[i], "string", inputs[i + 1]));
        return target.process(r);
    }

    private static AnyContent output(ProcessResponse r, String key) {
        return r.getOutput().stream()
                .filter(i -> key.equals(i.getName()))
                .findFirst()
                .orElseThrow();
    }

    private ProcessResponse search() {
        call("choices");
        return call("search", "patientId", "2512489996", "professional", "professional-1");
    }

    private static String handle(ProcessResponse r) {
        return output(r, "documents").getItem().get(0).getValue();
    }

    private static void failure(ProcessResponse response, String code) {
        assertEquals(TestResultType.FAILURE, response.getReport().getResult());
        assertTrue(
                response.getOutput().stream()
                        .allMatch(
                                i ->
                                        Set.of("errorCode", "errorMessage", "retrievedDocumentLog")
                                                .contains(i.getName())));
        assertEquals(code, output(response, "errorCode").getValue());
        assertFalse(output(response, "errorMessage").getValue().contains("sensitive-STStoken"));
        var bar =
                (com.gitb.tr.BAR)
                        response.getReport()
                                .getReports()
                                .getInfoOrWarningOrError()
                                .get(0)
                                .getValue();
        assertEquals(bar.getDescription(), output(response, "errorMessage").getValue());
        assertEquals(code, bar.getAssertionID());
        assertFalse(bar.getDescription().contains("sensitive-STStoken"));
    }

    @Test
    void selectedRegistrySurvivesFilteringAndCannotBeOverriddenDuringRetrieval() {
        registryChoices =
                List.of(
                        new com.trifork.ihexdsapi.service.RegistryRouting.Choice(
                                "one", "DDS, TEST"),
                        new com.trifork.ihexdsapi.service.RegistryRouting.Choice(
                                "two", "DDS, TEST"));
        var choices = call("choices");
        assertEquals("2", output(choices, "registryCount").getValue());
        var labels = output(choices, "registryLabels").getItem();
        assertNotEquals(labels.getFirst().getValue(), labels.getLast().getValue());
        assertFalse(labels.getLast().getValue().contains(","));
        for (String invalid : List.of("", "https://untrusted.invalid/registry")) {
            failure(
                    call(
                            "search",
                            "registry",
                            invalid,
                            "patientId",
                            "2512489996",
                            "professional",
                            "professional-1"),
                    "XDS-INPUT");
        }
        assertEquals(0, searchCalls);
        var found =
                call(
                        "search",
                        "registry",
                        labels.getLast().getValue(),
                        "patientId",
                        "2512489996",
                        "professional",
                        "professional-1");
        assertEquals("two", lastSearch.path("registryId").asText());
        var filtered = call("filter");
        assertEquals(TestResultType.SUCCESS, filtered.getReport().getResult());
        var retrieved = call("retrieve", "document", handle(found), "registry", "one");
        assertEquals(TestResultType.SUCCESS, retrieved.getReport().getResult());
        assertEquals("two", lastRetrieve.path("registryId").asText());
        assertTrue(
                retrieved.getReport().getContext().getItem().stream()
                        .anyMatch(
                                i ->
                                        "Registry".equals(i.getName())
                                                && labels.getLast()
                                                        .getValue()
                                                        .equals(i.getValue())));
        call(
                "search",
                "registry",
                "one",
                "patientId",
                "2512489996",
                "professional",
                "professional-1");
        assertEquals("one", lastSearch.path("registryId").asText());
        failure(call("retrieve", "document", handle(found)), "XDS-SELECTION");
    }

    @Test
    void invalidRegistryCatalogueFailsBeforeSearching() {
        registryChoices = List.of();
        failure(call("choices"), "XDS-RESPONSE");
        registryChoices =
                List.of(
                        new com.trifork.ihexdsapi.service.RegistryRouting.Choice("same", "One"),
                        new com.trifork.ihexdsapi.service.RegistryRouting.Choice("same", "Two"));
        failure(call("choices"), "XDS-RESPONSE");
        assertEquals(0, searchCalls);
    }

    @Test
    void roundTripPreservesBytesAndSearchContext() {
        var choices = call("choices");
        var details = choices.getReport().getContext().getItem();
        assertTrue(
                details.stream()
                        .anyMatch(
                                i ->
                                        i.getValue()
                                                .contains(
                                                        "MOCES — Test professional — expires 2028-01-01")));
        assertTrue(details.stream().anyMatch(i -> i.getValue().equals("Læge")));
        assertTrue(
                details.stream().anyMatch(i -> i.getValue().contains("code-1; scheme: scheme-1")));
        assertTrue(
                details.stream()
                        .anyMatch(i -> i.getValue().contains("No patient search has run yet")));
        assertFalse(details.stream().anyMatch(i -> i.getValue().contains("professional-1")));
        assertEquals(
                "Test; with comma (code-1; scheme: scheme-1)",
                output(choices, "typeLabels").getItem().get(1).getValue());
        var found =
                call(
                        "search",
                        "patientId",
                        "2512489996",
                        "professional",
                        "professional-1",
                        "typeCode",
                        output(choices, "typeCodes").getItem().get(1).getValue(),
                        "startFromDate",
                        "2026-01-01T00:00:00Z",
                        "endToDate",
                        "2026-02-01T00:00:00Z");
        assertEquals(TestResultType.SUCCESS, found.getReport().getResult());
        assertEquals("Approved", lastSearch.at("/queryParameters/availabilityStatus").asText());
        assertEquals("STABLE", lastSearch.at("/queryParameters/documentType/0").asText());
        assertEquals("scheme-1", lastSearch.at("/queryParameters/typeCode/codeScheme").asText());
        assertEquals(
                Instant.parse("2026-01-01T00:00:00Z").toEpochMilli(),
                lastSearch.at("/queryParameters/startFromDate").asLong());
        assertFalse(lastSearch.at("/context/consentOverride").asBoolean());
        assertEquals("Læge", lastSearch.at("/context/role").asText());
        var retrieved = call("retrieve", "document", handle(found));
        assertEquals(TestResultType.SUCCESS, retrieved.getReport().getResult());
        assertArrayEquals(
                document, Base64.getDecoder().decode(output(retrieved, "document").getValue()));
        assertEquals("binary", output(retrieved, "document").getType());
        assertTrue(output(retrieved, "retrievedDocumentLog").getValue().contains("<!-- æøå -->"));
        assertArrayEquals(document, reportAttachment(retrieved));
        assertEquals(lastSearch.get("context"), lastRetrieve.get("context"));
        assertEquals("professional-1", lastRetrieve.path("credentialId").asText());
        assertEquals("repo-1", lastRetrieve.at("/queryParameters/repositoryId").asText());
        assertEquals(
                "false", lastRetrieve.at("/queryParameters/includeFormattedResponse").asText());
        assertEquals("2512489996", lastRetrieve.at("/queryParameters/patientId").asText());
        failure(call("retrieve", "document", handle(found)), "XDS-SELECTION");
    }

    @Test
    void multipleCodesUseArraysAndKeepTypeAndFormatSeparate() {
        var choices = call("choices");
        String types =
                output(choices, "typeCodes").getItem().get(1).getValue()
                        + ","
                        + output(choices, "typeCodes").getItem().get(2).getValue();
        String formats =
                output(choices, "formatCodes").getItem().get(1).getValue()
                        + ","
                        + output(choices, "formatCodes").getItem().get(2).getValue();
        var response =
                call(
                        "search",
                        "patientId",
                        "2512489996",
                        "professional",
                        "professional-1",
                        "typeCode",
                        types,
                        "formatCode",
                        formats);
        assertEquals(TestResultType.SUCCESS, response.getReport().getResult());
        for (String field : List.of("type", "format")) {
            assertFalse(lastSearch.path("queryParameters").hasNonNull(field + "Code"));
            assertEquals(2, lastSearch.at("/queryParameters/" + field + "Codes").size());
            assertEquals(
                    "code-1", lastSearch.at("/queryParameters/" + field + "Codes/0/code").asText());
            assertEquals(
                    "scheme-2",
                    lastSearch.at("/queryParameters/" + field + "Codes/1/codeScheme").asText());
        }
        lastSearch = null;
        for (String invalid : List.of("any," + types, types + ",unknown", types + ",")) {
            failure(
                    call(
                            "search",
                            "patientId",
                            "2512489996",
                            "professional",
                            "professional-1",
                            "typeCode",
                            invalid),
                    "XDS-INPUT");
            assertNull(lastSearch);
        }
        failure(
                call(
                        "search",
                        "patientId",
                        "2512489996",
                        "professional",
                        "professional-1",
                        "formatCode",
                        types),
                "XDS-INPUT");
        assertNull(lastSearch);
        String first = output(choices, "typeCodes").getItem().get(1).getValue();
        call(
                "search",
                "patientId",
                "2512489996",
                "professional",
                "professional-1",
                "typeCode",
                first + "," + first);
        assertTrue(lastSearch.path("queryParameters").hasNonNull("typeCode"));
        call(
                "search",
                "patientId",
                "2512489996",
                "professional",
                "professional-1",
                "typeCode",
                "any",
                "formatCode",
                "");
        assertFalse(lastSearch.path("queryParameters").hasNonNull("typeCode"));
        assertFalse(lastSearch.path("queryParameters").hasNonNull("formatCode"));
    }

    @Test
    void readableSelectionsResolveToTheOriginalBackendValues() {
        var choices = call("choices");
        String professional = output(choices, "professionalLabels").getItem().get(0).getValue();
        String type = output(choices, "typeLabels").getItem().get(1).getValue();
        String format = output(choices, "formatLabels").getItem().get(2).getValue();
        var found =
                call(
                        "search",
                        "patientId",
                        "2512489996",
                        "professional",
                        professional,
                        "typeCode",
                        type,
                        "formatCode",
                        format);
        assertEquals(TestResultType.SUCCESS, found.getReport().getResult());
        assertEquals("professional-1", lastSearch.path("credentialId").asText());
        assertEquals("code-1", lastSearch.at("/queryParameters/typeCode/code").asText());
        assertEquals("scheme-2", lastSearch.at("/queryParameters/formatCode/codeScheme").asText());
        String selectedDocument = output(found, "documentLabels").getItem().get(0).getValue();
        assertEquals(
                TestResultType.SUCCESS,
                call("retrieve", "document", selectedDocument).getReport().getResult());
        assertEquals("doc-1", lastRetrieve.at("/queryParameters/documentId").asText());
        failure(call("retrieve", "document", selectedDocument), "XDS-SELECTION");
    }

    @Test
    void readableMultipleCodesAndAnyRetainSearchSemantics() {
        var choices = call("choices");
        String selected =
                String.join(
                        ",",
                        output(choices, "typeLabels").getItem().subList(1, 3).stream()
                                .map(AnyContent::getValue)
                                .toList());
        var result =
                call(
                        "search",
                        "patientId",
                        "2512489996",
                        "professional",
                        "professional-1",
                        "typeCode",
                        selected);
        assertEquals(TestResultType.SUCCESS, result.getReport().getResult());
        assertEquals(2, lastSearch.at("/queryParameters/typeCodes").size());
        assertEquals("code-1", lastSearch.at("/queryParameters/typeCodes/0/code").asText());
        lastSearch = null;
        failure(
                call(
                        "search",
                        "patientId",
                        "2512489996",
                        "professional",
                        "professional-1",
                        "typeCode",
                        "Any," + selected),
                "XDS-INPUT");
        assertNull(lastSearch);
        call(
                "search",
                "patientId",
                "2512489996",
                "professional",
                "professional-1",
                "typeCode",
                "Any",
                "formatCode",
                "Any");
        assertFalse(lastSearch.path("queryParameters").hasNonNull("typeCode"));
        assertFalse(lastSearch.path("queryParameters").hasNonNull("formatCode"));
    }

    @Test
    void duplicateIdentityLabelsRemainDistinctAndTamperedLabelsAreRejected() {
        identities = identities.replace("Test professional", "Test, professional");
        identities =
                identities.substring(0, identities.length() - 1)
                        + ","
                        + identities.substring(1).replace("professional-1", "professional-2");
        var choices = call("choices");
        var labels = output(choices, "professionalLabels").getItem();
        String first = labels.get(0).getValue(), second = labels.get(1).getValue();
        assertTrue(first.contains("Test; professional"));
        assertEquals(first + " [2]", second);
        call("search", "patientId", "2512489996", "professional", second);
        assertEquals("professional-2", lastSearch.path("credentialId").asText());
        lastSearch = null;
        failure(
                call("search", "patientId", "2512489996", "professional", first + " changed"),
                "XDS-INPUT");
        failure(
                call(
                        "search",
                        "patientId",
                        "2512489996",
                        "professional",
                        first,
                        "typeCode",
                        "Invented code (injected)"),
                "XDS-INPUT");
        assertNull(lastSearch);
    }

    @Test
    void documentPayloadCanExceedMetadataLengthLimit() {
        document =
                ("<ClinicalDocument xmlns='urn:hl7-org:v3'><!--"
                                + "x".repeat(20000)
                                + "--></ClinicalDocument>")
                        .getBytes(StandardCharsets.UTF_8);
        String handle = handle(search());
        var result = call("retrieve", "document", handle);
        assertEquals(TestResultType.SUCCESS, result.getReport().getResult());
        assertArrayEquals(
                document, Base64.getDecoder().decode(output(result, "document").getValue()));
    }

    @Test
    void noResultsAndUniqueIdFilter() {
        call("choices");
        var result =
                call(
                        "search",
                        "patientId",
                        "2512489996",
                        "professional",
                        "professional-1",
                        "uniqueId",
                        "not-present");
        assertEquals("0", output(result, "count").getValue());
        assertTrue(output(result, "documents").getItem().isEmpty());
        assertEquals(TestResultType.SUCCESS, result.getReport().getResult());
        assertFalse(lastSearch.path("queryParameters").hasNonNull("uniqueId"));
    }

    @Test
    void allResultsRemainExplicitChoices() {
        rows =
                rows.substring(0, rows.length() - 1)
                        + ","
                        + rows.substring(1).replace("doc-1", "doc-2");
        var result = search();
        assertEquals("2", output(result, "count").getValue());
        assertNull(lastRetrieve);
        assertEquals(2, output(result, "documentLabels").getItem().size());
    }

    private ProcessResponse searchThreeRepositories() {
        String row = rows.substring(1, rows.length() - 1);
        rows =
                "["
                        + row.replace("repo-1", "1.2.208.176.43210.8.1.30")
                        + ","
                        + row.replace("doc-1", "doc-2")
                                .replace("repo-1", "1.2.208.176.43210.8.1.29")
                        + ","
                        + row.replace("doc-1", "doc-3").replace("repo-1", "2.999.1")
                        + "]";
        return search();
    }

    @Test
    void repositoryFilteringIncludesExcludesAndRestoresWithoutSearchingAgain() {
        var found = searchThreeRepositories();
        var repos = output(found, "repositoryLabels").getItem();
        assertTrue(repos.get(0).getValue().contains("KIH Repository · TEST1 / PRODTEST"));
        assertTrue(repos.get(2).getValue().contains("2.999.1"));
        String selection = repos.get(0).getValue() + "," + repos.get(2).getValue();
        var only =
                call(
                        "filter",
                        "repositoryMode",
                        "Only selected repositories",
                        "repositories",
                        selection);
        assertEquals("2", output(only, "count").getValue());
        assertTrue(
                output(only, "summary")
                        .getValue()
                        .contains(
                                "Included repositories: KIH Repository · TEST1 / PRODTEST; 2.999.1."));
        assertTrue(
                output(only, "summary")
                        .getValue()
                        .contains("Excluded repositories: KIH Repository · TEST2."));
        assertEquals(
                output(found, "documents").getItem().get(2).getValue(),
                output(only, "documents").getItem().get(1).getValue());
        var excluded =
                call(
                        "filter",
                        "repositoryMode",
                        "Exclude selected repositories",
                        "repositories",
                        selection);
        assertEquals("1", output(excluded, "count").getValue());
        assertTrue(
                output(excluded, "summary")
                        .getValue()
                        .contains("Included repositories: KIH Repository · TEST2."));
        assertTrue(
                output(excluded, "summary")
                        .getValue()
                        .contains(
                                "Excluded repositories: KIH Repository · TEST1 / PRODTEST; 2.999.1."));
        assertEquals(output(found, "documents").getItem().get(1).getValue(), handle(excluded));
        failure(call("retrieve", "document", handle(found)), "XDS-SELECTION");
        failure(
                call(
                        "retrieve",
                        "document",
                        output(found, "documentLabels").getItem().get(0).getValue()),
                "XDS-SELECTION");
        assertNull(lastRetrieve);
        String all = String.join(",", repos.stream().map(AnyContent::getValue).toList());
        var empty =
                call(
                        "filter",
                        "repositoryMode",
                        "Exclude selected repositories",
                        "repositories",
                        all);
        assertEquals("0", output(empty, "count").getValue());
        assertTrue(output(empty, "summary").getValue().contains("Included repositories: None."));
        assertEquals(3, output(empty, "repositoryLabels").getItem().size());
        for (String mode :
                List.of(
                        "All repositories",
                        "Only selected repositories",
                        "Exclude selected repositories")) {
            assertEquals(
                    "3",
                    output(call("filter", "repositoryMode", mode, "repositories", ""), "count")
                            .getValue());
        }
        assertEquals(
                "3",
                output(
                                call(
                                        "filter",
                                        "repositoryMode",
                                        "All repositories",
                                        "repositories",
                                        all),
                                "count")
                        .getValue());
        assertEquals(1, searchCalls);
        assertEquals(
                TestResultType.SUCCESS,
                call(
                                "retrieve",
                                "document",
                                output(found, "documentLabels").getItem().get(2).getValue())
                        .getReport()
                        .getResult());
        assertEquals("doc-3", lastRetrieve.at("/queryParameters/documentId").asText());
        assertEquals("2.999.1", lastRetrieve.at("/queryParameters/repositoryId").asText());
    }

    @Test
    void repositorySelectionsAreBoundToCurrentSearchAndRejectTampering() {
        failure(call("filter"), "XDS-SELECTION");
        var found = searchThreeRepositories();
        String repository = output(found, "repositories").getItem().get(0).getValue();
        assertEquals(
                "1",
                output(
                                call(
                                        "filter",
                                        "repositoryMode",
                                        "Only selected repositories",
                                        "repositories",
                                        repository),
                                "count")
                        .getValue());
        for (String invalid : List.of("1.2.208.176.43210.8.1.30", repository + ",", "invented")) {
            failure(
                    call(
                            "filter",
                            "repositoryMode",
                            "Only selected repositories",
                            "repositories",
                            invalid),
                    "XDS-INPUT");
            failure(call("retrieve", "document", handle(found)), "XDS-SELECTION");
        }
        failure(call("filter", "repositoryMode", "invalid"), "XDS-INPUT");
        String other = service.beginTransaction(new BeginTransactionRequest()).getSessionId();
        callFor(service, other, "choices");
        callFor(
                service,
                other,
                "search",
                "patientId",
                "2512489996",
                "professional",
                "professional-1");
        failure(callFor(service, other, "filter", "repositories", repository), "XDS-INPUT");
        search();
        failure(call("filter", "repositories", repository), "XDS-INPUT");
        assertNull(lastRetrieve);
    }

    private static byte[] reportAttachment(ProcessResponse response) {
        var attachment =
                response.getReport().getContext().getItem().stream()
                        .filter(i -> "retrieved-document".equals(i.getName()))
                        .findFirst()
                        .orElseThrow();
        return Base64.getDecoder().decode(attachment.getValue());
    }

    private static void assertSummaryOnly(ProcessResponse response, String expected) {
        var items = response.getReport().getContext().getItem();
        assertEquals(2, items.size());
        assertEquals("Registry", items.getLast().getName());
        assertEquals("Configured XDS registry", items.getLast().getValue());
        assertEquals("Results", items.getFirst().getName());
        assertEquals(expected, items.getFirst().getValue());
    }

    @Test
    void compactLabelsStayDistinctAndOnlySelectedMetadataIsReported() {
        String id = "1.2.208.184^same-long-prefix-unique-document-";
        String row =
                rows.substring(1, rows.length() - 1)
                        .replace("repo-1", "1.2.208.176.43210.8.1.30")
                        .replace("\"PHMR\"", "\"Personal Health Monitoring Report\"");
        rows = "[" + row.replace("doc-1", id + "1") + "," + row.replace("doc-1", id + "2") + "]";
        var found = search();
        var labels = output(found, "documentLabels").getItem();
        assertNotEquals(labels.get(0).getValue(), labels.get(1).getValue());
        assertTrue(labels.get(0).getValue().startsWith("#1 | " + id.substring(0, 17) + "… | "));
        assertTrue(labels.get(1).getValue().startsWith("#2 | " + id.substring(0, 17) + "… | "));
        for (var label : labels) {
            assertTrue(label.getValue().length() < 120);
            assertTrue(
                    label.getValue()
                            .contains(
                                    "KIH Repository · TEST1 / PRODTEST | PHMR | 2024-01-01 00:00 UTC"));
            assertFalse(label.getValue().contains(","));
        }
        assertSummaryOnly(found, "Showing 2 of 2 fetched documents. All repositories.");
        var filtered = call("filter", "repositoryMode", "All repositories");
        assertSummaryOnly(filtered, "Showing 2 of 2 fetched documents. All repositories.");
        var retrieved = call("retrieve", "document", labels.get(1).getValue());
        assertEquals(TestResultType.SUCCESS, retrieved.getReport().getResult());
        assertEquals(3, retrieved.getReport().getContext().getItem().size());
        var selected = retrieved.getReport().getContext().getItem().getFirst();
        assertEquals("Selected document", selected.getName());
        assertTrue(selected.getValue().contains(id + "2"));
        assertFalse(selected.getValue().contains(id + "1"));
        assertTrue(selected.getValue().contains("2024-01-01T00:00:00Z"));
        assertTrue(selected.getValue().contains("1.2.208.176.43210.8.1.30"));
        assertEquals(id + "2", lastRetrieve.at("/queryParameters/documentId").asText());
    }

    @Test
    void handlesCannotCrossSessionsOrSearches() {
        String handle = handle(search());
        String other = service.beginTransaction(new BeginTransactionRequest()).getSessionId();
        failure(callFor(service, other, "retrieve", "document", handle), "XDS-SELECTION");
        search();
        failure(call("retrieve", "document", handle), "XDS-SELECTION");
    }

    @Test
    void invalidSearchAlsoInvalidatesHandles() {
        String handle = handle(search());
        failure(call("search", "patientId", "bad", "professional", "professional-1"), "XDS-INPUT");
        failure(call("retrieve", "document", handle), "XDS-SELECTION");
    }

    @Test
    void inputValidation() {
        call("choices");
        failure(
                call("search", "patientId", "2512489996", "professional", "unconfigured"),
                "XDS-INPUT");
        failure(
                call(
                        "search",
                        "patientId",
                        "2512489996",
                        "professional",
                        "professional-1",
                        "typeCode",
                        "arbitrary"),
                "XDS-INPUT");
        failure(
                call(
                        "search",
                        "patientId",
                        "2512489996",
                        "professional",
                        "professional-1",
                        "startFromDate",
                        "2026-01-01"),
                "XDS-INPUT");
        failure(
                call(
                        "search",
                        "patientId",
                        "2512489996",
                        "professional",
                        "professional-1",
                        "startFromDate",
                        "2026-02-01T00:00:00Z",
                        "startToDate",
                        "2026-01-01T00:00:00Z"),
                "XDS-INPUT");
        assertNull(lastSearch);
    }

    @Test
    void expiredAndEndedTransactions() {
        search();
        clock.now = clock.now.plus(Duration.ofMinutes(31));
        failure(call("search"), "XDS-EXPIRED");
        session = service.beginTransaction(new BeginTransactionRequest()).getSessionId();
        var end = new BasicRequest();
        end.setSessionId(session);
        service.endTransaction(end);
        failure(call("choices"), "XDS-EXPIRED");
    }

    @Test
    void upstreamErrorsAreNotCdaFailures() {
        call("choices");
        status = 403;
        failure(
                call("search", "patientId", "2512489996", "professional", "professional-1"),
                "XDS-ACCESS");
        status = 400;
        var badRequest =
                call("search", "patientId", "2512489996", "professional", "professional-1");
        failure(badRequest, "XDS-BACKEND");
        assertFalse(output(badRequest, "errorMessage").getValue().contains("HTTP"));
        status = 500;
        failure(call("choices"), "XDS-BACKEND");
        status = 200;
        call("choices");
        error = ",\"errors\":[{\"severity\":\"ERROR\",\"codeContext\":\"sensitive-STStoken\"}]";
        failure(
                call("search", "patientId", "2512489996", "professional", "professional-1"),
                "XDS-REGISTRY");
    }

    @Test
    void timeoutIsReported() {
        delay = 1000;
        failure(call("choices"), "XDS-TIMEOUT");
    }

    @Test
    void partialSearchErrorsExplainWhyDocumentsAreNotOffered() {
        error =
                ",\"errors\":[{\"severity\":\"ERROR\",\"errorCode\":\"XDSRegistryMetadataError , REGISTRY_METADATA_ERROR\",\"codeContext\":\"sensitive-STStoken\"},"
                        + "{\"severity\":\"ERROR\",\"codeContext\":\"urn:dk:nsi:Information Withheld due to Extraction Error\"},"
                        + "{\"severity\":\"WARNING\",\"codeContext\":\"urn:dk:nsi:Consent Filter Applied\"}]";
        var result = search();
        failure(result, "XDS-REGISTRY");
        String message = output(result, "errorMessage").getValue();
        assertTrue(message.contains("1 document(s) and 2 registry error(s)"));
        assertTrue(message.contains("invalid registry metadata"));
        assertTrue(message.contains("information withheld due to an extraction error"));
        assertTrue(message.contains("results may be incomplete"));
        assertFalse(message.contains("CDA validation has not run")); // TDL adds this once.
        rows = "[]";
        assertTrue(output(search(), "errorMessage").getValue().contains("0 document(s)"));
    }

    @Test
    void warningOnlySearchStillOffersDocuments() {
        error = ",\"errors\":[{\"severity\":\"WARNING\",\"codeContext\":\"sensitive-STStoken\"}]";
        var result = search();
        assertEquals(TestResultType.SUCCESS, result.getReport().getResult());
        assertNotNull(handle(result));
    }

    @Test
    void noActiveRegistriesHasAnActionableSafeMessage() {
        call("choices");
        status = 400;
        errorBody =
                "{\"error\":\"org.apache.cxf.binding.soap.SoapFault: Ingen aktive registries\",\"otherError\":[\"sensitive-STStoken\"]}";
        var response = call("search", "patientId", "2512489996", "professional", "professional-1");
        failure(response, "XDS-NO-ACTIVE-REGISTRIES");
        assertTrue(output(response, "errorMessage").getValue().contains("Type code: Any"));
        assertTrue(output(response, "errorMessage").getValue().contains("no active registries"));
        status = 403;
        failure(
                call("search", "patientId", "2512489996", "professional", "professional-1"),
                "XDS-ACCESS");
        status = 400;
        failure(call("choices"), "XDS-BACKEND");
    }

    @Test
    void unknownBackendFaultsRemainRedacted() {
        call("choices");
        status = 400;
        for (String body :
                List.of(
                        "{\"error\":\"org.apache.cxf.binding.soap.SoapFault: Ingen aktive registries sensitive-STStoken\"}",
                        "{\"error\":\"sensitive-STStoken\"}",
                        "null",
                        "<html>sensitive-STStoken</html>")) {
            errorBody = body;
            failure(
                    call("search", "patientId", "2512489996", "professional", "professional-1"),
                    "XDS-BACKEND");
        }
    }

    @Test
    void retrievalGatewayErrorReachesReportAndLogOutputWithoutBackendContext() {
        rows = rows.replace("repo-1", "1.2.208.176.43210.8.1.30");
        String selected = handle(search());
        status = 400;
        errorBody =
                "{\"error_code\":1000,\"error\":\"Failed to retrieve document sensitive-STStoken\","
                        + "\"otherError\":[\"Responding gateway identified by Repository Unique Id: private-repository could not be contacted., XDSUnavailableCommunity , UNAVAILABLE_COMMUNITY, ERROR, null\"]}";
        var response = call("retrieve", "document", selected);
        failure(response, "XDS-REGISTRY");
        String message = output(response, "errorMessage").getValue();
        assertTrue(message.contains("ITI-43) failed."));
        assertTrue(message.contains("XDSUnavailableCommunity"));
        assertTrue(message.contains("gateway is unavailable"));
        assertTrue(message.contains("Retry later"));
        assertTrue(
                message.contains(
                        "Selected repository: 1.2.208.176.43210.8.1.30 (KIH Repository, TEST1 / PRODTEST)."));
        assertEquals(
                "1.2.208.176.43210.8.1.30",
                lastRetrieve.at("/queryParameters/repositoryId").asText());
        assertFalse(message.contains("private-repository"));
        assertEquals(
                "No retrieved document bytes are available.",
                output(response, "retrievedDocumentLog").getValue());
        var metadata = response.getReport().getContext().getItem();
        assertEquals(2, metadata.size());
        assertEquals("Configured XDS registry", metadata.getLast().getValue());
        assertEquals("Selected document", metadata.getFirst().getName());
        assertTrue(metadata.getFirst().getValue().contains("Unique ID: doc-1"));
    }

    @Test
    void retrievalFailuresIdentifyOnlyTheSavedRepositoryWithSafeUnknownFallbacks() {
        for (String repository :
                List.of("2.999.1", "private-repository", "1.2.3\nERROR injected")) {
            rows =
                    "[{\"patientId\":\"2512489996\",\"documentId\":\"doc-1\",\"repositoryID\":"
                            + GitbXdsAccess.JSON.valueToTree(repository)
                            + "}]";
            status = 200;
            String selected = handle(search());
            status = 400;
            errorBody = "{\"error\":\"sensitive-STStoken repository 1.2.208.176.43210.8.1.30\"}";
            var response = call("retrieve", "document", selected);
            failure(response, "XDS-BACKEND");
            String message = output(response, "errorMessage").getValue();
            assertFalse(message.contains("KIH"));
            assertFalse(message.contains("1.2.208.176.43210.8.1.30"));
            assertFalse(message.contains("private-repository"));
            assertFalse(message.contains("ERROR injected"));
            assertEquals(repository, lastRetrieve.at("/queryParameters/repositoryId").asText());
            assertTrue(
                    message.contains(
                            repository.equals("2.999.1")
                                    ? "Selected repository: 2.999.1 (name/environment unknown)."
                                    : "Selected repository: unrecognised repository identifier"));
        }
    }

    @Test
    void rejectsWrongPatientAndIncompleteMetadata() {
        rows = rows.replace("2512489996", "9999999999");
        failure(search(), "XDS-RESPONSE");
        rows = "[{}]";
        failure(search(), "XDS-RESPONSE");
    }

    @Test
    void rejectsNonCdaMalformedXmlAndExternalEntities() {
        for (String content :
                List.of(
                        "<html/>",
                        "<ClinicalDocument",
                        "<!DOCTYPE x [<!ENTITY secret SYSTEM 'file:///etc/passwd'>]><ClinicalDocument xmlns='urn:hl7-org:v3'>&secret;</ClinicalDocument>")) {
            String handle = handle(search());
            document = content.getBytes(StandardCharsets.UTF_8);
            var response = call("retrieve", "document", handle);
            failure(response, "XDS-CONTENT");
            assertTrue(output(response, "retrievedDocumentLog").getValue().contains(content));
            assertArrayEquals(document, reportAttachment(response));
        }
    }

    @Test
    void previewIsBoundedWhileOriginalAttachmentRemainsComplete() {
        document = ("<html>" + "x".repeat(100000) + "</html>").getBytes(StandardCharsets.UTF_8);
        var response = call("retrieve", "document", handle(search()));
        failure(response, "XDS-CONTENT");
        String preview = output(response, "retrievedDocumentLog").getValue();
        assertTrue(preview.contains("Preview truncated"));
        assertTrue(preview.length() < DocumentPreview.LIMIT + 1000);
        assertArrayEquals(document, reportAttachment(response));
        assertTrue(
                DocumentPreview.format(
                                "<?xml version='1.0'?><html>æøå</html>"
                                        .getBytes(StandardCharsets.UTF_16))
                        .contains("æøå"));
    }

    @Test
    void soapContractPublishesAndRoundTrips() throws Exception {
        int port;
        try (var socket = new java.net.ServerSocket(0)) {
            port = socket.getLocalPort();
        }
        Endpoint endpoint = Endpoint.publish("http://127.0.0.1:" + port + "/processing", service);
        try {
            var soap =
                    new ProcessingServiceService(
                                    URI.create("http://127.0.0.1:" + port + "/processing?wsdl")
                                            .toURL())
                            .getProcessingServicePort();
            String id = soap.beginTransaction(new BeginTransactionRequest()).getSessionId();
            assertNotNull(soap.getModuleDefinition(new com.gitb.ps.Void()));
            var choices = callFor(soap, id, "choices");
            assertEquals(TestResultType.SUCCESS, choices.getReport().getResult());
            assertEquals(
                    "professional-1", output(choices, "professionals").getItem().get(0).getValue());
            var found =
                    callFor(
                            soap,
                            id,
                            "search",
                            "patientId",
                            "2512489996",
                            "professional",
                            "professional-1");
            var retrieved = callFor(soap, id, "retrieve", "document", handle(found));
            assertArrayEquals(
                    document, Base64.getDecoder().decode(output(retrieved, "document").getValue()));
            found =
                    callFor(
                            soap,
                            id,
                            "search",
                            "patientId",
                            "2512489996",
                            "professional",
                            "professional-1");
            document = "<html>bad\u0000content</html>".getBytes(StandardCharsets.UTF_8);
            retrieved = callFor(soap, id, "retrieve", "document", handle(found));
            failure(retrieved, "XDS-CONTENT");
            assertTrue(
                    output(retrieved, "retrievedDocumentLog")
                            .getValue()
                            .contains("bad\\u0000content"));
            assertArrayEquals(document, reportAttachment(retrieved));
        } finally {
            endpoint.stop();
        }
    }

    private static final class MutableClock extends Clock {
        Instant now = Instant.parse("2026-01-01T00:00:00Z");

        public ZoneId getZone() {
            return ZoneOffset.UTC;
        }

        public Clock withZone(ZoneId zone) {
            return this;
        }

        public Instant instant() {
            return now;
        }
    }
}
