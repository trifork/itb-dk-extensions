package com.trifork.ihexdsapi.controller;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.sun.net.httpserver.HttpServer;
import com.trifork.ihexdsapi.configuration.IheXdsConfiguration;
import com.trifork.ihexdsapi.dao.impl.CacheRequestResponseHandleImpl;
import com.trifork.ihexdsapi.dgws.*;
import com.trifork.ihexdsapi.service.*;
import com.trifork.ihexdsapi.service.impl.IDContextServiceImpl;
import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import javax.xml.parsers.DocumentBuilderFactory;
import org.junit.jupiter.api.*;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.test.web.servlet.*;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

/** REST boundary tests with the real IPF/CXF wire stack; only STS and remote XDS are fixtures. */
class XdsRestContractTest {
    private static final String PATIENT = "3001749995";
    private static final String NS = "urn:oasis:names:tc:ebxml-regrep:xsd:";
    private static final String SUCCESS =
            "urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success";
    private static final String XML =
            """
            <?xml version="1.0" encoding="ISO-8859-1"?>\r
            <ClinicalDocument xmlns="urn:hl7-org:v3">\r
              <title>æøå</title>\r
            </ClinicalDocument>\
            """;
    private static final String FORMATTED =
            """
            <ClinicalDocument xmlns="urn:hl7-org:v3">
                <title>æøå</title>
            </ClinicalDocument>
            """;
    private HttpServer server;
    private IheXdsConfiguration config;
    private IDContextService ids;
    private MockMvc http;
    private ObjectMapper json;
    private DgwsService dgws;
    private volatile String responseBody, responseType, lastSoap;
    private volatile int responseStatus;

    @BeforeEach
    void setup() throws Exception {
        responseStatus = 200;
        responseType = "text/xml; charset=UTF-8";
        responseBody = envelope(queryResponse("", ""));
        server = HttpServer.create(new InetSocketAddress("127.0.0.1", 0), 0);
        server.createContext(
                "/",
                exchange -> {
                    lastSoap =
                            new String(
                                    exchange.getRequestBody().readAllBytes(),
                                    StandardCharsets.UTF_8);
                    if (lastSoap.stripLeading().startsWith("--")) {
                        int start = lastSoap.indexOf("\r\n\r\n") + 4;
                        lastSoap = lastSoap.substring(start, lastSoap.indexOf("\r\n--", start));
                    }
                    byte[] bytes = responseBody.getBytes(StandardCharsets.UTF_8);
                    exchange.getResponseHeaders().set("Content-Type", responseType);
                    exchange.sendResponseHeaders(responseStatus, bytes.length);
                    exchange.getResponseBody().write(bytes);
                    exchange.close();
                });
        server.start();
        config = new IheXdsConfiguration();
        String endpoint = "http://127.0.0.1:" + server.getAddress().getPort() + "/xds";
        ReflectionTestUtils.setField(config, "xdsIti18Endpoint", endpoint);
        ReflectionTestUtils.setField(config, "xdsIti43Endpoint", endpoint);
        var cache =
                new CacheRequestResponseHandleImpl(
                        java.time.Clock.systemUTC(), java.time.Duration.ofHours(2), 100);
        ids = new IDContextServiceImpl();
        var query = config.iti18Service(config.getDocumentRegistryServiceIti18(cache, ids));
        var retrieve = config.iti43Service(config.getDocumentRepositoryServiceIti43());
        dgws = mock(DgwsService.class);
        when(dgws.getHealthCareProfessionalClientInfo(anyString(), anyString(), any()))
                .thenAnswer(
                        call -> {
                            var factory = DocumentBuilderFactory.newInstance();
                            factory.setNamespaceAware(true);
                            var sosi =
                                    factory.newDocumentBuilder()
                                            .parse(
                                                    new ByteArrayInputStream(
                                                            envelope("")
                                                                    .getBytes(
                                                                            StandardCharsets
                                                                                    .UTF_8)));
                            return new DgwsClientInfo(
                                    sosi,
                                    "0101019999",
                                    call.getArgument(0),
                                    "FT001",
                                    "123456789012345",
                                    false);
                        });
        var controller =
                new IheXdsController(
                        com.trifork.ihexdsapi.service.RegistryRouting.legacy(dgws, query, retrieve),
                        cache,
                        ids);
        json = new ObjectMapper().registerModule(new JavaTimeModule());
        http =
                MockMvcBuilders.standaloneSetup(controller)
                        .setControllerAdvice(new ErrorController())
                        .setMessageConverters(new MappingJackson2HttpMessageConverter(json))
                        .build();
    }

