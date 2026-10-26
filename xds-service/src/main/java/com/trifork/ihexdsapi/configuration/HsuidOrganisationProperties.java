package com.trifork.ihexdsapi.configuration;

import com.trifork.ihexdsapi.dgws.HsuidConfigurationException;
import java.util.Set;
import org.springframework.boot.context.properties.ConfigurationProperties;

/** Organisation of the healthcare professional, separate from the signing certificate CVR. */
@ConfigurationProperties(prefix = "xds.hsuid.organisation")
public record HsuidOrganisationProperties(String identifier, String scheme) {
    public HsuidOrganisationProperties {
        identifier = identifier == null ? "" : identifier.strip();
        scheme = scheme == null || scheme.isBlank() ? "sor" : scheme.strip();
        if (!Set.of("sor", "skskode", "ynumber").contains(scheme))
            throw new IllegalArgumentException(
                    "HSUID organisation scheme must be sor, skskode or ynumber");
        if (!identifier.isEmpty() && !identifier.matches("[0-9A-Za-z]{1,30}"))
            throw new IllegalArgumentException(
                    "HSUID organisation identifier must contain 1–30 letters or digits");
        if ("sor".equals(scheme) && !identifier.isEmpty() && !identifier.matches("\\d+"))
            throw new IllegalArgumentException(
                    "HSUID SOR organisation identifier must contain only digits");
    }

    public void requireConfigured() {
        if (identifier.isEmpty()) throw new HsuidConfigurationException();
    }

    public String nameFormat() {
        return "nsi:" + scheme;
    }
}
