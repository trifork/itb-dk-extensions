package com.trifork.ihexdsapi.service;

import com.trifork.ihexdsapi.dgws.*;
import java.util.List;
import org.openapitools.model.*;
import org.openehealth.ipf.commons.ihe.xds.core.responses.QueryResponse;
import org.springframework.stereotype.Service;

@Service
public class DefaultXdsOperations implements XdsOperations {
    private final CredentialService credentials;
    private final CodesService codeService;
    private final RegistryRouting routing;

    public DefaultXdsOperations(
            CredentialService credentials, CodesService codeService, RegistryRouting registries) {
        this.credentials = credentials;
        this.codeService = codeService;
        this.routing = registries;
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
                target.dgws()
                        .getHealthCareProfessionalClientInfo(
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
                target.dgws()
                        .getHealthCareProfessionalClientInfo(
                                q.getPatientId(), request.getCredentialId(), request.getContext());
        return target.retrieval().getDocument(q, identity);
    }
}
