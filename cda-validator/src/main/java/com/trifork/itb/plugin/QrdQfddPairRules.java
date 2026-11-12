package com.trifork.itb.plugin;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Pattern;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Templates;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamSource;
import net.sf.saxon.TransformerFactoryImpl;
import net.sf.saxon.s9api.Processor;
import net.sf.saxon.s9api.XPathCompiler;
import net.sf.saxon.s9api.XdmItem;
import net.sf.saxon.s9api.XdmNode;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 * Checks a QRD against the QFDD it references (specs.md QRD-01). The QFDD comes from a {@link
 * QfddResolver}; the comparison itself is the paired Schematron {@code
 * qrd-qfdd-pair-conformance.sch} applied to the documented {@code pro:documents} envelope.
 *
 * <p>A reference that cannot be resolved is reported as a warning and never as a passed check.
 */
final class QrdQfddPairRules {

    static final String UNRESOLVED_RULE = "PRO-PAIR-QFDD-UNRESOLVED";
    static final String COMPARED_RULE = "PRO-PAIR-QFDD";
    static final String ENGINE_RULE = "PRO-PAIR-ENGINE";

    private static final String HL7_NS = "urn:hl7-org:v3";
    private static final String PRO_NS = "urn:dk:medcom:pro:validation";
    private static final String SVRL_NS = "http://purl.oclc.org/dsdl/svrl";
    private static final String COMPILER =
            "/external/schematron/20100710-xslt2/iso_svrl_for_xslt2.xsl";
    private static final String PAIR_SCHEMATRON = "/pro/qrd-qfdd-pair-conformance.sch";
    private static final String COULD_NOT_VALIDATE =
            "The QRD could not be validated against its QFDD: ";
    // Saxon reports locations as /*:name[namespace-uri()='...'][n]/..., which is valid XPath.
    private static final String ENVELOPE_STEP = "\\[namespace-uri\\(\\)='" + PRO_NS + "']\\[1]";
    private static final Pattern QFDD_PREFIX =
            Pattern.compile(
                    "^/\\*:documents" + ENVELOPE_STEP + "/\\*:qfdd" + ENVELOPE_STEP + "(?=/|$)");
    private static final Pattern QRD_PREFIX =
            Pattern.compile(
                    "^/\\*:documents" + ENVELOPE_STEP + "/\\*:qrd" + ENVELOPE_STEP + "(?=/|$)");

    private static Templates compiled;

    private QrdQfddPairRules() {}

    private record Reference(String id, String version) {}

    static List<Finding> validate(byte[] qrdBytes, QfddResolver resolver) {
        List<Finding> findings = new ArrayList<>();
        Document qrd;
        try {
            qrd = parse(qrdBytes);
        } catch (Exception e) {
            findings.add(unresolved("the QRD could not be parsed (" + e.getMessage() + ")"));
            return findings;
        }
        Set<Reference> references = references(qrd);
        if (references.isEmpty()) {
            findings.add(
                    unresolved(
                            "the QRD contains no reference to a QFDD (externalDocument id with root "
                                    + QfddResolver.QFDD_REFERENCE_ROOT
                                    + ")"));
        } else if (references.size() > 1) {
            findings.add(
                    unresolved(
                            "the QRD refers to "
                                    + references.size()
                                    + " different QFDDs, so the reference is ambiguous"));
        } else {
            Reference reference = references.iterator().next();
            QfddLookup lookup = resolver.resolve(reference.id(), reference.version());
            if (lookup.status == QfddLookup.Status.FOUND) {
                compare(qrd, qrdBytes, reference, lookup, findings);
            } else {
                findings.add(
                        unresolved(
                                "QFDD "
                                        + reference.id()
                                        + " is "
                                        + lookup.status
                                                .name()
                                                .toLowerCase(java.util.Locale.ROOT)
                                                .replace('_', ' ')
                                        + " ("
                                        + lookup.detail
                                        + ")"));
            }
        }
        return findings;
    }

    private static Finding unresolved(String reason) {
        return new Finding(
                Finding.Level.WARNING, COULD_NOT_VALIDATE + reason + ".", null, UNRESOLVED_RULE);
    }

    private static void compare(
            Document qrd,
            byte[] qrdBytes,
            Reference reference,
            QfddLookup lookup,
            List<Finding> findings) {
        try {
            Document qfdd = parse(lookup.document());
            findings.add(
                    new Finding(
                            Finding.Level.INFO,
                            "The QRD was compared with QFDD "
                                    + reference.id()
                                    + " ("
                                    + title(qfdd)
                                    + ") from the "
                                    + lookup.detail
                                    + ".",
                            null,
                            COMPARED_RULE));
            Document report = runSchematron(envelope(qrd, qfdd));
            collectFindings(report, qrdBytes, findings);
        } catch (Exception e) {
            // A comparison that could not run must never look like a pass.
            findings.add(
                    new Finding(
                            Finding.Level.ERROR,
                            "The QRD/QFDD comparison could not be executed: " + rootMessage(e),
                            null,
                            ENGINE_RULE));
        }
    }

    private static Set<Reference> references(Document qrd) {
        Set<Reference> result = new LinkedHashSet<>();
        NodeList documents = qrd.getElementsByTagNameNS(HL7_NS, "externalDocument");
        for (int i = 0; i < documents.getLength(); i++) {
            Element document = (Element) documents.item(i);
            Element id = child(document, "id");
            if (id != null
                    && QfddResolver.QFDD_REFERENCE_ROOT.equals(id.getAttribute("root"))
                    && !id.getAttribute("extension").isBlank()) {
                Element version = child(document, "versionNumber");
                result.add(
                        new Reference(
                                id.getAttribute("extension"),
                                version == null ? null : version.getAttribute("value")));
            }
        }
        return result;
    }

