package com.trifork.ihexdsapi.gitb;

import com.fasterxml.jackson.databind.JsonNode;
import com.gitb.core.AnyContent;
import com.gitb.core.ValueEmbeddingEnumeration;
import com.gitb.ps.*;
import com.gitb.tr.*;
import com.trifork.ihexdsapi.service.CdaMetadata;
import com.trifork.ihexdsapi.xds.QueryDates;
import jakarta.jws.WebService;
import java.io.ByteArrayInputStream;
import java.time.*;
import java.util.*;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.parsers.DocumentBuilderFactory;

@WebService(
        endpointInterface = "com.gitb.ps.ProcessingService",
        targetNamespace = "http://www.gitb.com/ps/v1/",
        serviceName = "ProcessingServiceService",
        portName = "ProcessingServicePort")
public class XdsProcessingService implements ProcessingService {
    private static final String PHMR_NAME = "Personal Health Monitoring Report";
    private static final String RETRIEVE_OPERATION = "retrieve";
    private static final String DOCUMENT_LOG = "retrievedDocumentLog";
    private static final String STRING = "string";
    private static final String TYPE_CODE = "typeCode";
    private static final String FORMAT_CODE = "formatCode";
    private static final String INPUT_ERROR = "XDS-INPUT";
    private static final String RESPONSE_ERROR = "XDS-RESPONSE";
    private static final String CODE = "code";
    private static final String PATIENT_ID = "patientId";
    private static final String DOCUMENT_ID = "documentId";
    private static final String REPOSITORY_ID = "repositoryID";
    private static final String HOME_COMMUNITY_ID = "homeCommunityId";
    private static final String ALL_REPOSITORIES = "All repositories";
    private static final String LABEL_SEPARATOR = " | ";
    private static final int MAX_CODES = 50;
    private static final int SINGLE_CODE_COUNT = 1;
    private static final String SCHEME = "scheme";
    private static final String REPOSITORIES = "repositories";
    private static final String REGISTRY = "registry";
    private static final String REGISTRY_LABEL = "Registry";
    private static final String DOCUMENT_TYPE = "documentType";
    private static final String DOCUMENT_FIELD = "document";
    private static final String ENTRY_UUID = "entryUuid";
    private static final String UPLOAD_TEXT = "documentText";
    private final GitbXdsAccess client;
    private final String role;
    private final String authorizationCode;
    private final Clock clock;
    private final Map<String, Session> sessions = new HashMap<>();
    private static final Duration TTL = Duration.ofMinutes(30);
    private static final int MAX_SESSIONS = 256;
    private static final int MAX_RESULTS = 500;

    XdsProcessingService(GitbXdsAccess client, String role, String authorizationCode, Clock clock) {
        this.client = client;
        this.role = role;
        this.authorizationCode = authorizationCode;
        this.clock = clock;
    }

    private static final class Session {
        Instant expires;
        final Map<String, SigningIdentity> credentials = new LinkedHashMap<>();
        final Set<String> stamkortRegistries = new HashSet<>();
        final Map<String, String> registries = new LinkedHashMap<>();
        final Map<String, String> registrySelections = new LinkedHashMap<>();
        final Map<String, JsonNode> types = new LinkedHashMap<>();
        final Map<String, JsonNode> formats = new LinkedHashMap<>();
        final Map<String, JsonNode> documents = new LinkedHashMap<>();
        final Map<String, String> professionalSelections = new LinkedHashMap<>();
        final Map<String, String> typeSelections = new LinkedHashMap<>();
        final Map<String, String> formatSelections = new LinkedHashMap<>();
        final Map<String, String> documentSelections = new LinkedHashMap<>();
        final Map<String, String> repositories = new LinkedHashMap<>();
        final Map<String, String> repositorySelections = new LinkedHashMap<>();
        final Map<String, Integer> documentNumbers = new LinkedHashMap<>();
        final Set<String> visibleDocuments = new LinkedHashSet<>();
        boolean searched;
        final Set<String> submitRegistries = new HashSet<>();
        final Set<String> deprecateRegistries = new HashSet<>();
        Upload upload = Upload.NONE;
        Submitted submitted = Submitted.NONE;
        Map<String, Object> context;
        String patient;
        String credential;
        String registry;
        String registryLabel;
    }

    /**
     * The one document an ITB session has stored, so the optional deprecation can find it again.
     */
    private record Submitted(
            String patient,
            String uniqueId,
            String registry,
            String registryLabel,
            String credential) {
        static final Submitted NONE = new Submitted("", "", "", "", "");

        boolean present() {
            return !uniqueId.isEmpty();
        }
    }

    /** A CDA read for upload. {@link #NONE} stands for "nothing prepared yet". */
    private static final class Upload {
        static final Upload NONE = new Upload(new byte[0], null);
        private final byte[] content;
        private final CdaMetadata header;

        Upload(byte[] content, CdaMetadata header) {
            this.content = content.clone();
            this.header = header;
        }

        byte[] bytes() {
            return content.clone();
        }

        CdaMetadata metadata() {
            return header;
        }

        boolean present() {
            return header != null;
        }
    }

    @Override
    public GetModuleDefinitionResponse getModuleDefinition(com.gitb.ps.Void input) {
        return new GetModuleDefinitionResponse();
    }

