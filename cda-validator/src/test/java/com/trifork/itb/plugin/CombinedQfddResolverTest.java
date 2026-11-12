package com.trifork.itb.plugin;

import static org.junit.jupiter.api.Assertions.*;

import java.util.concurrent.atomic.AtomicInteger;
import org.junit.jupiter.api.Test;

class CombinedQfddResolverTest {

    private static QfddLookup found(String source) {
        return QfddLookup.found("<x/>".getBytes(), source);
    }

    @Test
    void theFirstResolversAnswerIsUsedWithoutAskingTheSecond() {
        AtomicInteger asked = new AtomicInteger();
        var combined =
                new CombinedQfddResolver(
                        (id, v) -> found("first"),
                        (id, v) -> {
                            asked.incrementAndGet();
                            return found("second");
                        });
        assertEquals("first", combined.resolve("a", null).detail);
        assertEquals(0, asked.get());
    }

    @Test
    void theSecondResolverIsUsedWhenTheFirstHasNothing() {
        for (QfddLookup nothing :
                new QfddLookup[] {
                    QfddLookup.notFound("no"),
                    QfddLookup.unavailable("down"),
                    QfddLookup.ambiguous("two")
                }) {
            var combined = new CombinedQfddResolver((id, v) -> nothing, (id, v) -> found("second"));
            QfddLookup lookup = combined.resolve("a", null);
            assertEquals(QfddLookup.Status.FOUND, lookup.status, nothing.status.name());
            assertEquals("second", lookup.detail);
        }
    }

    @Test
    void withoutAnAnswerTheLeastCertainOutcomeWinsAndBothReasonsAreKept() {
        assertEquals(
                QfddLookup.Status.NOT_FOUND,
                outcome(QfddLookup.notFound("A"), QfddLookup.notFound("B")));
        assertEquals(
                QfddLookup.Status.AMBIGUOUS,
                outcome(QfddLookup.notFound("A"), QfddLookup.ambiguous("B")));
        assertEquals(
                QfddLookup.Status.UNAVAILABLE,
                outcome(QfddLookup.notFound("A"), QfddLookup.unavailable("B")));
        assertEquals(
                QfddLookup.Status.UNAVAILABLE,
                outcome(QfddLookup.unavailable("A"), QfddLookup.notFound("B")));
        assertEquals(
                QfddLookup.Status.UNAVAILABLE,
                outcome(QfddLookup.ambiguous("A"), QfddLookup.unavailable("B")));

        QfddLookup lookup =
                new CombinedQfddResolver(
                                (id, v) -> QfddLookup.notFound("embedded: none"),
                                (id, v) -> QfddLookup.unavailable("spgdef: down"))
                        .resolve("a", null);
        assertTrue(
                lookup.detail.contains("embedded: none") && lookup.detail.contains("spgdef: down"));
    }

    private static QfddLookup.Status outcome(QfddLookup first, QfddLookup second) {
        return new CombinedQfddResolver((id, v) -> first, (id, v) -> second)
                .resolve("a", null)
                .status;
    }
}
