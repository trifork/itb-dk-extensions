package com.trifork.ihexdsapi.gitb;

import static java.util.Map.entry;

import java.util.Map;
import java.util.regex.Pattern;

/** Display-only repository labels; never selects an endpoint or changes the retrieval request. */
final class XdsRepositories {
    private XdsRepositories() {}

    // MedCom, Kom godt igang med dokumentdeling v1.4, environment tables pp. 27-30.
    // https://medcom.dk/wp-content/uploads/2023/01/Kom-godt-igang-med-dokumentdeling-1.4-interactive-1.pdf
    // Only explicit repositoryUniqueId entries, not homeCommunityId values or inferred OID
    // families.
    private static final Map<String, String> NAMES =
            Map.ofEntries(
                    entry("1.2.208.176.43210.8.10.11", "Aftale DRS, TEST1"),
                    entry("1.2.208.176.43210.8.20.11", "Aftale DRS, TEST2"),
                    entry("1.2.208.176.43210.8.30.11", "Aftale DRS, PRODTEST"),
                    entry("1.2.208.176.43210.8.40.11", "Aftale DRS, UDDANNELSE"),
                    entry("1.2.208.176.43210.8.1.29", "KIH Repository, TEST2"),
                    // NSP's newer directory explicitly shares this OID between TEST1 and PRODTEST.
                    // https://www.nspop.dk/pages/releaseview.action?pageId=102380360 (section 3.1)
                    entry("1.2.208.176.43210.8.1.30", "KIH Repository, TEST1 / PRODTEST"),
                    entry("1.2.208.176.43210.8.1.31", "KIH Repository, UDDANNELSE"),
                    // All four sandbox entries are explicit in the same directory; no inferred
                    // siblings.
                    entry("1.2.208.176.43210.8.10.999", "Sandbox DROS, TEST1"),
                    entry("1.2.208.176.43210.8.20.999", "Sandbox DROS, TEST2"),
                    entry("1.2.208.176.43210.8.30.999", "Sandbox DROS, PRODTEST"),
                    entry("1.2.208.176.43210.8.40.999", "Sandbox DROS, UDDANNELSE"),
                    // Installation example reuses the OpenText OID for an OpenXDS proof of concept.
                    // This does not establish a current deployed implementation or environment.
                    // https://git.nspop.dk/projects/COM/repos/openxds/browse/compose/Installation%20af%20openxds-server.txt?at=e6df3fb88a2b7a6f59a3c4255dc1a25927335002
                    entry(
                            "1.3.6.1.4.1.21367.2010.1.2.1125",
                            "OpenXDS / OpenText PoC, environment unknown"));
    private static final Pattern OID_COMPONENT = Pattern.compile("0|[1-9]\\d*");

    private static boolean isOid(String value) {
        if (value == null || value.length() > 128) return false;
        var parts = value.split("\\.", -1);
        if (parts.length < 2 || !java.util.Set.of("0", "1", "2").contains(parts[0])) return false;
        for (var part : parts) if (!OID_COMPONENT.matcher(part).matches()) return false;
        return "2".equals(parts[0]) || (parts[1].length() <= 2 && Integer.parseInt(parts[1]) < 40);
    }

    static String shortLabel(String repositoryId) {
        String name = NAMES.get(repositoryId);
        if (name != null) return name.replace(", ", " · ");
        return isOid(repositoryId) ? repositoryId : "Unknown repository";
    }

    static String describe(String repositoryId) {
        // The saved search row supplies the identifier, not user input or backend error prose.
        // Unknown numeric OIDs are useful too; arbitrary text/control characters stay out of logs.
        if (!isOid(repositoryId)) {
            return "unrecognised repository identifier (non-OID or oversized value withheld)";
        }
        String name = NAMES.get(repositoryId);
        return repositoryId + " (" + (name == null ? "name/environment unknown" : name) + ")";
    }
}
