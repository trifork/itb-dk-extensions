package com.trifork.itb.preview;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Source;
import javax.xml.transform.Templates;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import net.sf.saxon.jaxp.TransformerImpl;
import org.jsoup.Jsoup;
import org.jsoup.safety.Cleaner;
import org.jsoup.safety.Safelist;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

/** Display only: never replaces the original XML used for validation. */
public final class CdaRenderer {
    /** Styles the structured questionnaire view; the page's CSP allows inline styles only. */
    private static final String QUESTIONNAIRE_CSS =
            ".qv-table{border-collapse:collapse;width:100%;margin:8px 0}"
                    + ".qv-table th,.qv-table td{border:1px solid #ccc;padding:4px 8px;"
                    + "vertical-align:top;text-align:left}"
                    + ".qv-table th{background:#f3f3f3}"
                    + ".qv-depth-1 td:first-child{padding-left:28px}"
                    + ".qv-depth-2 td:first-child{padding-left:48px}"
                    + ".qv-depth-3 td:first-child{padding-left:68px}"
                    + ".qv-note{color:#555;font-size:.9em}"
                    + ".qv-none{color:#888;font-style:italic}";

    public static final String POLICY =
            "default-src 'none'; style-src 'unsafe-inline'; img-src data:; base-uri 'none'; form-action 'none'";
    private final Templates stylesheet;
    private final Templates questionnaire;
    static final String STYLESHEET_URI = "classpath:/rendering/HL7_CDA_stylesheet.xsl";
    // The stylesheet reads its language dependent labels from this companion file, named by
    // its vocFile parameter and resolved relative to the stylesheet.
    private static final String STYLE_TAG = "style";
    static final String LABELS_NAME = "cda_l10n.xml";
    static final String LABELS_URI = "classpath:/rendering/" + LABELS_NAME;
    private final byte[] stylesheetBytes;
    private final byte[] labelBytes;

