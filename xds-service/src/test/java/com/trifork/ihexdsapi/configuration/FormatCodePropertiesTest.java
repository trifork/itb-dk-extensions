package com.trifork.ihexdsapi.configuration;

import static org.junit.jupiter.api.Assertions.*;

import java.util.Map;
import org.junit.jupiter.api.Test;
import org.springframework.boot.context.properties.bind.Binder;
import org.springframework.boot.context.properties.source.MapConfigurationPropertySource;

class FormatCodePropertiesTest {
    @Test
    void bindsSchemeOverridesKeyedByTheFormatCodeItself() {
        var bound =
                new Binder(
                                new MapConfigurationPropertySource(
                                        Map.of(
                                                "format.code.scheme-overrides[urn:ihe:iti:xds:2017:mimeTypeSufficient]",
                                                "1.3.6.1.4.1.19376.1.2.3")))
                        .bind("format.code", FormatCodeProperties.class)
                        .get();
        assertEquals(
                "1.3.6.1.4.1.19376.1.2.3",
                bound.schemeOverrides().get("urn:ihe:iti:xds:2017:mimeTypeSufficient"));
        assertTrue(new FormatCodeProperties(null).schemeOverrides().isEmpty());
    }

    @Test
    void rejectsBlankKeysAndSchemes() {
        var blankKey = Map.of(" ", "1.2");
        var blankScheme = Map.of("code", " ");
        assertThrows(IllegalArgumentException.class, () -> new FormatCodeProperties(blankKey));
        assertThrows(IllegalArgumentException.class, () -> new FormatCodeProperties(blankScheme));
    }
}
