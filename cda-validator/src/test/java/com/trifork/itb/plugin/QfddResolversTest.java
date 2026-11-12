package com.trifork.itb.plugin;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class QfddResolversTest {

    @Test
    void embeddedIsTheDefault() {
        for (String name : new String[] {null, "", "  ", "embedded", " EMBEDDED "}) {
            assertInstanceOf(EmbeddedQfddResolver.class, QfddResolvers.named(name), name);
        }
    }

    @Test
    void theOtherResolversAreSelectedByName() {
        assertInstanceOf(SpgdefQfddResolver.class, QfddResolvers.named("spgdef"));
        assertInstanceOf(CombinedQfddResolver.class, QfddResolvers.named("Combined"));
    }

    @Test
    void anUnknownNameIsAnErrorRatherThanAFallback() {
        var error =
                assertThrows(IllegalArgumentException.class, () -> QfddResolvers.named("registry"));
        assertTrue(error.getMessage().contains("embedded, spgdef or combined"), error.getMessage());
    }

    @Test
    void theSystemPropertyIsRead() {
        String previous = System.getProperty(QfddResolvers.PROPERTY);
        try {
            System.setProperty(QfddResolvers.PROPERTY, "spgdef");
            assertInstanceOf(SpgdefQfddResolver.class, QfddResolvers.configured());
        } finally {
            if (previous == null) System.clearProperty(QfddResolvers.PROPERTY);
            else System.setProperty(QfddResolvers.PROPERTY, previous);
        }
    }
}
