package com.trifork.itb.plugin;

import java.util.Locale;

/**
 * Chooses the QFDD resolver from configuration: the system property {@code cda.qfdd.resolver}, else
 * the environment variable {@code CDA_QFDD_RESOLVER}.
 *
 * <ul>
 *   <li>{@code embedded} (default): only the QFDDs embedded in the plugin; works offline.
 *   <li>{@code spgdef}: only the public catalogue at https://spgdef.dk/qfdd/.
 *   <li>{@code combined}: the embedded set first, then the catalogue.
 * </ul>
 *
 * An unknown value is an error; there is no silent fallback to another source.
 */
final class QfddResolvers {

    static final String PROPERTY = "cda.qfdd.resolver";
    static final String ENVIRONMENT = "CDA_QFDD_RESOLVER";

    private QfddResolvers() {}

    static QfddResolver configured() {
        String value = System.getProperty(PROPERTY);
        if (value == null) {
            value = System.getenv(ENVIRONMENT);
        }
        return named(value);
    }

    static QfddResolver named(String name) {
        String normalised = name == null || name.isBlank() ? "embedded" : name.strip();
        return switch (normalised.toLowerCase(Locale.ROOT)) {
            case "embedded" -> new EmbeddedQfddResolver();
            case "spgdef" -> SpgdefQfddResolver.standard();
            case "combined" ->
                    new CombinedQfddResolver(
                            new EmbeddedQfddResolver(), SpgdefQfddResolver.standard());
            default ->
                    throw new IllegalArgumentException(
                            "Unknown QFDD resolver '"
                                    + normalised
                                    + "'; expected embedded, spgdef or combined");
        };
    }
}
