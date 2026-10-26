package com.trifork.ihexdsapi.configuration;

import static org.junit.jupiter.api.Assertions.*;

import com.trifork.ihexdsapi.dgws.HsuidConfigurationException;
import org.junit.jupiter.api.Test;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.test.context.runner.ApplicationContextRunner;
import org.springframework.context.annotation.Configuration;

class HsuidOrganisationPropertiesTest {
    @Configuration(proxyBeanMethods = false)
    @EnableConfigurationProperties(HsuidOrganisationProperties.class)
    static class Config {}

    @Test
    void bindsOperatorOrganisationSeparatelyFromCertificateIdentity() {
        new ApplicationContextRunner()
                .withUserConfiguration(Config.class)
                .withPropertyValues(
                        "xds.hsuid.organisation.identifier=6620151",
                        "xds.hsuid.organisation.scheme=skskode")
                .run(
                        context -> {
                            var org = context.getBean(HsuidOrganisationProperties.class);
                            assertEquals("6620151", org.identifier());
                            assertEquals("nsi:skskode", org.nameFormat());
                            assertDoesNotThrow(org::requireConfigured);
                        });
    }

    @Test
    void allowsReadinessWithoutOrganisationButRejectsLiveUse() {
        var org = new HsuidOrganisationProperties(null, null);
        assertEquals("sor", org.scheme());
        assertThrows(HsuidConfigurationException.class, org::requireConfigured);
        assertThrows(
                HsuidConfigurationException.class,
                new HsuidOrganisationProperties("  ", " ")::requireConfigured);
    }

    @Test
    void validatesSchemesAndIdentifiers() {
        assertEquals(
                "nsi:ynumber", new HsuidOrganisationProperties("123456", "ynumber").nameFormat());
        assertEquals(
                "440081000016006",
                new HsuidOrganisationProperties(" 440081000016006 ", " sor ").identifier());
        assertDoesNotThrow(() -> new HsuidOrganisationProperties("AB123", "skskode"));
        assertThrows(
                IllegalArgumentException.class,
                () -> new HsuidOrganisationProperties("12345678", "cvr"));
        assertThrows(
                IllegalArgumentException.class,
                () -> new HsuidOrganisationProperties("ABC", "sor"));
        assertThrows(
                IllegalArgumentException.class,
                () -> new HsuidOrganisationProperties("bad value", "skskode"));
        String tooLong = "1".repeat(31);
        assertThrows(
                IllegalArgumentException.class,
                () -> new HsuidOrganisationProperties(tooLong, "sor"));
    }
}
