package com.trifork.itb.integration;

import static com.trifork.itb.integration.ValidatorClient.*;
import static org.junit.jupiter.api.Assertions.*;

import com.fasterxml.jackson.databind.JsonNode;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

class CdaVersionsIT {
    @FunctionalInterface
    interface Check {
        void run() throws Exception;
    }

    private static final String PHMR = "samples/phmr/phmr_example01.xml";

    public static Iterable<Object[]> checks() throws Exception {
        List<Object[]> cases = new ArrayList<>();
        TreeSet<String> profiles = new TreeSet<>();
        for (JsonNode sample : samples())
            profiles.add(sample.get("validationType").asText().split("\\.")[0]);
        for (String profile : profiles) {
            String target = profile + ".v999.0.0";
            add(
                    cases,
                    "Reject unsupported " + profile.toUpperCase() + " version",
                    target,
                    () -> {
                        HttpResponse<byte[]> response =
                                request(Files.readAllBytes(ROOT.resolve(PHMR)), target);
                        if (response.statusCode() >= 400) {
                            assertTrue(
                                    JSON.readTree(response.body())
                                            .path("message")
                                            .asText()
                                            .contains(
                                                    "validation type "
                                                            + target
                                                            + " is not valid for domain cda-dk"));
                        } else {
                            assertEquals(200, response.statusCode());
                            Document report = parse(response.body());
                            assertEquals("FAILURE", summary(report).get("result"));
                            boolean unsupported = false;
                            for (Element finding : findings(report)) {
                                if (List.of("error", "warning").contains(finding.getLocalName()))
                                    unsupported |=
                                            text(finding, "description")
                                                    .toLowerCase()
                                                    .contains("unsupported");
                            }
                            assertTrue(unsupported, "Unexpected rejection");
                        }
                    });
        }
        for (String target : List.of("phad.v1.0.1", "pmr.v2.0.0", "prf.v3.0.0", "pscr.v2.0.0")) {
            String file = null;
            for (JsonNode sample : samples())
                if (target.equals(sample.get("validationType").asText())) {
                    file = sample.get("file").asText();
                    break;
                }
            final String fixture = java.util.Objects.requireNonNull(file);
            add(
                    cases,
                    "Reject missing national template",
                    target,
                    () -> {
                        Document doc = document(fixture);
                        for (Element template : nodes(doc, "/c:ClinicalDocument/c:templateId"))
                            template.getParentNode().removeChild(template);
                        requireRule(bytes(doc), target, "CDA-DK-PROFILE-TEMPLATE");
                    });
            add(
                    cases,
                    "Reject conflicting profile declaration",
                    target,
                    () -> {
                        Document doc = document(fixture);
                        node(
                                        doc,
                                        "/c:ClinicalDocument/c:documentationOf/c:serviceEvent[c:templateId/@root='1.2.208.184.10.1.10']/c:id")
                                .setAttribute("extension", "wrong-profile-v999");
                        requireRule(
                                bytes(doc),
                                target,
                                target.startsWith("phad.")
                                        ? "PHAD-DK-1.0.1-H16"
                                        : "CDA-DK-PROFILE-VERSION");
                    });
        }
        for (String target : List.of("phmr.v1.3", "phmr.v2.1.0"))
            add(
                    cases,
                    "Reject invalid CPR",
                    target,
                    () -> {
                        Document doc = document(PHMR);
                        node(doc, "//c:patientRole/c:id").setAttribute("extension", "invalid-cpr");
                        requireRule(bytes(doc), target, "CONF-PHMR-DK-4");
                    });
        for (String[] pair :
                new String[][] {
                    {"phmr/phmr_v1_3_weight.xml", "phmr.v2.1.0"},
                    {"phmr/phmr_example01.xml", "phmr.v1.3"},
                    {"pdc/pdc20_minimum.xml", "pdc.v3.0.0"},
                    {"pdc/pdc30_minimum.xml", "pdc.v2.0"}
                })
            add(
                    cases,
                    "Reject wrong release: " + pair[0],
                    pair[1],
                    () ->
                            requireRule(
                                    Files.readAllBytes(ROOT.resolve("samples/" + pair[0])),
                                    pair[1],
                                    "CDA-DK-PROFILE-VERSION"));
        add(
                cases,
                "Reject missing methodCode",
                "phmr.v1.3",
                () -> {
                    Document doc = document("samples/phmr/phmr_v1_3_weight.xml");
                    Element method =
                            node(doc, "//c:organizer/c:component/c:observation/c:methodCode");
                    method.getParentNode().removeChild(method);
                    requireRule(bytes(doc), "phmr.v1.3", "PHMR-DK-1.3-METHOD-CARDINALITY");
                });
        add(
                cases,
                "Reject incorrect version marker",
                "phmr.v2.1.0",
                () -> {
                    Document doc = document(PHMR);
                    node(doc, "//c:serviceEvent/c:id[@extension='phmr-v2.1']")
                            .setAttribute("extension", "phmr-v1.2");
                    requireRule(bytes(doc), "phmr.v2.1.0", "CDA-DK-PROFILE-VERSION");
                });
        add(
                cases,
                "Reject old MCS code system",
                "phmr.v2.1.0",
                () -> {
                    Document doc = document(PHMR);
                    Element measurement = node(doc, "//c:observation/c:code");
                    measurement.setAttribute("code", "MCS88050");
                    measurement.setAttribute("codeSystem", "1.2.208.184.100.1");
                    requireRule(bytes(doc), "phmr.v2.1.0", "PHMR-DK-2.1.0-MCS-CODESYSTEM");
                });
        return cases;
    }

    private static void add(List<Object[]> cases, String name, String target, Check check) {
        cases.add(new Object[] {name, target, check});
    }

    @ParameterizedTest(name = "{0} [{1}]")
    @MethodSource("checks")
    void rejectsInvalidSelectionOrDocument(String name, String target, Check check) {
        assertDoesNotThrow(check::run);
    }
}
