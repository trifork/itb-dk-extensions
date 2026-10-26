package com.trifork.itb.integration;

import static com.trifork.itb.integration.ValidatorClient.*;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

class CdaLocationsIT {
    private static final String PHMR = "samples/phmr/phmr_example01.xml";
    private static final String VERSION = "CDA-DK-PROFILE-VERSION";
    private static final String BODY = "PHMR-DK-2.1.0-83";
    private static final String ROOT_LOCATION = "/ClinicalDocument[1]";

    public static Iterable<Object[]> cases() throws Exception {
        List<Object[]> cases = new ArrayList<>();
        for (String[] pair :
                new String[][] {
                    {"phmr_v1_3_weight.xml", "phmr.v2.1.0"}, {"phmr_example01.xml", "phmr.v1.3"}
                }) {
            Document doc = document("samples/phmr/" + pair[0]);
            add(
                    cases,
                    "Wrong release points to its id",
                    pair[1],
                    doc,
                    VERSION,
                    declarationLocations(doc));
        }
        Document doc = document(PHMR);
        remove(node(doc, "/c:ClinicalDocument/c:documentationOf/c:serviceEvent/c:id"));
        add(
                cases,
                "Missing version points to version serviceEvent",
                "phmr.v2.1.0",
                doc,
                VERSION,
                List.of(ROOT_LOCATION + "/documentationOf[2]/serviceEvent[1]"));
        doc = document(PHMR);
        Element declaration =
                node(doc, "/c:ClinicalDocument/c:documentationOf[c:serviceEvent/c:id]");
        declaration.getParentNode().insertBefore(declaration.cloneNode(true), declaration);
        add(
                cases,
                "Duplicate declarations point to both ids",
                "phmr.v2.1.0",
                doc,
                VERSION,
                declarationLocations(doc));
        for (int count : new int[] {0, 3}) {
            doc = document(PHMR);
            Element body = node(doc, "/c:ClinicalDocument/c:component/c:structuredBody");
            Element section = (Element) node(body, "c:component").cloneNode(true);
            while (body.hasChildNodes()) body.removeChild(body.getFirstChild());
            for (int i = 0; i < count; i++) body.appendChild(section.cloneNode(true));
            add(
                    cases,
                    count + " sections points to structuredBody",
                    "phmr.v2.1.0",
                    doc,
                    BODY,
                    List.of(ROOT_LOCATION + "/component[1]/structuredBody[1]"));
        }
        doc = document(PHMR);
        remove(node(doc, "/c:ClinicalDocument/c:component/c:structuredBody"));
        add(
                cases,
                "Missing body points to component",
                "phmr.v2.1.0",
                doc,
                BODY,
                List.of(ROOT_LOCATION + "/component[1]"));
        doc = document(PHMR);
        remove(node(doc, "/c:ClinicalDocument/c:component"));
        add(
                cases,
                "Missing component points to document",
                "phmr.v2.1.0",
                doc,
                BODY,
                List.of(ROOT_LOCATION));
        doc = document("cda-validator/src/test/resources/pro/qfdd-v1.2.xml");
        node(doc, "/c:ClinicalDocument/c:id").setAttribute("extension", "not-a-uuid");
        add(
                cases,
                "QFDD UUID error points to document id",
                "qfdd.v1.2",
                doc,
                "QFDD-DK-1.2-DK14",
                List.of(ROOT_LOCATION + "/id[1]"));
        doc = document("cda-validator/src/test/resources/pro/qrd-v1.3.2.xml");
        remove(
                node(
                        doc,
                        "/c:ClinicalDocument/c:author/c:assignedAuthor/c:representedOrganization"));
        add(
                cases,
                "QRD missing organisation points to assignedAuthor",
                "qrd.v1.3.2",
                doc,
                "QRD-DK-1.3.2-AUTHOR-ORGANISATION",
                List.of(ROOT_LOCATION + "/author[1]/assignedAuthor[1]"));
        doc = document("cda-validator/src/test/resources/pro/qrd-v1.3.2.xml");
        remove(node(doc, "//c:organizer/c:component/c:observation/c:value"));
        add(
                cases,
                "QRD numeric no-answer produces no cardinality finding",
                "qrd.v1.3.2",
                doc,
                "QRD-DK-1.3.2-C170",
                List.of());
        addPdcCases(cases);
        addOtherReleaseCases(cases);
        addProhibitedCases(cases);
        addPhmrPresenceCases(cases);
        return cases;
    }

