package com.trifork.ihexdsapi.gitb;

import static org.junit.jupiter.api.Assertions.*;

import java.util.*;
import org.junit.jupiter.api.Test;
import org.openehealth.ipf.commons.ihe.xds.core.responses.*;

class XdsErrorsTest {
    @Test
    void allStandardCodesUseIpfOpcodesWithoutPrivateContext() {
        for (var code : ErrorCode.values()) {
            var errors = List.of(FixtureData.error(code, "sensitive-STStoken", false));
            var error =
                    assertThrows(
                            XdsFailure.class,
                            () -> XdsErrors.check("DDS search (ITI-18)", errors, 2));
            assertEquals("XDS-REGISTRY", error.code);
            assertFalse(error.getMessage().contains("sensitive-STStoken"));
            if (code != ErrorCode._USER_DEFINED)
                assertTrue(error.getMessage().contains(code.getOpcode()));
        }
    }

    @Test
    void warningsDoNotStopProcessing() {
        XdsErrors.check(
                "search", List.of(FixtureData.error(ErrorCode.REGISTRY_ERROR, "private", true)), 1);
    }

    @Test
    void mixedErrorsCountOnlyErrorsAndExplainPartialResults() {
        var errors =
                List.of(
                        FixtureData.error(ErrorCode.REGISTRY_BUSY, "private", false),
                        FixtureData.error(ErrorCode.REGISTRY_ERROR, "private", true));
        var e =
                assertThrows(
                        XdsFailure.class, () -> XdsErrors.check("DDS search (ITI-18)", errors, 3));
        assertTrue(e.getMessage().contains("3 document(s) and 1 registry error(s)"));
        assertTrue(e.getMessage().contains("results may be incomplete"));
    }

    @Test
    void arbitraryFaultsNeverBecomeRecognisedCodes() {
        var e =
                XdsErrors.failure(
                        "DDS search (ITI-18)",
                        new IllegalStateException("private XDSUnavailableCommunity"));
        assertEquals("XDS-BACKEND", e.code);
        assertFalse(e.getMessage().contains("XDSUnavailableCommunity"));
    }

    @Test
    void typedTransportAndSecurityFailuresRemainDistinct() {
        assertEquals(
                "XDS-TIMEOUT",
                XdsErrors.failure("search", new java.net.SocketTimeoutException("private")).code);
        assertEquals(
                "XDS-UNAVAILABLE",
                XdsErrors.failure("search", new java.net.ConnectException("private")).code);
        assertEquals(
                "XDS-ACCESS",
                XdsErrors.failure(
                                "search",
                                new com.trifork.ihexdsapi.dgws.DgwsSecurityException(1, "private"))
                        .code);
    }
}
