package com.trifork.ihexdsapi.service.impl;

import com.trifork.ihexdsapi.dgws.*;
import org.openapitools.model.HealthcareProfessionalContext;

public class DgwsServiceImpl implements DgwsService {

    private final StsService stsService;

    private final CredentialService credentialService;

    public DgwsServiceImpl(StsService stsService, CredentialService credentialService) {
        this.stsService = stsService;
        this.credentialService = credentialService;
    }

    @Override
    public DgwsClientInfo getHealthCareProfessionalClientInfo(
            String patientId, String credentialId, HealthcareProfessionalContext context)
            throws DgwsSecurityException {

        CredentialInfo credentialInfo = credentialService.getCredentialInfoFromId(credentialId);

        if (credentialInfo == null)
            throw new DgwsSecurityException(1000, "Credentials do not exist");
        return stsService.getDgwsClientInfoForSystem(credentialInfo, patientId, context);
    }

    @Override
    public DgwsClientInfo getSystemClientInfo(String credentialId) throws DgwsSecurityException {
        CredentialInfo credentialInfo = credentialService.getCredentialInfoFromId(credentialId);

        if (credentialInfo == null) {
            throw new DgwsSecurityException(1000, "Credentials do not exist");
        }

        return stsService.getDgwsClientInfoForSystem(credentialInfo);
    }
}
