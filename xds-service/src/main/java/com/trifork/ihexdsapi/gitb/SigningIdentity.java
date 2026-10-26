package com.trifork.ihexdsapi.gitb;

import com.fasterxml.jackson.databind.JsonNode;
import java.time.Instant;
import java.time.ZoneOffset;
import java.util.Set;

/** Display and eligibility metadata; STS still verifies trust and authorisation. */
record SigningIdentity(
        String name, String kind, String role, Instant validFrom, Instant validUntil) {
    private static final String EMPLOYEE_KIND = "MOCES";
    private static final String EMPLOYEE_ROLE = "HEALTHCAREPROFESSIONAL";
    private static final String SYSTEM_KIND = "SYSTEM";

    static SigningIdentity from(JsonNode value) {
        String role = value.path("credentialType").asText();
        String kind = value.path("certificateKind").asText();
        if (!Set.of(EMPLOYEE_KIND, "FOCES", "VOCES", SYSTEM_KIND).contains(kind)) {
            kind = EMPLOYEE_ROLE.equals(role) ? EMPLOYEE_KIND : SYSTEM_KIND;
        }
        return new SigningIdentity(
                value.path("displayName").asText(),
                kind,
                role,
                date(value, "validFrom"),
                date(value, "validUntil"));
    }

    String label(Instant now) {
        String validity = validUntil == null ? "expiry unknown" : "expires " + day(validUntil);
        if (validUntil != null && now.isAfter(validUntil))
            validity = "EXPIRED — " + day(validUntil);
        else if (validFrom != null && now.isBefore(validFrom))
            validity = "NOT YET VALID — starts " + day(validFrom);
        String suffix = SYSTEM_KIND.equals(role) ? " — system identity" : "";
        return kind + " — " + name + " — " + validity + suffix;
    }

    boolean currentSystem(Instant now) {
        return SYSTEM_KIND.equals(role) && current(now);
    }

    boolean currentEmployee(Instant now) {
        return EMPLOYEE_ROLE.equals(role) && EMPLOYEE_KIND.equals(kind) && current(now);
    }

    private boolean current(Instant now) {
        return (validFrom == null || !now.isBefore(validFrom))
                && (validUntil == null || !now.isAfter(validUntil));
    }

    void requireSearchIdentity(Instant now) {
        requireSearchIdentity(now, false);
    }

    void requireSearchIdentity(Instant now, boolean stamkort) {
        if (validUntil != null && now.isAfter(validUntil))
            throw new XdsFailure(
                    "XDS-CERTIFICATE-EXPIRED",
                    "The selected certificate has expired. Choose a current certificate.");
        if (validFrom != null && now.isBefore(validFrom))
            throw new XdsFailure(
                    "XDS-CERTIFICATE-NOT-YET-VALID",
                    "The selected certificate is not valid yet. Choose a current certificate.");
        if (!EMPLOYEE_ROLE.equals(role) && !(stamkort && SYSTEM_KIND.equals(role)))
            throw new XdsFailure(
                    "XDS-IDENTITY-TYPE",
                    "The selected certificate is a system identity. This DDS search flow requires a healthcare-professional identity (MOCES); system-only authentication does not supply that user context.");
    }

    private static Instant date(JsonNode value, String field) {
        String text = value.path(field).asText("");
        return text.isBlank() ? null : Instant.parse(text);
    }

    private static String day(Instant value) {
        return value.atOffset(ZoneOffset.UTC).toLocalDate().toString();
    }
}
