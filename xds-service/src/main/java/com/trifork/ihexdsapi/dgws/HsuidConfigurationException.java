package com.trifork.ihexdsapi.dgws;

/** Missing operator configuration; never substitute the certificate CVR as a SOR identifier. */
public final class HsuidConfigurationException extends IllegalStateException {
    private static final long serialVersionUID = 1L;

    public HsuidConfigurationException() {
        super(
                "Configure xds.hsuid.organisation.identifier and its scheme (sor, skskode or ynumber) before DDS search or retrieval. The certificate CVR is not an HSUID organisation identifier.");
    }
}
