package com.trifork.ihexdsapi.service;

import java.util.List;
import org.openehealth.ipf.commons.ihe.xds.core.responses.ErrorInfo;

/** Original bytes and typed findings; binary content is never exposed in toString(). */
public final class RetrievedBytes {
    private final byte[] content;
    private final List<ErrorInfo> findings;

    public RetrievedBytes(byte[] bytes, List<ErrorInfo> errors) {
        this.content = copy(bytes);
        this.findings = List.copyOf(errors);
    }

    private static byte[] copy(byte[] value) {
        return value == null ? null : value.clone();
    }

    public byte[] bytes() {
        return copy(content);
    }

    public List<ErrorInfo> errors() {
        return findings;
    }
}