    @Override
    public synchronized BeginTransactionResponse beginTransaction(BeginTransactionRequest input) {
        sessions.values().removeIf(s -> !s.expires.isAfter(clock.instant()));
        if (sessions.size() >= MAX_SESSIONS)
            throw new jakarta.xml.ws.WebServiceException("XDS is busy. Retry later.");
        String id = UUID.randomUUID().toString();
        var s = new Session();
        s.expires = clock.instant().plus(TTL);
        sessions.put(id, s);
        var response = new BeginTransactionResponse();
        response.setSessionId(id);
        return response;
    }

    @Override
    public synchronized com.gitb.ps.Void endTransaction(BasicRequest input) {
        sessions.remove(input.getSessionId());
        return new com.gitb.ps.Void();
    }

    @Override
    public ProcessResponse process(ProcessRequest input) {
        var response = new ProcessResponse();
        if (RETRIEVE_OPERATION.equals(input.getOperation())) {
            response.getOutput()
                    .add(value(DOCUMENT_LOG, STRING, "No retrieved document bytes are available."));
        }
        try {
            Session session;
            synchronized (this) {
                session = sessions.get(input.getSessionId());
                if (session == null || !session.expires.isAfter(clock.instant())) {
                    sessions.remove(input.getSessionId());
                    throw new XdsFailure(
                            "XDS-EXPIRED",
                            "The XDS search expired. Start a new test session (searches expire after 30 minutes).");
                }
                session.expires = clock.instant().plus(TTL);
            }
            Map<String, String> values = new HashMap<>();
            for (AnyContent item : input.getInput()) {
                int limit = inputLimit(item.getName());
                if (item.getValue() != null && item.getValue().length() > limit)
                    throw new XdsFailure(INPUT_ERROR, "An XDS input is too long.");
                values.put(item.getName(), item.getValue() == null ? "" : item.getValue().trim());
            }
            synchronized (session) {
                switch (Objects.toString(input.getOperation(), "")) {
                    case "choices" -> choices(session, response);
                    case "queryChoices" -> queryChoices(session, values, response);
                    case "search" -> search(session, values, response);
                    case "filter" -> filter(session, values, response);
                    case RETRIEVE_OPERATION -> retrieve(session, values, response);
                    case "prepareUpload" -> prepareUpload(session, values, response);
                    case "submit" -> submit(session, values, response);
                    case "deprecate" -> deprecate(session, response);
                    default -> throw new XdsFailure(INPUT_ERROR, "Unsupported XDS operation.");
                }
            }
            finishReport(response, null);
        } catch (XdsFailure failure) {
            failed(response, failure);
        } catch (RuntimeException _) {
            // Do not propagate upstream payloads, credentials or patient details to SOAP
            // faults/logs.
            failed(
                    response,
                    new XdsFailure(RESPONSE_ERROR, "XDS returned an unexpected response."));
        }
        return response;
    }

    private static int inputLimit(String name) {
        if (REPOSITORIES.equals(name)) return 131072;
        // An uploaded CDA arrives Base64-encoded (4/3 of 10 MiB); pasted text is limited to 10 MiB.
        if (DOCUMENT_FIELD.equals(name)) return 14 * 1024 * 1024 + 4;
        if (UPLOAD_TEXT.equals(name)) return CdaMetadata.MAX_BYTES;
        if (Set.of(TYPE_CODE, FORMAT_CODE).contains(Objects.toString(name, ""))) return 4096;
        return 1024;
    }

    private static void failed(ProcessResponse response, XdsFailure failure) {
        // Keep the explicitly requested document diagnostics even when CDA parsing fails.
        response.getOutput().removeIf(item -> !DOCUMENT_LOG.equals(item.getName()));
        finishReport(response, failure);
        // Error messages never include backend HTTP/SOAP bodies or security material.
        response.getOutput().add(value("errorCode", STRING, failure.code));
        response.getOutput().add(value("errorMessage", STRING, failure.getMessage()));
    }

    private static void finishReport(ProcessResponse response, XdsFailure failure) {
        var completed = report(failure);
        if (response.getReport() != null) completed.setContext(response.getReport().getContext());
        response.setReport(completed);
    }

