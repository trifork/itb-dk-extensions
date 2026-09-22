package com.trifork.ihexdsapi.dao.impl;

import java.time.Clock;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/** Bounded process-local storage; access and scheduled maintenance remove expired entries. */
final class ExpiringStore<T> {
    private static final class Entry<T> {
        final T value;
        final Instant expires;

        Entry(T value, Instant expires) {
            this.value = value;
            this.expires = expires;
        }
    }

    private final Map<String, Entry<T>> entries = new LinkedHashMap<>();
    private final Clock clock;
    private final Duration ttl;
    private final int capacity;

    ExpiringStore(Clock clock, Duration ttl, int capacity) {
        if (ttl.isNegative() || ttl.isZero() || capacity < 1)
            throw new IllegalArgumentException("Invalid cache limits");
        this.clock = clock;
        this.ttl = ttl;
        this.capacity = capacity;
    }

    synchronized void put(String id, T value) {
        cleanUp();
        entries.remove(id);
        if (entries.size() >= capacity) entries.remove(entries.keySet().iterator().next());
        entries.put(id, new Entry<>(value, clock.instant().plus(ttl)));
    }

    synchronized T get(String id) {
        cleanUp();
        Entry<T> entry = entries.get(id);
        return entry == null ? null : entry.value;
    }

    synchronized List<T> values() {
        cleanUp();
        List<T> values = new ArrayList<>(entries.size());
        for (Entry<T> entry : entries.values()) values.add(entry.value);
        return values;
    }

    synchronized void cleanUp() {
        Instant now = clock.instant();
        entries.values().removeIf(entry -> !entry.expires.isAfter(now));
    }
}
