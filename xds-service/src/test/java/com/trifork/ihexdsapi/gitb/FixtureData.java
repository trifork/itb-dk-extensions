package com.trifork.ihexdsapi.gitb;

import com.fasterxml.jackson.databind.JsonNode;
import java.time.*;
import org.openehealth.ipf.commons.ihe.xds.core.metadata.*;
import org.openehealth.ipf.commons.ihe.xds.core.responses.*;

/** Test-only metadata construction, shared by unit and full ITB fixtures. */
public final class FixtureData {
    private FixtureData() {}

    public static ErrorInfo error(ErrorCode code, String context, boolean warning) {
        return new ErrorInfo(
                code, context, warning ? Severity.WARNING : Severity.ERROR, null, null);
    }

    public static QueryResponse search(String value) {
        try {
            return search(GitbXdsAccess.JSON.readTree(value));
        } catch (java.io.IOException e) {
            throw new java.io.UncheckedIOException(e);
        }
    }

    public static QueryResponse search(JsonNode value) {
        var response = new QueryResponse();
        for (var row : value.path("queryResponse")) {
            var entry = new DocumentEntry();
            entry.setPatientId(
                    new Identifiable(
                            row.path("patientId").asText(""),
                            new AssigningAuthority("1.2.208.176.1.2")));
            entry.setUniqueId(row.path("documentId").asText(""));
            entry.setRepositoryUniqueId(row.path("repositoryID").asText(""));
            entry.setTypeCode(
                    new Code(
                            "code",
                            new LocalizedString(row.path("documentType").asText("CDA")),
                            "scheme"));
            if (row.has("serviceStart"))
                entry.setServiceStartTime(
                        new Timestamp(
                                Instant.ofEpochMilli(row.path("serviceStart").asLong())
                                        .atZone(ZoneOffset.UTC),
                                Timestamp.Precision.SECOND));
            if (row.has("serviceEnd"))
                entry.setServiceStopTime(
                        new Timestamp(
                                Instant.ofEpochMilli(row.path("serviceEnd").asLong())
                                        .atZone(ZoneOffset.UTC),
                                Timestamp.Precision.SECOND));
            response.getDocumentEntries().add(entry);
        }
        for (var row : value.path("errors")) {
            var opcode = row.path("errorCode").asText().split(",")[0].trim();
            ErrorCode code;
            try {
                code = ErrorCode.valueOfOpcode(opcode);
            } catch (IllegalArgumentException _) {
                code = ErrorCode._USER_DEFINED;
            }
            response.getErrors()
                    .add(
                            error(
                                    code,
                                    row.path("codeContext").asText(),
                                    row.path("severity").asText().equals("WARNING")));
        }
        return response;
    }
}