    private void choices(Session s, ProcessResponse out) {
        s.credentials.clear();
        s.types.clear();
        s.formats.clear();
        clearResults(s);
        s.registries.clear();
        s.stamkortRegistries.clear();
        s.submitRegistries.clear();
        s.deprecateRegistries.clear();
        JsonNode registries = client.registries();
        if (!registries.isArray() || registries.isEmpty())
            throw new XdsFailure(RESPONSE_ERROR, "No XDS registries are configured.");
        for (JsonNode registry : registries) {
            if (registry.path("stamkort").asBoolean())
                s.stamkortRegistries.add(required(registry, "id"));
            if (registry.path("canSubmit").asBoolean())
                s.submitRegistries.add(required(registry, "id"));
            if (registry.path("canDeprecate").asBoolean())
                s.deprecateRegistries.add(required(registry, "id"));
            if (s.registries.put(required(registry, "id"), required(registry, "name")) != null)
                throw new XdsFailure(RESPONSE_ERROR, "Duplicate XDS registry IDs are configured.");
        }
        selectionLabels(s.registrySelections, s.registries, name -> name);
        list(out, "registryLabels", s.registrySelections.keySet());
        out.getOutput()
                .add(value("registryCount", "number", Integer.toString(s.registries.size())));
        out.getOutput()
                .add(
                        value(
                                "defaultRegistry",
                                STRING,
                                s.registrySelections.keySet().iterator().next()));
        JsonNode credentials = client.identities();
        if (!credentials.isArray())
            throw new XdsFailure(RESPONSE_ERROR, "Invalid signing identity list from XDS.");
        for (JsonNode credential : credentials) {
            String id = required(credential, "id");
            required(credential, "displayName");
            s.credentials.put(id, SigningIdentity.from(credential));
        }
        if (s.credentials.isEmpty())
            throw new XdsFailure("XDS-ACCESS", "No signing credentials are configured in XDS.");
        codes(s.types, TYPE_CODE);
        codes(s.formats, FORMAT_CODE);
        selectionLabels(
                s.professionalSelections,
                s.credentials,
                identity -> identity.label(clock.instant()));
        var labels = s.professionalSelections.keySet();
        list(out, "professionals", s.credentials.keySet());
        list(out, "professionalLabels", labels);
        codeLists(out, "type", s.types, s.typeSelections);
        codeLists(out, "format", s.formats, s.formatSelections);
        list(out, "entryTypeLabels", XdsDocumentEntryTypes.labels());
        out.getOutput()
                .add(
                        value(
                                "defaultEntryTypes",
                                STRING,
                                String.join(",", XdsDocumentEntryTypes.labels())));
        var context = new AnyContent();
        context.getItem()
                .add(
                        value(
                                "Configured registries",
                                STRING,
                                String.join("\n", s.registrySelections.keySet())));
        context.getItem()
                .add(
                        value(
                                "Signing identities (" + s.credentials.size() + ")",
                                STRING,
                                String.join("\n", labels)));
        context.getItem().add(value("Configured role", STRING, role));
        context.getItem()
                .add(
                        value(
                                "Professional authorisation",
                                STRING,
                                authorizationCode.isBlank()
                                        ? "Not configured"
                                        : authorizationCode));
        context.getItem().add(value("Document type filters", STRING, describeCodes(s.types)));
        context.getItem().add(value("Document format filters", STRING, describeCodes(s.formats)));
        context.getItem()
                .add(
                        value(
                                "Search defaults",
                                STRING,
                                "Approved, stable and on-demand documents; consent override disabled. Any means no filter on that code."));
        context.getItem()
                .add(
                        value(
                                "What this step checked",
                                STRING,
                                "The backend returned its configured signing identities and search codes. STS authentication and DDS access are checked when you submit a search. No patient search has run yet."));
        var details = new TAR();
        details.setContext(context);
        out.setReport(details);
    }

    private static String describeCodes(Map<String, JsonNode> codes) {
        var lines = new ArrayList<String>();
        lines.add("Any — no filter");
        codes.values()
                .forEach(
                        code ->
                                lines.add(
                                        code.path("name").asText()
                                                + " ("
                                                + code.path(CODE).asText()
                                                + "; scheme: "
                                                + code.path(SCHEME).asText()
                                                + ")"));
        return String.join("\n", lines);
    }

    private void codes(Map<String, JsonNode> target, String kind) {
        var codes = client.codes(kind);
        if (!codes.isArray()) throw new XdsFailure(RESPONSE_ERROR, "Invalid code list from XDS.");
        for (JsonNode code : codes) {
            if (!code.path(CODE).asText().isBlank()) target.put(UUID.randomUUID().toString(), code);
        }
    }

    private static void codeLists(
            ProcessResponse out,
            String prefix,
            Map<String, JsonNode> codes,
            Map<String, String> selections) {
        selectionLabels(
                selections,
                codes,
                node ->
                        node.path("name").asText()
                                + " ("
                                + node.path(CODE).asText()
                                + "; scheme: "
                                + node.path(SCHEME).asText()
                                + ")");
        var ids = new ArrayList<String>();
        var labels = new ArrayList<String>();
        ids.add("any");
        labels.add("Any");
        ids.addAll(codes.keySet());
        labels.addAll(selections.keySet());
        list(out, prefix + "Codes", ids);
        list(out, prefix + "Labels", labels);
    }

    private static <T> void selectionLabels(
            Map<String, String> selections,
            Map<String, T> choices,
            java.util.function.Function<T, String> describe) {
        selections.clear();
        choices.forEach(
                (id, value) -> {
                    String label = displayLabel(describe.apply(value));
                    String unique = label;
                    for (int number = 2; selections.containsKey(unique); number++)
                        unique = label + " [" + number + "]";
                    selections.put(unique, id);
                });
    }

    private static void selectRegistry(Session s, Map<String, String> v) {
        String selectedRegistry = v.getOrDefault(REGISTRY, "");
        s.registry = s.registrySelections.getOrDefault(selectedRegistry, selectedRegistry);
        if (s.registry.isBlank() && s.registries.size() == 1)
            s.registry = s.registries.keySet().iterator().next();
        if (!s.registries.containsKey(s.registry))
            throw new XdsFailure(INPUT_ERROR, "Choose a configured XDS registry.");
        s.registryLabel =
                s.registrySelections.entrySet().stream()
                        .filter(entry -> entry.getValue().equals(s.registry))
                        .findFirst()
                        .orElseThrow()
                        .getKey();
    }