    @AfterEach
    void stop() {
        if (config != null) config.destroyClients();
        if (server != null) server.stop(0);
    }

    private String download(String direction, String id) throws Exception {
        var response =
                http.perform(get("/v1/" + direction + "/{id}", id)).andReturn().getResponse();
        assertEquals(200, response.getStatus());
        return json.readTree(response.getContentAsByteArray()).path("payload").asText();
    }

    private static String soapPayload(String log) {
        return log.substring(
                log.indexOf("\nPayload: ") + "\nPayload: ".length(),
                log.lastIndexOf("\n--------------------------------------"));
    }

    @Test
    void downloadableLogsRemainCompleteAndDistinctAcrossQueries() throws Exception {
        String largeEntry =
                entry().replace("Personal health monitoring report", "æøå".repeat(20000));
        responseBody = envelope(queryResponse(largeEntry, ""));
        String firstResponse = responseBody;
        JsonNode first = request("/v1/iti18", query(), 200);
        String firstRequest = lastSoap;
        responseBody = envelope(queryResponse("", ""));
        JsonNode second = request("/v1/iti18", query(), 200);
        assertNotEquals(first.path("requestId"), second.path("requestId"));
        assertNotEquals(first.path("responseId"), second.path("responseId"));
        assertTrue(firstResponse.length() > 48 * 1024);
        assertEquals(
                firstRequest, soapPayload(download("request", first.path("requestId").asText())));
        assertEquals(
                firstResponse,
                soapPayload(download("response", first.path("responseId").asText())));
        assertEquals(
                responseBody,
                soapPayload(download("response", second.path("responseId").asText())));
    }

    @Test
    void soapFaultIsAvailableThroughTheResponseDownload() throws Exception {
        responseStatus = 500;
        responseBody =
                envelope(
                        "<s:Fault"
                                + " xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'><faultcode>s:Server</faultcode><faultstring>fixture"
                                + " error</faultstring></s:Fault>");
        request("/v1/iti18", query(), 400);
        assertEquals(lastSoap, soapPayload(download("request", ids.getId("tempReq"))));
        assertEquals(responseBody, soapPayload(download("response", ids.getId("tempRes"))));
    }

    private static String envelope(String body) {
        return "<s:Envelope xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'><s:Header/><s:Body>"
                + body
                + "</s:Body></s:Envelope>";
    }

    private static String queryResponse(String entries, String errors) {
        return "<q:AdhocQueryResponse xmlns:q='"
                + NS
                + "query:3.0' xmlns:r='"
                + NS
                + "rim:3.0' xmlns:rs='"
                + NS
                + "rs:3.0' status='"
                + SUCCESS
                + "'>"
                + errors
                + "<r:RegistryObjectList>"
                + entries
                + "</r:RegistryObjectList></q:AdhocQueryResponse>";
    }

    private static String slot(String name, String value) {
        return "<r:Slot name='"
                + name
                + "'><r:ValueList><r:Value>"
                + value
                + "</r:Value></r:ValueList></r:Slot>";
    }

    private static String entry() {
        return "<r:ExtrinsicObject id='urn:uuid:document-1' mimeType='text/xml'"
                + " objectType='urn:uuid:34268e47-fdf5-41a6-ba33-82133c465248'>"
                + slot("repositoryUniqueId", "1.2.3.4")
                + slot("serviceStartTime", "20260102030405")
                + slot("serviceStopTime", "20260102040506")
                + "<r:Classification id='type' classifiedObject='urn:uuid:document-1'"
                + " classificationScheme='urn:uuid:f0306f51-975f-434e-a61c-c59651d33983'"
                + " nodeRepresentation='53576-5'>"
                + slot("codingScheme", "2.16.840.1.113883.6.1")
                + "<r:Name><r:LocalizedString value='Personal health monitoring"
                + " report'/></r:Name></r:Classification><r:ExternalIdentifier id='unique'"
                + " registryObject='urn:uuid:document-1'"
                + " identificationScheme='urn:uuid:2e82c1f6-a085-4c72-9da3-8640a32e42ab'"
                + " value='1.2.3.5'/></r:ExtrinsicObject>";
    }

    private JsonNode request(String path, Map<String, Object> query, int expected)
            throws Exception {
        Map<String, Object> body =
                new LinkedHashMap<>(
                        Map.of(
                                "credentialId",
                                "employee",
                                "context",
                                Map.of(
                                        "role",
                                        "Læge",
                                        "authorizationCode",
                                        "FT001",
                                        "consentOverride",
                                        false),
                                "queryParameters",
                                query));
        if (path.endsWith("uniqueID")) {
            var nested = new LinkedHashMap<String, Object>(query);
            nested.put("credentialId", body.remove("credentialId"));
            nested.put("context", body.remove("context"));
            body.put("queryParameters", nested);
        }
        var response =
                http.perform(
                                post(path)
                                        .contentType(MediaType.APPLICATION_JSON)
                                        .content(json.writeValueAsBytes(body)))
                        .andReturn()
                        .getResponse();
        assertEquals(expected, response.getStatus(), response.getContentAsString());
        return json.readTree(response.getContentAsByteArray());
    }

