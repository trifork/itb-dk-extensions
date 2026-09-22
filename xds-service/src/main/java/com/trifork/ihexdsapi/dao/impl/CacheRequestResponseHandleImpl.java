package com.trifork.ihexdsapi.dao.impl;

import com.trifork.ihexdsapi.dao.CacheRequestResponseHandle;
import com.trifork.ihexdsapi.dao.entity.LogEntry;
import java.time.Clock;
import java.time.Duration;
import org.springframework.scheduling.annotation.Scheduled;

public class CacheRequestResponseHandleImpl implements CacheRequestResponseHandle {
    private final ExpiringStore<String> records;

    public CacheRequestResponseHandleImpl(Clock clock, Duration ttl, int capacity) {
        records = new ExpiringStore<>(clock, ttl, capacity);
    }

    @Override
    public String getRequestAndResponse(String id) {
        String payload = records.get(id);
        return payload == null ? "" : payload;
    }

    @Override
    public void saveRequestAndResponse(String id, LogEntry payload) {
        records.put(id, payload.getPayload());
    }

    @Scheduled(fixedDelay = 60000)
    public void cleanUp() {
        records.cleanUp();
    }
}
