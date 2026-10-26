package com.trifork.ihexdsapi.configuration;

import static org.junit.jupiter.api.Assertions.*;

import com.trifork.ihexdsapi.service.impl.CodesServiceImpl;
import com.trifork.ihexdsapi.service.impl.CodesServiceImpl.CodeListDefinition;
import java.util.Map;
import java.util.stream.Collectors;
import org.junit.jupiter.api.Test;
import org.openapitools.model.Code;
import org.springframework.boot.context.properties.bind.Binder;
import org.springframework.boot.context.properties.source.MapConfigurationPropertySource;

class TypeCodePropertiesTest {
    private static final String MEDCOM = "1.2.208.184.100.1";
    private static final String LOINC = "2.16.840.1.113883.6.1";

    @Test
    void mixedTypeCodesBindAndRetainTheirIndividualSchemes() throws Exception {
        var properties =
                Map.of(
                        "type.code.scheme-overrides[PDC]", MEDCOM,
                        "type.code.scheme-overrides[PSCR]", MEDCOM);
        var binder = new Binder(new MapConfigurationPropertySource(properties));
        var overrides = binder.bind("type.code", TypeCodeProperties.class).get();
        var type =
                new CodeListDefinition(
                        "53576-5;PDC;PSCR",
                        "PHMR;Stamkort;Pregnancy Shared Care Report",
                        LOINC,
                        overrides.schemeOverrides());
        var empty = new CodeListDefinition("", "", "");
        var service = new CodesServiceImpl(type, empty, empty, empty, empty, empty);
        var types =
                service.getTypeCodesList().stream()
                        .collect(Collectors.toMap(Code::getCode, Code::getScheme));
        assertEquals(Map.of("53576-5", LOINC, "PDC", MEDCOM, "PSCR", MEDCOM), types);
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
