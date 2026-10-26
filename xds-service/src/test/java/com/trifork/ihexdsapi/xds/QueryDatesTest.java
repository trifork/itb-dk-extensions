package com.trifork.ihexdsapi.xds;

import static org.junit.jupiter.api.Assertions.*;

import java.time.Instant;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.junit.jupiter.params.provider.ValueSource;

class QueryDatesTest {
    @ParameterizedTest
    @CsvSource({
        "2026,2026",
        "2026-10,202610",
        "2028-02-29,20280229",
        "2026-03-29T02,2026032902",
        "2026-10-25T02:30,202610250230",
        "2026-10-25T02:30:45,20261025023045",
        "2026-10-25T02:30:45Z,20261025023045",
        "2026-10-25T02:30:45+02:00,20261025003045"
    })
    void preservesEachPrecisionAndNormalisesLegacyOffsets(String input, String dtm) {
        assertEquals(dtm, QueryDates.fromInput(input));
        assertEquals(dtm, QueryDates.resolve(null, dtm).toHL7());
    }

    @ParameterizedTest
    @ValueSource(
            strings = {
                "",
                "026",
                "0000",
                "0999",
                "10000",
                "202613",
                "202600",
                "20260100",
                "20260229",
                "2026043100",
                "2026010124",
                "202601010060",
                "20260101000060",
                "2026101",
                "2026Z",
                "<secret>"
            })
    void rejectsInvalidDtmWithoutEchoingInput(String dtm) {
        var error = assertThrows(IllegalArgumentException.class, () -> QueryDates.parse(dtm));
        assertTrue(error.getMessage().startsWith("Use a valid UTC"));
    }

    @Test
    void validatesRangesAtCommonPrecisionAndPreservesOmittedBounds() {
        assertNull(QueryDates.resolve(null, null));
        QueryDates.validateRange(null, QueryDates.parse("2026"));
        QueryDates.validateRange(QueryDates.parse("2026"), null);
        QueryDates.validateRange(QueryDates.parse("20261025"), QueryDates.parse("2026"));
        QueryDates.validateRange(QueryDates.parse("202610"), QueryDates.parse("202610"));
        var nextYear = QueryDates.parse("2027");
        var december = QueryDates.parse("202612");
        var laterDay = QueryDates.parse("20261026");
        var earlierDay = QueryDates.parse("20261025");
        assertThrows(
                IllegalArgumentException.class, () -> QueryDates.validateRange(nextYear, december));
        assertThrows(
                IllegalArgumentException.class,
                () -> QueryDates.validateRange(laterDay, earlierDay));
    }

    @Test
    void retainsEpochContractAndRejectsConflictingFormsAndUnsupportedYears() {
        long millis = Instant.parse("2026-10-26T12:30:45.123Z").toEpochMilli();
        assertEquals("20261026123045", QueryDates.resolve(millis, null).toHL7());
        assertThrows(IllegalArgumentException.class, () -> QueryDates.resolve(millis, "2026"));
        assertThrows(
                IllegalArgumentException.class, () -> QueryDates.resolve(Long.MAX_VALUE, null));
        assertThrows(
                IllegalArgumentException.class, () -> QueryDates.resolve(Long.MIN_VALUE, null));
        assertThrows(IllegalArgumentException.class, () -> QueryDates.fromInput("not-a-date"));
        assertThrows(IllegalArgumentException.class, () -> QueryDates.fromInput("2026-02-29"));
    }
}
