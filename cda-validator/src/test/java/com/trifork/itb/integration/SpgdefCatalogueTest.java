package com.trifork.itb.integration;

import static org.junit.jupiter.api.Assertions.*;

import java.nio.charset.StandardCharsets;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

class SpgdefCatalogueTest {
    @Test
    void discoversAllRowsIncludingNumericIdsAndDeduplicatesDownloads() {
        String html =
                "<a href='/qfdd'>Navigation</a><table id='dt-select'><tbody>"
                        + row("Hjerte &amp; lunge v.1", "/qfdd/abc-123")
                        + row("Older version", "/qfdd/28")
                        + row("Duplicate link", "https://spgdef.dk/qfdd/abc-123")
                        + "</tbody></table>";
        var entries = SpgdefCatalogue.parse(html.getBytes(StandardCharsets.UTF_8));
        assertEquals(2, entries.size());
        assertEquals("Hjerte & lunge v.1", entries.getFirst().name());
        assertEquals("https://spgdef.dk/qfdd/28", entries.get(1).url().toString());
    }

    @ParameterizedTest
    @ValueSource(
            strings = {
                "https://example.org/qfdd/a",
                "http://spgdef.dk/qfdd/a",
                "/other/a",
                "/qfdd/../a",
                "/qfdd/a?redirect=1"
            })
    void rejectsUnexpectedDownloadLocations(String url) {
        byte[] html =
                ("<table id='dt-select'><tbody>" + row("Questionnaire", url) + "</tbody></table>")
                        .getBytes(StandardCharsets.UTF_8);
        assertThrows(IllegalArgumentException.class, () -> SpgdefCatalogue.parse(html));
    }

    @ParameterizedTest
    @ValueSource(
            strings = {
                "<html>Unavailable</html>",
                "<table id='dt-select'><tbody></tbody></table>",
                "<table id='dt-select'><tbody><tr><td>Missing download</td></tr></tbody></table>"
            })
    void doesNotTreatMissingDocumentsOrChangedMarkupAsSuccessfulEmptyRun(String html) {
        byte[] bytes = html.getBytes(StandardCharsets.UTF_8);
        assertThrows(IllegalArgumentException.class, () -> SpgdefCatalogue.parse(bytes));
    }

    @Test
    void retainsValidationFailuresAndWarningsAsDistinctFromServiceErrors() throws Exception {
        var failure = SpgdefCatalogue.outcome(report("FAILURE", 3, 2, "qfdd.v1.2"));
        assertEquals("FAILURE", failure.get("result"));
        assertEquals(3, failure.get("errors"));
        assertEquals(2, failure.get("warnings"));
        var warningOnly = SpgdefCatalogue.outcome(report("SUCCESS", 0, 2, "qfdd.v1.2"));
        assertEquals("SUCCESS", warningOnly.get("result"));
        assertEquals(2, warningOnly.get("warnings"));
    }

    @ParameterizedTest
    @ValueSource(strings = {"UNDEFINED", "SUCCESS_WITH_ERRORS", "WRONG_TARGET", "HTML"})
    void rejectsServiceErrorsAndWrongOrUnreachedValidationTarget(String scenario) {
        byte[] response =
                switch (scenario) {
                    case "UNDEFINED" -> report("UNDEFINED", 0, 0, "qfdd.v1.2");
                    case "SUCCESS_WITH_ERRORS" -> report("SUCCESS", 2, 0, "qfdd.v1.2");
                    case "WRONG_TARGET" -> report("SUCCESS", 0, 0, "qrd.v1.3.2");
                    default -> "<html>Bad gateway</html>".getBytes(StandardCharsets.UTF_8);
                };
        assertThrows(IllegalArgumentException.class, () -> SpgdefCatalogue.outcome(response));
    }

    private static String row(String name, String href) {
        return "<tr><td>"
                + name
                + "</td><td>ID</td><td><a href='"
                + href
                + "' title='Download QFDD'></a></td></tr>";
    }

    private static byte[] report(String result, int errors, int warnings, String target) {
        return ("<tar:TestAssertionReport xmlns:tar='http://www.gitb.com/tar/v1/'>"
                        + "<result>"
                        + result
                        + "</result><counters><nrOfErrors>"
                        + errors
                        + "</nrOfErrors><nrOfWarnings>"
                        + warnings
                        + "</nrOfWarnings></counters>"
                        + "<reports><info><assertionID>CDA-DK-RULESET</assertionID><description>Selected "
                        + target
                        + "</description></info></reports></tar:TestAssertionReport>")
                .getBytes(StandardCharsets.UTF_8);
    }
}