    private void queryChoices(Session s, Map<String, String> v, ProcessResponse out) {
        selectRegistry(s, v);
        boolean stamkort = s.stamkortRegistries.contains(s.registry);
        out.getOutput().add(value("stamkort", "boolean", Boolean.toString(stamkort)));
        list(out, "professionalLabels", s.professionalSelections.keySet());
        String preferred = "";
        for (var entry : s.professionalSelections.entrySet()) {
            var identity = s.credentials.get(entry.getValue());
            boolean eligible =
                    stamkort
                            ? identity.currentSystem(clock.instant())
                            : identity.currentEmployee(clock.instant());
            if (eligible) {
                boolean preferredKind = !stamkort || "FOCES".equals(identity.kind());
                if (preferred.isEmpty() || preferredKind) preferred = entry.getKey();
                if (preferredKind) break;
            }
        }
        out.getOutput().add(value("defaultProfessional", STRING, preferred));
        codeLists(out, "format", stamkort ? stamkortFormats(s) : s.formats, s.formatSelections);
    }

    private static Map<String, JsonNode> stamkortFormats(Session s) {
        Map<String, JsonNode> result = new LinkedHashMap<>();
        s.formats.forEach(
                (id, code) -> {
                    if (code.path(CODE).asText().startsWith("urn:ad:dk:medcom:pdc-v")
                            && "1.2.208.184.100.10".equals(code.path(SCHEME).asText()))
                        result.put(id, code);
                });
        return result;
    }

    private void search(Session s, Map<String, String> v, ProcessResponse out) {
        clearResults(s); // Old handles must never survive a new search, even a failed one.
        selectRegistry(s, v);
        var searchReport = new TAR();
        searchReport.setContext(new AnyContent());
        searchReport.getContext().getItem().add(value(REGISTRY_LABEL, STRING, s.registryLabel));
        out.setReport(searchReport);
        String patient = v.getOrDefault(PATIENT_ID, "");
        if (!patient.matches("\\d{10}"))
            throw new XdsFailure(
                    INPUT_ERROR, "Enter a ten-digit test CPR, without spaces or a hyphen.");
        String selectedProfessional = v.getOrDefault("professional", "");
        String credential =
                s.professionalSelections.getOrDefault(selectedProfessional, selectedProfessional);
        if (!s.credentials.containsKey(credential))
            throw new XdsFailure(INPUT_ERROR, "Choose a configured signing identity.");
        boolean stamkort = s.stamkortRegistries.contains(s.registry);
        s.credentials.get(credential).requireSearchIdentity(clock.instant(), stamkort);
        Map<String, Object> query = new LinkedHashMap<>();
        query.put(PATIENT_ID, patient);
        query.put("availabilityStatus", "Approved");
        if (stamkort) {
            query.put(DOCUMENT_TYPE, List.of("ON-DEMAND"));
            query.put(TYPE_CODE, Map.of(CODE, "PDC", "codeScheme", "1.2.208.184.100.1"));
            putCode(query, FORMAT_CODE, v.get(FORMAT_CODE), stamkortFormats(s), s.formatSelections);
        } else {
            query.put(DOCUMENT_TYPE, XdsDocumentEntryTypes.select(v.get("entryTypes")));
            putCode(query, TYPE_CODE, v.get(TYPE_CODE), s.types, s.typeSelections);
            putCode(query, FORMAT_CODE, v.get(FORMAT_CODE), s.formats, s.formatSelections);
            dates(query, v, "startFromDate", "startToDate");
            dates(query, v, "endFromDate", "endToDate");
        }
        s.patient = patient;
        s.credential = credential;
        s.context = newContext();
        JsonNode rows = client.search(envelope(s, query));
        if (!rows.isArray())
            throw new XdsFailure(RESPONSE_ERROR, "XDS did not return a document list.");
        String uniqueId = stamkort ? "" : v.getOrDefault("uniqueId", "");
        for (JsonNode row : rows) {
            String document = required(row, DOCUMENT_ID);
            required(row, REPOSITORY_ID);
            if (!patient.equals(required(row, PATIENT_ID)))
                throw new XdsFailure(RESPONSE_ERROR, "XDS returned an unexpected patient context.");
            if (!uniqueId.isEmpty() && !uniqueId.equals(document)) continue;
            if (s.documents.size() >= MAX_RESULTS) {
                s.documents.clear();
                throw new XdsFailure(
                        "XDS-RESULT-LIMIT",
                        "More than 500 results. Narrow the search using type, dates or Unique ID.");
            }
            String handle = UUID.randomUUID().toString();
            s.documents.put(handle, row);
            s.documentNumbers.put(handle, s.documents.size());
        }
        var counts = new LinkedHashMap<String, Integer>();
        s.documents
                .values()
                .forEach(row -> counts.merge(required(row, REPOSITORY_ID), 1, Integer::sum));
        counts.keySet()
                .forEach(
                        repository -> s.repositories.put(UUID.randomUUID().toString(), repository));
        selectionLabels(
                s.repositorySelections,
                s.repositories,
                repository ->
                        XdsRepositories.shortLabel(repository)
                                + " — "
                                + counts.get(repository)
                                + " document(s) | "
                                + XdsRepositories.describe(repository));
        s.searched = true;
        presentResults(s, s.documents, ALL_REPOSITORIES, out);
    }

