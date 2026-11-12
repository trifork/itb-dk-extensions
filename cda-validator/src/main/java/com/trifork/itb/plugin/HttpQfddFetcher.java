package com.trifork.itb.plugin;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URI;

/**
 * Plain {@link HttpURLConnection} client. It deliberately avoids {@code java.net.http}, which the
 * plugin's isolated class loader may not see. No redirects, no cookies, no connection reuse,
 * bounded size and time, and a generic user agent that carries no information about the caller.
 */
final class HttpQfddFetcher implements QfddFetcher {

    private static final String USER_AGENT = "cda-dk-validator";
    private final int connectTimeoutMillis;
    private final int readTimeoutMillis;

    HttpQfddFetcher(int connectTimeoutMillis, int readTimeoutMillis) {
        this.connectTimeoutMillis = connectTimeoutMillis;
        this.readTimeoutMillis = readTimeoutMillis;
    }

    @Override
    public Response get(URI uri, int maxBytes) throws IOException {
        String scheme = uri.getScheme();
        if (!"https".equals(scheme) && !"http".equals(scheme)) {
            throw new IOException("Unsupported URL scheme: " + scheme);
        }
        HttpURLConnection connection = (HttpURLConnection) uri.toURL().openConnection();
        try {
            connection.setInstanceFollowRedirects(false);
            connection.setUseCaches(false);
            connection.setConnectTimeout(connectTimeoutMillis);
            connection.setReadTimeout(readTimeoutMillis);
            connection.setRequestMethod("GET");
            connection.setRequestProperty("User-Agent", USER_AGENT);
            connection.setRequestProperty("Accept", "application/xml, text/html;q=0.9");
            // Requests are rare and cached. A pooled connection that the server has silently
            // dropped would otherwise hang until the read timeout.
            connection.setRequestProperty("Connection", "close");
            int status = connection.getResponseCode();
            if (status != 200) {
                // The body of anything else is of no interest and is never read.
                return new Response(status, new byte[0]);
            }
            try (InputStream stream = connection.getInputStream()) {
                return new Response(status, readBounded(stream, maxBytes));
            }
        } finally {
            connection.disconnect();
        }
    }

    private static byte[] readBounded(InputStream stream, int maxBytes) throws IOException {
        ByteArrayOutputStream body = new ByteArrayOutputStream();
        byte[] buffer = new byte[8192];
        int read;
        while ((read = stream.read(buffer)) != -1) {
            if (body.size() + read > maxBytes) {
                throw new IOException("The response is larger than " + maxBytes + " bytes");
            }
            body.write(buffer, 0, read);
        }
        return body.toByteArray();
    }
}
