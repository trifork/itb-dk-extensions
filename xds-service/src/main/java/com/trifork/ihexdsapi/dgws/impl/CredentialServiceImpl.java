package com.trifork.ihexdsapi.dgws.impl;

import com.trifork.ihexdsapi.dao.CredentialRepository;
import com.trifork.ihexdsapi.dao.entity.CredentialInfoEntity;
import com.trifork.ihexdsapi.dgws.CredentialInfo;
import com.trifork.ihexdsapi.dgws.CredentialService;
import com.trifork.ihexdsapi.dgws.DgwsSecurityException;
import com.trifork.ihexdsapi.utility.VaultGenerator;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import org.openapitools.model.CredentialInfoResponse;

public class CredentialServiceImpl implements CredentialService {
    private final CredentialRepository repository;
    private final String vaultPassword;

    public CredentialServiceImpl(CredentialRepository repository, String vaultPassword) {
        this.repository = repository;
        this.vaultPassword = vaultPassword;
    }

    @Override
    public synchronized CredentialInfo createAndAddCredentialInfo(
            String owner, String displayName, String publicCertStr, String privateKeyStr)
            throws DgwsSecurityException {
        CredentialInfo info = parse(displayName, publicCertStr, privateKeyStr);
        repository.saveCredentialsForID(
                new CredentialInfoEntity(
                        owner == null ? null : owner.trim(),
                        UUID.randomUUID().toString(),
                        info.getDisplayName(),
                        publicCertStr,
                        privateKeyStr,
                        info.getSerialNumber(),
                        info.getType()));
        return info;
    }

    private CredentialInfo parse(String name, String certificate, String key)
            throws DgwsSecurityException {
        var vault = VaultGenerator.generateGenericCredentialVault(certificate, key, vaultPassword);
        try {
            return new CredentialInfo(vault, name);
        } catch (IllegalArgumentException e) {
            throw new DgwsSecurityException(
                    e, 1, "Unsupported or incomplete OCES certificate identity");
        }
    }

    @Override
    public List<String[]> getIds(String owner) {
        List<String[]> result = new ArrayList<>();
        addIds(result, null);
        if (owner != null) addIds(result, owner.trim());
        return result;
    }

    private void addIds(List<String[]> target, String owner) {
        List<String[]> stored = repository.findListOfIDsForOwner(owner);
        if (stored != null) target.addAll(stored);
    }

    @Override
    public CredentialInfo getCredentialInfoFromId(String id) {
        String selectedId = id;
        if (selectedId == null) {
            List<String[]> defaults = repository.findListOfIDsForOwner(null);
            if (defaults == null || defaults.isEmpty()) return null;
            selectedId = defaults.get(0)[0];
        }
        CredentialInfoEntity stored = repository.findCredentialInfoByID(selectedId);
        if (stored == null) return null;
        try {
            return parse(
                    stored.getDisplayName(), stored.getPublicCertStr(), stored.getPrivateKeyStr());
        } catch (DgwsSecurityException e) {
            throw new IllegalStateException("Unable to load stored credential", e);
        }
    }

    @Override
    public String getType(String id) {
        CredentialInfoEntity stored = repository.findCredentialInfoByID(id);
        return stored == null ? null : stored.getType();
    }

    @Override
    public String getSerialNumber(String id) {
        CredentialInfoEntity stored = repository.findCredentialInfoByID(id);
        return stored == null ? null : stored.getSerialNumber();
    }

    @Override
    public List<CredentialInfoResponse> populateResponses(
            String owner, CredentialInfoResponse.CredentialTypeEnum type) {
        List<CredentialInfoResponse> responses = new ArrayList<>();
        for (String[] id : getIds(owner)) {
            CredentialInfoEntity stored = repository.findCredentialInfoByID(id[0]);
            if (stored == null) continue;
            var actualType = CredentialInfoResponse.CredentialTypeEnum.valueOf(stored.getType());
            if (type == null || type == actualType) {
                CredentialInfoResponse response = new CredentialInfoResponse();
                response.setId(stored.getId());
                response.setDisplayName(stored.getDisplayName());
                response.setSubjectSerialNumber(stored.getSerialNumber());
                response.setCredentialType(actualType);
                CertificateDetails.populate(response, stored.getPublicCertStr());
                responses.add(response);
            }
        }
        return responses;
    }
}
