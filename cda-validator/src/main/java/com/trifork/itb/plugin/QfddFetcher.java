package com.trifork.itb.plugin;

import java.io.IOException;
import java.net.URI;

/** Retrieves one resource over HTTP(S). Kept apart from {@link SpgdefQfddResolver} for testing. */
interface QfddFetcher {

    /** An HTTP response. Redirects are never followed, so a 3xx status is reported as is. */
    final class Response {
        final int status;
        private final byte[] body;

        Response(int status, byte[] body) {
            this.status = status;
            this.body = body.clone();
        }

        byte[] body() {
            return body.clone();
        }
    }

    /**
     * @param maxBytes the largest body accepted
     * @throws IOException on network failure, timeout or a body larger than {@code maxBytes}
     */
    Response get(URI uri, int maxBytes) throws IOException;
}
