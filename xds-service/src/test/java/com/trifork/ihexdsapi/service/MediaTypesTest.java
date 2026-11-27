package com.trifork.ihexdsapi.service;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.nio.charset.StandardCharsets;
import org.junit.jupiter.api.Test;

class MediaTypesTest {
    private static byte[] text(String value) {
        return value.getBytes(StandardCharsets.UTF_8);
    }

    @Test
    void detectsCommonFilesFromTheirFirstBytes() {
        assertEquals("application/pdf", MediaTypes.detect(text("%PDF-1.4")));
        assertEquals("image/png", MediaTypes.detect(new byte[] {(byte) 0x89, 'P', 'N', 'G', 1}));
        assertEquals(
                "image/jpeg",
                MediaTypes.detect(new byte[] {(byte) 0xFF, (byte) 0xD8, (byte) 0xFF, 0}));
        assertEquals("image/gif", MediaTypes.detect(text("GIF89a")));
        assertEquals("application/zip", MediaTypes.detect(new byte[] {'P', 'K', 3, 4, 0}));
        assertEquals("text/xml", MediaTypes.detect(text("  <?xml version=\"1.0\"?><a/>")));
        assertEquals("text/html", MediaTypes.detect(text("<HTML><body/>")));
        assertEquals("application/json", MediaTypes.detect(text("{\"a\":1}")));
        assertEquals("application/json", MediaTypes.detect(text("[1,2]")));
        assertEquals(
                "application/fhir+json", MediaTypes.detect(text("{\"resourceType\":\"Patient\"}")));
        assertEquals("text/plain", MediaTypes.detect(text("Hello, wørld")));
    }

    @Test
    void treatsBinaryAndTruncatedInputSafely() {
        assertEquals(
                "application/octet-stream",
                MediaTypes.detect(new byte[] {0, (byte) 0xC3, 0x28, (byte) 0xFF}));
        assertEquals("application/octet-stream", MediaTypes.detect(new byte[] {'a', 0, 'b'}));
        // A multi-byte character straddling the sample boundary is not mistaken for binary.
        byte[] long8191 = new byte[8191];
        java.util.Arrays.fill(long8191, (byte) 'a');
        byte[] withUmlaut = java.util.Arrays.copyOf(long8191, 8193);
        withUmlaut[8191] = (byte) 0xC3;
        withUmlaut[8192] = (byte) 0xB8;
        assertEquals("text/plain", MediaTypes.detect(withUmlaut));
    }
}
