package com.trifork.itb.preview;

import java.io.ByteArrayInputStream;
import java.io.StringWriter;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Source;
import javax.xml.transform.Templates;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import net.sf.saxon.jaxp.TransformerImpl;
import org.jsoup.Jsoup;
import org.jsoup.safety.Cleaner;
import org.jsoup.safety.Safelist;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

/** Display only: never replaces the original XML used for validation. */
public final class CdaRenderer {
    public static final String POLICY =
            "default-src 'none'; style-src 'unsafe-inline'; img-src data:; base-uri 'none'; form-action 'none'";
    private final Templates stylesheet;
    static final String STYLESHEET_URI = "classpath:/rendering/CDA.xsl";
    private final byte[] stylesheetBytes;

    public CdaRenderer() throws Exception {
        TransformerFactory factory =
                TransformerFactory.newInstance(
                        "net.sf.saxon.TransformerFactoryImpl", CdaRenderer.class.getClassLoader());
        factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);
        factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");
        factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_STYLESHEET, "");
        try (var input = CdaRenderer.class.getResourceAsStream("/rendering/CDA.xsl")) {
            if (input == null) throw new IllegalStateException("CDA display stylesheet is missing");
            stylesheetBytes = input.readAllBytes();
        }
        factory.setURIResolver(this::resolveStylesheet);
        stylesheet = factory.newTemplates(resolveStylesheet("", STYLESHEET_URI));
    }

    // document('') in the upstream stylesheet reads its own table attribute allowlist.
    // Resolve just that resource from memory, never fall back to filesystem/network access.
    Source resolveStylesheet(String href, String base) throws TransformerException {
        if (!(href.isEmpty() && STYLESHEET_URI.equals(base)) && !STYLESHEET_URI.equals(href)) {
            throw new TransformerException("External preview stylesheet resources are disabled");
        }
        try {
            return new DOMSource(parse(stylesheetBytes), STYLESHEET_URI);
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
        var output = new StringWriter();
        transformer.transform(new DOMSource(document), new StreamResult(output));
        var rendered = Jsoup.parse(output.toString());
        // Retain narrative tables and typography, but strip active content and navigation.
        var allowed =
                Safelist.relaxed()
                        .removeAttributes("a", "href")
                        .addAttributes(":all", "class", "style", "id", "align", "valign")
                        .addTags("h1", "h2", "h3", "h4", "h5", "h6", "hr", "div", "span");
        var clean = new Cleaner(allowed).clean(rendered);
        clean.head().appendElement("meta").attr("charset", "utf-8");
        clean.head()
                .appendElement("meta")
                .attr("http-equiv", "Content-Security-Policy")
                .attr("content", POLICY);
        clean.title("CDA document preview");
        for (var style : rendered.head().select("style")) clean.head().appendChild(style.clone());
        return "<!doctype html>\n" + clean.outerHtml();
    }
}
