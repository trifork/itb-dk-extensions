package com.trifork.itb.plugin;

import static org.junit.jupiter.api.Assertions.*;

import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.function.UnaryOperator;
import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.Test;

class QrdQfddPairRulesTest {

    // The Docker build context is cda-validator/ only, so the tests use their own fixture copies;
    // fixturesMatchTheSamples keeps them identical to samples/ wherever samples/ is available.
    private static final Path SAMPLES = Path.of("..", "samples");
    private static final String QFDD_ID = "6069bddf-b6ae-4e64-833e-ad2ba8b5c6b2";
    private static final String ANSWER_ONE =
            "<value code=\"A00001_3\" displayName=\"Moderat svært\" codeSystem=\"1.2.208.195.1.1.4\""
                    + " codeSystemName=\"Sundhedsvæsenets Kvalitetsinstitut\" xsi:type=\"CE\"/>";
    private static final QfddResolver MOCK = new MockQfddResolver();
    private static final List<String> FIXTURES =
            List.of(
                    "qrd_overekstremitet.xml",
                    "qrd_multiple_choice.xml",
                    "qrd_associated_text_1.xml",
                    "qrd_associated_text_2.xml",
                    "qrd_analog_slider.xml",
                    "qrd_analog_slider_feedback.xml",
                    "qrd_multiple_choice_grouped.xml");

    private static String fixture(String name) throws Exception {
        try (var stream = QrdQfddPairRulesTest.class.getResourceAsStream("/pair/" + name)) {
            assertNotNull(stream, "Missing test fixture " + name);
            return new String(stream.readAllBytes(), StandardCharsets.UTF_8);
        }
    }

    private static String qrd() throws Exception {
        return fixture("qrd_overekstremitet.xml");
    }

    private static List<Finding> validate(String qrd, QfddResolver resolver) {
        return QrdQfddPairRules.validate(qrd.getBytes(StandardCharsets.UTF_8), resolver);
    }

    private static List<Finding> validate(UnaryOperator<String> mutation) throws Exception {
        String original = qrd();
        String mutated = mutation.apply(original);
        assertNotEquals(original, mutated, "The mutation must change the QRD");
        return validate(mutated, MOCK);
    }

    private static Finding single(List<Finding> findings, String assertionId) {
        List<Finding> matching =
                findings.stream().filter(f -> assertionId.equals(f.assertionId)).toList();
        assertEquals(1, matching.size(), assertionId + " in " + describe(findings));
        return matching.get(0);
    }

    private static String describe(List<Finding> findings) {
        return findings.stream()
                .map(f -> f.level + " " + f.assertionId + " " + f.description)
                .toList()
                .toString();
    }

    private static void assertNoFailures(List<Finding> findings) {
        assertTrue(
                findings.stream().noneMatch(f -> f.level != Finding.Level.INFO),
                describe(findings));
    }

    @Test
    void fixturesMatchTheSamples() throws Exception {
        Assumptions.assumeTrue(
                Files.isDirectory(SAMPLES), "samples/ is outside the Docker build context");
        for (String name : FIXTURES) {
            assertEquals(Files.readString(SAMPLES.resolve("qrd/" + name)), fixture(name), name);
        }
    }

    @Test
    void validPairIsComparedWithoutFindings() throws Exception {
        List<Finding> findings = validate(qrd(), MOCK);
        assertNoFailures(findings);
        Finding compared = single(findings, QrdQfddPairRules.COMPARED_RULE);
        assertTrue(compared.description.contains(QFDD_ID), compared.description);
    }

    @Test
    void answerOutsideTheQuestionOptionsIsReportedOnTheAnswer() throws Exception {
        List<Finding> findings =
                validate(
                        q ->
                                q.replace(
                                        "code=\"A00001_3\" displayName",
                                        "code=\"A00001_9\" displayName"));
        Finding finding = single(findings, "PRO-PAIR-ANSWER-OPTION");
        assertEquals(Finding.Level.ERROR, finding.level);
        assertNotNull(finding.lineLocation, "The finding must carry the line of the answer");
        assertEquals(
                1279,
                Integer.parseInt(
                        finding.lineLocation.substring(0, finding.lineLocation.indexOf(':'))));
    }

