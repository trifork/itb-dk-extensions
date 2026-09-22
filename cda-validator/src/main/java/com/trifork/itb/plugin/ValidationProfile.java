package com.trifork.itb.plugin;

/** Explicit mapping of supported rule bundles to their Gazelle engine and resources. */
enum ValidationProfile {
    PHAD("phad", "1.0.1", Resources.CDA_SCHEMA),
    PMR("pmr", Resources.VERSION_2_0_0, Resources.CDA_SCHEMA),
    PRF("prf", "3.0.0", Resources.CDA_SCHEMA),
    PSCR("pscr", Resources.VERSION_2_0_0, Resources.CDA_SCHEMA),
    APD("apd", "2.0.1", Resources.CDA_SCHEMA),
    CPD("cpd", Resources.VERSION_2_0_0, Resources.CDA_SCHEMA),
    PDC_20("pdc", "2.0", Resources.CDA_SCHEMA),
    PDC_30("pdc", "3.0.0", Resources.CDA_SCHEMA),
    PHMR_13("phmr", "1.3", "gazelle/phmr/schemas/infrastructure/CDA_SDTC.xsd"),
    PHMR("phmr", "2.1.0", "gazelle/phmr/schemas/infrastructure/CDA_SDTC.xsd"),
    QRD("qrd", "1.3.2", "gazelle/ihe/xsd/CDA.xsd"),
    QFDD("qfdd", "1.2", "gazelle/qfdd/schemas/infrastructure/CDA_SDTC.xsd");

    private static final class Resources {
        private static final String CDA_SCHEMA = "gazelle/cpd/infrastructure/cda/CDA_SDTC.xsd";
        private static final String VERSION_2_0_0 = "2.0.0";

        private Resources() {}
    }

    final String label;
    final String fullType;
    final String schemaPath;
    final boolean usesPhmrEngine;

    ValidationProfile(String profile, String version, String schemaPath) {
        this.label = profile.toUpperCase(java.util.Locale.ROOT) + "-DK " + version;
        this.fullType = profile + ".v" + version;
        this.schemaPath = schemaPath;
        this.usesPhmrEngine = "phmr".equals(profile);
    }

    static ValidationProfile resolve(String type) {
        for (ValidationProfile profile : values()) {
            if (profile.fullType.equals(type)) {
                return profile;
            }
        }
        // Never guess a version or route unknown types to the generic CDA engine.
        throw new IllegalArgumentException("Unsupported CDA profile/ruleset: " + type);
    }
}