    // The CDA parser's message is curated and safe; its cause is dropped so no content can leak.
    @SuppressWarnings("PMD.PreserveStackTrace")
    private void prepareUpload(Session s, Map<String, String> v, ProcessResponse out) {
        byte[] bytes;
        String encoded = v.getOrDefault(DOCUMENT_FIELD, "");
        if (!encoded.isEmpty()) {
            try {
                bytes = Base64.getMimeDecoder().decode(encoded);
            } catch (IllegalArgumentException _) {
                throw new XdsFailure(INPUT_ERROR, "The uploaded file could not be read.");
            }
        } else if (!v.getOrDefault(UPLOAD_TEXT, "").isEmpty()) {
            bytes = v.get(UPLOAD_TEXT).getBytes(java.nio.charset.StandardCharsets.UTF_8);
        } else {
            throw new XdsFailure(INPUT_ERROR, "Upload a CDA file or paste the CDA contents.");
        }
        s.upload = Upload.NONE;
        s.submitted = Submitted.NONE;
        CdaMetadata metadata;
        try {
            metadata = CdaMetadata.parse(bytes);
        } catch (IllegalArgumentException e) {
            throw new XdsFailure("XDS-CONTENT", e.getMessage() + " Nothing was uploaded.");
        }
        s.upload = new Upload(bytes, metadata);
        // ITB shows an instruction as one block of text and collapses line breaks, so each field is
        // also returned on its own for the test to show as separate, labelled lines.
        var fields = new LinkedHashMap<String, String>();
        fields.put("uploadPatient", metadata.patientId());
        fields.put("uploadId", metadata.uniqueId());
        fields.put("uploadType", metadata.typeCode() + " (scheme " + metadata.typeScheme() + ")");
        fields.put("uploadTitle", metadata.title().isEmpty() ? "-" : metadata.title());
        fields.put(
                "uploadCreated",
                metadata.creationTime().isEmpty() ? "now" : metadata.creationTime());
        fields.put("uploadSize", bytes.length + " bytes");
        fields.forEach((name, text) -> out.getOutput().add(value(name, STRING, text)));
        String summary =
                "Patient (CPR): "
                        + fields.get("uploadPatient")
                        + "\nDocument unique ID: "
                        + fields.get("uploadId")
                        + "\nType code: "
                        + fields.get("uploadType")
                        + "\nTitle: "
                        + fields.get("uploadTitle")
                        + "\nCreated: "
                        + fields.get("uploadCreated")
                        + "\nSize: "
                        + fields.get("uploadSize");
        out.getOutput().add(value("uploadSummary", STRING, summary));
        out.getOutput().add(value(PATIENT_ID, STRING, metadata.patientId()));
        out.getOutput().add(value("uploadFormatDefault", STRING, defaultFormatLabel(s, metadata)));
        list(out, "uploadFormatLabels", s.formatSelections.keySet());
        var context = new AnyContent();
        context.getItem().add(value("Upload", STRING, summary));
        var report = new TAR();
        report.setContext(context);
        out.setReport(report);
    }

    /** CDA types with one obvious MedCom format; for any other type the user must choose. */
    private static String defaultFormatLabel(Session s, CdaMetadata metadata) {
        String wanted =
                switch (metadata.typeCode()) {
                    case "74468-0" -> "urn:ad:dk:medcom:qfdd-v1.2:full";
                    case "74465-6" -> "urn:ad:dk:medcom:qrd-v1.3";
                    case "53576-5" -> "urn:ad:dk:medcom:phmr-v2.1:full";
                    default -> "";
                };
        for (var entry : s.formatSelections.entrySet()) {
            var code = s.formats.get(entry.getValue());
            if (code != null && wanted.equals(code.path(CODE).asText())) return entry.getKey();
        }
        return "";
    }

    private void submit(Session s, Map<String, String> v, ProcessResponse out) {
        if (!s.upload.present())
            throw new XdsFailure("XDS-STATE", "Provide a CDA before uploading it.");
        selectRegistry(s, v);
        var report = new TAR();
        report.setContext(new AnyContent());
        report.getContext().getItem().add(value(REGISTRY_LABEL, STRING, s.registryLabel));
        out.setReport(report);
        if (s.stamkortRegistries.contains(s.registry) || !s.submitRegistries.contains(s.registry))
            throw new XdsFailure(
                    INPUT_ERROR,
                    "Upload (ITI-41) is not enabled for this registry. Choose a DDS registry that has an ITI-41 endpoint configured.");
        String selectedProfessional = v.getOrDefault("professional", "");
        String credential =
                s.professionalSelections.getOrDefault(selectedProfessional, selectedProfessional);
        if (!s.credentials.containsKey(credential))
            throw new XdsFailure(INPUT_ERROR, "Choose a configured signing identity.");
        s.credentials.get(credential).requireSearchIdentity(clock.instant(), false);
        String selectedFormat = v.getOrDefault(FORMAT_CODE, "");
        String formatId = s.formatSelections.get(selectedFormat);
        JsonNode format = formatId == null ? null : s.formats.get(formatId);
        if (format == null)
            throw new XdsFailure(INPUT_ERROR, "Choose a format code for the upload.");
        CdaMetadata metadata = s.upload.metadata();
        s.patient = metadata.patientId();
        s.credential = credential;
        s.context = newContext();
        Map<String, Object> submission = new LinkedHashMap<>();
        submission.put(FORMAT_CODE, format.path(CODE).asText());
        submission.put("documentBase64", Base64.getEncoder().encodeToString(s.upload.bytes()));
        client.submit(envelope(s, submission));
        s.submitted =
                new Submitted(
                        s.patient, metadata.uniqueId(), s.registry, s.registryLabel, credential);
        out.getOutput().add(value("submittedUniqueId", STRING, metadata.uniqueId()));
        out.getOutput().add(value(PATIENT_ID, STRING, s.patient));
        s.upload = Upload.NONE; // The bytes are no longer needed; do not keep them for the session
        // TTL.
    }

