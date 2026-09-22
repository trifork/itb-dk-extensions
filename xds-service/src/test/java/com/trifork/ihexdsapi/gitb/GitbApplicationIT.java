package com.trifork.ihexdsapi.gitb;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import com.gitb.ps.*;
import com.gitb.tr.TestResultType;
import com.sun.net.httpserver.HttpServer;
import com.trifork.ihexdsapi.dgws.*;
import java.io.ByteArrayInputStream;
import java.net.*;
import java.net.http.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.concurrent.*;
import javax.xml.parsers.DocumentBuilderFactory;
import org.junit.jupiter.api.*;
import org.openapitools.model.CredentialInfoResponse;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.test.context.*;
import org.springframework.test.context.bean.override.mockito.MockitoBean;

/** Real GITB HTTP endpoint -> real shared services -> real IPF/CXF -> loopback SOAP fixture. */
@SpringBootTest(
        webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT,
        properties = {
            "management.server.port=0",
            // Exclude the deployment's application.properties and its live registry/STS bundles.
            "spring.config.location=classpath:/"
        })
@ActiveProfiles("integration")
class GitbApplicationIT {
    private static final List<String> requests = Collections.synchronizedList(new ArrayList<>());
    private static volatile boolean registryError;
    private static final HttpServer remote = remote();
    @LocalServerPort int port;
    @MockitoBean CredentialService credentials;
    @MockitoBean DgwsService dgws;

    static HttpServer remote() {
        try {
            var server = HttpServer.create(new InetSocketAddress("127.0.0.1", 0), 0);
            server.setExecutor(Executors.newVirtualThreadPerTaskExecutor());
            server.createContext(
                    "/",
                    exchange -> {
                        requests.add(
                                new String(
                                        exchange.getRequestBody().readAllBytes(),
                                        StandardCharsets.UTF_8));
                        String error =
                                registryError
                                        ? "<rs:RegistryErrorList><rs:RegistryError errorCode='XDSRegistryBusy' codeContext='private-context' severity='urn:oasis:names:tc:ebxml-regrep:ErrorSeverityType:Error'/></rs:RegistryErrorList>"
                                        : "";
                        String response =
                                envelope(
                                        "<query:AdhocQueryResponse xmlns:query='urn:oasis:names:tc:ebxml-regrep:xsd:query:3.0' xmlns:rs='urn:oasis:names:tc:ebxml-regrep:xsd:rs:3.0' status='urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success'>"
                                                + error
                                                + "<rim:RegistryObjectList xmlns:rim='urn:oasis:names:tc:ebxml-regrep:xsd:rim:3.0'/></query:AdhocQueryResponse>");
                        byte[] bytes = response.getBytes(StandardCharsets.UTF_8);
                        exchange.getResponseHeaders()
                                .set("Content-Type", "text/xml; charset=UTF-8");
                        exchange.sendResponseHeaders(200, bytes.length);
                        exchange.getResponseBody().write(bytes);
                        exchange.close();
                    });
            server.start();
            return server;
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }

    static String envelope(String body) {
        return "<s:Envelope xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'><s:Header/><s:Body>"
                + body
                + "</s:Body></s:Envelope>";
    }

    @DynamicPropertySource
    static void endpoints(DynamicPropertyRegistry registry) {
        registry.add(
                "xdsIti18Endpoint",
                () -> "http://127.0.0.1:" + remote.getAddress().getPort() + "/registry");
    }

    @BeforeEach
    void identities() throws Exception {
        requests.clear();
        registryError = false;
        when(credentials.populateResponses(null, null))
                .thenReturn(
                        Arrays.asList(
                                GitbXdsAccess.JSON.readValue(
                                        "[{\"id\":\"professional\",\"displayName\":\"Synthetic professional\",\"credentialType\":\"HEALTHCAREPROFESSIONAL\",\"certificateKind\":\"MOCES\",\"validUntil\":\"2099-01-01T00:00:00Z\"}]",
                                        CredentialInfoResponse[].class)));
        when(dgws.getHealthCareProfessionalClientInfo(anyString(), anyString(), any()))
                .thenAnswer(
                        call -> {
                            var factory = DocumentBuilderFactory.newInstance();
                            factory.setNamespaceAware(true);
                            var document =
                                    factory.newDocumentBuilder()
                                            .parse(
                                                    new ByteArrayInputStream(
                                                            envelope("")
                                                                    .getBytes(
                                                                            StandardCharsets
                                                                                    .UTF_8)));
                            return new DgwsClientInfo(
                                    document,
                                    "0101019999",
                                    call.getArgument(0),
                                    "FT001",
                                    "123456789012345",
                                    false);
                        });
    }

    private ProcessingService soap() throws Exception {
        return new ProcessingServiceService(
                        new URI("http://localhost:" + port + "/processing?wsdl").toURL())
                .getProcessingServicePort();
    }

    private ProcessResponse search(String patient) throws Exception {
        var soap = soap();
        var id = soap.beginTransaction(new BeginTransactionRequest()).getSessionId();
        var choices = new ProcessRequest();
        choices.setSessionId(id);
        choices.setOperation("choices");
        assertEquals(TestResultType.SUCCESS, soap.process(choices).getReport().getResult());
        var request = new ProcessRequest();
        request.setSessionId(id);
        request.setOperation("search");
        request.getInput().add(XdsProcessingService.value("patientId", "string", patient));
        request.getInput()
                .add(XdsProcessingService.value("professional", "string", "professional"));
        var result = soap.process(request);
        var end = new BasicRequest();
        end.setSessionId(id);
        soap.endTransaction(end);
        return result;
    }

    @Test
    void typedIpfErrorsReachGitbWithoutRestFlattening() throws Exception {
        registryError = true;
        var result = search("2512489996");
        assertEquals(TestResultType.FAILURE, result.getReport().getResult());
        String message =
                result.getOutput().stream()
                        .filter(i -> i.getName().equals("errorMessage"))
                        .findFirst()
                        .orElseThrow()
                        .getValue();
        assertTrue(message.contains("XDSRegistryBusy"), message);
        assertFalse(message.contains("private-context"));
        assertFalse(message.contains("HTTP 400"));
        assertEquals(1, requests.size());
    }

    @Test
    void concurrentPatientsRemainIsolatedAndReadinessIsLocal() throws Exception {
        try (var client = HttpClient.newHttpClient()) {
            assertEquals(
                    200,
                    client.send(
                                    HttpRequest.newBuilder(
                                                    URI.create(
                                                            "http://localhost:"
                                                                    + port
                                                                    + "/health/ready"))
                                            .build(),
                                    HttpResponse.BodyHandlers.discarding())
                            .statusCode());
        }
        assertTrue(requests.isEmpty());
        try (var executor = Executors.newVirtualThreadPerTaskExecutor()) {
            var first = executor.submit(() -> search("2512489996"));
            var second = executor.submit(() -> search("0000000009"));
            assertEquals(
                    TestResultType.SUCCESS,
                    first.get(20, TimeUnit.SECONDS).getReport().getResult());
            assertEquals(
                    TestResultType.SUCCESS,
                    second.get(20, TimeUnit.SECONDS).getReport().getResult());
        }
        assertEquals(2, requests.size());
        // Query patient and HSUID patient must agree within each request; no cross-request context.
        for (String request : requests) {
            assertTrue(request.contains("2512489996") ^ request.contains("0000000009"));
        }
    }

    @AfterAll
    static void stop() {
        remote.stop(0);
    }
}
