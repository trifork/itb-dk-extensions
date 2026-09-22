package com.trifork.ihexdsapi.gitb;

import java.net.URI;
import java.net.http.*;
import java.time.Duration;

/** JDK-only probe; packaged separately for the distroless runtime. Never contacts STS/DDS. */
public final class ReadinessProbe {
    private ReadinessProbe() {}

    public static void main() throws Exception {
        try (var client = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(3)).build()) {
            var response =
                    client.send(
                            HttpRequest.newBuilder(URI.create("http://localhost:8080/health/ready"))
                                    .timeout(Duration.ofSeconds(5))
                                    .build(),
                            HttpResponse.BodyHandlers.discarding());
            if (response.statusCode() != java.net.HttpURLConnection.HTTP_OK)
                throw new IllegalStateException("XDS application is not ready");
        }
    }
}
