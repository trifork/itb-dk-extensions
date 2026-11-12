package com.trifork.itb.plugin;

import java.io.StringWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;

/**
 * Writes a complete QRD for any QFDD: every question the form's preconditions allow is answered
 * with a valid answer. Used on the real SPGDEF forms to check the QRD/QFDD comparison against data
 * we did not write ourselves. The answers are synthetic; the patient is the MedCom example patient.
 *
 * <p>Which questions are asked depends on earlier answers, so {@link #consistentResponse} starts
 * with every question answered and lets the comparison itself say which answers do not belong
 * (precondition findings) or are missing, until it settles.
 */
final class QrdGenerator {

    static final String V3 = "urn:hl7-org:v3";
    private static final String QFDD_TEMPLATES = "2.16.840.1.113883.10.20.32.4.";
    private static final String QRD_TEMPLATES = "2.16.840.1.113883.10.20.33.4.";
    private static final int MAX_ROUNDS = 12;
    private static final Pattern PATH = Pattern.compile("\\[at (/.+)]$");
    private static final Pattern MISSING_QUESTION = Pattern.compile("Question (\\S+) requires");

    /** A response and what the comparison still reports about it. */
    record Result(byte[] qrd, List<Finding> findings, int rounds) {}

    private final Document qfdd;
    private final String qfddId;
    private final Set<String> excluded = new HashSet<>();

    private QrdGenerator(byte[] qfddBytes) throws Exception {
        this.qfdd = SecureXml.parse(qfddBytes);
        Element id = SecureXml.child(qfdd.getDocumentElement(), "id");
        this.qfddId = id.getAttribute("extension");
    }

    /** The settled response to the form, and any findings that remain. */
    static Result consistentResponse(byte[] qfddBytes) throws Exception {
        QrdGenerator generator = new QrdGenerator(qfddBytes);
        QfddResolver resolver = (id, version) -> QfddLookup.found(qfddBytes, "test corpus");
        byte[] qrd = generator.generate();
        List<Finding> findings = QrdQfddPairRules.validate(qrd, resolver);
        int rounds = 1;
        while (rounds < MAX_ROUNDS && generator.adjust(qrd, findings)) {
            qrd = generator.generate();
            findings = QrdQfddPairRules.validate(qrd, resolver);
            rounds++;
        }
        return new Result(qrd, findings, rounds);
    }

    /**
     * Changes the set of answered questions according to the findings; false if nothing changed.
     */
    private boolean adjust(byte[] qrd, List<Finding> findings) throws Exception {
        Document response = SecureXml.parse(qrd);
        boolean changed = false;
        for (Finding finding : findings) {
            if ("PRO-PAIR-PRECONDITION".equals(finding.assertionId)) {
                Matcher path = PATH.matcher(finding.description);
                Element answer = path.find() ? element(response, path.group(1)) : null;
                changed |= answer != null && excluded.add(keyOfAnswer(answer));
            } else if ("PRO-PAIR-ANSWER-MISSING".equals(finding.assertionId)) {
                Matcher question = MISSING_QUESTION.matcher(finding.description);
                if (question.find()) {
                    changed |= includeQuestionsWithCode(question.group(1));
                }
            }
        }
        return changed;
    }

    private boolean includeQuestionsWithCode(String code) {
        boolean changed = false;
        for (Element question : questions(qfdd.getDocumentElement())) {
            Element c = SecureXml.child(question, "code");
            if (c != null && code.equals(c.getAttribute("code"))) {
                changed |= excluded.remove(key(question));
            }
        }
        return changed;
    }

    /** The element a readable path such as /ClinicalDocument[1]/component[1] points at. */
    static Element element(Document document, String readablePath) throws Exception {
        String xpath =
                readablePath.replaceAll("/([A-Za-z]+)\\[(\\d+)]", "/*[local-name()='$1'][$2]");
        return (Element)
                XPathFactory.newInstance()
                        .newXPath()
                        .evaluate(xpath, document, XPathConstants.NODE);
    }

    private static String keyOfAnswer(Element answer) {
        return key(answer);
    }

    private static String key(Element observation) {
        Element id = SecureXml.child(observation, "id");
        return id == null ? "" : id.getAttribute("root") + "|" + id.getAttribute("extension");
    }

    // ---- reading the form -------------------------------------------------------------

    private static boolean hasTemplate(Element element, String suffix) {
        for (Node n = element.getFirstChild(); n != null; n = n.getNextSibling()) {
            if (n instanceof Element e
                    && V3.equals(e.getNamespaceURI())
                    && "templateId".equals(e.getLocalName())
                    && (QFDD_TEMPLATES + suffix).equals(e.getAttribute("root"))) {
                return true;
            }
        }
        return false;
    }