    @Test
    void publishedExamplesAreComparedWithTheirPublishedQfdd() throws Exception {
        String sample = fixture("qrd_multiple_choice.xml");
        assertNoFailures(validate(sample, MOCK));
        List<Finding> findings = validate(sample.replace("code=\"A1_2\"", "code=\"A1_7\""), MOCK);
        assertEquals(Finding.Level.ERROR, single(findings, "PRO-PAIR-ANSWER-OPTION").level);
    }

    @Test
    void moreSelectedAnswersThanTheQuestionAllowsIsReported() throws Exception {
        List<Finding> findings = validate(q -> q.replace(ANSWER_ONE, ANSWER_ONE + ANSWER_ONE));
        assertEquals(Finding.Level.ERROR, single(findings, "PRO-PAIR-ANSWER-COUNT").level);
    }

    @Test
    void responseNotIdentifyingAQuestionOfTheQfddIsReported() throws Exception {
        List<Finding> findings =
                validate(
                        q ->
                                q.replace(
                                        "<id root=\"1.2.208.195.1.1.4\" extension=\"00001\"",
                                        "<id root=\"1.2.208.195.1.1.4\" extension=\"99999\""));
        assertEquals(Finding.Level.ERROR, single(findings, "PRO-PAIR-QUESTION-ID").level);
    }

    @Test
    void unknownQfddIsAWarningNeverAPass() throws Exception {
        List<Finding> findings =
                validate(q -> q.replace(QFDD_ID, "11111111-1111-4111-8111-111111111111"));
        Finding finding = single(findings, QrdQfddPairRules.UNRESOLVED_RULE);
        assertEquals(Finding.Level.WARNING, finding.level);
        assertTrue(finding.description.contains("could not be validated"), finding.description);
        assertTrue(findings.stream().noneMatch(f -> f.level == Finding.Level.ERROR));
        assertTrue(
                findings.stream()
                        .noneMatch(f -> QrdQfddPairRules.COMPARED_RULE.equals(f.assertionId)));
    }

    @Test
    void unavailableAndAmbiguousResolutionsAreWarnings() throws Exception {
        for (QfddLookup lookup :
                List.of(QfddLookup.unavailable("down"), QfddLookup.ambiguous("two matches"))) {
            List<Finding> findings = validate(qrd(), (id, version) -> lookup);
            assertEquals(
                    Finding.Level.WARNING,
                    single(findings, QrdQfddPairRules.UNRESOLVED_RULE).level);
        }
    }

    @Test
    void differentReferencesInOneQrdAreAmbiguous() throws Exception {
        String original = qrd();
        int second = original.indexOf(QFDD_ID, original.indexOf(QFDD_ID) + 1);
        String mutated =
                original.substring(0, second)
                        + "11111111-1111-4111-8111-111111111111"
                        + original.substring(second + QFDD_ID.length());
        Finding finding = single(validate(mutated, MOCK), QrdQfddPairRules.UNRESOLVED_RULE);
        assertTrue(finding.description.contains("ambiguous"), finding.description);
    }

    @Test
    void qrdWithoutAReferenceCannotBeValidatedAgainstAQfdd() throws Exception {
        List<Finding> findings =
                validate(q -> q.replace("root=\"2.16.840.1.113883.4.873\"", "root=\"1.2.3\""));
        assertEquals(
                Finding.Level.WARNING, single(findings, QrdQfddPairRules.UNRESOLVED_RULE).level);
    }

    @Test
    void unparsableQrdIsAWarningHere() {
        Finding finding =
                single(validate("<ClinicalDocument", MOCK), QrdQfddPairRules.UNRESOLVED_RULE);
        assertEquals(Finding.Level.WARNING, finding.level);
    }

    @Test
    void comparisonThatCannotRunIsAnError() throws Exception {
        QfddResolver broken =
                (id, version) ->
                        QfddLookup.found("not xml".getBytes(StandardCharsets.UTF_8), "test");
        Finding finding = single(validate(qrd(), broken), QrdQfddPairRules.ENGINE_RULE);
        assertEquals(Finding.Level.ERROR, finding.level);
    }

