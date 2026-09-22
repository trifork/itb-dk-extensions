package com.trifork.itb.plugin;

import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.nio.file.attribute.PosixFilePermissions;
import java.util.Enumeration;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;
import net.ihe.gazelle.IHEPaths;

/**
 * Extracts the Gazelle resource tree (XSDs, value sets, result XSL) bundled inside the plugin jar
 * to a temporary directory, because the Gazelle engines address these artifacts through filesystem
 * paths (see {@link net.ihe.gazelle.IHEPaths}).
 *
 * <p>The extraction happens once per JVM (per plugin classloader) and is reused across validations.
 */
final class GazelleResources {

    private static final String RESOURCE_ROOT = "gazelle/";
    private static Path extractedRoot;

    private GazelleResources() {}

    static synchronized Path root() {
        if (extractedRoot == null) {
            try {
                // A JVM temp dir (not the host's per-validation tempFolder input, which the
                // validator deletes after every validation) so the extraction is done once
                // and reused; the shutdown hook returns the space when the JVM exits.
                Path target =
                        Files.createTempDirectory(
                                "itb-cda-dk-gazelle",
                                PosixFilePermissions.asFileAttribute(
                                        PosixFilePermissions.fromString("rwx------")));
                extractTo(target);
                Runtime.getRuntime().addShutdownHook(new Thread(() -> deleteRecursively(target)));
                extractedRoot = target;
            } catch (IOException | URISyntaxException e) {
                throw new IllegalStateException(
                        "Unable to extract Gazelle resources from plugin jar", e);
            }
        }
        return extractedRoot;
    }

    private static void deleteRecursively(Path root) {
        try (var paths = Files.walk(root)) {
            paths.sorted(java.util.Comparator.reverseOrder())
                    .forEach(
                            p -> {
                                try {
                                    Files.deleteIfExists(p);
                                } catch (IOException _) {
                                    // Best effort - the OS temp dir is cleaned eventually anyway.
                                }
                            });
        } catch (IOException _) {
            // Best effort.
        }
    }

    private static void extractTo(Path target) throws IOException, URISyntaxException {
        Path jarPath =
                Path.of(
                        GazelleResources.class
                                .getProtectionDomain()
                                .getCodeSource()
                                .getLocation()
                                .toURI());
        try (JarFile jar = new JarFile(jarPath.toFile())) {
            Enumeration<JarEntry> entries = jar.entries();
            while (entries.hasMoreElements()) {
                JarEntry entry = entries.nextElement();
                if (!entry.getName().startsWith(RESOURCE_ROOT) || entry.isDirectory()) {
                    continue;
                }
                Path out = target.resolve(entry.getName());
                // Guard against zip-slip.
                if (!out.normalize().startsWith(target)) {
                    throw new IOException("Gazelle resource escapes its extraction directory");
                }
                Files.createDirectories(out.getParent());
                try (InputStream in = jar.getInputStream(entry)) {
                    Files.copy(in, out, StandardCopyOption.REPLACE_EXISTING);
                }
            }
        }
    }

    /** Paths mirroring dk.medcom.cda.CDAServlet's per-profile engine construction. */
    static IHEPaths pathsFor(ValidationProfile profile) {
        Path root = root();
        return new IHEPaths(
                root.resolve(profile.schemaPath).toString(),
                root.resolve("gazelle/ihe/valueSets").toString(),
                root.resolve("gazelle/ihe/mbvalidatorDetailedResult.xsl").toString());
    }
}
