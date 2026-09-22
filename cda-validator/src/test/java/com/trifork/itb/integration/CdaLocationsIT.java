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
                "Missing version points to document",
                "phmr.v2.1.0",
                doc,
                VERSION,
                List.of(ROOT_LOCATION));
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
        return cases;
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
