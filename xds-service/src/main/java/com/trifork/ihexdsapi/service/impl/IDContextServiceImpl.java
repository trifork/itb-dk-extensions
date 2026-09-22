package com.trifork.ihexdsapi.service.impl;

import com.trifork.ihexdsapi.service.IDContextService;
import java.util.HashMap;
import java.util.Map;

/**
 * This is the ID context which keeps track of the ID for requests and responses when you want to
 * downlod the previous request or ide as a file.
 */
public class IDContextServiceImpl implements IDContextService {
    private Map<String, String> temporaryIdMap;

    public IDContextServiceImpl() {
        temporaryIdMap = new HashMap<>();
    }

    @Override
    public Map<String, String> getIds() {
        return Map.copyOf(temporaryIdMap);
    }

    @Override
    public String getId(String key) {
        return temporaryIdMap.get(key);
    }

    @Override
    public void updateId(String key, String idValue) {
        temporaryIdMap.put(key, idValue);
    }
}
