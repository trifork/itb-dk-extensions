package com.trifork.itb.integration;

import static org.junit.jupiter.api.Assertions.*;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.IntStream;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

class ShardSelectionTest {
    private static final List<Integer> CASES = IntStream.range(0, 143).boxed().toList();

    @Test
    void withoutASpecEveryCaseIsKept() {
        assertSame(CASES, ShardSelection.select(CASES, null));
        assertSame(CASES, ShardSelection.select(CASES, " "));
        assertEquals(CASES, ShardSelection.select(CASES, "1/1"));
    }

    @ParameterizedTest
    @ValueSource(ints = {1, 2, 3, 4, 7})
    void shardsTogetherCoverEveryCaseExactlyOnce(int count) {
        List<Integer> union = new ArrayList<>();
        for (int shard = 1; shard <= count; shard++) {
            List<Integer> part = ShardSelection.select(CASES, shard + "/" + count);
            assertTrue(
                    Math.abs(part.size() - CASES.size() / (double) count) < 1,
                    "shards stay balanced: " + part.size());
            union.addAll(part);
        }
        assertEquals(CASES.size(), union.size());
        assertEquals(CASES, union.stream().sorted().toList());
    }

    @Test
    void shardsKeepEveryNthCaseInOrder() {
        assertEquals(List.of(0, 3, 6), ShardSelection.select(List.of(0, 1, 2, 3, 4, 5, 6), "1/3"));
        assertEquals(List.of(1, 4), ShardSelection.select(List.of(0, 1, 2, 3, 4, 5, 6), "2/3"));
    }

    @Test
    void moreShardsThanCasesLeavesTheSurplusShardsEmpty() {
        assertEquals(List.of(), ShardSelection.select(List.of(0, 1), "3/3"));
    }

    @ParameterizedTest
    @ValueSource(strings = {"0/2", "3/2", "1/0", "-1/2", "a/b", "1", "1/2/3", "/", "1/"})
    void aMalformedSpecFailsInsteadOfSilentlyRunningTheWrongCases(String spec) {
        assertThrows(IllegalArgumentException.class, () -> ShardSelection.select(CASES, spec));
    }
}
