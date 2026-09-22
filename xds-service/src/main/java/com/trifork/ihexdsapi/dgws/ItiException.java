package com.trifork.ihexdsapi.dgws;

import java.util.List;
import org.openapitools.model.RegistryError;

public class ItiException extends AbstractServiceException {
    private static final long serialVersionUID = 1L;

    public ItiException(Exception cause, int errorCode, String message) {
        super(cause, errorCode, message);
    }

    public ItiException(
            Exception cause, int errorCode, String message, List<RegistryError> otherErrors) {
        super(cause, errorCode, message, otherErrors);
    }

    public ItiException(int errorCode, String message, List<RegistryError> otherErrors) {
        super(errorCode, message, otherErrors);
    }
}