    private void deprecate(Session s, ProcessResponse out) {
        Submitted done = s.submitted;
        if (!done.present())
            throw new XdsFailure(
                    "XDS-STATE",
                    "No document has been uploaded in this session, so there is nothing to deprecate.");
        s.registry = done.registry();
        s.registryLabel = done.registryLabel();
        s.patient = done.patient();
        s.credential = done.credential();
        s.context = newContext();
        var report = new TAR();
        report.setContext(new AnyContent());
        report.getContext().getItem().add(value(REGISTRY_LABEL, STRING, s.registryLabel));
        out.setReport(report);
        if (!s.deprecateRegistries.contains(s.registry))
            throw new XdsFailure(
                    INPUT_ERROR,
                    "Deprecation (ITI-57) is not enabled for this registry. Ask the operator to configure its ITI-57 endpoint.");
        // The registry's own entry UUID is needed, so look the document up again rather than assume
        // it.
        Map<String, Object> query = new LinkedHashMap<>();
        query.put(PATIENT_ID, s.patient);
        query.put("availabilityStatus", "Approved");
        query.put(DOCUMENT_TYPE, List.of("STABLE"));
        JsonNode rows = client.search(envelope(s, query));
        JsonNode match = null;
        for (JsonNode row : rows) {
            if (done.uniqueId().equals(row.path(DOCUMENT_ID).asText())) {
                match = row;
                break;
            }
        }
        if (match == null || match.path(ENTRY_UUID).asText("").isBlank())
            throw new XdsFailure(
                    "XDS-NOT-FOUND",
                    "The uploaded document is not registered as Approved for this patient, so it cannot be deprecated.");
        Map<String, Object> change = new LinkedHashMap<>();
        change.put(PATIENT_ID, s.patient);
        change.put(ENTRY_UUID, match.path(ENTRY_UUID).asText());
        change.put(TYPE_CODE, match.path(TYPE_CODE).asText(""));
        change.put("typeScheme", match.path("typeScheme").asText(""));
        client.deprecate(envelope(s, change));
        out.getOutput().add(value("deprecatedUniqueId", STRING, done.uniqueId()));
        s.submitted = Submitted.NONE;
    }

    private Map<String, Object> newContext() {
        Map<String, Object> context = new LinkedHashMap<>();
        context.put("role", role);
        context.put("consentOverride", false);
        if (!authorizationCode.isBlank()) context.put("authorizationCode", authorizationCode);
        return context;
    }

    private static void clearResults(Session s) {
        s.searched = false;
        s.documents.clear();
        s.documentSelections.clear();
        s.documentNumbers.clear();
        s.visibleDocuments.clear();
        s.repositories.clear();
        s.repositorySelections.clear();
    }

    private void filter(Session s, Map<String, String> v, ProcessResponse out) {
        s.visibleDocuments.clear();
        s.documentSelections.clear();
        if (!s.searched)
            throw new XdsFailure("XDS-SELECTION", "Search before filtering repositories.");
        String mode = v.getOrDefault("repositoryMode", ALL_REPOSITORIES);
        if (!Set.of(ALL_REPOSITORIES, "Only selected repositories", "Exclude selected repositories")
                .contains(mode))
            throw new XdsFailure(INPUT_ERROR, "Choose a repository filter mode from the list.");
        String input = v.getOrDefault(REPOSITORIES, "");
        var selected = new LinkedHashSet<String>();
        if (!input.isBlank()) {
            String[] choices = input.split(",", -1);
            if (choices.length > MAX_RESULTS)
                throw new XdsFailure(INPUT_ERROR, "Too many repository selections.");
            for (String choice : choices) {
                String key = choice.trim();
                String repository =
                        s.repositories.get(s.repositorySelections.getOrDefault(key, key));
                if (repository == null)
                    throw new XdsFailure(
                            INPUT_ERROR, "Choose repositories from the current search results.");
                selected.add(repository);
            }
        }
        var visible = new LinkedHashMap<String, JsonNode>();
        s.documents.forEach(
                (handle, row) -> {
                    boolean match = selected.contains(required(row, REPOSITORY_ID));
                    if (selected.isEmpty()
                            || ALL_REPOSITORIES.equals(mode)
                            || ("Only selected repositories".equals(mode) == match))
                        visible.put(handle, row);
                });
        presentResults(s, visible, selected.isEmpty() ? ALL_REPOSITORIES : mode, out);
    }

    private static void presentResults(
            Session s, Map<String, JsonNode> visible, String mode, ProcessResponse out) {
        s.visibleDocuments.clear();
        s.visibleDocuments.addAll(visible.keySet());
        s.documentSelections.clear();
        visible.forEach(
                (handle, row) -> s.documentSelections.put(documentLabel(s, handle, row), handle));
        list(out, "documents", visible.keySet());
        list(out, "documentLabels", s.documentSelections.keySet());
        list(out, REPOSITORIES, s.repositories.keySet());
        list(out, "repositoryLabels", s.repositorySelections.keySet());
        out.getOutput().add(value("count", "number", Integer.toString(visible.size())));
        String summary =
                "Showing "
                        + visible.size()
                        + " of "
                        + s.documents.size()
                        + " fetched documents. "
                        + mode
                        + ".";
        if (!ALL_REPOSITORIES.equals(mode)) {
            var included = new LinkedHashSet<String>();
            visible.values().forEach(row -> included.add(required(row, REPOSITORY_ID)));
            var excluded = new LinkedHashSet<>(s.repositories.values());
            excluded.removeAll(included);
            summary +=
                    "\nIncluded repositories: "
                            + repositorySummary(included)
                            + ".\nExcluded repositories: "
                            + repositorySummary(excluded)
                            + ".";
        }
        out.getOutput().add(value("summary", STRING, summary));
        var context = new AnyContent();
        context.getItem().add(value("Results", STRING, summary));
        context.getItem().add(value(REGISTRY_LABEL, STRING, s.registryLabel));
        var details = new TAR();
        details.setContext(context);
        out.setReport(details);
    }

