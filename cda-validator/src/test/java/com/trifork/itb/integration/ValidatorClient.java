package com.trifork.itb.integration;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.MessageDigest;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Base64;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

final class ValidatorClient {
    static final Path ROOT =
            Path.of(System.getProperty("repository.root", "..")).toAbsolutePath().normalize();
    static final ObjectMapper JSON = new ObjectMapper();
    private static final HttpClient HTTP =
            HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(15)).build();

    private ValidatorClient() {}

    static JsonNode samples() throws Exception {
        return JSON.readTree(ROOT.resolve("samples/validation-cases.json").toFile());
    }

    static HttpResponse<byte[]> request(byte[] content, String target) throws Exception {
        String base = System.getenv().getOrDefault("BASE_URL", "http://localhost:8091");
        String payload =
                JSON.writeValueAsString(
                        Map.of(
                                "contentToValidate",
                                Base64.getEncoder().encodeToString(content),
                                "embeddingMethod",
                                "BASE64",
                                "validationType",
                                target));
        return HTTP.send(
                HttpRequest.newBuilder(
                                URI.create(base.replaceAll("/$", "") + "/rest/cda-dk/api/validate"))
                        .timeout(Duration.ofSeconds(240))
                        .header("Content-Type", "application/json")
                        .header("Accept", "application/xml")
                        .POST(HttpRequest.BodyPublishers.ofString(payload))
                        .build(),
                HttpResponse.BodyHandlers.ofByteArray());
    }

    static Document validate(byte[] content, String target) throws Exception {
        HttpResponse<byte[]> response = request(content, target);
        org.junit.jupiter.api.Assertions.assertEquals(
                200, response.statusCode(), "Validator HTTP status");
        String reports = System.getenv("VALIDATION_REPORT_DIR");
        if (reports != null) {
            Path directory = Files.createDirectories(Path.of(reports));
            Files.write(Files.createTempFile(directory, target + "-", ".xml"), response.body());
        }
        return parse(response.body());
    }

    static Document parse(byte[] xml) throws Exception {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
        return factory.newDocumentBuilder().parse(new ByteArrayInputStream(xml));
    }

    static Document document(String file) throws Exception {
        return parse(Files.readAllBytes(ROOT.resolve(file)));
    }

    static byte[] bytes(Node node) throws Exception {
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        TransformerFactory.newInstance()
                .newTransformer()
                .transform(new DOMSource(node), new StreamResult(output));
        return output.toByteArray();
    }

    // XPath names refer to the CDA namespace; TAR queries use explicit local-name predicates.
    static List<Element> nodes(Node root, String expression) throws Exception {
        String xpath =
                expression.replaceAll(
                        "c:([A-Za-z][A-Za-z0-9]*)",
                        "*[local-name()='$1' and namespace-uri()='urn:hl7-org:v3']");
        NodeList result =
                (NodeList)
                        XPathFactory.newInstance()
                                .newXPath()
                                .evaluate(xpath, root, XPathConstants.NODESET);
        List<Element> elements = new ArrayList<>();
        for (int i = 0; i < result.getLength(); i++) elements.add((Element) result.item(i));
        return elements;
    }

    static Element node(Node root, String expression) throws Exception {
        List<Element> matches = nodes(root, expression);
        if (matches.isEmpty()) throw new AssertionError("Missing fixture node: " + expression);
        return matches.get(0);
    }

    static String text(Node root, String name) throws Exception {
        List<Element> matches = nodes(root, "./*[local-name()='" + name + "']");
        return matches.isEmpty() ? "" : matches.get(0).getTextContent();
    }

    static List<Element> findings(Document report) throws Exception {
        return nodes(report, "/*/*[local-name()='reports']/*");
    }

    static void requireRule(byte[] content, String target, String rule) throws Exception {
        Document report = validate(content, target);
        for (Element finding : findings(report)) {
            if (List.of("error", "warning").contains(finding.getLocalName())
                    && List.of(text(finding, "assertionID").split("/")).contains(rule)) return;
        }
        throw new AssertionError("Missing expected finding " + rule + " for " + target);
    }

    static Map<String, Object> summary(Document report) throws Exception {
        Element root = report.getDocumentElement();
        Element counters = node(root, "./*[local-name()='counters']");
        return Map.of(
                "result",
                text(root, "result"),
                "errors",
                Integer.parseInt(text(counters, "nrOfErrors")),
                "warnings",
                Integer.parseInt(text(counters, "nrOfWarnings")));
    }

    static String sha256(byte[] bytes) throws Exception {
        StringBuilder hex = new StringBuilder();
        for (byte value : MessageDigest.getInstance("SHA-256").digest(bytes))
            hex.append(String.format("%02x", value & 255));
        return hex.toString();
    }

    static void saveExample(JsonNode sample, Document report) throws Exception {
        String directory = System.getenv("EXAMPLE_RESULTS_DIR");
        if (directory == null) return;
        Map<String, Object> result = new LinkedHashMap<>(summary(report));
        String file = sample.get("file").asText();
        String target = sample.get("validationType").asText();
        result.put("file", file);
        result.put("validationType", target);
        result.put("validatedAt", Instant.now().toString());
        result.put("resourceSha256", System.getenv("VALIDATOR_RESOURCE_SHA256"));
        result.put("sha256", sha256(Files.readAllBytes(ROOT.resolve(file))));
        List<Map<String, String>> findings = new ArrayList<>();
        for (Element finding : findings(report)) {
            if (!List.of("error", "warning").contains(finding.getLocalName())) continue;
            findings.add(
                    Map.of(
                            "severity",
                            finding.getLocalName(),
                            "rule",
                            text(finding, "assertionID"),
                            "message",
                            text(finding, "description"),
                            "location",
                            text(finding, "location"),
                            "test",
                            text(finding, "test")));
        }
        result.put("findings", findings);
        Path output =
                Files.createDirectories(Path.of(directory))
                        .resolve(
                                sha256((target + ":" + file).getBytes(StandardCharsets.UTF_8))
                                        + ".json");
        JSON.writerWithDefaultPrettyPrinter().writeValue(output.toFile(), result);
    }
}