    @Test
    void answersFollowingTheQuestionDependenciesAreAccepted() throws Exception {
        // The associated text question is asked only when Q311 is answered A311_3.
        assertNoFailures(validate(fixture("qrd_associated_text_1.xml"), MOCK));
        assertNoFailures(validate(fixture("qrd_associated_text_2.xml"), MOCK));
        assertNoFailures(validate(fixture("qrd_analog_slider_feedback.xml"), MOCK));
    }

    @Test
    void answerToAQuestionThatWasNotAskedIsReported() throws Exception {
        // The published example marks the associated answer with the QFDD feedback template
        // (32.4.6) instead of the QRD text response template (33.4.6), so it is corrected here.
        String answered =
                fixture("qrd_associated_text_2.xml")
                        .replace(
                                "<templateId root=\"2.16.840.1.113883.10.20.32.4.6\"/>",
                                "<templateId root=\"2.16.840.1.113883.10.20.33.4.6\"/>");
        assertNoFailures(validate(answered, MOCK));
        List<Finding> findings =
                validate(
                        answered.replace("<value code=\"A311_3\"", "<value code=\"A311_1\""), MOCK);
        Finding finding = single(findings, "PRO-PAIR-PRECONDITION");
        assertEquals(Finding.Level.ERROR, finding.level);
        assertNotNull(finding.lineLocation);
    }

    @Test
    void analogSliderAnswerMustLieOnTheQfddScale() throws Exception {
        String sample = fixture("qrd_analog_slider.xml");
        assertNoFailures(validate(sample, MOCK));
        for (String value : List.of("9", "24")) {
            List<Finding> findings =
                    validate(
                            sample.replace(
                                    "<value value=\"8\" xsi:type=\"INT\"/>",
                                    "<value value=\"" + value + "\" xsi:type=\"INT\"/>"),
                            MOCK);
            assertEquals(
                    Finding.Level.ERROR, single(findings, "PRO-PAIR-ANSWER-RANGE").level, value);
        }
    }

    @Test
    void publishedGroupedExampleUsesTheDiscreteSliderPatternForMultipleChoiceQuestions()
            throws Exception {
        // Recorded in samples/validation-cases.json: the QFDD defines plain multiple choice
        // questions, the QRD answers five of them with the Discrete Slider response pattern.
        long mismatches =
                validate(fixture("qrd_multiple_choice_grouped.xml"), MOCK).stream()
                        .filter(f -> "PRO-PAIR-ANSWER-TYPE".equals(f.assertionId))
                        .count();
        assertEquals(5, mismatches);
    }

    @Test
    void missingAnswerToAMandatoryQuestionIsAnchoredAtTheResponseOrganizer() throws Exception {
        String qfdd = new String(MOCK.resolve(QFDD_ID, null).document(), StandardCharsets.UTF_8);
        // The first question's option limits become 1..1, so that it must be answered.
        String mandatory = qfdd.replaceFirst("<low value=\"0\" />", "<low value=\"1\" />");
        assertNotEquals(qfdd, mandatory);
        QfddResolver resolver =
                (id, version) ->
                        QfddLookup.found(mandatory.getBytes(StandardCharsets.UTF_8), "test");
        // The response copies the option limits, so it states the same minimum.
        String original = qrd().replaceFirst("<low value=\"0\"/>", "<low value=\"1\"/>");
        assertNoFailures(validate(original, resolver));

        List<Finding> findings =
                validate(original.replaceFirst("<value code=\"A00001_3\"[^>]*/>", ""), resolver);
        Finding finding = single(findings, "PRO-PAIR-ANSWER-MISSING");
        assertEquals(Finding.Level.ERROR, finding.level);
        assertTrue(finding.description.contains("Q00001"), finding.description);
        assertNotNull(finding.lineLocation, "The finding must be anchored in the QRD");
    }

    @Test
    void statedQfddVersionThatTheRegistryDoesNotHoldIsNotValidated() throws Exception {
        List<Finding> findings =
                validate(
                        q ->
                                q.replace(
                                        "displayName=\"Questionnaire Form Definition Document\"/>",
                                        "displayName=\"Questionnaire Form Definition Document\"/>"
                                                + "<versionNumber value=\"2\"/>"));
        Finding finding = single(findings, QrdQfddPairRules.UNRESOLVED_RULE);
        assertEquals(Finding.Level.WARNING, finding.level);
        assertTrue(finding.description.contains("version 2"), finding.description);
    }
}
