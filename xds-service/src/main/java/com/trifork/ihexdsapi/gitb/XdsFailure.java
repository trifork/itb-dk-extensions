package com.trifork.ihexdsapi.gitb;

final class XdsFailure extends RuntimeException {
    private static final long serialVersionUID = 1L;
    final String code;

    XdsFailure(String code, String message) {
        super(message);
        this.code = code;
    }
}
