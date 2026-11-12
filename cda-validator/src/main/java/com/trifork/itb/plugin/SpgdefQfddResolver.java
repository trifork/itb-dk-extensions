package com.trifork.itb.plugin;

import java.io.IOException;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.time.Clock;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.w3c.dom.Element;

/**
 * Resolves QFDDs from the public SPGDEF catalogue at {@code https://spgdef.dk/qfdd/}.
 *
 * <p>The catalogue table is the registry: an id is looked up there, and only the download link the
 * catalogue lists for it is fetched. Both the catalogue and the downloaded document are validated
 * (see {@link #parseCatalogue} and {@link QfddIntegrity}); anything unexpected is reported as
 * unavailable, never guessed at. The only value taken from a QRD is the id, and it must be a plain
 * identifier, so a reference can never address another host or path.
 *
 * <p>Only the QFDD id leaves the validator. Results are cached for a short time so that a busy
 * validator does not repeat the requests.
 */
final class SpgdefQfddResolver implements QfddResolver {

    static final URI INDEX = URI.create("https://spgdef.dk/qfdd/");
    static final String SOURCE = "SPGDEF QFDD catalogue (spgdef.dk)";
    static final int MAX_INDEX_BYTES = 2 * 1024 * 1024;
    static final int MAX_DOCUMENT_BYTES = 10 * 1024 * 1024;
    private static final int MAX_CACHED_DOCUMENTS = 32;
    private static final int MAX_SHOWN = 160;
    private static final Pattern ID = Pattern.compile("[A-Za-z0-9-]{1,64}");
    private static final Pattern DOWNLOAD_PATH = Pattern.compile("/qfdd/([A-Za-z0-9-]{1,64})");
    private static final int FLAGS = Pattern.DOTALL | Pattern.CASE_INSENSITIVE;
    private static final Pattern TABLE =
            Pattern.compile("<table\\b[^>]*\\bid=\"dt-select\"[^>]*>(.*?)</table>", FLAGS);
    private static final Pattern ROW = Pattern.compile("<tr\\b[^>]*>(.*?)</tr>", FLAGS);
    private static final Pattern CELL = Pattern.compile("<td\\b[^>]*>(.*?)</td>", FLAGS);
    private static final Pattern LINK = Pattern.compile("<a\\b[^>]*\\bhref=\"([^\"]*)\"", FLAGS);
    private static final Pattern TAG = Pattern.compile("<[^>]*>");

    private final QfddFetcher fetcher;
    private final Clock clock;
    private final Duration cacheTime;
    private final Map<String, Cached<byte[]>> documents =
            new LinkedHashMap<>(16, 0.75f, true) {
                @Override
                protected boolean removeEldestEntry(Map.Entry<String, Cached<byte[]>> eldest) {
                    return size() > MAX_CACHED_DOCUMENTS;
                }
            };
    private Cached<Map<String, URI>> catalogue;

    SpgdefQfddResolver(QfddFetcher fetcher, Clock clock, Duration cacheTime) {
        this.fetcher = fetcher;
        this.clock = clock;
        this.cacheTime = cacheTime;
    }

    /** The resolver as used in production: real HTTPS, short timeouts, 15 minutes of caching. */
    static SpgdefQfddResolver standard() {
        return new SpgdefQfddResolver(
                new HttpQfddFetcher(5_000, 20_000), Clock.systemUTC(), Duration.ofMinutes(15));
    }

    private record Cached<T>(T value, Instant loadedAt) {}

    @Override
    public QfddLookup resolve(String id, String version) {
        if (id == null || !ID.matcher(id).matches()) {
            return QfddLookup.notFound("The reference is not a valid QFDD identifier");
        }
        String key = id.toLowerCase(Locale.ROOT);
        byte[] document = cachedDocument(key);
        if (document == null) {
            QfddLookup downloaded = download(key);
            if (downloaded.status != QfddLookup.Status.FOUND) {
                return downloaded;
            }
            document = downloaded.document();
            cacheDocument(key, document);
        }
        if (version != null && !version.equals(versionOf(document))) {
            return QfddLookup.notFound(
                    "The SPGDEF catalogue has no version " + version + " of " + key);
        }
        return QfddLookup.found(document, SOURCE);
    }

    private QfddLookup download(String key) {
        URI url;
        try {
            url = catalogue().get(key);
        } catch (IOException | IllegalArgumentException e) {
            return QfddLookup.unavailable("The SPGDEF catalogue could not be read: " + reason(e));
        }
        if (url == null) {
            return QfddLookup.notFound("The SPGDEF catalogue does not list " + key);
        }
        QfddFetcher.Response response;
        try {
            response = fetcher.get(url, MAX_DOCUMENT_BYTES);
        } catch (IOException e) {
            return QfddLookup.unavailable(
                    "The SPGDEF catalogue entry " + key + " could not be fetched: " + reason(e));
        }
        if (response.status == 404 || response.status == 410) {
            return QfddLookup.notFound(
                    "The SPGDEF catalogue lists " + key + " but no longer serves it");
        }
        if (response.status != 200) {
            return QfddLookup.unavailable(
                    "spgdef.dk answered HTTP " + response.status + " for " + key);
        }
        byte[] body = response.body();
        String problem = QfddIntegrity.problem(body, key);
        if (problem != null) {
            return QfddLookup.unavailable(
                    "spgdef.dk returned a document for "
                            + key
                            + " that is not that QFDD: "
                            + problem);
        }
        return QfddLookup.found(body, SOURCE);
    }

