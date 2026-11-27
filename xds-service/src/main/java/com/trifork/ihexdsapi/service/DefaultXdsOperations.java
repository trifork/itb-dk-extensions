package com.trifork.ihexdsapi.service;

import com.trifork.ihexdsapi.configuration.SubmissionProperties;
import com.trifork.ihexdsapi.dgws.*;
import java.util.List;
import org.openapitools.model.*;
import org.openehealth.ipf.commons.ihe.xds.core.responses.QueryResponse;
import org.openehealth.ipf.commons.ihe.xds.core.responses.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DefaultXdsOperations implements XdsOperations {
    private final CredentialService credentials;
    private final CodesService codeService;
    private final RegistryRouting routing;
    private final SubmissionProperties submission;

    public DefaultXdsOperations(
            CredentialService credentials, CodesService codeService, RegistryRouting registries) {
        this(credentials, codeService, registries, SubmissionProperties.defaults());
    }

    @Autowired
    public DefaultXdsOperations(
            CredentialService credentials,
            CodesService codeService,
            RegistryRouting registries,
            SubmissionProperties submission) {
        this.credentials = credentials;
        this.codeService = codeService;
        this.routing = registries;
        this.submission = submission;
    }

    @Override
    public List<RegistryRouting.Choice> registries() {
        return routing.choices();
    }

    @Override
    public List<CredentialInfoResponse> identities() {
        return credentials.populateResponses(null, null);
    }

    @Override
    public List<Code> codes(boolean format) {
        return List.copyOf(
                format ? codeService.getFormatCodesList() : codeService.getTypeCodesList());
    }

    @Override
    public QueryResponse search(Iti18Request request)
            throws com.trifork.ihexdsapi.dgws.DgwsSecurityException,
                    com.trifork.ihexdsapi.dgws.ItiException {
        var q = request.getQueryParameters();
        var target = routing.target(request.getRegistryId());
        var identity =
                target.authenticate(
                        q.getPatientId(), request.getCredentialId(), request.getContext());
        return target.search().queryForDocument(q, identity);
    }

    @Override
    public RetrievedBytes retrieve(Iti43Request request)
            throws com.trifork.ihexdsapi.dgws.DgwsSecurityException,
                    com.trifork.ihexdsapi.dgws.ItiException {
        var q = request.getQueryParameters();
        var target = routing.target(request.getRegistryId());
        var identity =
                target.authenticate(
                        q.getPatientId(), request.getCredentialId(), request.getContext());
        return target.retrieval().getDocument(q, identity);
    }

    @Override
    public SubmissionResult submit(SubmitRequest request)
            throws DgwsSecurityException, ItiException {
        var target = routing.target(request.registryId());
        if (target.submission() == null || target.stamkort())
            throw new IllegalArgumentException(
                    "ITI-41 upload is not configured for the chosen registry");
        byte[] document = request.document();
        var cda = CdaMetadata.parse(document);
        var format = formatCode(request.formatCode());
        var identity =
                target.authenticateWriter(
                        cda.patientId(), request.credentialId(), request.context());
        var payload = Submissions.provide(document, cda, format, submission);
        var entry = payload.getDocuments().getFirst().getDocumentEntry();
        return new SubmissionResult(
                target.submission().submit(payload, identity),
                entry.getEntryUuid(),
                entry.getTypeCode().getCode(),
                entry.getTypeCode().getSchemeName());
    }

    @Override
    public Response deprecate(DeprecateRequest request) throws DgwsSecurityException, ItiException {
        var target = routing.target(request.registryId());
        if (target.update() == null || target.stamkort())
            throw new IllegalArgumentException(
                    "ITI-57 deprecation is not configured for the chosen registry");
        var contentType =
                request.typeCode() == null || request.typeCode().isBlank()
                        ? new org.openehealth.ipf.commons.ihe.xds.core.metadata.Code(
                                "UPDATE", null, submission.sourceId())
                        : new org.openehealth.ipf.commons.ihe.xds.core.metadata.Code(
                                request.typeCode(), null, request.typeScheme());
        var identity =
                target.authenticateWriter(
                        request.patientId(), request.credentialId(), request.context());
        return target.update()
                .update(
                        Submissions.deprecate(
                                request.patientId(), request.entryUuid(), contentType, submission),
                        identity);
    }

    private org.openehealth.ipf.commons.ihe.xds.core.metadata.Code formatCode(String code) {
        return codeService.getFormatCodesList().stream()
                .filter(c -> c.getCode() != null && c.getCode().equals(code))
                .findFirst()
                .map(
                        c ->
                                new org.openehealth.ipf.commons.ihe.xds.core.metadata.Code(
                                        c.getCode(),
                                        c.getName() == null
                                                ? null
                                                : new org.openehealth.ipf.commons.ihe.xds.core
                                                        .metadata.LocalizedString(c.getName()),
                                        c.getScheme()))
                .orElseThrow(() -> new IllegalArgumentException("Choose a configured format code"));
    }
}