    private static boolean isQuestion(Element observation) {
        for (String suffix : new String[] {"7", "8", "9", "10", "11"}) {
            if (hasTemplate(observation, suffix)) {
                return true;
            }
        }
        return false;
    }

    private static List<Element> children(Element parent, String name) {
        List<Element> result = new ArrayList<>();
        for (Node n = parent.getFirstChild(); n != null; n = n.getNextSibling()) {
            if (n instanceof Element e
                    && V3.equals(e.getNamespaceURI())
                    && name.equals(e.getLocalName())) {
                result.add(e);
            }
        }
        return result;
    }

    /** Every question observation below the element, in document order, nested ones included. */
    private static List<Element> questions(Element root) {
        List<Element> result = new ArrayList<>();
        var all = root.getElementsByTagNameNS(V3, "observation");
        for (int i = 0; i < all.getLength(); i++) {
            Element o = (Element) all.item(i);
            if ("DEF".equals(o.getAttribute("moodCode")) && isQuestion(o)) {
                result.add(o);
            }
        }
        return result;
    }

    // ---- writing the response ---------------------------------------------------------

    private byte[] generate() throws Exception {
        StringBuilder out = new StringBuilder(header());
        Element body =
                SecureXml.child(
                        SecureXml.child(qfdd.getDocumentElement(), "component"), "structuredBody");
        for (Element component : children(body, "component")) {
            for (Element section : children(component, "section")) {
                out.append("<component typeCode=\"COMP\" contextConductionInd=\"true\">")
                        .append(section(section))
                        .append("</component>\n");
            }
        }
        out.append("</structuredBody></component></ClinicalDocument>\n");
        return out.toString().getBytes(StandardCharsets.UTF_8);
    }

    private String section(Element section) throws Exception {
        boolean copyright = "2.16.840.1.113883.10.20.32.2.2".equals(templateRoot(section));
        List<Element> organizers = new ArrayList<>();
        for (Element entry : children(section, "entry")) {
            organizers.addAll(children(entry, "organizer"));
        }
        if (copyright || organizers.isEmpty()) {
            return serialize(section);
        }
        StringBuilder out = new StringBuilder("<section classCode=\"DOCSECT\" moodCode=\"EVN\">");
        out.append("<templateId root=\"2.16.840.1.113883.10.20.33.2.1\"/>")
                .append(
                        "<code code=\"74465-6\" codeSystem=\"2.16.840.1.113883.6.1\" codeSystemName=\"LOINC\"/>");
        for (String name : new String[] {"title", "text"}) {
            for (Element e : children(section, name)) {
                out.append(serialize(e));
            }
        }
        out.append("<languageCode code=\"da-DK\"/>");
        for (Element organizer : organizers) {
            String answers = organizer(organizer);
            if (!answers.isEmpty()) {
                out.append("<entry typeCode=\"DRIV\" contextConductionInd=\"true\">")
                        .append(answers)
                        .append("</entry>");
            }
        }
        return out.append("</section>").toString();
    }

    private static String templateRoot(Element element) {
        List<Element> templates = children(element, "templateId");
        return templates.isEmpty() ? "" : templates.get(0).getAttribute("root");
    }

    private String organizer(Element organizer) throws Exception {
        StringBuilder components = new StringBuilder();
        for (Element component : children(organizer, "component")) {
            for (Element observation : children(component, "observation")) {
                if ("DEF".equals(observation.getAttribute("moodCode"))
                        && isQuestion(observation)
                        && !excluded.contains(key(observation))) {
                    components.append(
                            "<component typeCode=\"COMP\" contextConductionInd=\"true\">");
                    for (Element sequence : children(component, "sequenceNumber")) {
                        components.append(serialize(sequence));
                    }
                    components.append(answer(observation)).append("</component>");
                }
            }
        }
        if (components.isEmpty()) {
            return "";
        }
        StringBuilder out = new StringBuilder("<organizer classCode=\"BATTERY\" moodCode=\"EVN\">");
        out.append("<templateId root=\"").append(QRD_TEMPLATES).append("1\"/>");
        for (String name : new String[] {"id", "code"}) {
            for (Element e : children(organizer, name)) {
                out.append(serialize(e));
            }
        }
        return out.append("<statusCode code=\"completed\"/>")
                .append(components)
                .append("</organizer>")
                .toString();
    }

