package com.trifork.ihexdsapi.service;

import org.openapitools.model.HealthcareProfessionalContext;

/** An ITI-41 upload. The metadata is read from the CDA; the format code is the caller's choice. */
public record SubmitRequest(
        String registryId,
        String credentialId,
        HealthcareProfessionalContext context,
        byte[] document,
        String formatCode) {
    public SubmitRequest {
        document = copy(document);
    }

    @Override
    public byte[] document() {
        return copy(document);
    }

    @Override
    public boolean equals(Object other) {
        return other
                        instanceof
                        SubmitRequest(
                                String otherRegistry,
                                String otherCredential,
                                HealthcareProfessionalContext otherContext,
                                byte[] otherDocument,
                                String otherFormat)
                && java.util.Objects.equals(registryId, otherRegistry)
                && java.util.Objects.equals(credentialId, otherCredential)
                && java.util.Objects.equals(context, otherContext)
                && java.util.Arrays.equals(document, otherDocument)
                && java.util.Objects.equals(formatCode, otherFormat);
    }

    @Override
    public int hashCode() {
        return 31 * java.util.Objects.hash(registryId, credentialId, context, formatCode)
                + java.util.Arrays.hashCode(document);
    }

    /** The document is patient data, so it is never part of the text form. */
    @Override
    public String toString() {
        return "SubmitRequest[registryId=" + registryId + ", formatCode=" + formatCode + "]";
    }

    private static byte[] copy(byte[] value) {
        return value == null ? null : value.clone();
    }
}
