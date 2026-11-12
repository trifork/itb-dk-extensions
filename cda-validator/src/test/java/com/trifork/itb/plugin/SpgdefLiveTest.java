package com.trifork.itb.plugin;

import static org.junit.jupiter.api.Assertions.*;

import java.net.URI;
import java.time.Clock;
import java.time.Duration;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.condition.EnabledIfSystemProperty;

/**
 * Talks to the real https://spgdef.dk/qfdd/. Opt-in, so that normal builds never depend on, or
 * load, the public site: {@code mvn test -Dtest=SpgdefLiveTest -Dcda.live.spgdef=true}.
 */
@EnabledIfSystemProperty(named = "cda.live.spgdef", matches = "true")
class SpgdefLiveTest {

    private final SpgdefQfddResolver resolver =
            new SpgdefQfddResolver(
                    new HttpQfddFetcher(10_000, 30_000), Clock.systemUTC(), Duration.ofMinutes(5));

    @Test
    void resolvesListedQfdds() {
        for (String id : new String[] {"cfe60422-8a81-4511-bed2-f40f7229e30e", "28"}) {
            QfddLookup lookup = resolver.resolve(id, null);
            assertEquals(QfddLookup.Status.FOUND, lookup.status, id + ": " + lookup.detail);
            assertNull(QfddIntegrity.problem(lookup.document(), id));
        }
    }

    @Test
    void anUnlistedIdentifierIsNotFound() {
        assertEquals(
                QfddLookup.Status.NOT_FOUND,
                resolver.resolve("11111111-1111-4111-8111-111111111111", null).status);
    }

    @Test
    void everyListedQfddIsAcceptedByTheIntegrityChecks() throws Exception {
        var response = new HttpQfddFetcher(10_000, 30_000).get(SpgdefQfddResolver.INDEX, 2_000_000);
        Map<String, URI> catalogue =
                SpgdefQfddResolver.parseCatalogue(new String(response.body(), "UTF-8"));
        assertTrue(catalogue.size() > 50, "the catalogue should list the published QFDDs");
        for (String id : catalogue.keySet()) {
            QfddLookup lookup = resolver.resolve(id, null);
            assertEquals(QfddLookup.Status.FOUND, lookup.status, id + ": " + lookup.detail);
        }
    }
}
