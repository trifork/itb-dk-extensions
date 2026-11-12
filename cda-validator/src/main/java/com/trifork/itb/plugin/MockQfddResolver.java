package com.trifork.itb.plugin;

import java.io.IOException;
import java.io.InputStream;
import java.util.Locale;
import java.util.regex.Pattern;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

/**
 * Stand-in for the QFDD registry. It serves the QFDDs bundled under {@code /qfdd-mock/}, one file
 * per document named {@code <id>.xml}. The bundled files are byte-identical copies of {@code
 * samples/qfdd} (guarded by a test); remove this class when a real registry exists.
 */
final class MockQfddResolver implements QfddResolver {

    private static final String HL7_NS = "urn:hl7-org:v3";
    private static final String RESOURCE_DIRECTORY = "/qfdd-mock/";
    private static final Pattern UUID_V4 =
            Pattern.compile(
                    "[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}",
                    Pattern.CASE_INSENSITIVE);

    @Override
    public QfddLookup resolve(String id, String version) {
        // Only well-formed identifiers become resource names, so no reference can address
        // anything but a bundled QFDD.
        if (id == null || !UUID_V4.matcher(id).matches()) {
            return QfddLookup.notFound("The reference is not a version 4 UUID");
        }
        String resource = RESOURCE_DIRECTORY + id.toLowerCase(Locale.ROOT) + ".xml";
        byte[] document;
        try (InputStream stream = MockQfddResolver.class.getResourceAsStream(resource)) {
            if (stream == null) {
                return QfddLookup.notFound("The mock QFDD registry has no document " + id);
            }
            document = stream.readAllBytes();
        } catch (IOException _) {
            return QfddLookup.unavailable("The mock QFDD registry could not read " + id);
        }
        if (version != null && !version.equals(versionOf(document))) {
            return QfddLookup.notFound(
                    "The mock QFDD registry has no version " + version + " of " + id);
        }
        return QfddLookup.found(document, "mock QFDD registry");
    }

    private static String versionOf(byte[] document) {
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);
            factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
            Document parsed =
                    factory.newDocumentBuilder().parse(new java.io.ByteArrayInputStream(document));
            org.w3c.dom.NodeList versions =
                    parsed.getDocumentElement().getElementsByTagNameNS(HL7_NS, "versionNumber");
            return versions.getLength() == 0
                    ? null
                    : ((Element) versions.item(0)).getAttribute("value");
        } catch (Exception _) {
            return null;
        }
    }
}
