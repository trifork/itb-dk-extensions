package com.trifork.ihexdsapi.configuration;

import static org.junit.jupiter.api.Assertions.*;

import com.trifork.ihexdsapi.service.impl.CodesServiceImpl;
import com.trifork.ihexdsapi.service.impl.CodesServiceImpl.CodeListDefinition;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.stream.Collectors;
import org.junit.jupiter.api.Test;
import org.openapitools.model.Code;
import org.springframework.boot.context.properties.bind.Binder;
import org.springframework.boot.context.properties.source.MapConfigurationPropertySource;

class TypeCodePropertiesTest {
    private static final String MEDCOM = "1.2.208.184.100.1";
    private static final String LOINC = "2.16.840.1.113883.6.1";

    @Test
    void publishedCatalogueIncludesStamkortAndOtherDocumentTypesWithTheirSchemes()
            throws Exception {
        // Read only maintained defaults, never the local credentials/configuration import.
        var properties = new Properties();
        try (var reader =
                Files.newBufferedReader(
                        Path.of("application.properties"), StandardCharsets.UTF_8)) {
            properties.load(reader);
        }
        var binder = new Binder(new MapConfigurationPropertySource(properties));
        var overrides = binder.bind("type.code", TypeCodeProperties.class).get();
        var type =
                new CodeListDefinition(
                        properties.getProperty("type.code.codes"),
                        properties.getProperty("type.code.names"),
                        properties.getProperty("type.code.scheme"),
                        overrides.schemeOverrides());
        var format =
                new CodeListDefinition(
                        properties.getProperty("format.code.codes"),
                        properties.getProperty("format.code.names"),
                        properties.getProperty("format.code.scheme"));
        var empty = new CodeListDefinition("", "", "");
        var service = new CodesServiceImpl(type, format, empty, empty, empty, empty);
        var types =
                service.getTypeCodesList().stream()
                        .collect(Collectors.toMap(Code::getCode, Code::getScheme));
        assertEquals(18, types.size());
        for (String code : Set.of("CMR", "PDC", "MADC", "PFR", "PSCR", "PMR")) {
            assertEquals(MEDCOM, types.get(code), code);
        }
        for (String code :
                Set.of(
                        "53576-5",
                        "74468-0",
                        "74465-6",
                        "11502-2",
                        "56446-8",
                        "39289-4",
                        "39290-2",
                        "103140-0",
                        "11450-4",
                        "81215-6",
                        "57059-8",
                        "28615-3")) {
            assertEquals(LOINC, types.get(code), code);
        }
        var formats =
                service.getFormatCodesList().stream()
                        .collect(Collectors.toMap(Code::getCode, Code::getScheme));
        assertEquals(28, formats.size());
        for (String code :
                Set.of(
                        "pdc-v2.0",
                        "pdc-v3.0",
                        "apd-v2.0.1",
                        "cpd-v1.0.1",
                        "cpd-v2.0",
                        "phad-v1.0",
                        "pmr-v1.0",
                        "prf-v1.0",
                        "pscr-v1.0",
                        "phmr",
                        "phmr-v2.1",
                        "qfdd-v1.2",
                        "qrd-v1.3")) {
            assertEquals(
                    "1.2.208.184.100.10", formats.get("urn:ad:dk:medcom:" + code + ":full"), code);
        }
    }

    @Test
    void legacySingleSchemeConfigurationAndUnusedOverridesRemainSupported() throws Exception {
        assertTrue(new TypeCodeProperties(null).schemeOverrides().isEmpty());
        var type =
                new CodeListDefinition(
                        "local", "Local type", "local-scheme", Map.of("PDC", MEDCOM));
        var empty = new CodeListDefinition("", "", "");
        var service = new CodesServiceImpl(type, empty, empty, empty, empty, empty);
        assertEquals(1, service.getTypeCodesList().size());
        assertEquals("local-scheme", service.getTypeCodesList().getFirst().getScheme());
    }

    @Test
    void rejectsBlankCodeOrSchemeOverrides() {
        var blankCode = Map.of(" ", MEDCOM);
        var blankScheme = Map.of("PDC", " ");
        assertThrows(IllegalArgumentException.class, () -> new TypeCodeProperties(blankCode));
        assertThrows(IllegalArgumentException.class, () -> new TypeCodeProperties(blankScheme));
    }
}
