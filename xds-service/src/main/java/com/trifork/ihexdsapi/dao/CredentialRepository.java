package com.trifork.ihexdsapi.dao;

import com.trifork.ihexdsapi.dao.entity.CredentialInfoEntity;
import java.util.List;

public interface CredentialRepository {

    boolean saveCredentialsForID(CredentialInfoEntity credentialInfo);

    CredentialInfoEntity findCredentialInfoByID(String id);

    List<String[]> findListOfIDsForOwner(String owner);
}
