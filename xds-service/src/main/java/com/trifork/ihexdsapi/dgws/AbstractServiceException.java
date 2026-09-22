package com.trifork.ihexdsapi.dgws;

import java.util.List;
import org.openapitools.model.RegistryError;

public abstract class AbstractServiceException extends Exception {
    private static final long serialVersionUID = 1L;
    private final int errorCode;
    private final List<RegistryError> otherErrors;

    protected AbstractServiceException(Exception cause, int errorCode, String message) {
        this(cause, errorCode, message, null);
    }

    protected AbstractServiceException(
            Exception cause, int errorCode, String message, List<RegistryError> otherErrors) {
        super(message, cause);
        this.errorCode = errorCode;
        this.otherErrors = otherErrors;
    }

    protected AbstractServiceException(int errorCode, String message) {
        this(null, errorCode, message, null);
    }

    protected AbstractServiceException(
            int errorCode, String message, List<RegistryError> otherErrors) {
        this(null, errorCode, message, otherErrors);
    }

    protected AbstractServiceException(String message) {
        this(null, 0, message, null);
    }

    public int getErrorCode() {
        return errorCode;
    }

    public List<RegistryError> getOtherErrors() {
        return otherErrors;
    }
}
