package com.trifork.ihexdsapi.configuration;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.springframework.boot.context.properties.bind.Binder;
import org.springframework.boot.context.properties.source.MapConfigurationPropertySource;

class RegistryPropertiesTest {
    private static final String URL = "https://registry.invalid/service";

    private static RegistryProperties.Registry registry(String id, String name, String endpoint) {
        return new RegistryProperties.Registry(id, name, endpoint, URL, URL);
    }

    @Test
    void bindsCompleteIndependentEndpointBundles() {
        var properties =
                new MapConfigurationPropertySource(
                        Map.of(
                                "xds.registries[0].id",
                                "test1",
                                "xds.registries[0].name",
                                "DDS TEST1",
                                "xds.registries[0].iti18-endpoint",
                                URL + "/18",
                                "xds.registries[0].iti43-endpoint",
                                URL + "/43",
                                "xds.registries[0].sts-endpoint",
                                URL + "/sts"));
        var bound = new Binder(properties).bind("xds", RegistryProperties.class).get();
        assertEquals(
                new RegistryProperties.Registry(
                        "test1", "DDS TEST1", URL + "/18", URL + "/43", URL + "/sts"),
                bound.registries().getFirst());
        assertTrue(new RegistryProperties(null).registries().isEmpty());
    }

    private static void invalid(RegistryProperties.Registry... entries) {
        var registries = List.of(entries);
        assertThrows(IllegalArgumentException.class, () -> new RegistryProperties(registries));
    }

    @Test
    void rejectsAmbiguousIdsAndUnsafeOrMissingEndpointConfiguration() {
        for (String id : new String[] {null, "", "a".repeat(65), "https://other.invalid"})
            invalid(registry(id, "DDS", URL));
        var first = registry("test", "DDS", URL);
        invalid(first, first);
        for (String name : new String[] {null, "", " ", "a".repeat(151), "DDS\nInjected"})
            invalid(registry("test", name, URL));
        for (String endpoint :
                new String[] {
                    null,
                    "",
                    "not a uri",
                    "file:///etc/passwd",
                    "https:/path",
                    "https://user:secret@host/path",
                    URL + "#fragment"
                }) invalid(registry("test", "DDS", endpoint));
        invalid(new RegistryProperties.Registry("test", "DDS", URL, null, URL));
        invalid(new RegistryProperties.Registry("test", "DDS", URL, URL, null));
        assertEquals(
                2,
                new RegistryProperties(
                                List.of(
                                        first,
                                        registry("other", "DDS", "http://localhost:8080/registry")))
                        .registries()
                        .size());
    }
}