    private static AnyContent selectedDocument(JsonNode document) {
        return value(
                "Selected document",
                STRING,
                "Document type: "
                        + document.path(DOCUMENT_TYPE).asText("CDA")
                        + "\nService dates: "
                        + dateLabel(document, "serviceStart")
                        + " – "
                        + dateLabel(document, "serviceEnd")
                        + "\nUnique ID: "
                        + required(document, DOCUMENT_ID)
                        + "\nRepository: "
                        + XdsRepositories.describe(required(document, REPOSITORY_ID)));
    }

    private static String repositorySummary(Collection<String> repositories) {
        return repositories.isEmpty()
                ? "None"
                : String.join(
                        "; ", repositories.stream().map(XdsRepositories::shortLabel).toList());
    }

    private static String documentLabel(Session s, String handle, JsonNode row) {
        String type = row.path(DOCUMENT_TYPE).asText("CDA");
        if (PHMR_NAME.equalsIgnoreCase(type)) type = "PHMR";
        String start = dateLabel(row, "serviceStart");
        try {
            start =
                    java.time.format.DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm 'UTC'")
                            .withZone(ZoneOffset.UTC)
                            .format(Instant.parse(start));
        } catch (java.time.format.DateTimeParseException _) {
            start = shortText(start, 24);
        }
        return displayLabel(
                "#"
                        + s.documentNumbers.get(handle)
                        + LABEL_SEPARATOR
                        + shortText(required(row, DOCUMENT_ID), 18)
                        + LABEL_SEPARATOR
                        + shortText(XdsRepositories.shortLabel(required(row, REPOSITORY_ID)), 40)
                        + LABEL_SEPARATOR
                        + shortText(type, 28)
                        + LABEL_SEPARATOR
                        + start);
    }

    private static String shortText(String text, int limit) {
        String display = displayLabel(text);
        return display.length() <= limit ? display : display.substring(0, limit - 1) + "…";
    }

    private static String dateLabel(JsonNode row, String field) {
        var n = row.path(field);
        return n.isNumber()
                ? Instant.ofEpochMilli(n.asLong()).toString()
                : n.asText("date unavailable");
    }

    private static void putCode(
            Map<String, Object> query,
            String name,
            String id,
            Map<String, JsonNode> codes,
            Map<String, String> selections) {
        if (id == null || id.isBlank() || "any".equals(id) || "Any".equals(id)) return;
        var selected = new LinkedHashSet<>(Arrays.asList(id.split(",", -1)));
        if (selected.contains("any") || selected.contains("Any"))
            throw new XdsFailure(INPUT_ERROR, "Select Any on its own, or select specific codes.");
        if (selected.size() > MAX_CODES)
            throw new XdsFailure(INPUT_ERROR, "Select at most 50 codes per filter.");
        var values = new ArrayList<Map<String, String>>();
        for (String selectedId : selected) {
            String selection = selectedId.trim();
            JsonNode code = codes.get(selections.getOrDefault(selection, selection));
            if (code == null)
                throw new XdsFailure(INPUT_ERROR, "Choose codes from the configured list.");
            values.add(Map.of(CODE, required(code, CODE), "codeScheme", required(code, SCHEME)));
        }
        // Preserve single-code requests for existing backends and test definitions.
        if (values.size() == SINGLE_CODE_COUNT) query.put(name, values.get(0));
        else query.put(name + "s", values);
    }

    // Keep sensitive input and upstream payloads out of exception causes and SOAP faults.
    @SuppressWarnings("PMD.PreserveStackTrace")
    private static void dates(
            Map<String, Object> query, Map<String, String> v, String from, String to) {
        try {
            String lower = v.getOrDefault(from, "");
            String upper = v.getOrDefault(to, "");
            String fromDtm = lower.isBlank() ? null : QueryDates.fromInput(lower);
            String toDtm = upper.isBlank() ? null : QueryDates.fromInput(upper);
            QueryDates.validateRange(
                    QueryDates.resolve(null, fromDtm), QueryDates.resolve(null, toDtm));
            if (fromDtm != null) query.put(from.replace("Date", "Dtm"), fromDtm);
            if (toDtm != null) query.put(to.replace("Date", "Dtm"), toDtm);
        } catch (IllegalArgumentException e) {
            throw new XdsFailure(INPUT_ERROR, e.getMessage());
        }
    }

