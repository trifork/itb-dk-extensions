package com.trifork.ihexdsapi.service;

public class CodesExecption extends Exception {
    private static final long serialVersionUID = 1L;
    private final int errorCode;

    public CodesExecption(Exception cause, int errorCode, String message) {
        super(message, cause);
        this.errorCode = errorCode;
    }

    public CodesExecption(int errorCode, String message) {
        this(null, errorCode, message);
    }

    public CodesExecption(String message) {
        this(null, 0, message);
    }

    public int getErrorCode() {
        return errorCode;
    }
}
