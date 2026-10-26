package com.trifork.ihexdsapi.gitb;

import java.io.StringReader;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.xml.sax.InputSource;
import org.xml.sax.helpers.DefaultHandler;

/** Extracts only fault text and response correlation fields, never arbitrary SOAP content. */
final class SoapFaultDiagnostics {
    private static final String SOAP_11 = "http://schemas.xmlsoap.org/soap/envelope/";
    private static final String SOAP_12 = "http://www.w3.org/2003/05/soap-envelope";
    private static final String DGWS = "http://www.medcom.dk/dgws/2006/04/dgws-1.0.xsd";
    private static final String WSA = "http://www.w3.org/2005/08/addressing";
    private static final String WSSE =
            "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd";
    private static final String WSU =
            "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd";
    private static final String FAULT_CODE = "faultcode";
    private static final String FAULT_STRING = "faultstring";
    private static final int MAX_RESPONSE = 65536;
    private static final int MAX_FIELD = 512;

    private SoapFaultDiagnostics() {}

    static String describe(Throwable cause, String response) {
        Map<String, String> fields = new LinkedHashMap<>();
        for (Throwable e = cause; e != null; e = e.getCause()) {
            if (e instanceof org.apache.cxf.binding.soap.SoapFault fault) {
                put(fields, FAULT_CODE, String.valueOf(fault.getFaultCode()));
                put(fields, FAULT_STRING, fault.getReason());
            } else if (e instanceof jakarta.xml.ws.soap.SOAPFaultException fault) {
                put(fields, FAULT_CODE, fault.getFault().getFaultCode());
                put(fields, FAULT_STRING, fault.getFault().getFaultString());
            }
        }
        fromResponse(fields, response);
        if (fields.isEmpty()) return "";
        return " SOAP diagnostics: "
                + String.join(
                        "; ",
                        fields.entrySet().stream()
                                .map(entry -> entry.getKey() + "=" + entry.getValue())
                                .toList())
                + ".";
    }

    private static void fromResponse(Map<String, String> fields, String response) {
        if (response == null || response.isBlank() || response.length() > MAX_RESPONSE) return;
        int start = response.indexOf("\nPayload: ");
        String xml = start < 0 ? response : response.substring(start + "\nPayload: ".length());
        int end = xml.lastIndexOf("\n--------------------------------------");
        if (end >= 0) xml = xml.substring(0, end);
        var root = parse(xml);
        if (root == null) return;
        String soap = root.getNamespaceURI();
        if (!"Envelope".equals(root.getLocalName())
                || !(SOAP_11.equals(soap) || SOAP_12.equals(soap))) return;
        var fault = child(child(root, soap, "Body"), soap, "Fault");
        if (fault == null) return;
        if (SOAP_11.equals(soap)) {
            put(fields, FAULT_CODE, text(child(fault, null, FAULT_CODE)));
            put(fields, FAULT_STRING, text(child(fault, null, FAULT_STRING)));
        } else {
            put(fields, FAULT_CODE, text(child(child(fault, soap, "Code"), soap, "Value")));
            put(fields, FAULT_STRING, text(child(child(fault, soap, "Reason"), soap, "Text")));
        }
        var header = child(root, soap, "Header");
        var security = child(header, WSSE, "Security");
        put(
                fields,
                "responseTimestamp",
                text(child(child(security, WSU, "Timestamp"), WSU, "Created")));
        var linking = child(child(header, DGWS, "Header"), DGWS, "Linking");
        for (String name : new String[] {"FlowID", "MessageID", "InResponseToMessageID"})
            put(fields, "DGWS " + name, text(child(linking, DGWS, name)));
        for (String name : new String[] {"MessageID", "RelatesTo"})
            put(fields, "WS-Addressing " + name, text(child(header, WSA, name)));
    }

    private static Element parse(String xml) {
        try {
            var factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);
            factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
            factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);
            factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");
            factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_SCHEMA, "");
            var builder = factory.newDocumentBuilder();
            builder.setErrorHandler(new DefaultHandler());
            return builder.parse(new InputSource(new StringReader(xml))).getDocumentElement();
        } catch (Exception _) {
            // Missing or malformed diagnostics must not replace the original failure.
            return null;
        }
    }

    private static Element child(Element parent, String namespace, String name) {
        if (parent == null) return null;
        for (Node node = parent.getFirstChild(); node != null; node = node.getNextSibling()) {
            if (node instanceof Element element
                    && name.equals(element.getLocalName())
                    && java.util.Objects.equals(namespace, element.getNamespaceURI()))
                return element;
        }
        return null;
    }

    private static String text(Element element) {
        if (element == null) return "";
        // Do not flatten nested markup/security material into a diagnostic field.
        for (Node node = element.getFirstChild(); node != null; node = node.getNextSibling())
            if (node instanceof Element) return "";
        return element.getTextContent();
    }

    private static void put(Map<String, String> fields, String key, String value) {
        if (value == null || value.isBlank()) return;
        String clean = value.replaceAll("[\\p{Cntrl}\\p{Zl}\\p{Zp}]", " ").strip();
        // Faults are plain text, not an avenue for embedding SOAP/XML payloads.
        if (clean.contains("<") || clean.contains(">")) clean = "[non-text content omitted]";
        fields.put(key, clean.length() > MAX_FIELD ? clean.substring(0, MAX_FIELD) + "…" : clean);
    }
}
