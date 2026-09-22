package com.trifork.ihexdsapi.dgws;

import java.util.List;
import org.openapitools.model.CredentialInfoResponse;

public interface CredentialService {

    public CredentialInfo createAndAddCredentialInfo(
            String owner, String displayName, String publicCertStr, String privateKeyStr)
            throws DgwsSecurityException;

    public List<String[]> getIds(String owner);

    public CredentialInfo getCredentialInfoFromId(String id);

    public String getType(String id);

    public String getSerialNumber(String id);

    List<CredentialInfoResponse> populateResponses(
            String owner, CredentialInfoResponse.CredentialTypeEnum type);
}
