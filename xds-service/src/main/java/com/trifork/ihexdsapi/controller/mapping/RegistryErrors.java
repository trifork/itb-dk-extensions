package com.trifork.ihexdsapi.controller.mapping;

import java.util.ArrayList;
import java.util.List;
import org.openapitools.model.RegistryError;
import org.openehealth.ipf.commons.ihe.xds.core.responses.ErrorInfo;
import org.openehealth.ipf.commons.ihe.xds.core.responses.Severity;

/** The existing REST error representation shared by search and retrieval. */
public final class RegistryErrors {
    private RegistryErrors() {}

    public static List<RegistryError> toRest(List<ErrorInfo> errors, boolean includeCustomCode) {
        List<RegistryError> result = new ArrayList<>(errors.size());
        for (ErrorInfo error : errors) {
            RegistryError mapped = new RegistryError();
            mapped.setCodeContext(error.getCodeContext());
            mapped.setErrorCode(
                    error.getErrorCode().getOpcode() + " , " + error.getErrorCode().name());
            mapped.setSeverity(
                    error.getSeverity() == Severity.ERROR
                            ? RegistryError.SeverityEnum.ERROR
                            : RegistryError.SeverityEnum.WARNING);
            if (includeCustomCode) mapped.setCustomErrorCode(error.getCustomErrorCode());
            result.add(mapped);
        }
        return result;
    }
}
