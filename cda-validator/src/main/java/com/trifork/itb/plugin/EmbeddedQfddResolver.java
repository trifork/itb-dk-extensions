package com.trifork.itb.plugin;

import java.io.IOException;
import java.io.InputStream;
import java.util.Locale;
import java.util.regex.Pattern;
import org.w3c.dom.Element;

/**
 * Serves the QFDDs embedded in the plugin under {@code /qfdd-embedded/}, one file per document
 * named {@code <id>.xml}. The embedded files are byte-identical copies of {@code samples/qfdd}
 * (guarded by a test). Works offline and always gives the same answer.
 */
final class EmbeddedQfddResolver implements QfddResolver {

    static final String SOURCE = "embedded QFDD set";
    private static final String RESOURCE_DIRECTORY = "/qfdd-embedded/";
    private static final Pattern UUID_V4 =
            Pattern.compile(
                    "[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}",
                    Pattern.CASE_INSENSITIVE);

    @Override
    public QfddLookup resolve(String id, String version) {
        // Only well-formed identifiers become resource names, so no reference can address
        // anything but an embedded QFDD.
        if (id == null || !UUID_V4.matcher(id).matches()) {
            return QfddLookup.notFound("The reference is not a version 4 UUID");
        }
        String resource = RESOURCE_DIRECTORY + id.toLowerCase(Locale.ROOT) + ".xml";
        byte[] document;
        try (InputStream stream = EmbeddedQfddResolver.class.getResourceAsStream(resource)) {
            if (stream == null) {
                return QfddLookup.notFound("The embedded QFDD set has no document " + id);
            }
            document = stream.readAllBytes();
        } catch (IOException _) {
            return QfddLookup.unavailable("The embedded QFDD set could not read " + id);
        }
        if (version != null && !version.equals(versionOf(document))) {
            return QfddLookup.notFound(
                    "The embedded QFDD set has no version " + version + " of " + id);
        }
        return QfddLookup.found(document, SOURCE);
    }

    private static String versionOf(byte[] document) {
        try {
            Element versionNumber =
                    SecureXml.child(
                            SecureXml.parse(document).getDocumentElement(), "versionNumber");
            return versionNumber == null ? null : versionNumber.getAttribute("value");
        } catch (Exception _) {
            return null;
        }
    }
}
