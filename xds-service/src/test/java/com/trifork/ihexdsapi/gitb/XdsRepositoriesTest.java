package com.trifork.ihexdsapi.gitb;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import org.junit.jupiter.api.Test;

class XdsRepositoriesTest {
    @Test
    void knownRepositoryOidsHaveTheirDocumentedEnvironment() {
        assertEquals(
                "1.2.208.176.43210.8.1.30 (KIH Repository, TEST1 / PRODTEST)",
                XdsRepositories.describe("1.2.208.176.43210.8.1.30"));
        assertEquals(
                "1.2.208.176.43210.8.1.29 (KIH Repository, TEST2)",
                XdsRepositories.describe("1.2.208.176.43210.8.1.29"));
        assertEquals(
                "1.2.208.176.43210.8.1.31 (KIH Repository, UDDANNELSE)",
                XdsRepositories.describe("1.2.208.176.43210.8.1.31"));
        String[] environments = {"TEST1", "TEST2", "PRODTEST", "UDDANNELSE"};
        for (int i = 0; i < environments.length; i++) {
            String oid = "1.2.208.176.43210.8." + (i + 1) + "0.11";
            assertEquals(
                    oid + " (Aftale DRS, " + environments[i] + ")", XdsRepositories.describe(oid));
            String sandbox = "1.2.208.176.43210.8." + (i + 1) + "0.999";
            assertEquals(
                    sandbox + " (Sandbox DROS, " + environments[i] + ")",
                    XdsRepositories.describe(sandbox));
            assertEquals("Sandbox DROS · " + environments[i], XdsRepositories.shortLabel(sandbox));
        }
        assertEquals(
                "1.3.6.1.4.1.21367.2010.1.2.1125 (OpenXDS / OpenText PoC, environment unknown)",
                XdsRepositories.describe("1.3.6.1.4.1.21367.2010.1.2.1125"));
    }

    @Test
    void unknownOidsAreRetainedWithoutGuessingNamesOrConfusingCommunityIds() {
        for (String oid :
                List.of(
                        "2.999.1",
                        "1.2.208.176.43210.8.30",
                        "1.2.208.176.43210.8.1.300",
                        "1.2.208.176.43210.8.1.30.1",
                        "1.2.208.176.43210.8.50.999",
                        "1.3.6.1.4.1.21367.2010.1.2.2045")) {
            assertEquals(oid + " (name/environment unknown)", XdsRepositories.describe(oid));
        }
    }

    @Test
    void arbitraryMetadataCannotInjectLogText() {
        for (String value :
                List.of(
                        "",
                        "1.2.3\nERROR injected",
                        "<Assertion>sensitive-STStoken</Assertion>",
                        "private-repository",
                        "3.1.2",
                        "1.40.1",
                        "2.01.2",
                        "1.2.3.",
                        " 1.2.3",
                        "1.2." + "9".repeat(129))) {
            assertEquals(
                    "unrecognised repository identifier (non-OID or oversized value withheld)",
                    XdsRepositories.describe(value));
        }
        assertEquals(
                "unrecognised repository identifier (non-OID or oversized value withheld)",
                XdsRepositories.describe(null));
    }
}
