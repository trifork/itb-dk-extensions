package com.trifork.ihexdsapi.gitb;

import static org.junit.jupiter.api.Assertions.*;

import java.time.Instant;
import org.junit.jupiter.api.Test;

class SigningIdentityTest {
    private final Instant now = Instant.parse("2026-09-15T12:00:00Z");

    @Test
    void labelsExposeTypeAndValidityWithoutClaimingTrust() {
        var current =
                new SigningIdentity(
                        "Jacob",
                        "MOCES",
                        "HEALTHCAREPROFESSIONAL",
                        now.minusSeconds(1),
                        now.plusSeconds(60));
        assertEquals("MOCES — Jacob — expires 2026-09-15", current.label(now));
        current.requireSearchIdentity(now);
        assertEquals("MOCES — Jacob — EXPIRED — 2026-09-15", current.label(now.plusSeconds(61)));
        var afterExpiry = now.plusSeconds(61);
        assertEquals(
                "XDS-CERTIFICATE-EXPIRED",
                assertThrows(XdsFailure.class, () -> current.requireSearchIdentity(afterExpiry))
                        .code);
        var future =
                new SigningIdentity(
                        "Future",
                        "MOCES",
                        "HEALTHCAREPROFESSIONAL",
                        now.plusSeconds(60),
                        now.plusSeconds(120));
        assertTrue(future.label(now).contains("NOT YET VALID"));
        assertEquals(
                "XDS-CERTIFICATE-NOT-YET-VALID",
                assertThrows(XdsFailure.class, () -> future.requireSearchIdentity(now)).code);
    }

    @Test
    void systemIdentityIsVisibleButNotUsedAsAPerson() {
        var system = new SigningIdentity("NSP", "FOCES", "SYSTEM", null, now.plusSeconds(60));
        assertTrue(system.label(now).startsWith("FOCES — NSP"));
        assertTrue(system.label(now).endsWith("system identity"));
        assertEquals(
                "XDS-IDENTITY-TYPE",
                assertThrows(XdsFailure.class, () -> system.requireSearchIdentity(now)).code);
    }

    @Test
    void metadataUsesUtcDatesAndSafeFallbackForUnknownKind() throws Exception {
        var node =
                GitbXdsAccess.JSON.readTree(
                        "{\"displayName\":\"Employee\",\"credentialType\":\"HEALTHCAREPROFESSIONAL\",\"certificateKind\":\"untrusted-label\",\"validUntil\":\"2026-09-16T00:30:00+02:00\"}");
        assertEquals(
                "MOCES — Employee — expires 2026-09-15", SigningIdentity.from(node).label(now));
        var old =
                SigningIdentity.from(
                        GitbXdsAccess.JSON.readTree(
                                "{\"displayName\":\"Old API\",\"credentialType\":\"HEALTHCAREPROFESSIONAL\"}"));
        assertTrue(old.label(now).contains("expiry unknown"));
        old.requireSearchIdentity(now);
    }
}
