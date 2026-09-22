package com.trifork.ihexdsapi.dao;

import com.trifork.ihexdsapi.dao.entity.LogEntry;

public interface CacheRequestResponseHandle {

    String getRequestAndResponse(String id);

    void saveRequestAndResponse(String id, LogEntry payload);
}
