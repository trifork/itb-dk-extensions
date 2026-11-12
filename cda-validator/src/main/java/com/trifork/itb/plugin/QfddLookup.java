package com.trifork.itb.plugin;

/** Outcome of looking up a referenced QFDD. Anything but {@link Status#FOUND} has no document. */
final class QfddLookup {

    enum Status {
        FOUND,
        NOT_FOUND,
        AMBIGUOUS,
        UNAVAILABLE
    }

    private static final byte[] NO_DOCUMENT = new byte[0];

    final Status status;
    final String detail;
    private final byte[] document;

    private QfddLookup(Status status, byte[] document, String detail) {
        this.status = status;
        this.document = document;
        this.detail = detail;
    }

    static QfddLookup found(byte[] document, String source) {
        return new QfddLookup(Status.FOUND, document.clone(), source);
    }

    static QfddLookup notFound(String detail) {
        return new QfddLookup(Status.NOT_FOUND, NO_DOCUMENT, detail);
    }

    static QfddLookup ambiguous(String detail) {
        return new QfddLookup(Status.AMBIGUOUS, NO_DOCUMENT, detail);
    }

    static QfddLookup unavailable(String detail) {
        return new QfddLookup(Status.UNAVAILABLE, NO_DOCUMENT, detail);
    }

    /** The original QFDD bytes; empty unless the status is {@link Status#FOUND}. */
    byte[] document() {
        return document.clone();
    }
}
