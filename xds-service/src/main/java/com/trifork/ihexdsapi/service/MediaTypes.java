package com.trifork.ihexdsapi.service;

import java.nio.ByteBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.CodingErrorAction;
import java.nio.charset.StandardCharsets;

/** Best-effort media type from the first bytes of a file; the uploader can correct it. */
public final class MediaTypes {
    private MediaTypes() {}

    public static String detect(byte[] bytes) {
        if (startsWith(bytes, "%PDF-")) return "application/pdf";
        if (startsWith(bytes, 0x89, 'P', 'N', 'G')) return "image/png";
        if (startsWith(bytes, 0xFF, 0xD8, 0xFF)) return "image/jpeg";
        if (startsWith(bytes, "GIF8")) return "image/gif";
        if (startsWith(bytes, 'P', 'K', 3, 4)) return "application/zip";
        String text = decode(bytes);
        // A NUL byte is valid UTF-8 but never in text a person would paste or attach.
        if (text == null || text.indexOf('\0') >= 0) return "application/octet-stream";
        String head = text.substring(0, Math.min(text.length(), 4096)).strip();
        if (head.startsWith("<"))
            return head.regionMatches(true, 0, "<html", 0, 5) ? "text/html" : "text/xml";
        if (head.startsWith("{") || head.startsWith("[")) {
            return head.contains("\"resourceType\"") ? "application/fhir+json" : "application/json";
        }
        return "text/plain";
    }

    private static boolean startsWith(byte[] bytes, String prefix) {
        int[] expected = prefix.chars().toArray();
        return startsWith(bytes, expected);
    }

    private static boolean startsWith(byte[] bytes, int... prefix) {
        if (bytes.length < prefix.length) return false;
        for (int i = 0; i < prefix.length; i++) if ((bytes[i] & 0xFF) != prefix[i]) return false;
        return true;
    }

    private static String decode(byte[] bytes) {
        int end = Math.min(bytes.length, 8192);
        // Do not cut a multi-byte character in half at the sample boundary.
        while (end < bytes.length && end > 0 && (bytes[end] & 0xC0) == 0x80) end--;
        try {
            return StandardCharsets.UTF_8
                    .newDecoder()
                    .onMalformedInput(CodingErrorAction.REPORT)
                    .onUnmappableCharacter(CodingErrorAction.REPORT)
                    .decode(ByteBuffer.wrap(bytes, 0, end))
                    .toString();
        } catch (CharacterCodingException _) {
            return null;
        }
    }
}
