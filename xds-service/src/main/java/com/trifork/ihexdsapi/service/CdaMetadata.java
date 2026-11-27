package com.trifork.ihexdsapi.service;

import java.io.ByteArrayInputStream;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Element;
import org.w3c.dom.Node;

/**
 * XDS metadata that a CDA header states itself. Parsing never echoes document content in its
 * messages, so a rejected document cannot leak patient data into a report.
 */
public record CdaMetadata(
        String uniqueId,
        String patientId,
        String title,
        String typeCode,
        String typeScheme,
        String typeDisplayName,
        String confidentialityCode,
        String confidentialityScheme,
        String languageCode,
        String creationTime,
        String authorFamilyName,
        String authorGivenName) {
    public static final String HL7 = "urn:hl7-org:v3";
    public static final String CPR_OID = "1.2.208.176.1.2";
    public static final int MAX_BYTES = 10 * 1024 * 1024;
    private static final String DEFAULT_CONFIDENTIALITY_SCHEME = "2.16.840.1.113883.5.25";
    private static final int MAX_ID_LENGTH = 128;
    private static final String CODE = "code";
    private static final String EXTENSION = "extension";
    private static final java.util.regex.Pattern CPR = java.util.regex.Pattern.compile("\\d{10}");
    private static final String CODE_SYSTEM = "codeSystem";

    /** Reads the header of a CDA; throws {@link IllegalArgumentException} with a safe message. */
    public static CdaMetadata parse(byte[] xml) {
        if (xml == null || xml.length == 0 || xml.length > MAX_BYTES)
            throw new IllegalArgumentException("The document is empty or larger than 10 MiB.");
        Element root = root(xml);
        Element id = child(root, "id");
        String idRoot = attr(id, "root");
        if (idRoot.isEmpty())
            throw new IllegalArgumentException("The CDA has no document id (ClinicalDocument/id).");
        String extension = attr(id, EXTENSION);
        String uniqueId = extension.isEmpty() ? idRoot : idRoot + "^" + extension;
        if (uniqueId.length() > MAX_ID_LENGTH)
            throw new IllegalArgumentException(
                    "The CDA document id is longer than 128 characters.");
        String patient = cpr(root);
        Element code = child(root, "code");
        if (attr(code, CODE).isEmpty() || attr(code, CODE_SYSTEM).isEmpty())
            throw new IllegalArgumentException(
                    "The CDA has no document type code with a code system (ClinicalDocument/code).");
        Element confidentiality = child(root, "confidentialityCode");
        boolean stated = !attr(confidentiality, CODE).isEmpty();
        Element person = child(child(child(root, "author"), "assignedAuthor"), "assignedPerson");
        Element name = child(person, "name");
        String language = attr(child(root, "languageCode"), CODE);
        return new CdaMetadata(
                uniqueId,
                patient,
                text(child(root, "title")),
                attr(code, CODE),
                attr(code, CODE_SYSTEM),
                attr(code, "displayName"),
                stated ? attr(confidentiality, CODE) : "N",
                stated && !attr(confidentiality, CODE_SYSTEM).isEmpty()
                        ? attr(confidentiality, CODE_SYSTEM)
                        : DEFAULT_CONFIDENTIALITY_SCHEME,
                language.isEmpty() ? "da-DK" : language,
                attr(child(root, "effectiveTime"), "value"),
                text(child(name, "family")),
                text(child(name, "given")));
    }

    private static Element root(byte[] xml) {
        try {
            var factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);
            factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
            factory.setFeature("http://xml.org/sax/features/external-general-entities", false);
            factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);
            factory.setXIncludeAware(false);
            factory.setExpandEntityReferences(false);
            var builder = factory.newDocumentBuilder();
            builder.setErrorHandler(new org.xml.sax.helpers.DefaultHandler());
            Element root = builder.parse(new ByteArrayInputStream(xml)).getDocumentElement();
            if (!"ClinicalDocument".equals(root.getLocalName())
                    || !HL7.equals(root.getNamespaceURI()))
                throw new IllegalArgumentException("Not a CDA document");
            return root;
        } catch (Exception _) {
            throw new IllegalArgumentException(
                    "The document is not well-formed CDA XML (ClinicalDocument in urn:hl7-org:v3).");
        }
    }

    private static String cpr(Element root) {
        for (Node n = firstChild(child(child(root, "recordTarget"), "patientRole"));
                n != null;
                n = n.getNextSibling()) {
            if (n instanceof Element e
                    && "id".equals(e.getLocalName())
                    && CPR_OID.equals(e.getAttribute("root"))
                    && CPR.matcher(e.getAttribute(EXTENSION)).matches())
                return e.getAttribute(EXTENSION);
        }
        throw new IllegalArgumentException(
                "The CDA has no ten-digit CPR (recordTarget/patientRole/id with root "
                        + CPR_OID
                        + ").");
    }

    private static Node firstChild(Element parent) {
        return parent == null ? null : parent.getFirstChild();
    }

    private static Element child(Element parent, String localName) {
        if (parent == null) return null;
        for (Node n = parent.getFirstChild(); n != null; n = n.getNextSibling())
            if (n instanceof Element e && localName.equals(e.getLocalName())) return e;
        return null;
    }

    private static String attr(Element element, String name) {
        return element == null ? "" : element.getAttribute(name).trim();
    }

    private static String text(Element element) {
        return element == null ? "" : element.getTextContent().trim();
    }
}
