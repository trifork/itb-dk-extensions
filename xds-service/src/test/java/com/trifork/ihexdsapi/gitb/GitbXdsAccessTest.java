package com.trifork.ihexdsapi.gitb;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import com.trifork.ihexdsapi.service.XdsOperations;
import java.time.Duration;
import java.util.List;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

class GitbXdsAccessTest {
    @Test
    void timeoutCancelsWorkAndLaterCallsStillSucceed() throws Exception {
        var operations = mock(XdsOperations.class);
        var interrupted = new CountDownLatch(1);
        when(operations.identities())
                .thenAnswer(
                        call -> {
                            try {
                                new CountDownLatch(1).await();
                                throw new AssertionError("Work should have been cancelled");
                            } catch (InterruptedException expected) {
                                interrupted.countDown();
                                throw expected;
                            }
                        })
                .thenReturn(List.of());
        try (var access = new GitbXdsAccess(operations, Duration.ofMillis(500))) {
            assertEquals("XDS-TIMEOUT", assertThrows(XdsFailure.class, access::identities).code);
            assertTrue(interrupted.await(2, TimeUnit.SECONDS));
            assertTrue(access.identities().isEmpty());
        }
    }

    @Test
    void workerContextIsPropagatedAndClearedBeforeReuse() {
        var operations = mock(XdsOperations.class);
        var attributes = new ServletRequestAttributes(new MockHttpServletRequest());
        when(operations.identities())
                .thenAnswer(
                        call -> {
                            assertSame(attributes, RequestContextHolder.getRequestAttributes());
                            return List.of();
                        });
        try (var access = new GitbXdsAccess(operations, Duration.ofSeconds(2))) {
            RequestContextHolder.setRequestAttributes(attributes);
            try {
                // Fill all eight workers with a request context.
                for (int i = 0; i < 8; i++) access.identities();
            } finally {
                RequestContextHolder.resetRequestAttributes();
            }
            doAnswer(
                            call -> {
                                assertNull(RequestContextHolder.getRequestAttributes());
                                return List.of();
                            })
                    .when(operations)
                    .identities();
            for (int i = 0; i < 8; i++) access.identities();
        }
    }
}
