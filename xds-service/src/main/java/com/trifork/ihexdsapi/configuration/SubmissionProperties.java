package com.trifork.ihexdsapi.configuration;

import org.openehealth.ipf.commons.ihe.xds.core.metadata.Code;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Operator-owned XDS metadata for ITI-41 submissions that a CDA cannot supply itself. Codes use the
 * form {@code code^display name^scheme OID}. A request can never override these values.
 */
@ConfigurationProperties(prefix = "xds.submission")
public record SubmissionProperties(
        String sourceId, String healthcareFacilityTypeCode, String practiceSettingCode) {
    static final String PLACEHOLDER_SOURCE = "2.25.171864120331415867290573429584325617453";
    static final String PLACEHOLDER_FACILITY = "OF^Outpatient facility^2.16.840.1.113883.5.111";
    static final String PLACEHOLDER_PRACTICE = "394802001^General medicine^2.16.840.1.113883.6.96";

    public SubmissionProperties {
        sourceId = blank(sourceId) ? PLACEHOLDER_SOURCE : sourceId.trim();
        healthcareFacilityTypeCode =
                blank(healthcareFacilityTypeCode)
                        ? PLACEHOLDER_FACILITY
                        : healthcareFacilityTypeCode.trim();
        practiceSettingCode =
                blank(practiceSettingCode) ? PLACEHOLDER_PRACTICE : practiceSettingCode.trim();
        if (!isOid(sourceId))
            throw new IllegalArgumentException("xds.submission.source-id must be an OID");
        code(healthcareFacilityTypeCode);
        code(practiceSettingCode);
    }

    public static SubmissionProperties defaults() {
        return new SubmissionProperties(null, null, null);
    }

    private static boolean isOid(String value) {
        var parts = value.split("\\.", -1);
        return parts.length > 1
                && java.util.Arrays.stream(parts)
                        .allMatch(
                                part ->
                                        !part.isEmpty()
                                                && part.chars().allMatch(Character::isDigit));
    }

    private static boolean blank(String value) {
        return value == null || value.isBlank();
    }

    private static Code code(String value) {
        var parts = value.split("\\^", -1);
        if (parts.length != 3 || parts[0].isBlank() || parts[2].isBlank())
            throw new IllegalArgumentException(
                    "XDS submission codes must use the form code^display name^scheme OID");
        return Code.parse(value);
    }

    public Code facilityType() {
        return code(healthcareFacilityTypeCode);
    }

    public Code practiceSetting() {
        return code(practiceSettingCode);
    }
}
