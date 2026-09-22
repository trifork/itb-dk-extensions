package com.trifork.ihexdsapi.dgws;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.trifork.ihexdsapi.controller.CredentialInfoController;
import com.trifork.ihexdsapi.controller.ErrorController;
import com.trifork.ihexdsapi.controller.IheXdsController;
import com.trifork.ihexdsapi.dao.entity.LogEntry;
import com.trifork.ihexdsapi.dao.impl.CacheRequestResponseHandleImpl;
import com.trifork.ihexdsapi.dao.impl.CredentialRepositoryImpl;
import com.trifork.ihexdsapi.dgws.impl.CredentialServiceImpl;
import com.trifork.ihexdsapi.service.*;
import java.time.*;
import java.util.Map;
import org.junit.jupiter.api.*;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

/** Tests storage through the unchanged HTTP contract, with a clock instead of sleeps. */
class StorageRestContractTest {
    private static final class TestClock extends Clock {
        Instant now = Instant.parse("2026-01-01T00:00:00Z");

        public Instant instant() {
            return now;
        }

        public ZoneId getZone() {
            return ZoneOffset.UTC;
        }

        public Clock withZone(ZoneId zone) {
            return this;
        }

        void advance(long seconds) {
            now = now.plusSeconds(seconds);
        }
    }

    private TestClock clock;
    private CredentialServiceImpl credentials;
    private CacheRequestResponseHandleImpl logs;
    private ObjectMapper json;
    private MockMvc http;
    private String certificate, key;

    @BeforeAll
    static void keys() throws Exception {
        OcesCredentialTest.keys();
    }

    @BeforeEach
    void setup() throws Exception {
        clock = new TestClock();
        credentials =
                new CredentialServiceImpl(
                        new CredentialRepositoryImpl(clock, Duration.ofSeconds(10), 2),
                        "fixture-vault-password");
        logs = new CacheRequestResponseHandleImpl(clock, Duration.ofSeconds(20), 2);
        var credentialController = new CredentialInfoController(credentials);
        var xdsController =
                new IheXdsController(
                        com.trifork.ihexdsapi.service.RegistryRouting.legacy(
                                mock(DgwsService.class),
                                mock(Iti18Service.class),
                                mock(Iti43Service.class)),
                        logs,
                        mock(IDContextService.class));
        json = new ObjectMapper().registerModule(new JavaTimeModule());
        http =
                MockMvcBuilders.standaloneSetup(credentialController, xdsController)
                        .setControllerAdvice(new ErrorController())
                        .setMessageConverters(new MappingJackson2HttpMessageConverter(json))
                        .build();
        var cert =
                OcesCredentialTest.certificate(
                        "C=DK, O=Fixture // CVR:12345678, CN=Anne Test,"
                                + " SERIALNUMBER=CVR:12345678-RID:1234");
        certificate = OcesCredentialTest.pem("CERTIFICATE", cert.getEncoded());
        // The fixture's key pair is deliberately generated for each test class.
        var field = OcesCredentialTest.class.getDeclaredField("keys");
        field.setAccessible(true);
        key =
                OcesCredentialTest.pem(
                        "PRIVATE KEY",
                        ((java.security.KeyPair) field.get(null)).getPrivate().getEncoded());
    }

    private void upload(String owner, String name) throws Exception {
        var body =
                Map.of(
                        "owner",
                        owner,
                        "displayName",
                        name,
                        "publicCertStr",
                        certificate,
                        "privateKeyStr",
                        key);
        assertEquals(
                201,
                http.perform(
                                put("/v1/credentialinfo")
                                        .contentType(MediaType.APPLICATION_JSON)
                                        .content(json.writeValueAsBytes(body)))
                        .andReturn()
                        .getResponse()
                        .getStatus());
    }

    private JsonNode getJson(String path) throws Exception {
        var response = http.perform(get(path)).andReturn().getResponse();
        assertEquals(200, response.getStatus());
        return json.readTree(response.getContentAsByteArray());
    }

