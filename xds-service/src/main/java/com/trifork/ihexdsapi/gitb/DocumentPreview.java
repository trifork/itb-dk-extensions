package com.trifork.ihexdsapi.gitb;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.regex.Pattern;

/** Display-only decoding: the report attachment and validator retain the original bytes. */
final class DocumentPreview {
    static final int LIMIT = 64 * 1024;
    private static final Pattern ENCODING_DECLARATION =
            Pattern.compile("^<\\?xml\\s[^?]*encoding\\s*=\\s*['\"]([^'\"]+)['\"]");

    private DocumentPreview() {}

    private static boolean startsWith(byte[] bytes, int... prefix) {
        if (bytes.length < prefix.length) return false;
        for (int i = 0; i < prefix.length; i++) if ((bytes[i] & 0xff) != prefix[i]) return false;
        return true;
    }

    private static Charset encoding(byte[] bytes) {
        if (startsWith(bytes, 0xff, 0xfe) || startsWith(bytes, 0xfe, 0xff))
            return StandardCharsets.UTF_16;
        if (startsWith(bytes, 0, '<', 0, '?')) return StandardCharsets.UTF_16BE;
        if (startsWith(bytes, '<', 0, '?', 0)) return StandardCharsets.UTF_16LE;
        int offset = startsWith(bytes, 0xef, 0xbb, 0xbf) ? 3 : 0;
        var declaration =
                new String(
                        bytes,
                        offset,
                        Math.min(bytes.length - offset, 1024),
                        StandardCharsets.ISO_8859_1);
        var match = ENCODING_DECLARATION.matcher(declaration);
        if (match.find()) {
            try {
                return Charset.forName(match.group(1));
            } catch (IllegalArgumentException _) {
                return StandardCharsets.UTF_8;
            }
        }
        return StandardCharsets.UTF_8;
    }

    private static boolean xmlCharacter(int point) {
        return point == 9
                || point == 10
                || point == 13
                || (point >= 32 && point <= 0xd7ff)
                || (point >= 0xe000 && point <= 0xfffd)
                || (point >= 0x10000 && point <= 0x10ffff);
    }

    static String format(byte[] bytes) {
        Charset charset = encoding(bytes);
        String decoded = new String(bytes, charset);
        var preview = new StringBuilder();
        int offset = 0;
        while (offset < decoded.length() && preview.length() < LIMIT) {
            int point = decoded.codePointAt(offset);
            offset += Character.charCount(point);
            // Escape controls that cannot cross the SOAP/XML transport, without parsing entities.
            if (xmlCharacter(point)) {
                preview.appendCodePoint(point);
            } else preview.append(String.format("\\u%04X", point));
        }
        return "Retrieved XDS document ("
                + bytes.length
                + " bytes; preview decoded as "
                + charset.name()
                + "):\n"
                + "--- BEGIN RETRIEVED DOCUMENT ---\n"
                + preview
                + (offset < decoded.length() ? "\n[Preview truncated at 64 KiB of text.]" : "")
                + "\n--- END RETRIEVED DOCUMENT ---\n"
                + "The complete original bytes are available as retrieved-document in the Retrieve selected CDA document step report.";
    }
}
