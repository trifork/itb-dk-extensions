package com.trifork.ihexdsapi.service;

import java.util.Map;

public interface IDContextService {

    Map<String, String> getIds();

    String getId(String key);

    void updateId(String key, String idValue);
}
