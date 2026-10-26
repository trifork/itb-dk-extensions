package com.trifork.ihexdsapi.configuration;

import java.util.Map;
import org.springframework.boot.context.properties.ConfigurationProperties;

/** Coding schemes for document types outside the configured default scheme. */
@ConfigurationProperties(prefix = "type.code")
public record TypeCodeProperties(Map<String, String> schemeOverrides) {
    public TypeCodeProperties {
        schemeOverrides = schemeOverrides == null ? Map.of() : Map.copyOf(schemeOverrides);
        if (schemeOverrides.entrySet().stream()
                .anyMatch(entry -> entry.getKey().isBlank() || entry.getValue().isBlank()))
            throw new IllegalArgumentException("Type code scheme overrides must not be blank");
    }
}
