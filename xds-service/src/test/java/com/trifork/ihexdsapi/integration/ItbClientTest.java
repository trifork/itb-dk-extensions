package com.trifork.ihexdsapi.integration;

import static com.trifork.ihexdsapi.integration.ItbClient.*;
import static org.junit.jupiter.api.Assertions.*;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Map;
import org.junit.jupiter.api.Test;

class ItbClientTest {
    @Test
    void staleLabelsCannotSilentlySubmitEmptyValues() throws Exception {
        var interaction =
                JSON.readTree(
                        """
                {"interactions":[{"type":"request","desc":"Type code (multiple allowed)"}]}
                """);
        var staleValues = Map.of("Type code", "Any");
        assertThrows(AssertionError.class, () -> assertKnownFields(interaction, staleValues));
        assertDoesNotThrow(
                () ->
                        assertKnownFields(
                                interaction, Map.of("Type code (multiple allowed)", "Any")));
        assertDoesNotThrow(() -> assertKnownFields(interaction, Map.of()));
    }

    @Test
    void inlineBinaryPreservesOriginalBytes() {
        byte[] original = "<html/>".getBytes(StandardCharsets.UTF_8);
        for (String method : new String[] {"BASE64", "BASE_64"}) {
            assertArrayEquals(
                    original,
                    attachment(
                            JSON.valueToTree(
                                    Map.of(
                                            "type",
                                            "binary",
                                            "embeddingMethod",
                                            method,
                                            "value",
                                            Base64.getEncoder().encodeToString(original))),
                            reference -> {
                                throw new AssertionError("Unexpected download");
                            }));
        }
    }

    @Test
    void externalBinaryDownloadsOriginalBytes() {
        String reference = "b1179c46-103a-4965-a933-d707f714d8be";
        byte[] original = new byte[] {0, (byte) 255};
        assertArrayEquals(
                original,
                attachment(
                        JSON.valueToTree(Map.of("value", "___[[" + reference + "]]___")),
                        actual -> {
                            assertEquals(reference, actual);
                            return original;
                        }));
    }

    @Test
    void invalidBase64Fails() {
        var item =
                JSON.valueToTree(
                        Map.of("type", "binary", "embeddingMethod", "BASE64", "value", "<html/>"));
        java.util.function.Function<String, byte[]> download =
                reference -> {
                    throw new AssertionError("Unexpected download");
                };
        assertThrows(IllegalArgumentException.class, () -> attachment(item, download));
    }

    @Test
    void unexpectedEmbeddingFails() {
        var item =
                JSON.valueToTree(
                        Map.of("type", "binary", "embeddingMethod", "STRING", "value", "<html/>"));
        java.util.function.Function<String, byte[]> download =
                reference -> {
                    throw new AssertionError("Unexpected download");
                };
        assertThrows(AssertionError.class, () -> attachment(item, download));
    }

    @Test
    void decodesBootstrapQuotingWithoutExecutingIt() {
        assertEquals("one two", shellValue("'one two'"));
        assertEquals("one two", shellValue("one\\ two"));
        assertEquals("a'b", shellValue("'a'\\''b'"));
        assertEquals("$(not-a-command)", shellValue("'$(not-a-command)'"));
        assertThrows(IllegalArgumentException.class, () -> shellValue("'unterminated"));
    }
}
