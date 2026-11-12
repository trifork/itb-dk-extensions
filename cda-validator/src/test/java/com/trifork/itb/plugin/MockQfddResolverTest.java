package com.trifork.itb.plugin;

import static org.junit.jupiter.api.Assertions.*;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.stream.Stream;
import javax.xml.parsers.DocumentBuilderFactory;
import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.Test;

class MockQfddResolverTest {

    private static final Path QFDD_SAMPLES = Path.of("..", "samples", "qfdd");
    private final MockQfddResolver resolver = new MockQfddResolver();

    private static String idOf(Path file) throws Exception {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        return factory.newDocumentBuilder()
                .parse(file.toFile())
                .getElementsByTagNameNS("urn:hl7-org:v3", "id")
                .item(0)
                .getAttributes()
                .getNamedItem("extension")
                .getNodeValue();
    }

    /** The bundled mock registry must stay byte-identical to the published QFDD samples. */
    @Test
    void everyQfddSampleIsServedUnchanged() throws Exception {
        // The Docker build context is cda-validator/ only; the repository-level build checks this.
        Assumptions.assumeTrue(
                Files.isDirectory(QFDD_SAMPLES), "samples/ is outside the Docker build context");
        List<Path> samples;
        try (Stream<Path> files = Files.list(QFDD_SAMPLES)) {
            samples = files.filter(f -> f.toString().endsWith(".xml")).sorted().toList();
        }
        assertFalse(samples.isEmpty());
        for (Path sample : samples) {
            QfddLookup lookup = resolver.resolve(idOf(sample), null);
            assertEquals(QfddLookup.Status.FOUND, lookup.status, sample.toString());
            assertArrayEquals(Files.readAllBytes(sample), lookup.document(), sample.toString());
        }
    }

    @Test
    void versionIsMatchedWhenTheReferenceStatesOne() {
        String id = "6069bddf-b6ae-4e64-833e-ad2ba8b5c6b2";
        assertEquals(QfddLookup.Status.FOUND, resolver.resolve(id, "1").status);
        assertEquals(QfddLookup.Status.NOT_FOUND, resolver.resolve(id, "2").status);
    }

    @Test
    void unknownAndMalformedIdentifiersAreNotFound() {
        for (String id :
                new String[] {
                    "11111111-1111-4111-8111-111111111111",
                    "../6069bddf-b6ae-4e64-833e-ad2ba8b5c6b2",
                    "not-a-uuid",
                    "",
                    null
                }) {
            assertEquals(QfddLookup.Status.NOT_FOUND, resolver.resolve(id, null).status, id);
        }
    }
}
