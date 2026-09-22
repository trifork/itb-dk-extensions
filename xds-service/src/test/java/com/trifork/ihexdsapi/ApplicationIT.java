package com.trifork.ihexdsapi;

import static org.junit.jupiter.api.Assertions.*;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.TestPropertySource;

/** Runs the assembled Spring application over HTTP. All remote endpoints are loopback only. */
@SpringBootTest(
        webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT,
        properties = {
            "management.server.port=0",
            // Exclude the deployment's application.properties and its live registry/STS bundles.
            "spring.config.location=classpath:/"
        })
@ActiveProfiles("integration")
@TestPropertySource("classpath:application-integration.properties")
@org.springframework.test.context.ContextConfiguration(
        initializers = ApplicationIT.VaultEnvironment.class)
class ApplicationIT {
    static class VaultEnvironment
            implements org.springframework.context.ApplicationContextInitializer<
                    org.springframework.context.ConfigurableApplicationContext> {
        @Override
        public void initialize(org.springframework.context.ConfigurableApplicationContext context) {
            context.getEnvironment()
                    .getPropertySources()
                    .addFirst(
                            new org.springframework.core.env.SystemEnvironmentPropertySource(
                                    "vault-test-environment",
                                    Map.of("XDS_VAULT_PASSWORD", "fixture-vault-password")));
        }
    }

    @LocalServerPort private int port;
    private final ObjectMapper json = new ObjectMapper();

    private HttpResponse<String> request(String method, String path, String body) throws Exception {
        try (var client = HttpClient.newHttpClient()) {
            return client.send(
                    HttpRequest.newBuilder(URI.create("http://localhost:" + port + path))
                            .header("Content-Type", "application/json")
                            .method(method, HttpRequest.BodyPublishers.ofString(body))
                            .build(),
                    HttpResponse.BodyHandlers.ofString());
        }
    }

    @Test
    void configurationUsesTheConfiguredEndpoints() throws Exception {
        var response = request("GET", "/v1/config", "");
        assertEquals(200, response.statusCode());
        var entries = json.readTree(response.body());
        assertEquals(3, entries.size());
        for (JsonNode entry : entries) {
            assertTrue(entry.get("configValue").asText().startsWith("http://127.0.0.1:1/"));
        }
        var registries = request("GET", "/v1/registries", "");
        assertEquals(200, registries.statusCode());
        var choices = json.readTree(registries.body());
        assertEquals(1, choices.size(), "Deployment registry bundles must not enter the fixture");
        assertEquals("default", choices.get(0).get("id").asText());
    }

    @ParameterizedTest
    @ValueSource(
            strings = {
                "typeCode",
                "formatCode",
                "healthCareFacilityType",
                "practiceSettingCode",
                "availabilityStatusCode",
                "objectTypeCode",
                "eventCode"
            })
    void codeListsAreAvailableThroughGeneratedInterfaces(String code) throws Exception {
        var response = request("GET", "/v1/codes/" + code, "");
        assertEquals(200, response.statusCode());
        var entries = json.readTree(response.body());
        assertTrue(entries.isArray());
        assertFalse(entries.isEmpty());
    }

    @Test
    void classCodeRetainsItsExistingEmptyResponse() throws Exception {
        // This endpoint was already unimplemented; consolidation must not change its contract.
        var response = request("GET", "/v1/codes/classCode", "");
        assertEquals(200, response.statusCode());
        assertEquals("", response.body());
    }

    @ParameterizedTest
    @ValueSource(strings = {"/v1/iti18", "/v1/iti43"})
    void invalidRequestsReturnBadRequest(String path) throws Exception {
        assertEquals(400, request("POST", path, "{}").statusCode());
    }

    @Test
    void credentialRegistrationAndFilteringWorkOverHttp() throws Exception {
        String certificate;
        String key;
        try (var cert = getClass().getResourceAsStream("/certificates/public-cert1.cer");
                var privateKey =
                        getClass().getResourceAsStream("/certificates/private-cert1.pem")) {
            certificate = new String(cert.readAllBytes(), StandardCharsets.UTF_8);
            key = new String(privateKey.readAllBytes(), StandardCharsets.UTF_8);
        }
        var payload =
                json.writeValueAsString(
                        Map.of(
                                "owner",
                                "application-it",
                                "displayName",
                                "Fixture",
                                "publicCertStr",
                                certificate,
                                "privateKeyStr",
                                key));
        assertEquals(201, request("PUT", "/v1/credentialinfo", payload).statusCode());
        var list = request("GET", "/v1/credentialinfo?owner=application-it", "");
        assertEquals(200, list.statusCode());
        assertEquals(1, json.readTree(list.body()).size());
        assertEquals(400, request("GET", "/v1/credentialinfo?type=INVALID", "").statusCode());
    }
}
