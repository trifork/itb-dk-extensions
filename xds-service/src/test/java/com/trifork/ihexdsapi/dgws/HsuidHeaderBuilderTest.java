package com.trifork.ihexdsapi.dgws;

import static org.junit.jupiter.api.Assertions.*;

import java.time.*;
import org.junit.jupiter.api.Test;
import org.xmlunit.builder.DiffBuilder;

class HsuidHeaderBuilderTest {
    @Test
    void matchesTheFormerHsuidLibraryWireHeader() throws Exception {
        var context =
                new DgwsClientInfo(
                        null, "0101019999", "3001749995", "FT001", "123456789012345", true);
        var actual =
                HsuidHeaderBuilder.build(
                        context,
                        Clock.fixed(Instant.parse("2026-01-02T03:04:05.123Z"), ZoneOffset.UTC));
        try (var expected = getClass().getResourceAsStream("/hsuid/header.xml")) {
            var diff =
                    DiffBuilder.compare(expected)
                            .withTest(actual)
                            .ignoreWhitespace()
                            .checkForSimilar()
                            .build();
            assertFalse(diff.hasDifferences(), diff::toString);
        }
    }

    @Test
    void omitsAbsentAuthorisationAndDoesNotClaimConsentOverride() throws Exception {
        var context =
                new DgwsClientInfo(
                        null, "0101019999", "3001749995", null, "123456789012345", false);
        var header = HsuidHeaderBuilder.build(context, Clock.systemUTC());
        var xpath = javax.xml.xpath.XPathFactory.newInstance().newXPath();
        assertEquals(
                "0",
                xpath.evaluate(
                        "count(//*[local-name()='Attribute'][@Name='nsi:ConsentOverride' or"
                                + " @Name='nsi:ResponsibleUserAuthorizationCode'])",
                        header));
        assertEquals(
                "0101019999",
                xpath.evaluate(
                        "string(//*[local-name()='Attribute'][@Name='nsi:ResponsibleUserCivilRegistrationNumber']/*)",
                        header));
    }
}
