package com.trifork.itb.integration;

import java.util.ArrayList;
import java.util.List;

/**
 * Splits a slow parameterised integration class across CI jobs. Shard {@code i/n} keeps every n-th
 * case starting at the i-th, so the shards together cover each case exactly once.
 */
final class ShardSelection {
    private ShardSelection() {}

    /** Returns {@code all} unchanged when {@code spec} is null or blank. */
    static <T> List<T> select(List<T> all, String spec) {
        if (spec == null || spec.isBlank()) return all;
        String[] parts = spec.trim().split("/", -1);
        int shard;
        int count;
        try {
            if (parts.length != 2) throw new NumberFormatException();
            shard = Integer.parseInt(parts[0]);
            count = Integer.parseInt(parts[1]);
        } catch (NumberFormatException exception) {
            throw new IllegalArgumentException(invalid(spec), exception);
        }
        if (count < 1 || shard < 1 || shard > count)
            throw new IllegalArgumentException(invalid(spec));
        List<T> selected = new ArrayList<>();
        for (int i = shard - 1; i < all.size(); i += count) selected.add(all.get(i));
        return selected;
    }

    private static String invalid(String spec) {
        return "Invalid CDA_IT_SHARD '" + spec + "': expected i/n with 1 <= i <= n";
    }
}