    @Test
    void credentialsRemainDiscoverableAndUsableWithTheSameJsonFields() throws Exception {
        upload("alice", "Fixture employee");
        var all = getJson("/v1/credentialinfo?owner=alice&type=HEALTHCAREPROFESSIONAL");
        assertEquals(1, all.size());
        var item = all.get(0);
        assertEquals("Fixture employee", item.path("displayName").asText());
        assertEquals("MOCES", item.path("certificateKind").asText());
        assertTrue(item.path("validFrom").isTextual());
        assertTrue(item.path("validUntil").isTextual());
        var certificateMetadata =
                (java.security.cert.X509Certificate)
                        java.security.cert.CertificateFactory.getInstance("X.509")
                                .generateCertificate(
                                        new java.io.ByteArrayInputStream(
                                                certificate.getBytes(
                                                        java.nio.charset.StandardCharsets
                                                                .US_ASCII)));
        assertEquals(
                certificateMetadata.getNotBefore().toInstant(),
                Instant.parse(item.path("validFrom").asText()));
        assertEquals(
                certificateMetadata.getNotAfter().toInstant(),
                Instant.parse(item.path("validUntil").asText()));
        assertEquals("HEALTHCAREPROFESSIONAL", item.path("credentialType").asText());
        assertEquals("CVR:12345678-RID:1234", item.path("subjectSerialNumber").asText());
        assertEquals(
                "Fixture employee",
                credentials.getCredentialInfoFromId(item.path("id").asText()).getDisplayName());
        assertEquals(0, getJson("/v1/credentialinfo?owner=bob").size());
        assertEquals(0, getJson("/v1/credentialinfo?owner=alice&type=SYSTEM").size());
    }

    @Test
    void uploadsExpireIndividuallyAndConfiguredIdentitySurvives() throws Exception {
        credentials.createAndAddCredentialInfo(null, "Startup", certificate, key);
        upload("alice", "First");
        clock.advance(5);
        upload("alice", "Second");
        clock.advance(5);
        var all = getJson("/v1/credentialinfo?owner=alice");
        assertEquals(2, all.size());
        assertEquals("Startup", all.get(0).path("displayName").asText());
        assertEquals("Second", all.get(1).path("displayName").asText());
        clock.advance(5);
        assertEquals(1, getJson("/v1/credentialinfo?owner=alice").size());
        assertNotNull(credentials.getCredentialInfoFromId(null));
        assertNull(credentials.getCredentialInfoFromId("missing"));
    }

    @Test
    void cacheEndpointsKeepPayloadAndMissingRecordBehavior() throws Exception {
        logs.saveRequestAndResponse("request", new LogEntry("request", "fixture request"));
        logs.saveRequestAndResponse("response", new LogEntry("response", "fixture response"));
        assertEquals("fixture request", getJson("/v1/request/request").path("payload").asText());
        assertEquals("fixture response", getJson("/v1/response/response").path("payload").asText());
        clock.advance(20);
        assertEquals("", getJson("/v1/request/request").path("payload").asText());
        assertEquals("", getJson("/v1/response/missing").path("payload").asText());
    }

    @Test
    void cacheCapacityEvictsOldestRecords() throws Exception {
        for (int i = 0; i < 3; i++)
            logs.saveRequestAndResponse("r" + i, new LogEntry("r" + i, "payload" + i));
        assertEquals("", getJson("/v1/request/r0").path("payload").asText());
        assertEquals("payload2", getJson("/v1/request/r2").path("payload").asText());
        for (int i = 0; i < 3; i++) upload("alice", "employee" + i);
        assertEquals(2, getJson("/v1/credentialinfo?owner=alice").size());
        assertEquals(
                "employee1",
                getJson("/v1/credentialinfo?owner=alice").get(0).path("displayName").asText());
    }
}