    private Map<String, URI> catalogue() throws IOException {
        synchronized (this) {
            if (catalogue != null && fresh(catalogue.loadedAt())) {
                return catalogue.value();
            }
        }
        QfddFetcher.Response response = fetcher.get(INDEX, MAX_INDEX_BYTES);
        if (response.status != 200) {
            throw new IOException("spgdef.dk answered HTTP " + response.status);
        }
        Map<String, URI> parsed =
                parseCatalogue(new String(response.body(), StandardCharsets.UTF_8));
        synchronized (this) {
            catalogue = new Cached<>(parsed, clock.instant());
        }
        return parsed;
    }

    private synchronized byte[] cachedDocument(String key) {
        Cached<byte[]> cached = documents.get(key);
        return cached != null && fresh(cached.loadedAt()) ? cached.value().clone() : null;
    }

    private synchronized void cacheDocument(String key, byte[] document) {
        documents.put(key, new Cached<>(document.clone(), clock.instant()));
    }

    private boolean fresh(Instant loadedAt) {
        return Duration.between(loadedAt, clock.instant()).compareTo(cacheTime) < 0;
    }

    /**
     * Reads the catalogue table: id to download link. The page layout is not a stable interface, so
     * every row is checked and the first surprise fails the whole catalogue.
     *
     * @return the download link of each listed id, keyed by the lower-case id
     * @throws IllegalArgumentException if the table is missing or any row is not recognised
     */
    static Map<String, URI> parseCatalogue(String html) {
        Matcher table = TABLE.matcher(html);
        if (!table.find()) {
            throw new IllegalArgumentException("no QFDD catalogue table found");
        }
        Map<String, URI> entries = new LinkedHashMap<>();
        Matcher rows = ROW.matcher(table.group(1));
        while (rows.find()) {
            List<String> cells = cells(rows.group(1));
            if (cells.isEmpty() && rows.group(1).toLowerCase(Locale.ROOT).contains("<th")) {
                continue;
            }
            addRow(entries, rows.group(1), cells);
        }
        if (entries.isEmpty()) {
            throw new IllegalArgumentException("the QFDD catalogue lists no documents");
        }
        return Map.copyOf(entries);
    }

    private static void addRow(Map<String, URI> entries, String row, List<String> cells) {
        if (cells.size() < 2) {
            throw new IllegalArgumentException("a catalogue row has no id cell");
        }
        String id = cells.get(1).toLowerCase(Locale.ROOT);
        if (!ID.matcher(id).matches()) {
            throw new IllegalArgumentException("a catalogue row has an unexpected id");
        }
        List<String> links = new ArrayList<>();
        Matcher link = LINK.matcher(row);
        while (link.find()) {
            links.add(link.group(1));
        }
        if (links.size() != 1) {
            throw new IllegalArgumentException(
                    "catalogue row " + id + " has no single download link");
        }
        URI url = INDEX.resolve(links.getFirst()).normalize();
        Matcher path = DOWNLOAD_PATH.matcher(url.getPath() == null ? "" : url.getPath());
        if (!"https".equals(url.getScheme())
                || !INDEX.getHost().equals(url.getHost())
                || url.getPort() != -1
                || url.getUserInfo() != null
                || url.getQuery() != null
                || url.getFragment() != null
                || !path.matches()
                || !path.group(1).equalsIgnoreCase(id)) {
            throw new IllegalArgumentException(
                    "catalogue row " + id + " has an unexpected download link");
        }
        if (entries.putIfAbsent(id, url) != null) {
            throw new IllegalArgumentException("the catalogue lists " + id + " twice");
        }
    }

    private static List<String> cells(String row) {
        List<String> cells = new ArrayList<>();
        Matcher cell = CELL.matcher(row);
        while (cell.find()) {
            cells.add(TAG.matcher(cell.group(1)).replaceAll("").strip());
        }
        return cells;
    }

    private static String versionOf(byte[] document) {
        try {
            Element versionNumber =
                    SecureXml.child(
                            SecureXml.parse(document).getDocumentElement(), "versionNumber");
            return versionNumber == null ? null : versionNumber.getAttribute("value");
        } catch (Exception _) {
            return null;
        }
    }

    private static String reason(Exception e) {
        String message = e.getMessage() == null ? e.getClass().getSimpleName() : e.getMessage();
        return message.length() <= MAX_SHOWN ? message : message.substring(0, MAX_SHOWN) + "...";
    }
}
