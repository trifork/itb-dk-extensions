package com.trifork.ihexdsapi.dgws;

public class DgwsSecurityException extends AbstractServiceException {
    private static final long serialVersionUID = 1L;

    public DgwsSecurityException(Exception cause, int errorCode, String message) {
        super(cause, errorCode, message);
    }

    public DgwsSecurityException(int errorCode, String message) {
        super(errorCode, message);
    }
}