    private static Map<String, Object> query() {
        var q = new LinkedHashMap<String, Object>();
        q.put("patientId", PATIENT);
        q.put("availabilityStatus", "Approved");
        q.put("documentType", List.of("STABLE"));
        return q;
    }

    private static Map<String, Object> retrieval() {
        return Map.of("patientId", PATIENT, "documentId", "1.2.3.5", "repositoryId", "1.2.3.4");
    }

    private String soapValue(String name) throws Exception {
        var f = DocumentBuilderFactory.newInstance();
        f.setNamespaceAware(true);
        var d =
                f.newDocumentBuilder()
                        .parse(new ByteArrayInputStream(lastSoap.getBytes(StandardCharsets.UTF_8)));
        var slots = d.getElementsByTagNameNS(NS + "rim:3.0", "Slot");
        for (int i = 0; i < slots.getLength(); i++) {
            var e = (org.w3c.dom.Element) slots.item(i);
            if (name.equals(e.getAttribute("name"))) return e.getTextContent();
        }
        return null;
    }

    private String soapElement(String name) throws Exception {
        var f = DocumentBuilderFactory.newInstance();
        f.setNamespaceAware(true);
        return f.newDocumentBuilder()
                .parse(new ByteArrayInputStream(lastSoap.getBytes(StandardCharsets.UTF_8)))
                .getElementsByTagNameNS("urn:ihe:iti:xds-b:2007", name)
                .item(0)
                .getTextContent();
    }

    @Test
    void mtomRetrievalKeepsTheExistingFormattedXmlContract() throws Exception {
        String boundary = "fixture-boundary";
        responseType =
                "multipart/related; type=\"application/xop+xml\"; start=\"<root@fixture>\";"
                        + " start-info=\"text/xml\"; boundary=\""
                        + boundary
                        + "\"";
        responseBody =
                "--"
                        + boundary
                        + "\r\n"
                        + "Content-Type: application/xop+xml; charset=UTF-8; type=\"text/xml\"\r\n"
                        + "Content-ID: <root@fixture>\r\n\r\n"
                        + envelope(
                                retrieveResponse(
                                        "<Document><xop:Include"
                                                + " xmlns:xop='http://www.w3.org/2004/08/xop/include'"
                                                + " href='cid:document@fixture'/></Document>"))
                        + "\r\n--"
                        + boundary
                        + "\r\n"
                        + "Content-Type: text/xml\r\n"
                        + "Content-Transfer-Encoding: base64\r\n"
                        + "Content-ID: <document@fixture>\r\n\r\n"
                        + Base64.getEncoder()
                                .encodeToString(XML.getBytes(StandardCharsets.ISO_8859_1))
                        + "\r\n--"
                        + boundary
                        + "--\r\n";
        var result = request("/v1/iti43", retrieval(), 200);
        assertEquals(FORMATTED, result.path("response").asText());
        org.junit.jupiter.api.Assertions.assertArrayEquals(
                XML.getBytes(StandardCharsets.ISO_8859_1),
                result.path("responseBase64").binaryValue());
    }