    private static void addPdcCases(List<Object[]> cases) throws Exception {
        String templatePath = "/c:ClinicalDocument/c:templateId[@root='1.2.208.184.16.1']";
        String markerPath =
                "/c:ClinicalDocument/c:documentationOf/c:serviceEvent/c:id[starts-with(@extension, 'pdc-v')]";
        String eventLocation = ROOT_LOCATION + "/documentationOf[2]/serviceEvent[1]";
        for (String[] release :
                new String[][] {
                    {"pdc20_minimum.xml", "pdc.v2.0", "CDA-DK-PROFILE-TEMPLATE-VERSION", "3.0"},
                    {"pdc30_minimum.xml", "pdc.v3.0.0", "PDC-DK-3.0.0-524", "2.0"}
                }) {
            String file = "samples/pdc/" + release[0];
            String target = release[1];
            Document doc = document(file);
            add(
                    cases,
                    "Matching PDC declaration has no release finding",
                    target,
                    doc,
                    VERSION,
                    List.of());
            add(
                    cases,
                    "Matching PDC template has no release finding",
                    target,
                    doc,
                    release[2],
                    List.of());
            doc = document(file);
            node(doc, markerPath).setAttribute("extension", "pdc-v" + release[3]);
            node(doc, templatePath).setAttribute("extension", release[3]);
            add(
                    cases,
                    "Wrong PDC declaration points to id",
                    target,
                    doc,
                    VERSION,
                    declarationLocations(doc));
            int index =
                    nodes(doc, "/c:ClinicalDocument/c:templateId").indexOf(node(doc, templatePath))
                            + 1;
            add(
                    cases,
                    "Wrong PDC template release points to templateId",
                    target,
                    doc,
                    release[2],
                    List.of(ROOT_LOCATION + "/templateId[" + index + "]"));
            doc = document(file);
            Element marker = node(doc, markerPath);
            marker.getParentNode().appendChild(marker.cloneNode(true));
            add(
                    cases,
                    "Duplicate PDC declarations point to each id",
                    target,
                    doc,
                    VERSION,
                    List.of(eventLocation + "/id[1]", eventLocation + "/id[2]"));
            doc = document(file);
            remove(node(doc, markerPath));
            add(
                    cases,
                    "Missing PDC declaration points to version serviceEvent",
                    target,
                    doc,
                    VERSION,
                    List.of(eventLocation));
            doc = document(file);
            for (Element event : nodes(doc, "/c:ClinicalDocument/c:documentationOf/c:serviceEvent"))
                remove(event);
            add(
                    cases,
                    "Missing PDC serviceEvent points to documentationOf",
                    target,
                    doc,
                    VERSION,
                    List.of(ROOT_LOCATION + "/documentationOf[1]"));
            doc = document(file);
            for (Element parent : nodes(doc, "/c:ClinicalDocument/c:documentationOf"))
                remove(parent);
            add(
                    cases,
                    "Missing PDC documentationOf points to document",
                    target,
                    doc,
                    VERSION,
                    List.of(ROOT_LOCATION));
            doc = document(file);
            node(doc, templatePath).removeAttribute("extension");
            add(
                    cases,
                    "PDC template extension is optional only for 2.0",
                    target,
                    doc,
                    release[2],
                    target.equals("pdc.v2.0")
                            ? List.of()
                            : List.of(ROOT_LOCATION + "/templateId[" + index + "]"));
        }
    }

