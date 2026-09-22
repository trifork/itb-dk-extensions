package com.trifork.ihexdsapi.dao.impl;

import com.trifork.ihexdsapi.dao.CredentialRepository;
import com.trifork.ihexdsapi.dao.entity.CredentialInfoEntity;
import java.time.Clock;
import java.time.Duration;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import org.springframework.scheduling.annotation.Scheduled;

/** Startup identities live until restart; uploaded identities expire individually. */
public class CredentialRepositoryImpl implements CredentialRepository {
    private final Map<String, CredentialInfoEntity> configured = new LinkedHashMap<>();
    private final ExpiringStore<CredentialInfoEntity> uploaded;

    public CredentialRepositoryImpl(Clock clock, Duration ttl, int capacity) {
        uploaded = new ExpiringStore<>(clock, ttl, capacity);
    }

    @Override
    public synchronized boolean saveCredentialsForID(CredentialInfoEntity credential) {
        if (credential.getOwner() == null) configured.put(credential.getId(), credential);
        else uploaded.put(credential.getId(), credential);
        return true;
    }

    @Override
    public synchronized CredentialInfoEntity findCredentialInfoByID(String id) {
        CredentialInfoEntity credential = configured.get(id);
        return credential != null ? credential : uploaded.get(id);
    }

    @Override
    public synchronized List<String[]> findListOfIDsForOwner(String owner) {
        List<String[]> result = new ArrayList<>();
        List<CredentialInfoEntity> all = new ArrayList<>(configured.values());
        all.addAll(uploaded.values());
        for (CredentialInfoEntity credential : all) {
            if (Objects.equals(owner, credential.getOwner())) {
                result.add(new String[] {credential.getId(), credential.getDisplayName()});
            }
        }
        return result;
    }

    @Scheduled(fixedDelay = 60000)
    public void cleanUp() {
        uploaded.cleanUp();
    }
}
