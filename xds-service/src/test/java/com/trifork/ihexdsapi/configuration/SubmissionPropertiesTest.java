package com.trifork.ihexdsapi.configuration;

import static org.junit.jupiter.api.Assertions.*;

import java.util.Map;
import org.junit.jupiter.api.Test;
import org.springframework.boot.context.properties.bind.Binder;
import org.springframework.boot.context.properties.source.MapConfigurationPropertySource;

class SubmissionPropertiesTest {
    @Test
    void usesDocumentedPlaceholdersUntilTheOperatorConfiguresThem() {
        var defaults = SubmissionProperties.defaults();
        assertTrue(defaults.sourceId().startsWith("2.25."));
        assertEquals("OF", defaults.facilityType().getCode());
        assertEquals("2.16.840.1.113883.5.111", defaults.facilityType().getSchemeName());
        assertEquals("394802001", defaults.practiceSetting().getCode());
        assertEquals(defaults, new SubmissionProperties(" ", "", null));
    }

    @Test
    void bindsOperatorValues() {
        var bound =
                new Binder(
                                new MapConfigurationPropertySource(
                                        Map.of(
                                                "xds.submission.source-id", "1.2.3",
                                                "xds.submission.healthcare-facility-type-code",
                                                        "a^A^1.2",
                                                "xds.submission.practice-setting-code", "b^B^1.3")))
                        .bind("xds.submission", SubmissionProperties.class)
                        .get();
        assertEquals("1.2.3", bound.sourceId());
        assertEquals("a", bound.facilityType().getCode());
        assertEquals("1.3", bound.practiceSetting().getSchemeName());
    }

    @Test
    void rejectsMalformedValues() {
        assertThrows(
                IllegalArgumentException.class,
                () -> new SubmissionProperties("not-an-oid", null, null));
        assertThrows(
                IllegalArgumentException.class,
                () -> new SubmissionProperties(null, "only-a-code", null));
        assertThrows(
                IllegalArgumentException.class, () -> new SubmissionProperties(null, null, "a^b^"));
    }
}
