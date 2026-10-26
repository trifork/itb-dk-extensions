package com.trifork.ihexdsapi.xds;

import java.time.DateTimeException;
import java.time.Instant;
import java.time.ZoneOffset;
import org.openehealth.ipf.commons.ihe.xds.core.metadata.Timestamp;
import org.openehealth.ipf.commons.ihe.xds.core.validate.XDSMetaDataException;

/** ITI-18 section 3.18.4.1.2.3.3: UTC dates retain their supplied precision. */
public final class QueryDates {
    private QueryDates() {}

    /** Accept the guided form's ISO partial date or its legacy offset timestamp. */
    public static String fromInput(String value) {
        if (value.matches("\\d{4}(-\\d{2}){0,2}")
                || value.matches("\\d{4}-\\d{2}-\\d{2}T\\d{2}(:\\d{2}){0,2}")) {
            String dtm = value.replace("-", "").replace("T", "").replace(":", "");
            return parse(dtm).toHL7();
        }
        try {
            return fromInstant(Instant.parse(value)).toHL7();
        } catch (DateTimeException _) {
            throw invalid();
        }
    }

    /** Legacy REST epoch milliseconds and precision-preserving DTM are mutually exclusive. */
    public static Timestamp resolve(Long epochMillis, String dtm) {
        if (epochMillis != null && dtm != null) {
            throw new IllegalArgumentException(
                    "Supply either epoch milliseconds or DTM for each date bound, not both.");
        }
        if (dtm != null) return parse(dtm);
        if (epochMillis == null) return null;
        return fromInstant(Instant.ofEpochMilli(epochMillis));
    }

    private static Timestamp fromInstant(Instant instant) {
        var date = instant.atZone(ZoneOffset.UTC);
        if (date.getYear() < 1000 || date.getYear() > 9999) throw invalid();
        return new Timestamp(date, Timestamp.Precision.SECOND);
    }

    public static Timestamp parse(String dtm) {
        if (!dtm.matches("[1-9]\\d{3}(\\d{2}){0,5}")) throw invalid();
        final Timestamp timestamp;
        try {
            timestamp = Timestamp.fromHL7(dtm);
        } catch (DateTimeException | XDSMetaDataException _) {
            throw invalid();
        }
        // IPF accepts some HL7 variants (e.g. zero month/day). Require the XDS
        // subset to round-trip unchanged; keep IPF's native precision throughout.
        if (!dtm.equals(timestamp.toHL7())) throw invalid();
        return timestamp;
    }

    public static void validateRange(Timestamp from, Timestamp to) {
        if (from == null || to == null) return;
        String lower = from.toHL7();
        String upper = to.toHL7();
        // A year/month upper bound may cover a finer lower bound in that period.
        // Reject only ranges reversed at their common precision; do not pad them.
        int length = Math.min(lower.length(), upper.length());
        if (lower.substring(0, length).compareTo(upper.substring(0, length)) > 0) {
            throw new IllegalArgumentException("A date range starts after it ends.");
        }
    }

    private static IllegalArgumentException invalid() {
        return new IllegalArgumentException(
                "Use a valid UTC year, month, day, hour, minute or second (years 1000–9999), or an ISO timestamp with timezone.");
    }
}
