package com.trifork.ihexdsapi.configuration;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.trifork.ihexdsapi.controller.CredentialInfoController;
import com.trifork.ihexdsapi.dao.impl.CredentialRepositoryImpl;
import com.trifork.ihexdsapi.dgws.CredentialService;
import com.trifork.ihexdsapi.dgws.impl.CredentialServiceImpl;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Clock;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Stream;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;
import org.springframework.boot.test.context.runner.ApplicationContextRunner;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

class CredentialConfigurationTest {
    @TempDir Path directory;

    private ApplicationContextRunner runner(CredentialService credentials) {
        return new ApplicationContextRunner()
                .withUserConfiguration(CredentialConfiguration.class)
                .withBean(CredentialService.class, () -> credentials);
    }

    @Test
    void noConfigurationLoadsNoBundledIdentities() {
        var credentials = mock(CredentialService.class);
        runner(credentials)
                .run(
                        context -> {
                            assertNull(context.getStartupFailure());
                            assertTrue(
                                    context.getBean(CredentialProperties.class)
                                            .credentials()
                                            .isEmpty());
                            verifyNoInteractions(credentials);
                        });
    }

    @Test
    void fourNamedCredentialsAreAvailableThroughTheExistingRestInterface() throws Exception {
        var settings = new ArrayList<String>();
        for (String name : new String[] {"employee", "alternate", "organisation", "auditor"}) {
            String cert = name.equals("organisation") ? "voces1.cer" : "public-cert1.cer";
            String key = name.equals("organisation") ? "voces1.pem" : "private-cert1.pem";
            settings.add("xds.credentials." + name + ".certificate=" + fixture(cert));
            settings.add("xds.credentials." + name + ".private-key=" + fixture(key));
            settings.add("xds.credentials." + name + ".display-name=" + name);
        }
        var service =
                new CredentialServiceImpl(
                        new CredentialRepositoryImpl(Clock.systemUTC(), Duration.ofHours(1), 10),
                        "fixture-vault-password");
        runner(service)
                .withPropertyValues(settings.toArray(String[]::new))
                .run(
                        context -> {
                            assertNull(context.getStartupFailure());
                            var http =
                                    MockMvcBuilders.standaloneSetup(
                                                    new CredentialInfoController(service))
                                            .build();
                            var response =
                                    http.perform(get("/v1/credentialinfo"))
                                            .andReturn()
                                            .getResponse();
                            assertEquals(200, response.getStatus());
                            var json =
                                    new ObjectMapper().readTree(response.getContentAsByteArray());
                            assertEquals(4, json.size());
                            var names = new java.util.HashSet<String>();
                            for (var credential : json) {
                                names.add(credential.path("displayName").asText());
                                assertFalse(credential.path("id").asText().isBlank());
                                assertFalse(credential.has("privateKey"));
                                assertFalse(credential.has("passwordFile"));
                            }
                            assertEquals(
                                    Set.of("employee", "alternate", "organisation", "auditor"),
                                    names);
                            var systems =
                                    http.perform(get("/v1/credentialinfo").param("type", "SYSTEM"))
                                            .andReturn()
                                            .getResponse();
                            assertEquals(
                                    4,
                                    new ObjectMapper()
                                            .readTree(systems.getContentAsByteArray())
                                            .size());
                        });
    }

    private Path fixture(String name) throws Exception {
        var target = directory.resolve(name);
        try (var input = getClass().getResourceAsStream("/certificates/" + name)) {
            assertNotNull(input);
            Files.copy(input, target, java.nio.file.StandardCopyOption.REPLACE_EXISTING);
        }
        return target;
    }

    static Stream<List<String>> invalidCredentials() {
        return Stream.of(
                List.of("certificate=cert.pem"),
                List.of("private-key=key.pem"),
                List.of("pkcs12=bundle.p12"),
                List.of("display-name=empty"),
                List.of(
                        "certificate=cert.pem",
                        "private-key=key.pem",
                        "pkcs12=bundle.p12",
                        "password-file=password"),
                List.of("certificate=cert.pem", "private-key=key.pem", "password-file=password"));
    }

    @ParameterizedTest
    @MethodSource("invalidCredentials")
    void invalidEntriesFailStartupWithoutLoadingFallbackCredentials(List<String> entry) {
        var credentials = mock(CredentialService.class);
        var settings =
                entry.stream()
                        .map(value -> "xds.credentials.employee." + value)
                        .toArray(String[]::new);
        runner(credentials)
                .withPropertyValues(settings)
                .run(
                        context -> {
                            assertNotNull(context.getStartupFailure());
                            verifyNoInteractions(credentials);
                        });
    }

    @Test
    void missingCredentialFilesFailStartup() {
        var credentials = mock(CredentialService.class);
        runner(credentials)
                .withPropertyValues(
                        "xds.credentials.employee.certificate=" + directory.resolve("missing.pem"),
                        "xds.credentials.employee.private-key=" + directory.resolve("missing.key"))
                .run(
                        context -> {
                            assertNotNull(context.getStartupFailure());
                            verifyNoInteractions(credentials);
                        });
    }
}
