package com.trifork.ihexdsapi.controller.exception;

import java.time.OffsetDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.openapitools.model.BasicError;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST)
public class BadRequestException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public enum ERROR_CODE {
        INVALID_CERT(1),
        INVALID_KEY(2),
        EXISTING_CREDENTIAL_ID(3),
        GENERIC(1000);

        private final int errorCode;

        ERROR_CODE(int errorCode) {
            this.errorCode = errorCode;
        }

        private static final Map<Integer, ERROR_CODE> intToMap = new HashMap<>();

        static {
            for (ERROR_CODE type : ERROR_CODE.values()) {
                intToMap.put(type.errorCode, type);
            }
        }

        public static ERROR_CODE fromInt(int i) {
            return intToMap.get(Integer.valueOf(i));
        }
    }

    private final BasicError error;

    private BadRequestException(BasicError error, Throwable cause) {
        super(error.getError(), cause);
        this.error = error;
    }

    public BasicError getError() {
        return error;
    }

    public static BadRequestException createException(ERROR_CODE code, String message) {
        return createException(code, message, null, null);
    }

    public static BadRequestException createException(
            ERROR_CODE code, String message, List<String> errors) {
        return createException(code, message, errors, null);
    }

    public static BadRequestException createException(
            ERROR_CODE code, String message, Throwable cause) {
        return createException(code, message, null, cause);
    }

    public static BadRequestException createException(
            ERROR_CODE code, String message, List<String> errors, Throwable cause) {
        var error = new BasicError();
        error.setError(message);
        error.setStatus(HttpStatus.BAD_REQUEST.value());
        error.setStatusText(HttpStatus.BAD_REQUEST.getReasonPhrase());
        error.setTimestamp(OffsetDateTime.now(java.time.ZoneId.systemDefault()));
        error.setErrorCode(code.errorCode);
        error.setOtherError(errors);
        return new BadRequestException(error, cause);
    }
}
