package com.trifork.itb.plugin;

/**
 * Resolves the QFDD a QRD refers to. There is no official QFDD registry yet, so the plugin offers
 * an {@link EmbeddedQfddResolver}, a {@link SpgdefQfddResolver} for the public SPGDEF catalogue and
 * a {@link CombinedQfddResolver} of both (see {@link QfddResolvers}); a registry only has to honour
 * this contract.
 */
interface QfddResolver {

    /** Root OID that QRD-DK 1.3.2 section 5.9 fixes for QFDD references. */
    String QFDD_REFERENCE_ROOT = "2.16.840.1.113883.4.873";

    /**
     * Looks up one QFDD by its identity.
     *
     * @param id the {@code externalDocument/id/@extension} (a version 4 UUID) of the reference
     * @param version the referenced version, or null when the QRD does not state one
     * @return a result that never hides a failed lookup: unknown, ambiguous or unreachable
     *     documents must not be reported as {@link QfddLookup.Status#FOUND}
     */
    QfddLookup resolve(String id, String version);
}