    // Keep sensitive input and upstream payloads out of exception causes and SOAP faults.
    @SuppressWarnings("PMD.PreserveStackTrace")
    private void retrieve(Session s, Map<String, String> v, ProcessResponse out) {
        String selection = v.get(DOCUMENT_FIELD);
        String handle = s.documentSelections.getOrDefault(selection, selection);
        JsonNode document = s.visibleDocuments.contains(handle) ? s.documents.get(handle) : null;
        if (document == null)
            throw new XdsFailure(
                    "XDS-SELECTION", "Choose a document from the current search results.");
        var context = new AnyContent();
        context.getItem().add(selectedDocument(document));
        context.getItem().add(value(REGISTRY_LABEL, STRING, s.registryLabel));
        var diagnostics = new TAR();
        diagnostics.setContext(context);
        out.setReport(diagnostics);
        String repositoryId = required(document, REPOSITORY_ID);
        var query =
                new LinkedHashMap<>(
                        Map.<String, Object>of(
                                PATIENT_ID,
                                s.patient,
                                DOCUMENT_ID,
                                required(document, DOCUMENT_ID),
                                "repositoryId",
                                repositoryId,
                                "includeFormattedResponse",
                                false));
        if (document.hasNonNull(HOME_COMMUNITY_ID))
            query.put(HOME_COMMUNITY_ID, document.get(HOME_COMMUNITY_ID).asText());
        byte[] bytes;
        try {
            bytes = client.retrieve(envelope(s, query));
        } catch (XdsFailure failure) {
            // Identify the attempted target without asserting that every failure means it is
            // offline.
            throw new XdsFailure(
                    failure.code,
                    failure.getMessage()
                            + " Selected repository: "
                            + XdsRepositories.describe(repositoryId)
                            + ".");
        }
        if (bytes.length <= 10 * 1024 * 1024) {
            var original =
                    value(
                            "retrieved-document",
                            "binary",
                            Base64.getEncoder().encodeToString(bytes));
            original.setEmbeddingMethod(ValueEmbeddingEnumeration.BASE_64);
            original.setMimeType("application/octet-stream");
            context.getItem().add(original);
            out.getOutput().removeIf(item -> DOCUMENT_LOG.equals(item.getName()));
            out.getOutput().add(value(DOCUMENT_LOG, STRING, DocumentPreview.format(bytes)));
        }
        checkCda(bytes);
        AnyContent content =
                value(DOCUMENT_FIELD, "binary", Base64.getEncoder().encodeToString(bytes));
        content.setEmbeddingMethod(ValueEmbeddingEnumeration.BASE_64);
        content.setMimeType("application/xml");
        out.getOutput().add(content);
        clearResults(s);
    }

    // Keep sensitive input and upstream payloads out of exception causes and SOAP faults.
    static void checkCda(byte[] bytes) {
        if (bytes.length == 0 || bytes.length > 10 * 1024 * 1024)
            throw new XdsFailure(
                    "XDS-CONTENT", "The retrieved document is empty or exceeds 10 MiB.");
        try {
            var factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);
            factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
            factory.setFeature("http://xml.org/sax/features/external-general-entities", false);
            factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);
            factory.setXIncludeAware(false);
            factory.setExpandEntityReferences(false);
            var builder = factory.newDocumentBuilder();
            builder.setErrorHandler(new org.xml.sax.helpers.DefaultHandler());
            var root = builder.parse(new ByteArrayInputStream(bytes)).getDocumentElement();
            if (!"ClinicalDocument".equals(root.getLocalName())
                    || !"urn:hl7-org:v3".equals(root.getNamespaceURI()))
                throw new org.xml.sax.SAXException("Not a CDA document");
        } catch (Exception _) {
            throw new XdsFailure(
                    "XDS-CONTENT",
                    "The selected document is not well-formed CDA XML. CDA conformance validation has not run.");
        }
    }

    private static Map<String, Object> envelope(Session s, Map<String, Object> query) {
        return Map.of(
                "registryId",
                s.registry,
                "credentialId",
                s.credential,
                "context",
                s.context,
                "queryParameters",
                query);
    }

    private static String required(JsonNode node, String field) {
        String value = node.path(field).asText("");
        if (value.isBlank() || (value.length() > 1024 && !"responseBase64".equals(field)))
            throw new XdsFailure(
                    RESPONSE_ERROR, "XDS response is missing required data (" + field + ").");
        return value;
    }

    static AnyContent value(String name, String type, String text) {
        var result = new AnyContent();
        result.setName(name);
        result.setType(type);
        result.setValue(text);
        result.setEmbeddingMethod(ValueEmbeddingEnumeration.STRING);
        return result;
    }

    private static void list(ProcessResponse response, String name, Collection<String> values) {
        var list = new AnyContent();
        list.setName(name);
        list.setType("list");
        for (String text : values) {
            // ITB serialises dropdown labels as comma-separated text, including list inputs.
            String display = name.endsWith("Labels") ? displayLabel(text) : text;
            list.getItem().add(value(null, STRING, display));
        }
        response.getOutput().add(list);
    }

    private static String displayLabel(String text) {
        return text.replace(',', ';').replaceAll("\\s+", " ").trim();
    }

    private static TAR report(XdsFailure failure) {
        var report = new TAR();
        report.setResult(failure == null ? TestResultType.SUCCESS : TestResultType.FAILURE);
        try {
            report.setDate(
                    DatatypeFactory.newInstance()
                            .newXMLGregorianCalendar(Instant.now().toString()));
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
        report.setReports(new TestAssertionGroupReportsType());
        if (failure != null) {
            var item = new BAR();
            item.setAssertionID(failure.code);
            item.setDescription(failure.getMessage());
            report.getReports()
                    .getInfoOrWarningOrError()
                    .add(
                            new com.gitb.tr.ObjectFactory()
                                    .createTestAssertionGroupReportsTypeError(item));
        }
        return report;
    }
}
