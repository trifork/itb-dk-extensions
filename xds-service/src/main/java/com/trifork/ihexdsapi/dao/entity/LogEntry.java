package com.trifork.ihexdsapi.dao.entity;

public class LogEntry {
    private String id;

    private String payload;

    public LogEntry(String id, String payload) {
        this.id = id;
        this.payload = payload;
    }

    public String getId() {
        return id;
    }

    public String getPayload() {
        return payload;
    }
}