    @Test
    void searchJsonAndAllFilterSlotsAreStable() throws Exception {
        responseBody = envelope(queryResponse(entry(), ""));
        var q = query();
        for (String key :
                List.of(
                        "typeCode",
                        "formatCode",
                        "eventCode",
                        "healthcareFacilityTypeCode",
                        "practiceSettingCode"))
            q.put(key, Map.of("code", "code-1", "codeScheme", "scheme-1"));
        q.put("startFromDate", 1767323045000L);
        q.put("startToDate", 1767326706000L);
        q.put("endFromDate", 1767323045000L);
        q.put("endToDate", 1767326706000L);
        JsonNode result = request("/v1/iti18", q, 200);
        assertEquals(
                json.readTree(
                        "{\"patientId\":\"3001749995\",\"documentId\":\"1.2.3.5\",\"repositoryID\":\"1.2.3.4\",\"documentType\":\"Personal"
                                + " health monitoring"
                                + " report\",\"serviceStart\":1767323045000,\"serviceEnd\":1767326706000}"),
                result.path("queryResponse").get(0));
        assertTrue(result.path("requestId").asText().startsWith("Req:"));
        assertTrue(result.path("responseId").asText().startsWith("Res:"));
        assertEquals(lastSoap, soapPayload(download("request", result.path("requestId").asText())));
        assertEquals(
                responseBody,
                soapPayload(download("response", result.path("responseId").asText())));
        assertEquals(0, result.path("errors").size());
        assertEquals(
                "'3001749995^^^&1.2.208.176.1.2&ISO'", soapValue("$XDSDocumentEntryPatientId"));
        assertEquals(
                "('urn:oasis:names:tc:ebxml-regrep:StatusType:Approved')",
                soapValue("$XDSDocumentEntryStatus"));
        for (String key :
                List.of(
                        "TypeCode",
                        "FormatCode",
                        "EventCodeList",
                        "HealthcareFacilityTypeCode",
                        "PracticeSettingCode"))
            assertEquals("('code-1^^scheme-1')", soapValue("$XDSDocumentEntry" + key));
        assertEquals("20260102030405", soapValue("$XDSDocumentEntryServiceStartTimeFrom"));
        assertEquals("20260102040506", soapValue("$XDSDocumentEntryServiceStopTimeTo"));
        assertTrue(lastSoap.contains("3001749995"));
        assertTrue(lastSoap.contains("FT001"));
    }

    @Test
    void multipleCodesAreOrListsInOneSoapQuery() throws Exception {
        var q = query();
        var first = Map.of("code", "53576-5", "codeScheme", "2.16.840.1.113883.6.1");
        var second = Map.of("code", "74465-6", "codeScheme", "2.16.840.1.113883.6.1");
        q.put("typeCode", first);
        q.put("typeCodes", List.of(first, second));
        q.put(
                "formatCodes",
                List.of(
                        Map.of("code", "format-a", "codeScheme", "scheme-a"),
                        Map.of("code", "format-b", "codeScheme", "scheme-b")));
        request("/v1/iti18", q, 200);
        assertEquals(
                "('53576-5^^2.16.840.1.113883.6.1')('74465-6^^2.16.840.1.113883.6.1')",
                soapValue("$XDSDocumentEntryTypeCode"));
        assertEquals(
                "('format-a^^scheme-a')('format-b^^scheme-b')",
                soapValue("$XDSDocumentEntryFormatCode"));
    }

    @Test
    void emptyCodeListsOmitTheFilters() throws Exception {
        var q = query();
        q.put("typeCodes", List.of());
        q.put("formatCodes", List.of());
        request("/v1/iti18", q, 200);
        assertFalse(lastSoap.contains("$XDSDocumentEntryTypeCode"));
        assertFalse(lastSoap.contains("$XDSDocumentEntryFormatCode"));
    }

    @Test
    void malformedCodeListsAreRejectedBeforeSendingSoap() throws Exception {
        for (String field : List.of("typeCodes", "formatCodes")) {
            for (Object invalid :
                    List.of(
                            List.of(Map.of("code", "53576-5")),
                            List.of(Map.of("code", "", "codeScheme", "scheme")),
                            Collections.singletonList(null),
                            Collections.nCopies(51, Map.of("code", "x", "codeScheme", "scheme")))) {
                var q = query();
                q.put(field, invalid);
                lastSoap = null;
                request("/v1/iti18", q, 400);
                assertNull(lastSoap);
            }
        }
    }

    @Test
    void noFiltersAndEmptyResultsRemainSupported() throws Exception {
        var result = request("/v1/iti18", query(), 200);
        assertEquals(0, result.path("queryResponse").size());
        assertNull(soapValue("$XDSDocumentEntryTypeCode"));
        assertNull(soapValue("$XDSDocumentEntryFormatCode"));
    }

    @Test
    void uniqueIdUsesTheGetDocumentsQuery() throws Exception {
        var result =
                request(
                        "/v1/iti18/uniqueID",
                        Map.of("patientId", PATIENT, "documentId", "1.2.3.5"),
                        200);
        assertEquals("('1.2.3.5')", soapValue("$XDSDocumentEntryUniqueId"));
        assertEquals(0, result.path("errors").size());
    }

    @Test
    void registryWarningsRemainInTheRestResponse() throws Exception {
        responseBody =
                envelope(
                        queryResponse(
                                "",
                                "<rs:RegistryErrorList><rs:RegistryError"
                                        + " errorCode='XDSRegistryError' codeContext='fixture warning'"
                                        + " severity='urn:oasis:names:tc:ebxml-regrep:ErrorSeverityType:Warning'/></rs:RegistryErrorList>"));
        var result = request("/v1/iti18", query(), 200);
        var error = result.path("errors").get(0);
        assertEquals("WARNING", error.path("severity").asText());
        assertEquals("fixture warning", error.path("codeContext").asText());
        assertEquals("XDSRegistryError , REGISTRY_ERROR", error.path("errorCode").asText());
    }

