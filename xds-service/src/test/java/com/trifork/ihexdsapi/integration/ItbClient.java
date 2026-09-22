package com.trifork.ihexdsapi.integration;

import static org.awaitility.Awaitility.await;
import static org.junit.jupiter.api.Assertions.*;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.ByteArrayInputStream;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Base64;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.regex.Pattern;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

final class ItbClient {
    static final Path ROOT =
            Path.of(System.getProperty("repository.root", "..")).toAbsolutePath().normalize();
    static final ObjectMapper JSON = new ObjectMapper();
    private static final Pattern STEP_PREFIX = Pattern.compile("^.*?: ");
    private static final Pattern EXTERNAL = Pattern.compile("___\\[\\[([0-9a-f-]+)\\]\\]___");
    private final HttpClient http =
            HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(15)).build();
    private final String base =
            System.getenv().getOrDefault("ITB_UI_API_BASE", "http://localhost:9000/api");
    private final Map<String, String> state;
    private String token;

    ItbClient() throws Exception {
        state =
                readState(
                        Path.of(
                                System.getenv()
                                        .getOrDefault(
                                                "ITB_STATE_FILE",
                                                ROOT.resolve(
                                                                "get-up-and-running/.itb-bootstrap.env")
                                                        .toString())));
        Map<String, String> user =
                readState(
                        Path.of(
                                System.getenv()
                                        .getOrDefault(
                                                "ITB_USER_STATE_FILE",
                                                ROOT.resolve("get-up-and-running/.itb-users.env")
                                                        .toString())));
        token =
                request(
                                "/oauth/access_token",
                                Map.of(
                                        "email",
                                        user.get("ITB_ADMIN_USERNAME"),
                                        "password",
                                        user.get("ITB_ADMIN_PASSWORD")),
                                true,
                                false)
                        .get("access_token")
                        .asText();
    }

    static Map<String, String> readState(Path path) throws Exception {
        Map<String, String> state = new LinkedHashMap<>();
        for (String line : Files.readAllLines(path)) {
            int split = line.indexOf('=');
            if (split > 0)
                state.put(line.substring(0, split), shellValue(line.substring(split + 1)));
        }
        return state;
    }

    // Decode shell-quoted bootstrap values as data; never evaluate shell expansions.
    static String shellValue(String value) {
        StringBuilder output = new StringBuilder();
        char quote = 0;
        boolean escape = false;
        for (char c : value.toCharArray()) {
            if (escape) {
                output.append(c);
                escape = false;
            } else if (c == '\\' && quote != '\'') escape = true;
            else if (quote != 0 && c == quote) quote = 0;
            else if (quote == 0 && (c == '\'' || c == '"')) quote = c;
            else output.append(c);
        }
        if (quote != 0 || escape)
            throw new IllegalArgumentException("Malformed bootstrap state quoting");
        return output.toString();
    }

    static String encode(String value) {
        return URLEncoder.encode(value, StandardCharsets.UTF_8).replace("+", "%20");
    }

    private byte[] raw(String path, Object body, boolean form, boolean rest) throws Exception {
        HttpRequest.Builder builder =
                HttpRequest.newBuilder(URI.create(base + path)).timeout(Duration.ofSeconds(60));
        builder.header("Accept", "application/json, application/octet-stream");
        if (rest) builder.header("ITB_API_KEY", state.get("ITB_ORGANISATION_API_KEY"));
        else if (token != null) builder.header("Authorization", "Bearer " + token);
        if (body != null) {
            JsonNode fields = JSON.valueToTree(body);
            String payload;
            if (form) {
                List<String> encoded = new ArrayList<>();
                fields.properties()
                        .forEach(
                                e ->
                                        encoded.add(
                                                encode(e.getKey())
                                                        + "="
                                                        + encode(e.getValue().asText())));
                payload = String.join("&", encoded);
            } else payload = JSON.writeValueAsString(body);
            builder.header(
                    "Content-Type",
                    form ? "application/x-www-form-urlencoded" : "application/json");
            builder.POST(HttpRequest.BodyPublishers.ofString(payload));
        }
        HttpResponse<byte[]> response =
                http.send(builder.build(), HttpResponse.BodyHandlers.ofByteArray());
        // Never include authentication responses or state values in test diagnostics.
        assertTrue(
                response.statusCode() >= 200 && response.statusCode() < 300,
                () -> "ITB HTTP " + response.statusCode() + " for " + path);
        return response.body();
    }

    JsonNode request(String path, Object body, boolean form, boolean rest) throws Exception {
        byte[] response = raw(path, body, form, rest);
        return response.length == 0 ? JSON.nullNode() : JSON.readTree(response);
    }

    JsonNode get(String path) throws Exception {
        return request(path, null, false, false);
    }

    String start() throws Exception {
        return request(
                        "/rest/tests/start",
                        Map.of(
                                "system",
                                state.get("ITB_SYSTEM_API_KEY"),
                                "actor",
                                state.get("ITB_ACTOR_API_KEY"),
                                "testCase",
                                List.of(state.get("ITB_INTERACTIVE_TEST_CASE_API_KEY")),
                                "waitForCompletion",
                                false),
                        false,
                        true)
                .get("createdSessions")
                .get(0)
                .get("session")
                .asText();
    }

    void stop(String session) throws Exception {
        request("/tests/" + session + "/stop", Map.of(), true, false);
    }

    JsonNode status(String session, boolean logs, boolean reports) throws Exception {
        JsonNode sessions =
                request(
                                "/rest/tests/status",
                                Map.of(
                                        "session",
                                        List.of(session),
                                        "withLogs",
                                        logs,
                                        "withReports",
                                        reports),
                                false,
                                true)
                        .get("sessions");
        return sessions.isEmpty() ? JSON.createObjectNode() : sessions.get(0);
    }

    JsonNode interactions(String session) throws Exception {
        return get("/repository/tests/" + session + "/admininteractions");
    }

    JsonNode interaction(String session, String title) {
        return await().alias("ITB interaction: " + title)
                .pollInSameThread()
                .pollInterval(Duration.ofMillis(250))
                .atMost(Duration.ofSeconds(90))
                .until(
                        () -> {
                            for (JsonNode item : interactions(session))
                                if (item.path("inputTitle").asText().contains(title)) return item;
                            assertFalse(
                                    status(session, false, false).hasNonNull("endTime"),
                                    "Session ended before " + title);
                            return null;
                        },
                        java.util.Objects::nonNull);
    }

    void submit(String session, JsonNode interaction, Map<String, ?> values) throws Exception {
        assertKnownFields(interaction, values);
        List<Map<String, Object>> inputs = new ArrayList<>();
        for (JsonNode item : interaction.get("interactions")) {
            if (!"request".equals(item.path("type").asText())) continue;
            Object value = values.get(item.path("desc").asText());
            if (value == null) value = "";
            if (value instanceof byte[] bytes) value = Base64.getEncoder().encodeToString(bytes);
            inputs.add(
                    Map.of(
                            "id",
                            item.get("id"),
                            "name",
                            item.path("name").asText(),
                            "type",
                            item.get("variableType"),
                            "embeddingMethod",
                            item.get("contentType"),
                            "value",
                            value));
        }
        request(
                "/tests/" + session + "/provideadmin",
                Map.of(
                        "teststep",
                        interaction.get("stepId").asText(),
                        "inputs",
                        JSON.writeValueAsString(inputs)),
                true,
                false);
    }

    static JsonNode field(JsonNode interaction, String description) {
        for (JsonNode field : interaction.get("interactions"))
            if (description.equals(field.path("desc").asText())) return field;
        throw new AssertionError("Missing interaction field " + description);
    }

    static void assertKnownFields(JsonNode interaction, Map<String, ?> values) {
        for (String description : values.keySet()) {
            JsonNode item = field(interaction, description);
            assertEquals("request", item.path("type").asText(), "Only request fields accept input");
        }
    }

    static List<String> options(JsonNode field) {
        assertEquals(
                field.get("optionLabels").asText(),
                field.get("options").asText(),
                "Reports must retain readable selections");
        return List.of(field.get("options").asText().split(",", -1));
    }

    static String option(JsonNode interaction, String description, String text) {
        List<String> choices =
                options(field(interaction, description)).stream()
                        .filter(s -> s.contains(text))
                        .toList();
        assertEquals(1, choices.size(), "Expected one option matching " + text);
        return choices.getFirst();
    }

    JsonNode ended(String session, int seconds) {
        return await().alias("ITB session completion")
                .pollInSameThread()
                .pollInterval(Duration.ofMillis(250))
                .atMost(Duration.ofSeconds(seconds))
                .until(() -> status(session, false, false), status -> status.hasNonNull("endTime"));
    }

    String logs(String session) throws Exception {
        List<String> logs = new ArrayList<>();
        status(session, true, false).get("logs").forEach(line -> logs.add(line.asText()));
        return String.join("\n", logs);
    }

    Document report(String session) throws Exception {
        String xml = status(session, false, true).get("report").asText();
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
        return factory.newDocumentBuilder()
                .parse(new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8)));
    }

    static List<Element> nodes(Node root, String xpath) throws Exception {
        NodeList result =
                (NodeList)
                        XPathFactory.newInstance()
                                .newXPath()
                                .evaluate(xpath, root, XPathConstants.NODESET);
        List<Element> elements = new ArrayList<>();
        for (int i = 0; i < result.getLength(); i++) elements.add((Element) result.item(i));
        return elements;
    }

    JsonNode stepReport(String session, String description) throws Exception {
        for (Element step : nodes(report(session), "//*[local-name()='step']")) {
            List<Element> descriptions = nodes(step, "./*[local-name()='description']");
            if (descriptions.isEmpty()
                    || !STEP_PREFIX
                            .matcher(descriptions.getFirst().getTextContent())
                            .replaceFirst("")
                            .equals(description)) continue;
            for (JsonNode metadata : get("/reports/" + session + "/steps"))
                if (step.getAttribute("id").equals(metadata.get("stepId").asText()))
                    return get(
                            "/repository/reports/teststep/"
                                    + session
                                    + "/"
                                    + encode(metadata.get("path").asText()));
        }
        throw new AssertionError("Missing step report " + description);
    }

    static Map<String, String> context(JsonNode report) {
        Map<String, String> values = new LinkedHashMap<>();
        report.path("context")
                .path("item")
                .forEach(item -> values.put(item.get("name").asText(), item.get("value").asText()));
        return values;
    }

    static byte[] attachment(JsonNode item, Function<String, byte[]> download) {
        var reference = EXTERNAL.matcher(item.get("value").asText());
        if (reference.matches()) return download.apply(reference.group(1));
        assertEquals("binary", item.get("type").asText());
        assertTrue(List.of("BASE64", "BASE_64").contains(item.get("embeddingMethod").asText()));
        return Base64.getDecoder().decode(item.get("value").asText());
    }

    byte[] attachment(String session, JsonNode item) {
        return attachment(
                item,
                reference -> {
                    try {
                        return raw(
                                "/repository/reports/testdata/" + session + "/" + reference,
                                null,
                                false,
                                false);
                    } catch (Exception e) {
                        throw new IllegalStateException("Failed to download test attachment", e);
                    }
                });
    }

    List<Object> signature(String session) throws Exception {
        Element report =
                nodes(
                                report(session),
                                "//*[local-name()='step']/*[local-name()='report'][*[local-name()='overview']/*[local-name()='profileID']]")
                        .getFirst();
        assertEquals(
                "phmr.v2.1.0",
                nodes(report, "./*[local-name()='overview']/*[local-name()='profileID']")
                        .getFirst()
                        .getTextContent());
        List<Object> findings = new ArrayList<>();
        boolean located = false;
        for (Element finding : nodes(report, "./*[local-name()='reports']/*")) {
            List<Object> children = new ArrayList<>();
            for (Element child : nodes(finding, "./*")) {
                children.add(
                        List.of(
                                child.getNamespaceURI(),
                                child.getLocalName(),
                                child.getTextContent()));
                located |=
                        "location".equals(child.getLocalName())
                                && !child.getTextContent().isEmpty();
            }
            findings.add(List.of(finding.getNamespaceURI(), finding.getLocalName(), children));
        }
        assertTrue(located, "Expected locations in validation findings");
        return List.of(
                nodes(report, "./*[local-name()='result']").getFirst().getTextContent(), findings);
    }
}
