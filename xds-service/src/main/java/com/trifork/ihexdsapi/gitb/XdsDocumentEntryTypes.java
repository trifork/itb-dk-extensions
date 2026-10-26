package com.trifork.ihexdsapi.gitb;

import java.util.*;

/** Server-owned labels for the ITI-18 objectType filter, distinct from clinical typeCode. */
final class XdsDocumentEntryTypes {
    private static final Map<String, String> CHOICES;

    static {
        var choices = new LinkedHashMap<String, String>();
        choices.put("Stable (stored document)", "STABLE");
        choices.put("On-demand (generated on retrieval)", "ON-DEMAND");
        CHOICES = Collections.unmodifiableMap(choices);
    }

    private XdsDocumentEntryTypes() {}

    static Set<String> labels() {
        return CHOICES.keySet();
    }

    static List<String> select(String selection) {
        // Existing saved TDL definitions do not send this new input.
        if (selection == null) return List.copyOf(CHOICES.values());
        var result = new LinkedHashSet<String>();
        for (String label : selection.split(",", -1)) {
            String type = CHOICES.get(label.trim());
            if (type == null)
                throw new XdsFailure(
                        "XDS-INPUT", "Choose Stable, On-demand, or both document entry types.");
            result.add(type);
        }
        return List.copyOf(result);
    }
}
