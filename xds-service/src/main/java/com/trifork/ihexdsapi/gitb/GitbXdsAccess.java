package com.trifork.ihexdsapi.gitb;

import com.fasterxml.jackson.databind.*;
import com.trifork.ihexdsapi.service.XdsOperations;
import java.time.Duration;
import java.util.*;
import java.util.concurrent.*;
import org.openapitools.model.*;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * Calls Java services directly. JSON trees are only the adapter's saved UI metadata representation.
 */
final class GitbXdsAccess implements AutoCloseable {
    static final ObjectMapper JSON =
            new ObjectMapper()
                    .findAndRegisterModules()
                    .disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
    private final XdsOperations operations;
    private final Duration timeout;
    private final ExecutorService executor =
            new ThreadPoolExecutor(
                    8,
                    8,
                    0,
                    TimeUnit.SECONDS,
                    new ArrayBlockingQueue<>(32),
                    Thread.ofPlatform().daemon().name("gitb-xds-", 0).factory());

    GitbXdsAccess(XdsOperations operations, Duration timeout) {
        this.operations = operations;
        this.timeout = timeout;
    }

    JsonNode identities() {
        return execute("XDS identity lookup", () -> JSON.valueToTree(operations.identities()));
    }

    JsonNode registries() {
        return execute("XDS registry lookup", () -> JSON.valueToTree(operations.registries()));
    }

    JsonNode codes(String kind) {
        return execute(
                "XDS code lookup",
                () -> JSON.valueToTree(operations.codes("formatCode".equals(kind))));
    }

    JsonNode search(Map<String, Object> values) {
        return execute(
                "DDS search (ITI-18)",
                () -> {
                    var request = JSON.convertValue(values, Iti18Request.class);
                    var result = operations.search(request);
                    XdsErrors.check(
                            "DDS search (ITI-18)",
                            result.getErrors(),
                            result.getDocumentEntries().size());
                    var rows = JSON.createArrayNode();
                    for (var entry : result.getDocumentEntries()) {
                        var row = rows.addObject();
                        row.put(
                                "patientId",
                                entry.getPatientId() == null ? null : entry.getPatientId().getId());
                        row.put("documentId", entry.getUniqueId());
                        row.put("repositoryID", entry.getRepositoryUniqueId());
                        row.put(
                                "documentType",
                                entry.getTypeCode() == null
                                                || entry.getTypeCode().getDisplayName() == null
                                        ? "CDA"
                                        : entry.getTypeCode().getDisplayName().getValue());
                        if (entry.getServiceStartTime() != null)
                            row.put(
                                    "serviceStart",
                                    entry.getServiceStartTime()
                                            .getDateTime()
                                            .toInstant()
                                            .toEpochMilli());
                        if (entry.getServiceStopTime() != null)
                            row.put(
                                    "serviceEnd",
                                    entry.getServiceStopTime()
                                            .getDateTime()
                                            .toInstant()
                                            .toEpochMilli());
                    }
                    return rows;
                });
    }

    byte[] retrieve(Map<String, Object> values) {
        return execute(
                "DDS document retrieval (ITI-43)",
                () -> {
                    var result = operations.retrieve(JSON.convertValue(values, Iti43Request.class));
                    XdsErrors.check("DDS document retrieval (ITI-43)", result.errors(), null);
                    if (result.bytes() == null)
                        throw new XdsFailure(
                                "XDS-CONTENT", "No retrieved document bytes are available.");
                    return result.bytes();
                });
    }

    // Deliberately discard causes: they can contain patient data and SOAP security material.
    @SuppressWarnings("PMD.PreserveStackTrace")
    private <T> T execute(String operation, Callable<T> action) {
        var attributes = RequestContextHolder.getRequestAttributes();
        Future<T> future;
        try {
            future =
                    executor.submit(
                            () -> {
                                RequestContextHolder.setRequestAttributes(attributes);
                                try {
                                    return action.call();
                                } finally {
                                    RequestContextHolder.resetRequestAttributes();
                                }
                            });
        } catch (RejectedExecutionException _) {
            throw new XdsFailure("XDS-BUSY", "XDS is busy. Retry later.");
        }
        try {
            return future.get(timeout.toMillis(), TimeUnit.MILLISECONDS);
        } catch (InterruptedException _) {
            future.cancel(true);
            Thread.currentThread().interrupt();
            throw new XdsFailure("XDS-UNAVAILABLE", "XDS request was interrupted.");
        } catch (TimeoutException e) {
            future.cancel(true);
            throw XdsErrors.failure(operation, e);
        } catch (ExecutionException e) {
            throw XdsErrors.failure(operation, e.getCause());
        }
    }

    @Override
    public void close() {
        executor.shutdownNow();
    }
}