    public CdaRenderer() throws Exception {
        TransformerFactory factory =
                TransformerFactory.newInstance(
                        "net.sf.saxon.TransformerFactoryImpl", CdaRenderer.class.getClassLoader());
        factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);
        factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");
        factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_STYLESHEET, "");
        stylesheetBytes = withDanishDates(bundled("/rendering/HL7_CDA_stylesheet.xsl"));
        labelBytes =
                mergeLabels(
                        bundled("/rendering/" + LABELS_NAME),
                        bundled("/rendering/cda_l10n_da.xml"));
        factory.setURIResolver(this::resolveStylesheet);
        stylesheet = factory.newTemplates(resolveStylesheet("", STYLESHEET_URI));
        questionnaire =
                factory.newTemplates(
                        new StreamSource(
                                new ByteArrayInputStream(bundled("/rendering/questionnaire.xsl"))));
    }

    private static final Pattern DATE_ORDER =
            Pattern.compile(
                    "(<xsl:when test=\"\\$textLangPartLowerCase = 'nl'\">)(\\s*<xsl:value-of select=\"\\$dayNum\"/>)");

    /** Danish writes "13. maj 2025"; the stylesheet only knows that order for Dutch. */
    private static final String DANISH_DATE =
            "<xsl:when test=\"$textLangPartLowerCase = 'da'\">"
                    + "<xsl:if test=\"string-length($dayNum) > 0\">"
                    + "<xsl:value-of select=\"$dayNum\"/><xsl:text>. </xsl:text></xsl:if>"
                    + "<xsl:if test=\"string-length(normalize-space($monthText)) > 0\">"
                    + "<xsl:call-template name=\"caseDown\"><xsl:with-param name=\"data\" "
                    + "select=\"normalize-space($monthText)\"/></xsl:call-template>"
                    + "<xsl:text> </xsl:text></xsl:if>"
                    + "<xsl:value-of select=\"$yearNum\"/></xsl:when>";

    /**
     * The one change to the upstream stylesheet: a Danish branch for the order of day, month and
     * year, placed before the Dutch one. The files on disk stay unchanged and pinned; the change is
     * made here, in memory, and fails loudly if the stylesheet is replaced by one it no longer
     * fits.
     */
    static byte[] withDanishDates(byte[] stylesheet) {
        String xsl = new String(stylesheet, StandardCharsets.UTF_8);
        Matcher match = DATE_ORDER.matcher(xsl);
        if (!match.find()) {
            throw new IllegalStateException("The display stylesheet has no date order to extend");
        }
        int start = match.start();
        if (match.find()) {
            throw new IllegalStateException("The display stylesheet has several date orders");
        }
        return (xsl.substring(0, start) + DANISH_DATE + xsl.substring(start))
                .getBytes(StandardCharsets.UTF_8);
    }

    /**
     * Adds the Danish labels to the upstream label file, which has none. A key that upstream
     * already has gains a da-dk value; any other key is added. Upstream values are never changed.
     */
    static byte[] mergeLabels(byte[] upstream, byte[] danish) throws Exception {
        Document labels = parse(upstream);
        Map<String, Element> known = new HashMap<>();
        NodeList existing = labels.getElementsByTagName("translation");
        for (int i = 0; i < existing.getLength(); i++) {
            Element translation = (Element) existing.item(i);
            known.put(translation.getAttribute("key"), translation);
        }
        NodeList additions = parse(danish).getElementsByTagName("translation");
        for (int i = 0; i < additions.getLength(); i++) {
            Element addition = (Element) additions.item(i);
            Element target = known.get(addition.getAttribute("key"));
            if (target == null) {
                labels.getDocumentElement().appendChild(labels.importNode(addition, true));
                continue;
            }
            NodeList values = addition.getElementsByTagName("value");
            for (int v = 0; v < values.getLength(); v++) {
                target.appendChild(labels.importNode(values.item(v), true));
            }
        }
        var out = new ByteArrayOutputStream();
        var transformer = TransformerFactory.newInstance().newTransformer();
        transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
        transformer.transform(new DOMSource(labels), new StreamResult(out));
        return out.toByteArray();
    }

    private static byte[] bundled(String path) throws java.io.IOException {
        try (var input = CdaRenderer.class.getResourceAsStream(path)) {
            if (input == null) {
                throw new IllegalStateException("CDA display resource is missing: " + path);
            }
            return input.readAllBytes();
        }
    }

    // The stylesheet is the HL7 SDWG CDA R2 stylesheet that MedCom publishes (see
    // cda-validator/README.md). It reads exactly one other resource, its label file.
    // Resolve just the stylesheet and that file from memory, never fall back to
    // filesystem/network access.
    Source resolveStylesheet(String href, String base) throws TransformerException {
        boolean stylesheetItself = href.isEmpty() && STYLESHEET_URI.equals(base);
        boolean labels =
                (LABELS_NAME.equals(href) && STYLESHEET_URI.equals(base))
                        || LABELS_URI.equals(href);
        if (!stylesheetItself && !labels && !STYLESHEET_URI.equals(href)) {
            throw new TransformerException("External preview stylesheet resources are disabled");
        }
        try {
            return labels
                    ? new DOMSource(parse(labelBytes), LABELS_URI)
                    : new DOMSource(parse(stylesheetBytes), STYLESHEET_URI);
        } catch (Exception e) {
            throw new TransformerException("Cannot read bundled CDA display stylesheet", e);
        }
    }

    private static Document parse(byte[] xml) throws Exception {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newDefaultInstance();
        factory.setNamespaceAware(true);
        factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);
        factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
        factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");
        factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_SCHEMA, "");
        factory.setXIncludeAware(false);
        factory.setExpandEntityReferences(false);
        var builder = factory.newDocumentBuilder();
        // Do not print user XML or parser diagnostics to server logs.
        builder.setErrorHandler(new DefaultHandler());
        return builder.parse(new ByteArrayInputStream(xml));
    }

    /**
     * A QRD or QFDD keeps its content in entries that the general stylesheet does not show. This
     * adds a list of them after the narrative; other documents get nothing.
     */
    private void appendQuestionnaireView(Document document, org.jsoup.nodes.Document page)
            throws TransformerException {
        var transformer = questionnaire.newTransformer();
        transformer.setURIResolver(this::resolveStylesheet);
        var fragment = new StringWriter();
        transformer.transform(new DOMSource(document), new StreamResult(fragment));
        if (!fragment.toString().isBlank()) {
            page.head().appendElement(STYLE_TAG).text(QUESTIONNAIRE_CSS);
            page.body().append(fragment.toString());
        }
    }

    public String render(byte[] xml) throws Exception {
        var document = parse(xml);
        var root = document.getDocumentElement();
        if (!"ClinicalDocument".equals(root.getLocalName())
                || !"urn:hl7-org:v3".equals(root.getNamespaceURI())) {
            throw new SAXException("Expected a CDA ClinicalDocument");
        }
        var transformer = stylesheet.newTransformer();
        transformer.setURIResolver(this::resolveStylesheet);
        var saxon = ((TransformerImpl) transformer).getUnderlyingXsltTransformer();
        // Stylesheet diagnostics can contain document URIs; keep them out of server logs.
        saxon.setMessageHandler(
                _ -> {
                    /* Terminating messages still fail the transform. */
                });
        saxon.setErrorReporter(
                _ -> {
                    /* The caller reports a safe transformation error. */
                });
        transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
        transformer.setParameter("limit-external-images", "yes");
        // The preview is sanitised and sandboxed; do not ask the stylesheet for scripts.
        transformer.setParameter("useJavascript", "false");
        var output = new StringWriter();
        transformer.transform(new DOMSource(document), new StreamResult(output));
        var rendered = Jsoup.parse(output.toString());
        appendQuestionnaireView(document, rendered);
        // Retain narrative tables and typography, but strip active content and navigation.
        var allowed =
                Safelist.relaxed()
                        .removeAttributes("a", "href")
                        .addAttributes(":all", "class", STYLE_TAG, "id", "align", "valign")
                        .addTags("h1", "h2", "h3", "h4", "h5", "h6", "hr", "div", "span");
        var clean = new Cleaner(allowed).clean(rendered);
        clean.head().appendElement("meta").attr("charset", "utf-8");
        clean.head()
                .appendElement("meta")
                .attr("http-equiv", "Content-Security-Policy")
                .attr("content", POLICY);
        clean.title("CDA document preview");
        for (var style : rendered.head().select(STYLE_TAG)) clean.head().appendChild(style.clone());
        return "<!doctype html>\n" + clean.outerHtml();
    }
}
