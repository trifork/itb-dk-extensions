package com.trifork.ihexdsapi.configuration;

import java.util.Map;
import org.springframework.boot.context.properties.ConfigurationProperties;

/** Coding schemes for format codes outside the configured default (MedCom) scheme. */
@ConfigurationProperties(prefix = "format.code")
public record FormatCodeProperties(Map<String, String> schemeOverrides) {
    public FormatCodeProperties {
        schemeOverrides = schemeOverrides == null ? Map.of() : Map.copyOf(schemeOverrides);
        if (schemeOverrides.entrySet().stream()
                .anyMatch(entry -> entry.getKey().isBlank() || entry.getValue().isBlank()))
            throw new IllegalArgumentException("Format code scheme overrides must not be blank");
    }
}
