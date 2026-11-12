package com.trifork.itb.plugin;

import static org.junit.jupiter.api.Assertions.*;

import java.io.IOException;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.time.Clock;
import java.time.Duration;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class SpgdefQfddResolverTest {

    private static final String ID = "6069bddf-b6ae-4e64-833e-ad2ba8b5c6b2";
    private static final URI DOCUMENT = URI.create("https://spgdef.dk/qfdd/" + ID);
    private static final Duration TTL = Duration.ofMinutes(15);

    /** Serves canned responses and records every request. */
    private static final class FakeFetcher implements QfddFetcher {
        final Map<URI, Object> answers = new HashMap<>();
        final List<URI> requests = new ArrayList<>();

        @Override
        public Response get(URI uri, int maxBytes) throws IOException {
            requests.add(uri);
            Object answer = answers.get(uri);
            if (answer instanceof IOException e) {
                throw e;
            }
            if (answer instanceof Response response) {
                return response;
            }
            return new Response(404, new byte[0]);
        }

        int count(URI uri) {
            return (int) requests.stream().filter(uri::equals).count();
        }
    }

    private static final class MutableClock extends Clock {
        Instant now = Instant.parse("2026-11-12T12:00:00Z");

        @Override
        public ZoneId getZone() {
            return ZoneOffset.UTC;
        }

        @Override
        public Clock withZone(ZoneId zone) {
            return this;
        }

        @Override
        public Instant instant() {
            return now;
        }
    }

    private FakeFetcher fetcher;
    private MutableClock clock;
    private SpgdefQfddResolver resolver;
    private byte[] qfdd;

    @BeforeEach
    void setUp() {
        fetcher = new FakeFetcher();
        clock = new MutableClock();
        resolver = new SpgdefQfddResolver(fetcher, clock, TTL);
        qfdd = new EmbeddedQfddResolver().resolve(ID, null).document();
        publish(ID, qfdd);
    }

    private static byte[] table(String... idAndLink) {
        StringBuilder rows = new StringBuilder();
        for (int i = 0; i < idAndLink.length; i += 2) {
            rows.append("<tr><td>Form ")
                    .append(idAndLink[i])
                    .append(" v.1</td><td>")
                    .append(idAndLink[i])
                    .append("</td><td><a href=\"")
                    .append(idAndLink[i + 1])
                    .append("\" class=\"btn\"><i class=\"x\"></i></a></td></tr>");
        }
        return ("<html><body><table id=\"dt-select\" class=\"table\"><thead><tr><th>Name</th>"
                        + "<th>UUID</th><th>Download</th></tr></thead><tbody>"
                        + rows
                        + "</tbody></table></body></html>")
                .getBytes(StandardCharsets.UTF_8);
    }

    private void publish(String id, byte[] document) {
        fetcher.answers.put(
                SpgdefQfddResolver.INDEX, new QfddFetcher.Response(200, table(id, "/qfdd/" + id)));
        fetcher.answers.put(
                URI.create("https://spgdef.dk/qfdd/" + id),
                new QfddFetcher.Response(200, document));
    }

    private static String xml(String body) {
        return "<ClinicalDocument xmlns=\"urn:hl7-org:v3\">" + body + "</ClinicalDocument>";
    }

    @Test
    void resolvesAListedQfddAndCachesIt() {
        QfddLookup first = resolver.resolve(ID, null);
        assertEquals(QfddLookup.Status.FOUND, first.status, first.detail);
        assertArrayEquals(qfdd, first.document());
        assertEquals(SpgdefQfddResolver.SOURCE, first.detail);
        assertEquals(2, fetcher.requests.size(), "the catalogue and the document");

        assertEquals(QfddLookup.Status.FOUND, resolver.resolve(ID.toUpperCase(), null).status);
        assertEquals(2, fetcher.requests.size(), "the second answer comes from the cache");
    }

    @Test
    void cachedAnswersExpire() {
        resolver.resolve(ID, null);
        clock.now = clock.now.plus(TTL).plusSeconds(1);
        assertEquals(QfddLookup.Status.FOUND, resolver.resolve(ID, null).status);
        assertEquals(2, fetcher.count(SpgdefQfddResolver.INDEX));
        assertEquals(2, fetcher.count(DOCUMENT));
    }

    @Test
    void anIdentifierThatIsNotListedIsNotFetched() {
        QfddLookup lookup = resolver.resolve("11111111-1111-4111-8111-111111111111", null);
        assertEquals(QfddLookup.Status.NOT_FOUND, lookup.status);
        assertEquals(List.of(SpgdefQfddResolver.INDEX), fetcher.requests, "only the catalogue");
    }

    @Test
    void identifiersThatCouldAddressAnotherResourceMakeNoRequest() {
        for (String id :
                new String[] {
                    null, "", "../etc/passwd", "a/b", "a b", "x?y=1", "a".repeat(65), "%2e%2e"
                }) {
            assertEquals(QfddLookup.Status.NOT_FOUND, resolver.resolve(id, null).status, id);
        }
        assertTrue(fetcher.requests.isEmpty());
    }

    @Test
    void statusCodesAreNeverMistakenForAPass() {
        for (int status : new int[] {301, 302, 403, 500, 503}) {
            fetcher.answers.put(DOCUMENT, new QfddFetcher.Response(status, qfdd));
            QfddLookup lookup = resolver.resolve(ID, null);
            assertEquals(QfddLookup.Status.UNAVAILABLE, lookup.status, "HTTP " + status);
            assertTrue(lookup.detail.contains("HTTP " + status), lookup.detail);
        }
        for (int status : new int[] {404, 410}) {
            fetcher.answers.put(DOCUMENT, new QfddFetcher.Response(status, new byte[0]));
            assertEquals(QfddLookup.Status.NOT_FOUND, resolver.resolve(ID, null).status);
        }
    }

    @Test
    void networkFailureIsUnavailableAndNotCached() {
        fetcher.answers.put(DOCUMENT, new IOException("Connection timed out"));
        QfddLookup lookup = resolver.resolve(ID, null);
        assertEquals(QfddLookup.Status.UNAVAILABLE, lookup.status);
        assertTrue(lookup.detail.contains("timed out"), lookup.detail);

        fetcher.answers.put(DOCUMENT, new QfddFetcher.Response(200, qfdd));
        assertEquals(QfddLookup.Status.FOUND, resolver.resolve(ID, null).status);
    }

    @Test
    void anUnreadableCatalogueIsUnavailable() {
        for (Object answer :
                new Object[] {
                    new IOException("Unknown host"),
                    new QfddFetcher.Response(503, new byte[0]),
                    new QfddFetcher.Response(
                            200, "<html>nothing here</html>".getBytes(StandardCharsets.UTF_8)),
                    new QfddFetcher.Response(200, table("a", "https://evil.example/qfdd/a"))
                }) {
            fetcher.answers.put(SpgdefQfddResolver.INDEX, answer);
            QfddLookup lookup = new SpgdefQfddResolver(fetcher, clock, TTL).resolve(ID, null);
            assertEquals(QfddLookup.Status.UNAVAILABLE, lookup.status, String.valueOf(answer));
            assertTrue(lookup.detail.contains("catalogue could not be read"), lookup.detail);
        }
    }

    @Test
    void aDownloadThatIsNotTheRequestedQfddIsRejected() {
        String body = new String(qfdd, StandardCharsets.UTF_8);
        Map<String, String> bad = new HashMap<>();
        bad.put("another id", body.replace("extension=\"" + ID + "\"", "extension=\"other\""));
        bad.put("not XML", "this is not xml");
        bad.put(
                "a DOCTYPE",
                "<!DOCTYPE ClinicalDocument [<!ENTITY x SYSTEM 'file:///etc/passwd'>]>" + body);
        bad.put("not a ClinicalDocument", "<html xmlns=\"urn:hl7-org:v3\"/>");
        bad.put(
                "not a QFDD",
                xml("<templateId root=\"1.2.208.184.13.1\"/><id extension=\"" + ID + "\"/>"));
        bad.put("the wrong document code", body.replace("code=\"74468-0\"", "code=\"74465-6\""));
        for (var entry : bad.entrySet()) {
            fetcher.answers.put(
                    DOCUMENT,
                    new QfddFetcher.Response(
                            200, entry.getValue().getBytes(StandardCharsets.UTF_8)));
            QfddLookup lookup = new SpgdefQfddResolver(fetcher, clock, TTL).resolve(ID, null);
            assertEquals(QfddLookup.Status.UNAVAILABLE, lookup.status, entry.getKey());
            assertTrue(
                    lookup.detail.contains("not that QFDD"), entry.getKey() + ": " + lookup.detail);
        }
    }

    @Test
    void aStatedVersionMustMatch() {
        assertEquals(QfddLookup.Status.FOUND, resolver.resolve(ID, "1").status);
        QfddLookup lookup = resolver.resolve(ID, "2");
        assertEquals(QfddLookup.Status.NOT_FOUND, lookup.status);
        assertTrue(lookup.detail.contains("version 2"), lookup.detail);
    }

    @Test
    void parsesTheRealCatalogueLayout() throws Exception {
        try (var stream = getClass().getResourceAsStream("/spgdef/catalogue-table.html")) {
            Map<String, URI> entries =
                    SpgdefQfddResolver.parseCatalogue(
                            new String(stream.readAllBytes(), StandardCharsets.UTF_8));
            assertEquals(86, entries.size());
            assertEquals(
                    URI.create("https://spgdef.dk/qfdd/cfe60422-8a81-4511-bed2-f40f7229e30e"),
                    entries.get("cfe60422-8a81-4511-bed2-f40f7229e30e"));
            assertEquals(URI.create("https://spgdef.dk/qfdd/28"), entries.get("28"));
        }
    }

    @Test
    void anyUnexpectedCatalogueRowFailsTheWholeCatalogue() {
        String good = "/qfdd/abc";
        for (String html :
                new String[] {
                    "<table id=\"dt-select\"><tbody></tbody></table>",
                    "<table id=\"other\"><tr><td>x</td><td>abc</td></tr></table>",
                    new String(table("abc", "https://spgdef.dk.evil.example/qfdd/abc")),
                    new String(table("abc", "http://spgdef.dk/qfdd/abc")),
                    new String(table("abc", "//evil.example/qfdd/abc")),
                    new String(table("abc", "/qfdd/abc?download=1")),
                    new String(table("abc", "/qfdd/abc#frag")),
                    new String(table("abc", "/qfdd/other")),
                    new String(table("abc", "/other/abc")),
                    new String(table("abc", good, "abc", good)),
                    new String(table("not an id!", "/qfdd/abc"))
                }) {
            assertThrows(
                    IllegalArgumentException.class,
                    () -> SpgdefQfddResolver.parseCatalogue(html),
                    html);
        }
    }
}