    private static String location(Element element) throws Exception {
        if (!(element.getParentNode() instanceof Element parent)) return ROOT_LOCATION;
        int index = nodes(parent, "c:" + element.getLocalName()).indexOf(element) + 1;
        return location(parent) + "/" + element.getLocalName() + "[" + index + "]";
    }

    private static Document fixture(String profile) throws Exception {
        String folder = profile.startsWith("qrd") ? "pro" : "cda";
        return document("cda-validator/src/test/resources/" + folder + "/" + profile + ".xml");
    }

    private static String target(String profile) {
        return profile.replace("-v", ".v");
    }

    private static void addOtherReleaseCases(List<Object[]> cases) throws Exception {
        for (String profile :
                List.of(
                        "apd-v2.0.1",
                        "cpd-v2.0.0",
                        "qrd-v1.3.2",
                        "pmr-v2.0.0",
                        "prf-v3.0.0",
                        "pscr-v2.0.0")) {
            String path =
                    "/c:ClinicalDocument/c:documentationOf/c:serviceEvent[c:templateId/@root='1.2.208.184.10.1.10']/c:id";
            Document doc = fixture(profile);
            add(
                    cases,
                    "Correct release has no identity finding",
                    target(profile),
                    doc,
                    VERSION,
                    List.of());
            doc = fixture(profile);
            Element marker = node(doc, path);
            marker.setAttribute("extension", "wrong-profile-v999");
            add(
                    cases,
                    "Wrong declaration points to version-event id",
                    target(profile),
                    doc,
                    VERSION,
                    List.of(location(marker)));
            doc = fixture(profile);
            marker = node(doc, path);
            Element duplicate = (Element) marker.cloneNode(true);
            marker.getParentNode().appendChild(duplicate);
            add(
                    cases,
                    "Duplicate declarations point to both ids",
                    target(profile),
                    doc,
                    VERSION,
                    List.of(location(marker), location(duplicate)));
            doc = fixture(profile);
            marker = node(doc, path);
            String parent = location((Element) marker.getParentNode());
            remove(marker);
            add(
                    cases,
                    "Missing declaration points to version event",
                    target(profile),
                    doc,
                    VERSION,
                    List.of(parent));
        }
    }

    private static void addProhibitedCases(List<Object[]> cases) throws Exception {
        String common =
                "dataEnterer,informant,informationRecipient,legalAuthenticator,authenticator";
        for (String[] group :
                new String[][] {
                    {"apd-v2.0.1", common + ",participant,inFulfillmentOf", "PROHIBIT-"},
                    {"pdc-v2.0", common + ",participant", "C"},
                    {"pdc-v3.0.0", common + ",participant", "C"},
                    {"pmr-v2.0.0", common + ",inFulfillmentOf", "NO-"},
                    {"prf-v3.0.0", common + ",inFulfillmentOf", "NO-"},
                    {"pscr-v2.0.0", common + ",inFulfillmentOf", "NO-"},
                    {"qrd-v1.3.2", "informant,legalAuthenticator,authenticator", "NO-"}
                }) {
            String[] elements = group[1].split(",");
            for (int i = 0; i < elements.length; i++) {
                String element = elements[i];
                String suffix =
                        group[0].startsWith("pdc")
                                ? List.of("121", "122", "130", "131", "132", "133").get(i)
                                : element;
                if (group[0].startsWith("qrd")) suffix = suffix.toUpperCase(java.util.Locale.ROOT);
                String rule =
                        group[0].toUpperCase(java.util.Locale.ROOT).replace("-V", "-DK-")
                                + "-"
                                + group[2]
                                + suffix;
                Document doc = fixture(group[0]);
                add(
                        cases,
                        "Absent prohibited " + element + " produces no finding",
                        target(group[0]),
                        doc,
                        rule,
                        List.of());
                doc = fixture(group[0]);
                Element prohibited = doc.createElementNS("urn:hl7-org:v3", element);
                doc.getDocumentElement().appendChild(prohibited);
                add(
                        cases,
                        "Prohibited " + element + " points to itself",
                        target(group[0]),
                        doc,
                        rule,
                        List.of(ROOT_LOCATION + "/" + element + "[1]"));
            }
        }
    }

