package com.trifork.ihexdsapi.gitb;

import java.util.*;
import org.openehealth.ipf.commons.ihe.xds.core.responses.*;

/** Only curated text and standard opcodes enter ITB reports; never SOAP or patient context. */
final class XdsErrors {
    private XdsErrors() {}

    private record Explanation(String explanation, String advice) {}

    private static final String RETRY =
            "Retry later; if the problem persists, contact the DDS operator.";
    private static final String CONFIG = "Ask the DDS operator to check routing and configuration.";
    private static final String REQUEST =
            "Ask the integration maintainer to check the request and backend configuration.";
    private static final String METADATA = "Ask the DDS operator to check the document metadata.";
    private static final Map<ErrorCode, Explanation> EXPLANATIONS =
            Map.ofEntries(
                    Map.entry(
                            ErrorCode.UNAVAILABLE_COMMUNITY,
                            new Explanation(
                                    "A required community or repository gateway is unavailable.",
                                    RETRY)),
                    Map.entry(
                            ErrorCode.UNKNOWN_COMMUNITY,
                            new Explanation("The home community is not recognised.", CONFIG)),
                    Map.entry(
                            ErrorCode.MISSING_HOME_COMMUNITY_ID,
                            new Explanation("A required home community ID is missing.", REQUEST)),
                    Map.entry(
                            ErrorCode.UNKNOWN_REPOSITORY_ID,
                            new Explanation(
                                    "The repository ID cannot be resolved or does not match.",
                                    CONFIG)),
                    Map.entry(
                            ErrorCode.DOCUMENT_UNIQUE_ID_ERROR,
                            new Explanation(
                                    "The document is unavailable, no longer available, or access is not authorised.",
                                    "Search again or ask the DDS operator to check document availability and access.")),
                    Map.entry(
                            ErrorCode.REGISTRY_BUSY,
                            new Explanation("The registry is busy.", RETRY)),
                    Map.entry(
                            ErrorCode.REPOSITORY_BUSY,
                            new Explanation("The repository is busy.", RETRY)),
                    Map.entry(
                            ErrorCode.REGISTRY_OUT_OF_RESOURCES,
                            new Explanation(
                                    "The registry lacks resources to process the request.", RETRY)),
                    Map.entry(
                            ErrorCode.REPOSITORY_OUT_OF_RESOURCES,
                            new Explanation(
                                    "The repository lacks resources to process the request.",
                                    RETRY)),
                    Map.entry(
                            ErrorCode.REGISTRY_NOT_AVAILABLE,
                            new Explanation("The repository cannot access the registry.", RETRY)),
                    Map.entry(
                            ErrorCode.REGISTRY_ERROR,
                            new Explanation("The registry reported an internal error.", RETRY)),
                    Map.entry(
                            ErrorCode.REPOSITORY_ERROR,
                            new Explanation("The repository reported an internal error.", RETRY)),
                    Map.entry(
                            ErrorCode.REGISTRY_METADATA_ERROR,
                            new Explanation("DDS reported invalid registry metadata.", METADATA)),
                    Map.entry(
                            ErrorCode.REPOSITORY_METADATA_ERROR,
                            new Explanation("DDS reported invalid repository metadata.", METADATA)),
                    Map.entry(
                            ErrorCode.RESULT_NOT_SINGLE_PATIENT,
                            new Explanation(
                                    "The result would contain multiple patients.",
                                    "Processing stopped. Ask the DDS operator to check patient matching.")),
                    Map.entry(
                            ErrorCode.UNKNOWN_PATIENT_ID,
                            new Explanation(
                                    "The receiving service does not recognise the patient ID.",
                                    "Check the test CPR and its registration in the selected environment.")),
                    Map.entry(
                            ErrorCode.UNKNOWN_STORED_QUERY,
                            new Explanation("The stored query ID is not recognised.", REQUEST)),
                    Map.entry(
                            ErrorCode.STORED_QUERY_MISSING_PARAM,
                            new Explanation("A required search parameter is missing.", REQUEST)),
                    Map.entry(
                            ErrorCode.STORED_QUERY_PARAM_NUMBER,
                            new Explanation(
                                    "A single-valued search parameter contains multiple values.",
                                    REQUEST)),
                    Map.entry(
                            ErrorCode.TOO_MANY_RESULTS,
                            new Explanation(
                                    "The request or response is too broad or large.",
                                    "Narrow the search using type, format or date filters.")));

