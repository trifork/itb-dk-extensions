package com.trifork.itb.plugin;

import static org.junit.jupiter.api.Assertions.*;

import java.util.ArrayList;
import java.util.List;
import net.ihe.gazelle.ccdav21.ccdav21.CCDAV21PackValidator;
import net.ihe.gazelle.cda.POCDMT000040ClinicalDocument;
import net.ihe.gazelle.cda.POCDMT000040Organizer;
import net.ihe.gazelle.datatypes.II;
import net.ihe.gazelle.validation.DetailedResult;
import net.ihe.gazelle.validation.MDAValidation;
import net.ihe.gazelle.validation.Note;
import net.ihe.gazelle.validation.Notification;
import net.ihe.gazelle.validation.Warning;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.NullAndEmptySource;
import org.junit.jupiter.params.provider.ValueSource;

class GazelleFindingsTest {
    private static final String UUID_RULE = "cdadt-IISpec-cdadt011";
    private static final String ORGANIZER_ID_RULE = "ccdav21-VitalSignsOrganizerV3-ccdav211617";
    private static final String CCDA_DOCUMENT_TYPE_RULE =
            "ccdav21-CCDAV21ClinicalDocumentSpec-ccdav215689";
    private static final String LOCATION =
            "/ClinicalDocument/component/structuredBody/component/section/entry/organizer";

    @Test
    void ccdav21DocumentMembershipIsExcludedOnlyForPhmrProfiles() {
        var document = new POCDMT000040ClinicalDocument();
        var template = new II();
        template.setRoot("2.16.840.1.113883.10.20.9");
        document.getTemplateId().add(template);
        List<Notification> notifications = new ArrayList<>();
        new CCDAV21PackValidator().validate(document, "/ClinicalDocument", notifications);
        assertTrue(
                notifications.stream()
                        .anyMatch(
                                n ->
                                        n instanceof net.ihe.gazelle.validation.Error
                                                && CCDA_DOCUMENT_TYPE_RULE.equals(
                                                        n.getIdentifiant())));
        for (ValidationProfile profile : ValidationProfile.values()) {
            List<Finding> findings = collect(notifications, profile);
            assertEquals(
                    !profile.usesPhmrEngine,
                    findings.stream()
                            .anyMatch(
                                    f ->
                                            f.level == Finding.Level.ERROR
                                                    && CCDA_DOCUMENT_TYPE_RULE.equals(
                                                            f.assertionId)),
                    profile.fullType);
        }
    }

    @Test
    void realCcdav21ErrorsSurviveMappingAndDisappearWhenSatisfied() {
        var organizer = new POCDMT000040Organizer();
        var template = new II();
        template.setRoot("2.16.840.1.113883.10.20.22.4.26");
        organizer.getTemplateId().add(template);

        List<Notification> notifications = validate(organizer);
        List<Finding> findings = collect(notifications);
        long errors =
                notifications.stream()
                        .filter(net.ihe.gazelle.validation.Error.class::isInstance)
                        .count();
        assertTrue(errors > 0);
        assertEquals(errors, findings.stream().filter(f -> f.level == Finding.Level.ERROR).count());
        Finding missingId =
                findings.stream()
                        .filter(f -> ORGANIZER_ID_RULE.equals(f.assertionId))
                        .findFirst()
                        .orElseThrow();
        assertEquals(Finding.Level.ERROR, missingId.level);
        assertTrue(missingId.description.contains("[at " + LOCATION + "]"));

        // C-CDA 2.1 Vital Signs Organizer V3, CONF:1198-7282: at least one id.
        var id = new II();
        id.setRoot("1.2.3.4");
        organizer.getId().add(id);
        assertTrue(
                collect(validate(organizer)).stream()
                        .noneMatch(f -> ORGANIZER_ID_RULE.equals(f.assertionId)));
    }

    @ParameterizedTest
    @NullAndEmptySource
    @ValueSource(
            strings = {
                "Missing required element",
                "WARNING: this is still a typed error",
                "ERROR: legacy wording"
            })
    void typedErrorsDoNotDependOnWording(String description) {
        var error = notification(new net.ihe.gazelle.validation.Error(), description, "error-rule");
        List<Finding> findings = collect(List.of(error));
        assertEquals(1, findings.size());
        assertEquals(Finding.Level.ERROR, findings.getFirst().level);
        assertEquals("error-rule", findings.getFirst().assertionId);
        assertEquals(description == null ? "" : description, findings.getFirst().description);
    }

    @ParameterizedTest
    @ValueSource(
            strings = {
                "Recommended element missing",
                "ERROR: wording does not set severity",
                "WARNING: legacy wording"
            })
    void typedWarningsDoNotDependOnWording(String description) {
        List<Finding> findings =
                collect(List.of(notification(new Warning(), description, "warning-rule")));
        assertEquals(1, findings.size());
        assertEquals(Finding.Level.WARNING, findings.getFirst().level);
        assertEquals(description, findings.getFirst().description);
    }

    @ParameterizedTest
    @ValueSource(
            strings = {"UUID letters must be uppercase", "ERROR: UUID letters must be uppercase"})
    void uppercaseUuidRuleRemainsInformational(String description) {
        List<Finding> findings =
                collect(
                        List.of(
                                notification(
                                        new net.ihe.gazelle.validation.Error(),
                                        description,
                                        UUID_RULE)));
        assertEquals(1, findings.size());
        assertEquals(Finding.Level.INFO, findings.getFirst().level);
        assertEquals(UUID_RULE, findings.getFirst().assertionId);
        assertFalse(findings.getFirst().description.contains("ERROR"));
    }

    @Test
    void notesAreIgnoredEvenWhenTheirDescriptionContainsSeverityWords() {
        assertTrue(
                collect(
                                List.of(
                                        notification(
                                                new Note(),
                                                "ERROR: a note quoting a failed condition",
                                                "note-rule"),
                                        notification(
                                                new Note(),
                                                "WARNING: a note quoting a recommendation",
                                                "note-rule"),
                                        notification(
                                                new Note(),
                                                "ERROR: successful UUID check",
                                                UUID_RULE)))
                        .isEmpty());
    }

    private static List<Notification> validate(POCDMT000040Organizer organizer) {
        List<Notification> notifications = new ArrayList<>();
        new CCDAV21PackValidator().validate(organizer, LOCATION, notifications);
        return notifications;
    }

    private static Notification notification(
            Notification notification, String description, String identifier) {
        notification.setDescription(description);
        notification.setIdentifiant(identifier);
        return notification;
    }

    private static List<Finding> collect(List<Notification> notifications) {
        return collect(notifications, ValidationProfile.PHMR);
    }

    private static List<Finding> collect(
            List<Notification> notifications, ValidationProfile profile) {
        var result = new DetailedResult();
        result.setMDAValidation(new MDAValidation());
        result.getMDAValidation().getWarningOrErrorOrNote().addAll(notifications);
        List<Finding> findings = new ArrayList<>();
        CdaDkGazellePlugin.collectMdaFindings(result, profile, findings);
        return findings;
    }
}
