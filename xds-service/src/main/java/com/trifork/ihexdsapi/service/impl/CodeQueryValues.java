package com.trifork.ihexdsapi.service.impl;

import java.util.ArrayList;
import java.util.List;
import org.openapitools.model.CodeQuery;
import org.openehealth.ipf.commons.ihe.xds.core.metadata.Code;

/** Combines legacy single-code filters with their OR-list equivalents. */
final class CodeQueryValues {
    private static final int MAX_CODES = 50;

    private CodeQueryValues() {}

    static List<Code> combine(CodeQuery single, List<CodeQuery> multiple) {
        List<Code> result = new ArrayList<>();
        // Preserve the legacy convention that an empty single code means no filter.
        if (single != null && single.getCode() != null && !single.getCode().isEmpty()) {
            add(result, single);
        }
        if (multiple != null) {
            if (multiple.size() > MAX_CODES) {
                throw new IllegalArgumentException("At most 50 codes may be supplied per filter");
            }
            for (CodeQuery value : multiple) {
                if (value == null
                        || value.getCode() == null
                        || value.getCode().isBlank()
                        || value.getCodeScheme() == null
                        || value.getCodeScheme().isBlank()) {
                    throw new IllegalArgumentException(
                            "Each filter code needs a code and codeScheme");
                }
                add(result, value);
            }
        }
        return result;
    }

    private static void add(List<Code> result, CodeQuery value) {
        Code code = new Code();
        code.setCode(value.getCode());
        code.setSchemeName(value.getCodeScheme());
        if (!result.contains(code)) result.add(code);
    }
}
