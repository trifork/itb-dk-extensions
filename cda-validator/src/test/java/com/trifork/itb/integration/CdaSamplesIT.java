package com.trifork.itb.integration;

import static com.trifork.itb.integration.ValidatorClient.*;
import static org.junit.jupiter.api.Assertions.*;

import com.fasterxml.jackson.databind.JsonNode;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

/** Every catalogue example exercises the deployed XSD → Schematron → Java chain. */
class CdaSamplesIT {
    public static Iterable<Object[]> examples() throws Exception {
        List<Object[]> examples = new ArrayList<>();
        for (JsonNode sample : samples())
            examples.add(
                    new Object[] {
                        sample.get("file").asText(), sample.get("validationType").asText(), sample
                    });
        return examples;
    }

    @ParameterizedTest(name = "{0} [{1}]")
    @MethodSource("examples")
    void matchesPublishedExpectation(String file, String target, JsonNode sample) throws Exception {
        Document report = validate(Files.readAllBytes(ROOT.resolve(file)), target);
        saveExample(sample, report); // Retain actual findings even when an assertion fails.
        assertEquals(
                sample.get("expected"),
                JSON.valueToTree(summary(report)),
                "Result and finding counts for " + file);
        boolean releaseRecorded = false;
        List<String> found = new ArrayList<>();
        for (Element finding : findings(report)) {
            String rule = text(finding, "assertionID");
            if ("info".equals(finding.getLocalName())) {
                releaseRecorded |=
                        "CDA-DK-RULESET".equals(rule)
                                && text(finding, "description").contains(target);
            } else if (List.of("error", "warning").contains(finding.getLocalName()))
                found.add(rule);
        }
        assertTrue(releaseRecorded, "Missing selected release in report");
        for (JsonNode required : sample.path("conformanceAssertions"))
            assertTrue(
                    found.contains(required.asText()), "Missing specification finding " + required);
    }
}
