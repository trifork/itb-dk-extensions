package com.trifork.itb.plugin;

import java.util.HashSet;
import java.util.Set;
import org.w3c.dom.Element;
import org.w3c.dom.Node;

/**
 * Checks that a downloaded document really is the QFDD that was asked for. This establishes
 * identity and kind only; whether the QFDD itself conforms is the job of the QFDD-DK 1.2
 * validation.
 */
final class QfddIntegrity {

    private static final String QFDD_HEADER_TEMPLATE = "1.2.208.184.12.1";
    private static final String QFDD_DOCUMENT_TEMPLATE = "1.2.208.184.12.1.1.1";
    private static final String QFDD_DOCUMENT_CODE = "74468-0";
    private static final int MAX_SHOWN = 80;

    private QfddIntegrity() {}

    /**
     * @return why the document is not the QFDD with this id, or null when it is
     */
    static String problem(byte[] document, String expectedId) {
        Element root;
        try {
            root = SecureXml.parse(document).getDocumentElement();
        } catch (Exception _) {
            return "it is not well-formed XML without a DOCTYPE";
        }
        if (!SecureXml.HL7_NS.equals(root.getNamespaceURI())
                || !"ClinicalDocument".equals(root.getLocalName())) {
            return "its root element is not a CDA ClinicalDocument";
        }
        Set<String> templates = new HashSet<>();
        for (Node node = root.getFirstChild(); node != null; node = node.getNextSibling()) {
            if (node instanceof Element element
                    && SecureXml.HL7_NS.equals(element.getNamespaceURI())
                    && "templateId".equals(element.getLocalName())) {
                templates.add(element.getAttribute("root"));
            }
        }
        if (!templates.contains(QFDD_HEADER_TEMPLATE)
                || !templates.contains(QFDD_DOCUMENT_TEMPLATE)) {
            return "it does not declare the QFDD-DK templates "
                    + QFDD_HEADER_TEMPLATE
                    + " and "
                    + QFDD_DOCUMENT_TEMPLATE;
        }
        Element code = SecureXml.child(root, "code");
        if (code == null || !QFDD_DOCUMENT_CODE.equals(code.getAttribute("code"))) {
            return "its document code is not " + QFDD_DOCUMENT_CODE;
        }
        Element id = SecureXml.child(root, "id");
        String actual = id == null ? "" : id.getAttribute("extension");
        if (!expectedId.equalsIgnoreCase(actual)) {
            return "its document id is '" + shown(actual) + "', not '" + expectedId + "'";
        }
        return null;
    }

    private static String shown(String value) {
        return value.length() <= MAX_SHOWN ? value : value.substring(0, MAX_SHOWN) + "...";
    }
}
