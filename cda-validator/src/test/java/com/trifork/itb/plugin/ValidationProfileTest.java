package com.trifork.itb.plugin;

import static org.junit.jupiter.api.Assertions.*;

import com.gitb.core.AnyContent;
import com.gitb.tr.BAR;
import com.gitb.tr.TestResultType;
import com.gitb.vs.ValidateRequest;
import org.junit.jupiter.api.Test;

class ValidationProfileTest {
    @Test
    void publishedTargetsAreDistinct() {
        assertEquals("PHMR-DK 2.1.0", ValidationProfile.resolve("phmr.v2.1.0").label);
        assertNotSame(
                ValidationProfile.resolve("pdc.v2.0"), ValidationProfile.resolve("pdc.v3.0.0"));
        assertEquals("PHMR-DK 1.3", ValidationProfile.resolve("phmr.v1.3").label);
        assertNotSame(
                ValidationProfile.resolve("phmr.v1.3"), ValidationProfile.resolve("phmr.v2.1.0"));
        assertEquals(12, ValidationProfile.values().length);
    }

    @Test
    void schemaSelectionPreservesProfileSpecificResources() {
        for (String type : new String[] {"phmr.v1.3", "phmr.v2.1.0"}) {
            assertTrue(ValidationProfile.resolve(type).usesPhmrEngine);
            assertEquals(
                    "gazelle/phmr/schemas/infrastructure/CDA_SDTC.xsd",
                    ValidationProfile.resolve(type).schemaPath);
        }
        assertFalse(ValidationProfile.resolve("pdc.v3.0.0").usesPhmrEngine);
        assertEquals(
                "gazelle/phmr/schemas/infrastructure/CDA_SDTC.xsd",
                ValidationProfile.resolve("phmr.v2.1.0").schemaPath);
        assertEquals(
                "gazelle/qfdd/schemas/infrastructure/CDA_SDTC.xsd",
                ValidationProfile.resolve("qfdd.v1.2").schemaPath);
        assertEquals("gazelle/ihe/xsd/CDA.xsd", ValidationProfile.resolve("qrd.v1.3.2").schemaPath);
        for (String name : new String[] {"apd.v2.0.1", "cpd.v2.0.0", "pdc.v2.0", "pdc.v3.0.0"}) {
            assertEquals(
                    "gazelle/cpd/infrastructure/cda/CDA_SDTC.xsd",
                    ValidationProfile.resolve(name).schemaPath);
        }
    }

    @Test
    void unsupportedSelectionsCannotFallBackToAnotherEngine() {
        for (String type :
                new String[] {"phmr.v1.2", "phmr", "pdc", "apd.latest", "unknown", "", null}) {
            var error =
                    assertThrows(
                            IllegalArgumentException.class, () -> ValidationProfile.resolve(type));
            assertTrue(error.getMessage().contains("Unsupported CDA profile/ruleset"));
        }
    }

    @Test
    void pluginReportsUnsupportedVersionBeforeReadingDocument() {
        ValidateRequest request = new ValidateRequest();
        addInput(request, "validationType", "phmr.v999.0.0");
        addInput(request, "contentToValidate", "/does-not-exist.xml");
        var report = new CdaDkGazellePlugin().validate(request).getReport();
        assertEquals(TestResultType.FAILURE, report.getResult());
        assertEquals(1, report.getCounters().getNrOfErrors().intValue());
        BAR finding = (BAR) report.getReports().getInfoOrWarningOrError().get(0).getValue();
        assertEquals("CDA-DK-UNSUPPORTED-RULESET", finding.getAssertionID());
    }

    private static void addInput(ValidateRequest request, String name, String value) {
        AnyContent input = new AnyContent();
        input.setName(name);
        input.setValue(value);
        request.getInput().add(input);
    }
}