    private static Element child(Element parent, String localName) {
        for (Node node = parent.getFirstChild(); node != null; node = node.getNextSibling()) {
            if (node instanceof Element element
                    && HL7_NS.equals(element.getNamespaceURI())
                    && localName.equals(element.getLocalName())) {
                return element;
            }
        }
        return null;
    }

    private static String title(Document qfdd) {
        Element title = child(qfdd.getDocumentElement(), "title");
        return title == null ? "untitled" : title.getTextContent().strip();
    }

    private static Document parse(byte[] bytes) throws Exception {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);
        factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
        return factory.newDocumentBuilder().parse(new ByteArrayInputStream(bytes));
    }

    /** The envelope documented in docs/pro-conformance.md ("Paired input"). */
    private static Document envelope(Document qrd, Document qfdd) throws Exception {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        Document envelope = factory.newDocumentBuilder().newDocument();
        Element root = envelope.createElementNS(PRO_NS, "pro:documents");
        envelope.appendChild(root);
        for (Object[] part : new Object[][] {{"pro:qfdd", qfdd}, {"pro:qrd", qrd}}) {
            Element wrapper = envelope.createElementNS(PRO_NS, (String) part[0]);
            wrapper.appendChild(
                    envelope.importNode(((Document) part[1]).getDocumentElement(), true));
            root.appendChild(wrapper);
        }
        return envelope;
    }

    private static synchronized Templates schematron() throws Exception {
        if (compiled == null) {
            TransformerFactory factory = new TransformerFactoryImpl();
            Transformer compiler =
                    factory.newTransformer(new StreamSource(resource(COMPILER).toExternalForm()));
            DOMResult xslt = new DOMResult();
            compiler.transform(new StreamSource(resource(PAIR_SCHEMATRON).toExternalForm()), xslt);
            compiled = factory.newTemplates(new DOMSource(xslt.getNode()));
        }
        return compiled;
    }

    private static URL resource(String path) throws IOException {
        URL url = QrdQfddPairRules.class.getResource(path);
        if (url == null) {
            throw new IOException("Missing plugin resource " + path);
        }
        return url;
    }

    private static Document runSchematron(Document envelope) throws Exception {
        DOMResult result = new DOMResult();
        schematron().newTransformer().transform(new DOMSource(envelope), result);
        return (Document) result.getNode();
    }

    private static void collectFindings(Document svrl, byte[] qrdBytes, List<Finding> findings)
            throws Exception {
        NodeList failures = svrl.getElementsByTagNameNS(SVRL_NS, "failed-assert");
        LineLocator locator = failures.getLength() == 0 ? null : new LineLocator(qrdBytes);
        for (int i = 0; i < failures.getLength(); i++) {
            Element failure = (Element) failures.item(i);
            String path = failure.getAttribute("location");
            String text = firstText(failure);
            Finding.Level level =
                    "warning".equalsIgnoreCase(failure.getAttribute("flag"))
                            ? Finding.Level.WARNING
                            : Finding.Level.ERROR;
            String description = text;
            String line = null;
            var qrdPath = QRD_PREFIX.matcher(path);
            var qfddPath = QFDD_PREFIX.matcher(path);
            if (qrdPath.find()) {
                String relative = path.substring(qrdPath.end());
                description = text + " [at " + readable(relative) + "]";
                line = locator == null ? null : locator.lineOf(relative);
            } else if (qfddPath.find()) {
                // The finding concerns a QFDD question that has no counterpart in the QRD (for
                // example a missing answer). It is anchored at the QRD's response organizer.
                description =
                        text
                                + " [QFDD question at "
                                + readable(path.substring(qfddPath.end()))
                                + "]";
                line = locator == null ? null : locator.anchorLine();
            }
            findings.add(new Finding(level, description, line, failure.getAttribute("id")));
        }
    }

    private static String firstText(Element failure) {
        NodeList texts = failure.getElementsByTagNameNS(SVRL_NS, "text");
        return texts.getLength() == 0 ? "" : texts.item(0).getTextContent().strip();
    }

    private static String readable(String path) {
        return path.replace("[namespace-uri()='" + HL7_NS + "']", "").replace("/*:", "/");
    }

    private static String rootMessage(Throwable throwable) {
        Throwable root = throwable;
        while (root.getCause() != null && root.getCause() != root) {
            root = root.getCause();
        }
        return root.getMessage() == null ? root.getClass().getSimpleName() : root.getMessage();
    }

    /** Resolves a path inside the QRD to "line:column" of the original input, or null. */
    private static final class LineLocator {
        private final XdmNode document;
        private final XPathCompiler xpath;

        LineLocator(byte[] qrdBytes) throws Exception {
            Processor processor = new Processor(false);
            net.sf.saxon.s9api.DocumentBuilder builder = processor.newDocumentBuilder();
            builder.setLineNumbering(true);
            try (InputStream stream = new ByteArrayInputStream(qrdBytes)) {
                this.document = builder.build(new StreamSource(stream));
            }
            this.xpath = processor.newXPathCompiler();
        }

        /** The response organizer, or the document element when the QRD has none. */
        String anchorLine() {
            String line =
                    lineOf(
                            "(//*:organizer[*:templateId/@root='2.16.840.1.113883.10.20.33.4.1'])[1]");
            return line != null ? line : lineOf("/*");
        }

        String lineOf(String path) {
            try {
                XdmItem item = xpath.evaluateSingle(path, document);
                if (item instanceof XdmNode node && node.getLineNumber() > 0) {
                    return node.getLineNumber() + ":" + Math.max(node.getColumnNumber(), 0);
                }
            } catch (Exception _) {
                // The finding is still reported, only without a line.
            }
            return null;
        }
    }
}
