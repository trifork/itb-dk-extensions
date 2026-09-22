package com.trifork.itb.integration;

import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;

/** The public catalogue contains every download in its server-rendered table (no pagination). */
final class SpgdefCatalogue {
    static final URI INDEX = URI.create("https://spgdef.dk/qfdd/");
    static final String TARGET = "qfdd.v1.2";
    private static final Pattern DOWNLOAD_PATH = Pattern.compile("/qfdd/[A-Za-z0-9-]+");

    private SpgdefCatalogue() {}

    record Entry(String name, URI url) {}

    static List<Entry> parse(byte[] html) {
        var page = Jsoup.parse(new String(html, StandardCharsets.UTF_8), INDEX.toString());
        Map<URI, Entry> entries = new LinkedHashMap<>();
        var rows = page.select("table#dt-select tbody tr");
        if (rows.isEmpty()) throw new IllegalArgumentException("No QFDD catalogue rows found");
        for (Element row : rows) {
            var cells = row.select("td");
            var links = row.select("a[href]");
            if (cells.isEmpty() || links.size() != 1 || cells.getFirst().text().isBlank()) {
                throw new IllegalArgumentException(
                        "Catalogue row is missing its name or download link");
            }
            URI url = INDEX.resolve(links.getFirst().attr("href")).normalize();
            if (!"https".equals(url.getScheme())
                    || !INDEX.getHost().equals(url.getHost())
                    || url.getPort() != -1
                    || url.getUserInfo() != null
                    || url.getQuery() != null
                    || url.getFragment() != null
                    || !DOWNLOAD_PATH.matcher(url.getPath()).matches()) {
                throw new IllegalArgumentException("Unexpected QFDD download URL: " + url);
            }
            entries.putIfAbsent(url, new Entry(cells.getFirst().text(), url));
        }
        return List.copyOf(entries.values());
    }

    static Map<String, Object> outcome(byte[] report) throws Exception {
        var document = ValidatorClient.parse(report);
        if (ValidatorClient.nodes(document, "/*/*[local-name()='counters']").isEmpty()) {
            throw new IllegalArgumentException("Validator did not return a validation report");
        }
        var summary = ValidatorClient.summary(document);
        String result = (String) summary.get("result");
        int errors = (Integer) summary.get("errors");
        int warnings = (Integer) summary.get("warnings");
        if (!List.of("SUCCESS", "FAILURE").contains(result)
                || errors < 0
                || warnings < 0
                || ("SUCCESS".equals(result) && errors > 0)) {
            throw new IllegalArgumentException(
                    "Validator returned an incomplete or inconsistent result: " + summary);
        }
        boolean targetRecorded = false;
        for (var finding : ValidatorClient.findings(document)) {
            targetRecorded |=
                    "CDA-DK-RULESET".equals(ValidatorClient.text(finding, "assertionID"))
                            && ValidatorClient.text(finding, "description").contains(TARGET);
        }
        if (!targetRecorded)
            throw new IllegalArgumentException(
                    "QFDD-DK 1.2 was not recorded in the validation report");
        return summary;
    }

    static String markdown(String value) {
        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("|", "&#124;")
                .replace("\r", " ")
                .replace("\n", " ")
                .replace("[", "&#91;")
                .replace("]", "&#93;")
                .replace("`", "&#96;");
    }
}