    private static void addPhmrPresenceCases(List<Object[]> cases) throws Exception {
        for (String[] release :
                new String[][] {{"phmr_v1_3_weight.xml", "1.3"}, {"phmr_example01.xml", "2.1.0"}}) {
            String file = "samples/phmr/" + release[0];
            String target = "phmr.v" + release[1];
            String rule = "PHMR-DK-" + release[1];
            Document doc = document(file);
            for (Element time :
                    nodes(
                            doc,
                            "/c:ClinicalDocument/c:documentationOf/c:serviceEvent/c:effectiveTime"))
                remove(time);
            add(
                    cases,
                    "Missing monitoring time points to serviceEvent",
                    target,
                    doc,
                    rule + "-MONITORING-INTERVAL",
                    List.of(ROOT_LOCATION + "/documentationOf[1]/serviceEvent[1]"));
            doc = document(file);
            for (Element event : nodes(doc, "/c:ClinicalDocument/c:documentationOf/c:serviceEvent"))
                remove(event);
            add(
                    cases,
                    "Missing service event points to documentationOf",
                    target,
                    doc,
                    rule + "-SERVICE-EVENT",
                    List.of(ROOT_LOCATION + "/documentationOf[1]"));
            add(
                    cases,
                    "Missing time and event points to documentationOf",
                    target,
                    doc,
                    rule + "-MONITORING-INTERVAL",
                    List.of(ROOT_LOCATION + "/documentationOf[1]"));
            doc = document(file);
            for (Element parent : nodes(doc, "/c:ClinicalDocument/c:documentationOf"))
                remove(parent);
            add(
                    cases,
                    "Missing documentationOf uses document root",
                    target,
                    doc,
                    rule + "-SERVICE-EVENT",
                    List.of(ROOT_LOCATION));
            add(
                    cases,
                    "Missing all time ancestors uses document root",
                    target,
                    doc,
                    rule + "-MONITORING-INTERVAL",
                    List.of(ROOT_LOCATION));
        }
    }

    private static void remove(Element node) {
        node.getParentNode().removeChild(node);
    }

    private static List<String> declarationLocations(Document doc) throws Exception {
        List<String> locations = new ArrayList<>();
        List<Element> declarations = nodes(doc, "/c:ClinicalDocument/c:documentationOf");
        for (int i = 0; i < declarations.size(); i++) {
            if (!nodes(declarations.get(i), "c:serviceEvent/c:id").isEmpty())
                locations.add(
                        ROOT_LOCATION + "/documentationOf[" + (i + 1) + "]/serviceEvent[1]/id[1]");
        }
        return locations;
    }

    private static void add(
            List<Object[]> cases,
            String name,
            String target,
            Document doc,
            String rule,
            List<String> expected) {
        cases.add(new Object[] {name, target, doc, rule, expected});
    }

    @ParameterizedTest(name = "{0} [{1}]")
    @MethodSource("cases")
    void pointsToOffendingElement(
            String name, String target, Document document, String rule, List<String> expected)
            throws Exception {
        Document report = validate(bytes(document), target);
        List<String> actual = new ArrayList<>();
        for (Element finding : findings(report))
            if ("error".equals(finding.getLocalName()) && rule.equals(text(finding, "assertionID")))
                actual.add(text(finding, "location"));
        Collections.sort(actual);
        List<String> sortedExpected = new ArrayList<>(expected);
        Collections.sort(sortedExpected);
        assertEquals(sortedExpected, actual, rule);
    }
}
