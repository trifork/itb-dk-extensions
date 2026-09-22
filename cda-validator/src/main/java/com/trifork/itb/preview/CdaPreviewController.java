package com.trifork.itb.preview;

import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.concurrent.Semaphore;
import javax.xml.transform.TransformerException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

@RestController
public final class CdaPreviewController {
    static final int MAX_BYTES = 10 * 1024 * 1024;
    private final CdaRenderer renderer;
    private final Semaphore slots = new Semaphore(2);

    public CdaPreviewController(CdaRenderer renderer) {
        this.renderer = renderer;
    }

    @GetMapping(value = "/cda-dk/preview.js", produces = "text/javascript;charset=UTF-8")
    public byte[] script() throws IOException {
        try (var input = getClass().getResourceAsStream("/rendering/preview.js")) {
            if (input == null) throw new IOException("Preview script is missing");
            return input.readAllBytes();
        }
    }

    @PostMapping(
            value = "/cda-dk/preview",
            consumes = {"application/xml", "text/xml", "application/octet-stream"})
    public ResponseEntity<String> preview(HttpServletRequest request) throws IOException {
        if (!slots.tryAcquire()) return error(429, "Preview is busy. Please try again shortly.");
        try {
            if (request.getContentLengthLong() > MAX_BYTES) return tooLarge();
            byte[] xml = request.getInputStream().readNBytes(MAX_BYTES + 1);
            if (xml.length > MAX_BYTES) return tooLarge();
            try {
                return ResponseEntity.ok()
                        .header("Content-Type", "text/html;charset=UTF-8")
                        .header("Cache-Control", "no-store")
                        .header("X-Content-Type-Options", "nosniff")
                        .header("Content-Security-Policy", CdaRenderer.POLICY + "; sandbox")
                        .body(renderer.render(xml));
            } catch (SAXParseException e) {
                if (e.getMessage().contains("DOCTYPE is disallowed")) {
                    return error(
                            400,
                            "Preview does not accept DOCTYPE declarations. External DTDs and entities are disabled.");
                }
                return error(
                        400,
                        "The XML could not be parsed at line "
                                + e.getLineNumber()
                                + ", column "
                                + e.getColumnNumber()
                                + ". Check XML syntax and character encoding.");
            } catch (SAXException _) {
                return error(
                        400,
                        "Preview requires a CDA ClinicalDocument in the urn:hl7-org:v3 namespace.");
            } catch (TransformerException _) {
                return error(
                        422,
                        "The CDA XML was read, but the display stylesheet could not render it. This is a preview error, not a validation result. You can still select Validate.");
            } catch (Exception _) {
                return error(
                        500,
                        "The preview service encountered an unexpected error. You can still select Validate.");
            }
        } finally {
            slots.release();
        }
    }

    private static ResponseEntity<String> tooLarge() {
        return error(413, "Preview supports CDA documents up to 10 MiB.");
    }

    private static ResponseEntity<String> error(int status, String message) {
        return ResponseEntity.status(status)
                .header("Content-Type", "text/plain;charset=UTF-8")
                .header("Cache-Control", "no-store")
                .body(message);
    }
}