    @Test
    void inlineRetrievalKeepsTheExistingFormattedXmlContract() throws Exception {
        responseBody =
                envelope(
                        retrieveResponse(
                                "<Document>"
                                        + Base64.getEncoder()
                                                .encodeToString(
                                                        XML.getBytes(StandardCharsets.ISO_8859_1))
                                        + "</Document>"));
        var result = request("/v1/iti43", retrieval(), 200);
        assertEquals(FORMATTED, result.path("response").asText());
        org.junit.jupiter.api.Assertions.assertArrayEquals(
                XML.getBytes(StandardCharsets.ISO_8859_1),
                result.path("responseBase64").binaryValue());
        assertEquals("1.2.3.5", soapElement("DocumentUniqueId"));
        assertEquals("1.2.3.4", soapElement("RepositoryUniqueId"));
    }

    @Test
    void originalBytesCanBeRetrievedWithoutXmlParsing() throws Exception {
        for (byte[] original :
                List.of(
                        "<?xml version='1.0' encoding='UTF-16'?><ClinicalDocument xmlns='urn:hl7-org:v3'>  ø  </ClinicalDocument>"
                                .getBytes(StandardCharsets.UTF_16),
                        "%PDF-1.7\nfixture".getBytes(StandardCharsets.UTF_8),
                        "<malformed".getBytes(StandardCharsets.UTF_8))) {
            responseBody =
                    envelope(
                            retrieveResponse(
                                    "<Document>"
                                            + Base64.getEncoder().encodeToString(original)
                                            + "</Document>"));
            var query = new LinkedHashMap<>(retrieval());
            query.put("includeFormattedResponse", false);
            var result = request("/v1/iti43", query, 200);
            org.junit.jupiter.api.Assertions.assertArrayEquals(
                    original, result.path("responseBase64").binaryValue());
            assertTrue(result.path("response").isNull() || result.path("response").isMissingNode());
        }
    }

    private static String retrieveResponse(String document) {
        return "<RetrieveDocumentSetResponse xmlns='urn:ihe:iti:xds-b:2007'><RegistryResponse"
                + " xmlns='"
                + NS
                + "rs:3.0' status='"
                + SUCCESS
                + "'/><DocumentResponse><RepositoryUniqueId>1.2.3.4</RepositoryUniqueId><DocumentUniqueId>1.2.3.5</DocumentUniqueId><mimeType>text/xml</mimeType>"
                + document
                + "</DocumentResponse></RetrieveDocumentSetResponse>";
    }

    @Test
    void missingDocumentPreservesHttp400AndRegistryDetails() throws Exception {
        responseBody =
                envelope(
                        "<RetrieveDocumentSetResponse"
                                + " xmlns='urn:ihe:iti:xds-b:2007'><RegistryResponse xmlns='"
                                + NS
                                + "rs:3.0'"
                                + " status='urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Failure'><RegistryErrorList><RegistryError"
                                + " errorCode='XDSRepositoryError' codeContext='fixture document"
                                + " missing'"
                                + " severity='urn:oasis:names:tc:ebxml-regrep:ErrorSeverityType:Error'/></RegistryErrorList></RegistryResponse></RetrieveDocumentSetResponse>");
        var error = request("/v1/iti43", retrieval(), 400);
        assertEquals(1000, error.path("error_code").asInt());
        assertEquals("/v1/iti43", error.path("path").asText());
        assertTrue(error.path("error").asText().contains("Failed to retrieve document"));
        assertEquals(1, error.path("otherError").size());
    }

    @Test
    void minlogSoapFaultKeepsTheRestErrorMapping() throws Exception {
        responseStatus = 500;
        responseBody =
                envelope(
                        "<s:Fault"
                                + " xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'><faultcode>s:Server</faultcode><faultstring>internal_error_minlog</faultstring></s:Fault>");
        var error = request("/v1/iti18", query(), 400);
        assertEquals("Patient-ID does not exists", error.path("error").asText());
    }

    @Test
    void authenticationFailureDoesNotCallXds() throws Exception {
        when(dgws.getHealthCareProfessionalClientInfo(anyString(), anyString(), any()))
                .thenThrow(new DgwsSecurityException(1000, "fixture denied"));
        var error = request("/v1/iti18", query(), 400);
        assertEquals("fixture denied", error.path("error").asText());
        assertNull(lastSoap);
    }
}
