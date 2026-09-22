package com.trifork.ihexdsapi.configuration;

import java.net.URI;
import java.util.HashSet;
import java.util.List;
import org.springframework.boot.context.properties.ConfigurationProperties;

/** Operator-owned endpoint bundles. Request input can select an ID, never a URL. */
@ConfigurationProperties(prefix = "xds")
public record RegistryProperties(List<Registry> registries) {
    private static final java.util.regex.Pattern ID =
            java.util.regex.Pattern.compile("[A-Za-z0-9_-]{1,64}");

    public RegistryProperties {
        registries = registries == null ? List.of() : List.copyOf(registries);
        var ids = new HashSet<String>();
        for (var registry : registries) {
            if (registry.id() == null
                    || !ID.matcher(registry.id()).matches()
                    || !ids.add(registry.id()))
                throw new IllegalArgumentException(
                        "XDS registry IDs must be unique and use 1–64 letters, digits, underscores or hyphens");
            if (registry.name() == null
                    || registry.name().isBlank()
                    || registry.name().length() > 150
                    || registry.name().chars().anyMatch(Character::isISOControl))
                throw new IllegalArgumentException(
                        "Each XDS registry needs a readable name of up to 150 characters");
            endpoint(registry.iti18Endpoint());
            endpoint(registry.iti43Endpoint());
            endpoint(registry.stsEndpoint());
        }
    }

    private static void endpoint(String value) {
        try {
            URI uri = URI.create(value);
            if (!("http".equals(uri.getScheme()) || "https".equals(uri.getScheme()))
                    || uri.getHost() == null
                    || uri.getUserInfo() != null
                    || uri.getFragment() != null)
                throw new IllegalArgumentException("Invalid endpoint");
        } catch (IllegalArgumentException | NullPointerException e) {
            throw new IllegalArgumentException(
                    "Each XDS registry requires HTTP(S) ITI-18, ITI-43 and STS endpoints without embedded credentials or fragments",
                    e);
        }
    }

    public record Registry(
            String id,
            String name,
            String iti18Endpoint,
            String iti43Endpoint,
            String stsEndpoint) {}
}
