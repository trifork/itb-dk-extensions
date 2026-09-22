package com.trifork.ihexdsapi.service;

import com.trifork.ihexdsapi.dgws.DgwsService;
import java.util.List;

/** Immutable routes with separate SOAP and STS clients for each registry. */
public final class RegistryRouting {
    private final List<Target> targets;

    public RegistryRouting(List<Target> targets) {
        if (targets.isEmpty())
            throw new IllegalArgumentException("At least one XDS registry is required");
        this.targets = List.copyOf(targets);
    }

    public static RegistryRouting legacy(
            DgwsService dgws, Iti18Service search, Iti43Service retrieval) {
        return new RegistryRouting(
                List.of(new Target("default", "Configured XDS registry", dgws, search, retrieval)));
    }

    public List<Choice> choices() {
        return targets.stream().map(t -> new Choice(t.id(), t.name())).toList();
    }

    public Target target(String id) {
        if (id == null || id.isBlank()) return targets.getFirst();
        return targets.stream()
                .filter(t -> t.id().equals(id))
                .findFirst()
                .orElseThrow(
                        () -> new IllegalArgumentException("Choose a configured XDS registry ID"));
    }

    public record Choice(String id, String name) {}

    public record Target(
            String id,
            String name,
            DgwsService dgws,
            Iti18Service search,
            Iti43Service retrieval) {}
}
