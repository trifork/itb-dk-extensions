package com.trifork.ihexdsapi.configuration;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import com.sun.net.httpserver.HttpServer;
import com.trifork.ihexdsapi.dao.CacheRequestResponseHandle;
import com.trifork.ihexdsapi.dgws.*;
import com.trifork.ihexdsapi.service.*;
import java.io.ByteArrayInputStream;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
import java.util.*;
import javax.xml.parsers.DocumentBuilderFactory;
import org.junit.jupiter.api.Test;
import org.openapitools.model.*;
import org.springframework.test.util.ReflectionTestUtils;

/** Real configured CXF clients contact distinct loopback registry/retrieval paths. */
class RegistryConfigurationTest {
    private HttpServer server;
    private final IheXdsConfiguration configuration = new IheXdsConfiguration();

    @org.junit.jupiter.api.AfterEach
    void close() {
        configuration.destroyClients();
        if (server != null) server.stop(0);
    }

    @Test
    void constructsSeparateSearchRetrievalAndStsClientsForEachBundle() throws Exception {
        var paths = new ArrayList<String>();
        server = HttpServer.create(new InetSocketAddress("127.0.0.1", 0), 0);
        server.createContext(
                "/",
                exchange -> {
                    exchange.getRequestBody().readAllBytes();
                    paths.add(exchange.getRequestURI().getPath());
                    byte[] response =
                            envelope(
                                            "<s:Fault><faultcode>s:Server</faultcode><faultstring>fixture unavailable</faultstring></s:Fault>")
                                    .getBytes(StandardCharsets.UTF_8);
                    exchange.getResponseHeaders().set("Content-Type", "text/xml; charset=UTF-8");
                    exchange.sendResponseHeaders(500, response.length);
                    exchange.getResponseBody().write(response);
                    exchange.close();
                });
        server.start();

        String base = "http://127.0.0.1:" + server.getAddress().getPort();
        var properties =
                new RegistryProperties(
                        List.of(
                                new RegistryProperties.Registry(
                                        "one",
                                        "DDS One",
                                        base + "/one/search",
                                        base + "/one/retrieve",
                                        base + "/one/sts"),
                                new RegistryProperties.Registry(
                                        "two",
                                        "DDS Two",
                                        base + "/two/search",
                                        base + "/two/retrieve",
                                        base + "/two/sts")));
        var legacy = mock(DgwsService.class);
        var credentials = mock(CredentialService.class);
        var routing =
                configuration.registryRouting(
                        properties,
                        credentials,
                        legacy,
                        mock(Iti18Service.class),
                        mock(Iti43Service.class),
                        mock(CacheRequestResponseHandle.class),
                        mock(IDContextService.class));
        var factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        var sosi =
                factory.newDocumentBuilder()
                        .parse(
                                new ByteArrayInputStream(
                                        envelope("").getBytes(StandardCharsets.UTF_8)));
        var identity =
                new DgwsClientInfo(
                        sosi, "0101019999", "2512489996", "FT001", "123456789012345", false);
        for (String id : List.of("two", "one")) {
            var target = routing.target(id);
            var sts = ReflectionTestUtils.getField(target.dgws(), "stsService");
            assertEquals(base + "/" + id + "/sts", ReflectionTestUtils.getField(sts, "stsUrl"));
            assertSame(
                    credentials, ReflectionTestUtils.getField(target.dgws(), "credentialService"));
            assertThrows(
                    jakarta.xml.ws.WebServiceException.class,
                    () ->
                            target.search()
                                    .queryForDocument(
                                            new Iti18QueryParameter()
                                                    .patientId("2512489996")
                                                    .availabilityStatus("Approved")
                                                    .documentType(List.of("STABLE")),
                                            identity));
            assertThrows(
                    jakarta.xml.ws.WebServiceException.class,
                    () ->
                            target.retrieval()
                                    .getDocument(
                                            new Iti43QueryParameter()
                                                    .patientId("2512489996")
                                                    .documentId("document")
                                                    .repositoryId("repository"),
                                            identity));
        }
        assertEquals(
                List.of("/two/search", "/two/retrieve", "/one/search", "/one/retrieve"), paths);
        assertNotSame(
                ReflectionTestUtils.getField(routing.target("one").dgws(), "stsService"),
                ReflectionTestUtils.getField(routing.target("two").dgws(), "stsService"));
        verifyNoInteractions(legacy);
        var fallback =
                configuration.registryRouting(
                        new RegistryProperties(null),
                        credentials,
                        legacy,
                        mock(Iti18Service.class),
                        mock(Iti43Service.class),
                        mock(CacheRequestResponseHandle.class),
                        mock(IDContextService.class));
        assertSame(legacy, fallback.target(null).dgws());
    }

    private static String envelope(String body) {
        return "<s:Envelope xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'><s:Header/><s:Body>"
                + body
                + "</s:Body></s:Envelope>";
    }
}