    private static final String EXTRACTION_ERROR =
            "urn:dk:nsi:Information Withheld due to Extraction Error";

    private static Explanation explanation(ErrorCode code) {
        return code == null ? null : EXPLANATIONS.get(code);
    }

    static void check(String operation, List<ErrorInfo> findings, Integer documents) {
        var reasons = new LinkedHashSet<String>();
        var advice = new LinkedHashSet<String>();
        int count = 0;
        for (var finding : findings) {
            if (finding.getSeverity() == Severity.WARNING) continue;
            count++;
            var code = finding.getErrorCode();
            var explanation = explanation(code);
            if (explanation != null) {
                reasons.add(code.getOpcode() + ": " + explanation.explanation());
                advice.add(explanation.advice());
            } else if (EXTRACTION_ERROR.equals(finding.getCodeContext())) {
                reasons.add("DDS reports information withheld due to an extraction error.");
                advice.add("Try another test patient or contact the DDS operator.");
            } else if (code != null && code != ErrorCode._USER_DEFINED) {
                reasons.add(code.getOpcode() + ": DDS reported a registry/repository error.");
                advice.add("Ask the DDS operator to check the request and service diagnostics.");
            } else {
                reasons.add("Unrecognised registry/repository error (details withheld).");
                advice.add("Ask the integration maintainer to check service diagnostics.");
            }
        }
        if (count > 0)
            throw new XdsFailure(
                    "XDS-REGISTRY",
                    operation
                            + " failed. "
                            + (documents == null
                                    ? "DDS reported "
                                    : "DDS returned " + documents + " document(s) and ")
                            + count
                            + " registry error(s): "
                            + String.join(" ", reasons)
                            + " "
                            + (documents == null
                                    ? "Document retrieval stopped. "
                                    : "Search stopped because results may be incomplete. ")
                            + String.join(" ", advice));
    }

    private static boolean noActiveRegistries(Throwable cause) {
        if (cause instanceof org.apache.cxf.binding.soap.SoapFault fault)
            return "Ingen aktive registries".equals(fault.getReason());
        if (cause instanceof jakarta.xml.ws.soap.SOAPFaultException fault)
            return "Ingen aktive registries".equals(fault.getFault().getFaultString());
        return false;
    }

    static XdsFailure failure(String operation, Throwable cause) {
        for (Throwable e = cause; e != null; e = e.getCause()) {
            if (e instanceof XdsFailure failure) return failure;
            if (e instanceof com.trifork.ihexdsapi.dgws.DgwsSecurityException
                    || e
                            instanceof
                            org.springframework.web.client.HttpClientErrorException.Unauthorized
                    || e
                            instanceof
                            org.springframework.web.client.HttpClientErrorException.Forbidden)
                return new XdsFailure(
                        "XDS-ACCESS",
                        operation
                                + " failed. Access was denied. Check signing identity authorisation and endpoint access.");
            if (operation.contains("ITI-18") && noActiveRegistries(e))
                return new XdsFailure(
                        "XDS-NO-ACTIVE-REGISTRIES",
                        "DDS reports no active registries for this search. Start a new session and try Type code: Any, or check DDS registry availability for the selected document type.");
            if (e instanceof java.net.SocketTimeoutException
                    || e instanceof java.util.concurrent.TimeoutException)
                return new XdsFailure(
                        "XDS-TIMEOUT",
                        operation + " timed out. Retry the search or check endpoint access.");
            if (e instanceof java.net.ConnectException)
                return new XdsFailure(
                        "XDS-UNAVAILABLE",
                        operation + " could not reach STS/DDS. Check endpoint access.");
        }
        return new XdsFailure(
                "XDS-BACKEND",
                operation
                        + " failed. No recognised XDS error code was returned. Ask the integration maintainer to check service diagnostics, access and endpoint configuration.");
    }
}
