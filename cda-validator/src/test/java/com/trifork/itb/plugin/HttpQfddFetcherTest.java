package com.trifork.itb.plugin;

import static org.junit.jupiter.api.Assertions.*;

import com.sun.net.httpserver.HttpServer;
import java.io.IOException;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicReference;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

class HttpQfddFetcherTest {

    private static HttpServer server;
    private static ExecutorService executor;
    // Holds the deliberately slow handler until the class is done, so that no test sleeps.
    private static final CountDownLatch release = new CountDownLatch(1);
    private static final AtomicReference<String> userAgent = new AtomicReference<>();
    private static final AtomicReference<String> cookie = new AtomicReference<>();
    private static final AtomicReference<String> connectionHeader = new AtomicReference<>();

    @BeforeAll
    static void start() throws IOException {
        server = HttpServer.create(new InetSocketAddress(InetAddress.getLoopbackAddress(), 0), 0);
        server.createContext(
                "/ok",
                exchange -> {
                    userAgent.set(exchange.getRequestHeaders().getFirst("User-Agent"));
                    cookie.set(exchange.getRequestHeaders().getFirst("Cookie"));
                    connectionHeader.set(exchange.getRequestHeaders().getFirst("Connection"));
                    exchange.getResponseHeaders().add("Set-Cookie", "session=secret");
                    send(exchange, 200, "hello");
                });
        server.createContext("/missing", exchange -> send(exchange, 404, "gone"));
        server.createContext(
                "/redirect",
                exchange -> {
                    exchange.getResponseHeaders().add("Location", "/ok");
                    send(exchange, 302, "moved");
                });
        server.createContext("/big", exchange -> send(exchange, 200, "x".repeat(5000)));
        server.createContext(
                "/slow",
                exchange -> {
                    try {
                        release.await(30, TimeUnit.SECONDS);
                    } catch (InterruptedException _) {
                        Thread.currentThread().interrupt();
                    }
                    send(exchange, 200, "late");
                });
        // Several threads, so that the deliberately slow handler never delays another test.
        executor = Executors.newCachedThreadPool();
        server.setExecutor(executor);
        server.start();
    }

    @AfterAll
    static void stop() {
        release.countDown();
        server.stop(0);
        executor.shutdownNow();
    }

    private static void send(com.sun.net.httpserver.HttpExchange exchange, int status, String body)
            throws IOException {
        byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
        exchange.sendResponseHeaders(status, bytes.length);
        try (var out = exchange.getResponseBody()) {
            out.write(bytes);
        }
    }

    private static URI url(String path) {
        return URI.create("http://127.0.0.1:" + server.getAddress().getPort() + path);
    }

    // Generous, so that a cold JVM or a busy machine never makes an ordinary request time out.
    private final HttpQfddFetcher fetcher = new HttpQfddFetcher(5_000, 10_000);

    @Test
    void returnsTheBodyOfASuccessfulResponse() throws Exception {
        var response = fetcher.get(url("/ok"), 1024);
        assertEquals(200, response.status);
        assertEquals("hello", new String(response.body(), StandardCharsets.UTF_8));
    }

    @Test
    void identifiesItselfGenericallyAndKeepsNoCookies() throws Exception {
        fetcher.get(url("/ok"), 1024);
        fetcher.get(url("/ok"), 1024);
        assertEquals("cda-dk-validator", userAgent.get());
        assertNull(cookie.get(), "cookies from an earlier response must not be sent back");
    }

    @Test
    void doesNotReuseConnections() throws Exception {
        fetcher.get(url("/ok"), 1024);
        assertEquals("close", connectionHeader.get());
    }

    @Test
    void reportsOtherStatusesWithoutABody() throws Exception {
        var missing = fetcher.get(url("/missing"), 1024);
        assertEquals(404, missing.status);
        assertEquals(0, missing.body().length);
    }

    @Test
    void neverFollowsRedirects() throws Exception {
        var response = fetcher.get(url("/redirect"), 1024);
        assertEquals(302, response.status);
        assertEquals(0, response.body().length);
    }

    @Test
    void refusesABodyLargerThanTheLimit() {
        var error = assertThrows(IOException.class, () -> fetcher.get(url("/big"), 1000));
        assertTrue(error.getMessage().contains("larger than 1000"), error.getMessage());
    }

    @Test
    void givesUpWhenTheServerIsTooSlow() {
        var impatient = new HttpQfddFetcher(5_000, 300);
        assertThrows(IOException.class, () -> impatient.get(url("/slow"), 1024));
    }

    @Test
    void onlyHttpAndHttpsAreSupported() {
        for (String uri :
                new String[] {"file:///etc/passwd", "ftp://example.com/a", "jar:file:/a!/b"}) {
            assertThrows(IOException.class, () -> fetcher.get(URI.create(uri), 1024), uri);
        }
    }
}
