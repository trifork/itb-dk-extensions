package com.trifork.ihexdsapi.dgws;

import java.security.Security;
import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;

/** Optional JVM-wide algorithm compatibility for TEST1's legacy DGWS signatures. */
public final class DgwsSignaturePolicy {
    private static final String POLICY = "jdk.xml.dsig.secureValidationPolicy";
    private static final Set<String> LEGACY_DGWS_ALGORITHMS =
            Set.of(
                    "disallowAlg http://www.w3.org/2000/09/xmldsig#rsa-sha1",
                    "disallowAlg http://www.w3.org/2000/09/xmldsig#sha1");

    private DgwsSignaturePolicy() {}

    /** Invoke once at startup, before the XML signature provider initializes its policy. */
    public static void configure(boolean allowTest1LegacySha1) {
        if (allowTest1LegacySha1) {
            Security.setProperty(POLICY, allowLegacyDgwsAlgorithms(Security.getProperty(POLICY)));
        }
    }

    static String allowLegacyDgwsAlgorithms(String policy) {
        if (policy == null || policy.isBlank()) {
            throw new IllegalStateException("JDK XML signature security policy is missing");
        }
        return Arrays.stream(policy.split(","))
                .map(String::trim)
                .filter(rule -> !LEGACY_DGWS_ALGORITHMS.contains(rule))
                .collect(Collectors.joining(","));
    }
}
