package com.trifork.ihexdsapi.logging;

import static org.junit.jupiter.api.Assertions.*;

import jakarta.servlet.ServletException;
import java.util.UUID;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.NullAndEmptySource;
import org.junit.jupiter.params.provider.ValueSource;
import org.slf4j.MDC;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

class RequestCorrelationFilterTest {
    @AfterEach
    void clearContext() {
        MDC.clear();
    }

    @Test
    void usesConfiguredHeaderAndPreservesOtherContext() throws Exception {
        var request = new MockHttpServletRequest();
        request.addHeader("X-Correlation", "request-123");
        MDC.put("other", "retained");
        new RequestCorrelationFilter("X-Correlation")
                .doFilter(
                        request,
                        new MockHttpServletResponse(),
                        (req, res) -> {
                            assertEquals("request-123", MDC.get("correlation-id"));
                            assertEquals("retained", MDC.get("other"));
                        });
        assertNull(MDC.get("correlation-id"));
        assertEquals("retained", MDC.get("other"));
    }

    @ParameterizedTest
    @NullAndEmptySource
    @ValueSource(strings = {"spaces are not an ID", "line\nbreak"})
    void generatesIdForMissingOrInvalidHeaders(String header) throws Exception {
        var request = new MockHttpServletRequest();
        if (header != null) request.addHeader("X-REQUEST-ID", header);
        new RequestCorrelationFilter("X-REQUEST-ID")
                .doFilter(
                        request,
                        new MockHttpServletResponse(),
                        (req, res) -> assertNotNull(UUID.fromString(MDC.get("correlation-id"))));
        assertNull(MDC.get("correlation-id"));
    }

    @Test
    void restoresContextWhenRequestFails() {
        MDC.put("correlation-id", "outer-request");
        var request = new MockHttpServletRequest();
        request.addHeader("X-REQUEST-ID", "inner-request");
        var filter = new RequestCorrelationFilter("X-REQUEST-ID");
        assertThrows(
                ServletException.class,
                () ->
                        filter.doFilter(
                                request,
                                new MockHttpServletResponse(),
                                (req, res) -> {
                                    assertEquals("inner-request", MDC.get("correlation-id"));
                                    throw new ServletException("Expected failure");
                                }));
        assertEquals("outer-request", MDC.get("correlation-id"));
    }
}
