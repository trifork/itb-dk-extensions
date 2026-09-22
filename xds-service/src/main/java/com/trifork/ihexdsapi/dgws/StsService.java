package com.trifork.ihexdsapi.dgws;

import org.openapitools.model.HealthcareProfessionalContext;

public interface StsService {

    DgwsClientInfo getDgwsClientInfoForSystem(
            CredentialInfo credentialInfo, String patientId, HealthcareProfessionalContext context)
            throws DgwsSecurityException;

    DgwsClientInfo getDgwsClientInfoForSystem(CredentialInfo credentialInfo)
            throws DgwsSecurityException;
}