    private String answer(Element question) throws Exception {
        boolean analog = hasTemplate(question, "10");
        boolean discrete = hasTemplate(question, "11");
        boolean choice = hasTemplate(question, "8");
        boolean text = hasTemplate(question, "9");
        StringBuilder out = new StringBuilder("<observation classCode=\"OBS\" moodCode=\"EVN\">");
        if (choice || discrete) {
            out.append("<templateId root=\"").append(QRD_TEMPLATES).append("5\"/>");
        }
        if (discrete) {
            out.append("<templateId root=\"").append(QRD_TEMPLATES).append("8\"/>");
        }
        if (text) {
            out.append("<templateId root=\"").append(QRD_TEMPLATES).append("6\"/>");
        }
        if (!choice && !discrete && !text) {
            out.append("<templateId root=\"").append(QRD_TEMPLATES).append("4\"/>");
        }
        if (analog) {
            out.append("<templateId root=\"").append(QRD_TEMPLATES).append("7\"/>");
        }
        for (String name : new String[] {"id", "code"}) {
            for (Element e : children(question, name)) {
                out.append(serialize(e));
            }
        }
        out.append("<statusCode code=\"completed\"/>");
        if (choice || discrete) {
            out.append(selectedOptions(question, discrete));
        } else if (text) {
            out.append(
                    "<value xsi:type=\"ST\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">Svar</value>");
        } else {
            out.append(numericValue(question, analog));
        }
        for (Element child : children(question, "entryRelationship")) {
            out.append(entryRelationship(child));
        }
        // CDA order: entryRelationship, reference, then referenceRange.
        out.append(reference());
        for (Element range : children(question, "referenceRange")) {
            out.append(serialize(range).replace(QFDD_TEMPLATES + "5", QRD_TEMPLATES + "3"));
        }
        return out.append("</observation>").toString();
    }

    private String entryRelationship(Element relationship) throws Exception {
        for (Element nested : children(relationship, "observation")) {
            if (hasTemplate(nested, "20")) {
                return "<entryRelationship typeCode=\"SUBJ\" contextConductionInd=\"true\">"
                        + serialize(nested)
                        + "</entryRelationship>";
            }
            if ("DEF".equals(nested.getAttribute("moodCode"))
                    && isQuestion(nested)
                    && !excluded.contains(key(nested))) {
                return "<entryRelationship typeCode=\"SUBJ\" contextConductionInd=\"true\">"
                        + answer(nested)
                        + "</entryRelationship>";
            }
        }
        return "";
    }

    private static String selectedOptions(Element question, boolean single) throws Exception {
        List<Element> options = children(question, "value");
        int minimum = 0;
        int maximum = Integer.MAX_VALUE;
        for (Element relationship : children(question, "entryRelationship")) {
            for (Element limits : children(relationship, "observation")) {
                if (hasTemplate(limits, "20") && !children(limits, "value").isEmpty()) {
                    Element value = children(limits, "value").get(0);
                    minimum = integer(value, "low", 0);
                    maximum = integer(value, "high", Integer.MAX_VALUE);
                }
            }
        }
        int count = single ? 1 : Math.max(minimum, 1);
        count = Math.min(Math.min(count, maximum), options.size());
        StringBuilder out = new StringBuilder();
        for (int i = 0; i < count; i++) {
            out.append(serialize(options.get(i)));
        }
        return out.toString();
    }

    private static int integer(Element value, String bound, int fallback) {
        List<Element> bounds = children(value, bound);
        return bounds.isEmpty() ? fallback : Integer.parseInt(bounds.get(0).getAttribute("value"));
    }

    private static String numericValue(Element question, boolean analog) {
        String xsi = " xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"";
        for (Element range : children(question, "referenceRange")) {
            var values = range.getElementsByTagNameNS(V3, "value");
            for (int i = 0; i < values.getLength(); i++) {
                Element value = (Element) values.item(i);
                String type =
                        value.getAttributeNS("http://www.w3.org/2001/XMLSchema-instance", "type");
                if (analog && type.endsWith("GLIST_PQ")) {
                    return "<value xsi:type=\"INT\" value=\"" + head(value) + "\"" + xsi + "/>";
                }
                List<Element> low = children(value, "low");
                if (!low.isEmpty() && type.endsWith("IVL_TS")) {
                    return "<value xsi:type=\"TS\" value=\""
                            + low.get(0).getAttribute("value")
                            + "\""
                            + xsi
                            + "/>";
                }
                if (!low.isEmpty() && type.endsWith("IVL_REAL")) {
                    return "<value xsi:type=\"REAL\" value=\""
                            + low.get(0).getAttribute("value")
                            + "\""
                            + xsi
                            + "/>";
                }
                if (!low.isEmpty() && type.endsWith("IVL_INT")) {
                    return "<value xsi:type=\"INT\" value=\""
                            + low.get(0).getAttribute("value")
                            + "\""
                            + xsi
                            + "/>";
                }
            }
        }
        return "<value xsi:type=\"INT\" value=\"1\"" + xsi + "/>";
    }

    private static String head(Element glist) {
        List<Element> head = children(glist, "head");
        return head.isEmpty() ? "0" : head.get(0).getAttribute("value");
    }

    private String reference() {
        return "<reference typeCode=\"REFR\"><templateId root=\"1.2.208.184.6.1\"/><externalDocument classCode=\"DOC\">"
                + "<id root=\"2.16.840.1.113883.4.873\" extension=\""
                + qfddId
                + "\"/>"
                + "<code code=\"74468-0\" codeSystem=\"2.16.840.1.113883.6.1\" displayName=\"Questionnaire Form Definition Document\"/>"
                + "</externalDocument></reference>";
    }

    private String header() {
        return """
                <?xml version="1.0" encoding="UTF-8"?>
                <ClinicalDocument xmlns="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" classCode="DOCCLIN" moodCode="EVN">
                <realmCode code="DK"/><typeId root="2.16.840.1.113883.1.3" extension="POCD_HD000040"/>
                <templateId root="1.2.208.184.13.1"/><templateId root="1.2.208.184.13.1.1.1"/>
                <id root="1.2.208.184" extension="7f1c9a52-3b1e-4c6d-9a41-2c8e5d0b6f13" assigningAuthorityName="MedCom"/>
                <code code="74465-6" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Questionnaire Response Document"/>
                <title>Synthetic response</title><effectiveTime value="20261112090500+0100"/>
                <confidentialityCode code="N" codeSystem="2.16.840.1.113883.5.25"/><languageCode code="da-DK"/><versionNumber value="1"/>
                <recordTarget typeCode="RCT" contextControlCode="OP"><patientRole classCode="PAT">
                <id root="1.2.208.176.1.2" extension="2512489996" assigningAuthorityName="CPR"/>
                <addr use="H"><streetAddressLine>Skovvejen 12</streetAddressLine><postalCode>5700</postalCode><city>Svendborg</city><country>Danmark</country></addr>
                <telecom use="H" value="tel:65123456"/>
                <patient classCode="PSN" determinerCode="INSTANCE"><name><given>Nancy</given><family>Berggren</family></name>
                <administrativeGenderCode code="F" codeSystem="2.16.840.1.113883.5.1" codeSystemName="HL7"/><birthTime value="19481225000000+0000"/></patient>
                </patientRole></recordTarget>
                <author typeCode="AUT" contextControlCode="OP"><time value="20261112092100+0100"/><assignedAuthor classCode="ASSIGNED">
                <id root="1.2.208.176.1.2" extension="2512489996" assigningAuthorityName="CPR"/>
                <code code="SELF" codeSystem="2.16.840.1.113883.5.111" codeSystemName="HL7 Role code" displayName="self"/>
                <addr use="H"><streetAddressLine>Skovvejen 12</streetAddressLine><postalCode>5700</postalCode><city>Svendborg</city><country>Danmark</country></addr>
                <telecom use="H" value="tel:65123456"/>
                <assignedPerson classCode="PSN" determinerCode="INSTANCE"><name><given>Nancy</given><family>Berggren</family></name></assignedPerson>
                <representedOrganization classCode="ORG" determinerCode="INSTANCE"><id root="1.2.208.176.1.1" extension="310541000016007" assigningAuthorityName="SOR"/><name>Odense Universitetshospital</name>
                <telecom use="WP" value="tel:65112233"/><addr use="WP"><streetAddressLine>Valdemarsgade 53</streetAddressLine><postalCode>5700</postalCode><city>Svendborg</city><country>Danmark</country></addr></representedOrganization>
                </assignedAuthor></author>
                <custodian typeCode="CST"><assignedCustodian classCode="ASSIGNED"><representedCustodianOrganization classCode="ORG" determinerCode="INSTANCE">
                <id root="1.2.208.176.1.1" extension="310541000016007" assigningAuthorityName="SOR"/><name>Odense Universitetshospital</name><telecom use="WP" value="tel:65112233"/>
                <addr use="WP"><streetAddressLine>Valdemarsgade 53</streetAddressLine><postalCode>5700</postalCode><city>Svendborg</city><country>Danmark</country></addr>
                </representedCustodianOrganization></assignedCustodian></custodian>
                <documentationOf><serviceEvent><templateId root="1.2.208.184.10.1.10"/><id root="1.2.208.184.100.10" extension="qrd-v1.3" assigningAuthorityName="MedCom"/></serviceEvent></documentationOf>
                <documentationOf typeCode="DOC"><serviceEvent classCode="MPROT" moodCode="EVN"><effectiveTime><low value="20261112090500+0100"/><high value="20261112092100+0100"/></effectiveTime></serviceEvent></documentationOf>
                <component typeCode="COMP" contextConductionInd="true"><structuredBody classCode="DOCBODY" moodCode="EVN">
                """;
    }

    private static String serialize(Node node) throws Exception {
        Transformer transformer = TransformerFactory.newInstance().newTransformer();
        transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
        StringWriter writer = new StringWriter();
        transformer.transform(new DOMSource(node), new StreamResult(writer));
        return writer.toString();
    }
}
