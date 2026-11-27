package com.trifork.ihexdsapi.configuration;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.mock;

import com.sun.net.httpserver.HttpServer;
import com.trifork.ihexdsapi.dao.CacheRequestResponseHandle;
import com.trifork.ihexdsapi.dgws.*;
import com.trifork.ihexdsapi.service.*;
import java.io.ByteArrayInputStream;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import javax.xml.parsers.DocumentBuilderFactory;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.openehealth.ipf.commons.ihe.xds.core.metadata.Code;
import org.openehealth.ipf.commons.ihe.xds.core.responses.Status;

/** Real CXF clients send ITI-41 and ITI-57 to loopback endpoints that act as a registry. */
class WriteTransactionsTest {
    private static final String SUCCESS =
            "urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success";
    private final IheXdsConfiguration configuration = new IheXdsConfiguration();
    private final List<String> paths = new ArrayList<>();
    private final List<String> contentTypes = new ArrayList<>();
    private final List<String> bodies = new ArrayList<>();
    private HttpServer server;

    @AfterEach
    void close() {
        configuration.destroyClients();
        if (server != null) server.stop(0);
    }

    private static String envelope(String body) {
        return "<s:Envelope xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'><s:Header/><s:Body>"
                + body
                + "</s:Body></s:Envelope>";
    }

    private void start(String responseStatus) throws Exception {
        server = HttpServer.create(new InetSocketAddress("127.0.0.1", 0), 0);
        server.createContext(
                "/",
                exchange -> {
                    paths.add(exchange.getRequestURI().getPath());
                    contentTypes.add(exchange.getRequestHeaders().getFirst("Content-Type"));
                    bodies.add(
                            new String(
                                    exchange.getRequestBody().readAllBytes(),
                                    StandardCharsets.UTF_8));
                    byte[] response =
                            envelope(
                                            "<rs:RegistryResponse xmlns:rs='urn:oasis:names:tc:ebxml-regrep:xsd:rs:3.0' status='"
                                                    + responseStatus
                                                    + "'/>")
                                    .getBytes(StandardCharsets.UTF_8);
                    exchange.getResponseHeaders().set("Content-Type", "text/xml; charset=UTF-8");
                    exchange.sendResponseHeaders(200, response.length);
                    exchange.getResponseBody().write(response);
                    exchange.close();
                });
        server.start();
    }

    private RegistryRouting routing(boolean writable) {
        String base = "http://127.0.0.1:" + server.getAddress().getPort();
        var registry =
                new RegistryProperties.Registry(
                        "test2",
                        "DDS TEST2",
                        base + "/registry",
                        base + "/retrieve",
                        base + "/sts",
                        false,
                        writable ? base + "/repository" : null,
                        writable ? base + "/update" : null);
        return configuration.registryRouting(
                new RegistryProperties(List.of(registry)),
                new HsuidOrganisationProperties("440081000016006", "sor"),
                mock(CredentialService.class),
                mock(DgwsService.class),
                mock(Iti18Service.class),
                mock(Iti43Service.class),
                mock(CacheRequestResponseHandle.class),
                mock(IDContextService.class));
    }

    private static DgwsClientInfo identity() throws Exception {
        var factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        var sosi =
                factory.newDocumentBuilder()
                        .parse(
                                new ByteArrayInputStream(
                                        envelope("").getBytes(StandardCharsets.UTF_8)));
        return new DgwsClientInfo(
                sosi, "0101019999", "0103660140", "FT001", "123456789012345", false);
    }

    @Test
    void uploadSendsTheDocumentAsAMultipartAttachmentToTheRepositoryEndpoint() throws Exception {
        start(SUCCESS);
        var target = routing(true).target("test2");
        var document = CdaMetadataTest.HEADER.getBytes(StandardCharsets.UTF_8);
        var request =
                Submissions.provide(
                        document,
                        CdaMetadata.parse(document),
                        new Code("urn:ad:dk:medcom:qfdd-v1.2:full", null, "1.2.208.184.100.10"),
                        SubmissionProperties.defaults());

        var response = target.submission().submit(request, identity());

        assertEquals(Status.SUCCESS, response.getStatus());
        assertEquals(List.of("/repository"), paths);
        assertTrue(
                contentTypes.getFirst().startsWith("multipart/related"), contentTypes.getFirst());
        assertTrue(bodies.getFirst().contains("ProvideAndRegisterDocumentSetRequest"));
        assertTrue(
                bodies.getFirst().contains("<ClinicalDocument"), "the CDA travels in the message");
        assertTrue(bodies.getFirst().contains("1.2.3.4.5^abc"));
    }

    @Test
    void deprecationIsAPlainSoapUpdateToTheRegistryUpdateEndpoint() throws Exception {
        start(SUCCESS);
        var target = routing(true).target("test2");
        var request =
                Submissions.deprecate(
                        "0103660140",
                        "urn:uuid:entry-1",
                        new Code("74468-0", null, "2.16.840.1.113883.6.1"),
                        SubmissionProperties.defaults());

        var response = target.update().update(request, identity());

        assertEquals(Status.SUCCESS, response.getStatus());
        assertEquals(List.of("/update"), paths);
        assertTrue(
                bodies.getFirst()
                        .contains("urn:ihe:iti:2010:AssociationType:UpdateAvailabilityStatus"));
        assertTrue(bodies.getFirst().contains("urn:uuid:entry-1"));
        assertTrue(
                bodies.getFirst()
                        .contains("urn:oasis:names:tc:ebxml-regrep:StatusType:Deprecated"));
    }

    @Test
    void aFailureStatusFromTheRegistryIsPassedOnNotHidden() throws Exception {
        start("urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Failure");
        var request =
                Submissions.deprecate(
                        "0103660140",
                        "urn:uuid:e",
                        new Code("c", null, "1.2"),
                        SubmissionProperties.defaults());
        assertEquals(
                Status.FAILURE,
                routing(true).target("test2").update().update(request, identity()).getStatus());
    }

    @Test
    void registriesWithoutWriteEndpointsOfferNoWriteServices() throws Exception {
        start(SUCCESS);
        var target = routing(false).target("test2");
        assertNull(target.submission());
        assertNull(target.update());
    }
}
