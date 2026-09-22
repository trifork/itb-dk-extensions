package com.trifork.ihexdsapi.gitb;

import com.trifork.ihexdsapi.service.*;
import java.nio.file.*;
import java.util.*;
import org.openapitools.model.*;
import org.openehealth.ipf.commons.ihe.xds.core.responses.*;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.*;

/** Synthetic ITB fixture. Compiled only into test output, never into the production application. */
public final class FixtureApplication {
    private FixtureApplication() {}

    public static void main(String[] args) {
        SpringApplication.run(Configuration.class, args);
    }

    @TestConfiguration
    @EnableAutoConfiguration
    @Import({GitbConfiguration.class, ReadinessController.class})
    public static class Configuration {
        @Bean
        XdsOperations fixtureOperations() {
            return new Operations();
        }
    }

    private static final class Operations implements XdsOperations {
        public List<RegistryRouting.Choice> registries() {
            return List.of(
                    new RegistryRouting.Choice("one", "Synthetic registry One"),
                    new RegistryRouting.Choice("two", "Synthetic registry Two"));
        }

        private static void registry(String id, String patient) {
            if (!Set.of("one", "two").contains(id)
                    || ("0000000010".equals(patient) && !"two".equals(id)))
                throw new IllegalArgumentException("Wrong fixture registry");
        }

        public List<CredentialInfoResponse> identities() {
            try {
                return Arrays.asList(
                        GitbXdsAccess.JSON.readValue(
                                """
                [{"id":"test-professional","displayName":"Synthetic test professional","credentialType":"HEALTHCAREPROFESSIONAL","certificateKind":"MOCES","validUntil":"2099-01-01T00:00:00Z"},
                 {"id":"expired-professional","displayName":"Expired fixture","credentialType":"HEALTHCAREPROFESSIONAL","certificateKind":"MOCES","validUntil":"2000-01-01T00:00:00Z"},
                 {"id":"test-system","displayName":"System fixture","credentialType":"SYSTEM","certificateKind":"FOCES","validUntil":"2099-01-01T00:00:00Z"}]
                """,
                                CredentialInfoResponse[].class));
            } catch (Exception e) {
                throw new IllegalStateException(e);
            }
        }

        public List<Code> codes(boolean format) {
            return List.of(
                    new Code().name("PHMR test code").code("test-code").scheme("test-scheme"),
                    new Code()
                            .name("Second test code")
                            .code("second-code")
                            .scheme("second-scheme"));
        }

        private static void context(String credential, HealthcareProfessionalContext context) {
            if (!"test-professional".equals(credential)
                    || !Boolean.FALSE.equals(context.getConsentOverride()))
                throw new IllegalArgumentException("Unexpected fixture context");
        }

        public QueryResponse search(Iti18Request request)
                throws com.trifork.ihexdsapi.dgws.DgwsSecurityException {
            context(request.getCredentialId(), request.getContext());
            var q = request.getQueryParameters();
            registry(request.getRegistryId(), q.getPatientId());
            String patient = q.getPatientId();
            if (!"Approved".equals(q.getAvailabilityStatus())
                    || !q.getDocumentType().toString().equals("[STABLE]"))
                throw new IllegalArgumentException("Unexpected query defaults");
            if (patient.equals("0000000004"))
                throw new com.trifork.ihexdsapi.dgws.DgwsSecurityException(
                        1000, "synthetic-access-error");
            if (patient.equals("0000000008"))
                throw new IllegalStateException(
                        "synthetic-private-context XDSUnavailableCommunity");
            if (patient.equals("0000000002") || patient.equals("0000000007")) {
                var response = new QueryResponse();
                response.getErrors()
                        .add(
                                FixtureData.error(
                                        patient.endsWith("7")
                                                ? ErrorCode.REGISTRY_BUSY
                                                : ErrorCode._USER_DEFINED,
                                        "synthetic-private-context",
                                        false));
                return response;
            }
            if (patient.equals("0000000005")) {
                var actual = GitbXdsAccess.JSON.valueToTree(q);
                for (String field : List.of("typeCodes", "formatCodes")) {
                    var list = actual.path(field);
                    if (list.size() != 2
                            || !list.get(0).path("code").asText().equals("test-code")
                            || !list.get(1).path("codeScheme").asText().equals("second-scheme"))
                        throw new IllegalArgumentException("Multi-code filter lost");
                }
            }
            var docs =
                    new ArrayList<>(
                            patient.equals("0000000000")
                                    ? List.<String>of()
                                    : List.of("phmr-2.1.0"));
            if (patient.equals("2512489996")) docs.add("phmr-1.3");
            if (patient.equals("0000000003")) docs = new ArrayList<>(List.of("non-cda"));
            if (patient.equals("0000000009"))
                docs = new ArrayList<>(List.of("phmr-prodtest", "phmr-test2", "phmr-unknown"));
            var value = GitbXdsAccess.JSON.createObjectNode();
            var rows = value.putArray("queryResponse");
            for (String doc : docs)
                rows.addObject()
                        .put("patientId", patient)
                        .put("documentId", doc)
                        .put("repositoryID", repository(patient, doc))
                        .put("documentType", "Personal Health Monitoring Report")
                        .put("serviceStart", 1704067200000L)
                        .put("serviceEnd", 1704153600000L);
            return FixtureData.search(value);
        }

        private static String repository(String patient, String doc) {
            if (patient.equals("0000000006")) return "1.2.208.176.43210.8.1.30";
            if (patient.equals("0000000009"))
                return switch (doc) {
                    case "phmr-prodtest" -> "1.2.208.176.43210.8.1.30";
                    case "phmr-test2" -> "1.2.208.176.43210.8.1.29";
                    default -> "2.999.1";
                };
            return "mock-repository";
        }

        private static byte[] readBytes(Path path) {
            try {
                return Files.readAllBytes(path);
            } catch (java.io.IOException e) {
                throw new java.io.UncheckedIOException(e);
            }
        }

        public RetrievedBytes retrieve(Iti43Request request) {
            context(request.getCredentialId(), request.getContext());
            var q = request.getQueryParameters();
            registry(request.getRegistryId(), q.getPatientId());
            if (!q.getRepositoryId().equals(repository(q.getPatientId(), q.getDocumentId())))
                throw new IllegalArgumentException("Wrong repository");
            if (q.getPatientId().equals("0000000006"))
                return new RetrievedBytes(
                        null,
                        List.of(
                                FixtureData.error(
                                        ErrorCode.UNAVAILABLE_COMMUNITY,
                                        "synthetic-private-context",
                                        false)));
            byte[] bytes =
                    q.getDocumentId().equals("non-cda")
                            ? "<html/>".getBytes(java.nio.charset.StandardCharsets.UTF_8)
                            : readBytes(
                                    Path.of(
                                            System.getenv()
                                                    .getOrDefault("FIXTURE_SAMPLES", "/samples"),
                                            "phmr",
                                            q.getDocumentId().equals("phmr-1.3")
                                                    ? "phmr_v1_3_weight.xml"
                                                    : "phmr_example01.xml"));
            return new RetrievedBytes(bytes, List.of());
        }
    }
}
