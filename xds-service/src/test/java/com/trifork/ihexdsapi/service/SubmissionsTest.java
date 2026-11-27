package com.trifork.ihexdsapi.service;

import static org.junit.jupiter.api.Assertions.*;

import com.trifork.ihexdsapi.configuration.SubmissionProperties;
import java.nio.charset.StandardCharsets;
import org.junit.jupiter.api.Test;
import org.openehealth.ipf.commons.ihe.xds.XDS;
import org.openehealth.ipf.commons.ihe.xds.XdsIntegrationProfile;
import org.openehealth.ipf.commons.ihe.xds.XdsInteractionId;
import org.openehealth.ipf.commons.ihe.xds.core.ebxml.ebxml30.EbXMLFactory30;
import org.openehealth.ipf.commons.ihe.xds.core.metadata.*;
import org.openehealth.ipf.commons.ihe.xds.core.transform.requests.ProvideAndRegisterDocumentSetTransformer;
import org.openehealth.ipf.commons.ihe.xds.core.transform.requests.RegisterDocumentSetTransformer;
import org.openehealth.ipf.commons.ihe.xds.core.validate.ValidationProfile;
import org.openehealth.ipf.commons.ihe.xds.core.validate.requests.ProvideAndRegisterDocumentSetRequestValidator;
import org.openehealth.ipf.commons.ihe.xds.core.validate.requests.SubmitObjectsRequestValidator;

/** The payloads are checked against IPF's own XDS.b validators for ITI-41 and ITI-57. */
class SubmissionsTest {
    private static final byte[] DOCUMENT = CdaMetadataTest.HEADER.getBytes(StandardCharsets.UTF_8);
    private static final SubmissionProperties PROPERTIES = SubmissionProperties.defaults();

    private static ValidationProfile profile(XDS.Interactions interaction) {
        return new ValidationProfile() {
            public boolean isQuery() {
                return false;
            }

            public XdsInteractionId getInteractionId() {
                return interaction;
            }

            public XdsIntegrationProfile getInteractionProfile() {
                return interaction.getInteractionProfile();
            }
        };
    }

    @Test
    void provideAndRegisterCarriesTheCdaAndItsHeaderMetadata() {
        var cda = CdaMetadata.parse(DOCUMENT);
        var format = new Code("urn:ad:dk:medcom:qfdd-v1.2:full", null, "1.2.208.184.100.10");
        var request = Submissions.provide(DOCUMENT, cda, format, PROPERTIES);

        assertEquals(1, request.getDocuments().size());
        var document = request.getDocuments().getFirst();
        var entry = document.getDocumentEntry();
        assertEquals("1.2.3.4.5^abc", entry.getUniqueId());
        assertEquals("0103660140", entry.getPatientId().getId());
        assertEquals(
                "1.2.208.176.1.2", entry.getPatientId().getAssigningAuthority().getUniversalId());
        assertEquals(entry.getPatientId(), entry.getSourcePatientId());
        assertEquals(AvailabilityStatus.APPROVED, entry.getAvailabilityStatus());
        assertEquals(DocumentEntryType.STABLE, entry.getType());
        assertEquals("text/xml", entry.getMimeType());
        assertEquals("74468-0", entry.getTypeCode().getCode());
        assertEquals(entry.getTypeCode(), entry.getClassCode());
        assertEquals(format.getCode(), entry.getFormatCode().getCode());
        assertEquals(format.getSchemeName(), entry.getFormatCode().getSchemeName());
        assertEntryDetails(entry);

        var set = request.getSubmissionSet();
        assertEquals(PROPERTIES.sourceId(), set.getSourceId());
        assertTrue(set.getUniqueId().startsWith("2.25."));
        assertEquals(entry.getPatientId(), set.getPatientId());
        assertEquals(1, request.getAssociations().size());
        var member = request.getAssociations().getFirst();
        assertEquals(AssociationType.HAS_MEMBER, member.getAssociationType());
        assertEquals(set.getEntryUuid(), member.getSourceUuid());
        assertEquals(entry.getEntryUuid(), member.getTargetUuid());

        var wire =
                new ProvideAndRegisterDocumentSetTransformer(new EbXMLFactory30()).toEbXML(request);
        assertDoesNotThrow(
                () ->
                        ProvideAndRegisterDocumentSetRequestValidator.getInstance()
                                .validate(wire, profile(XDS.Interactions.ITI_41)));
    }

    private static void assertEntryDetails(DocumentEntry entry) {
        assertEquals("R", entry.getConfidentialityCodes().getFirst().getCode());
        assertEquals("en-US", entry.getLanguageCode());
        assertEquals("Form", entry.getTitle().getValue());
        assertEquals((long) DOCUMENT.length, entry.getSize());
        assertEquals(40, entry.getHash().length());
        assertEquals(
                "Test",
                ((XcnName) entry.getAuthors().getFirst().getAuthorPerson().getName())
                        .getFamilyName());
        assertEquals(PROPERTIES.facilityType(), entry.getHealthcareFacilityTypeCode());
        assertEquals(PROPERTIES.practiceSetting(), entry.getPracticeSettingCode());
        assertNotNull(entry.getEntryUuid());
    }

    @Test
    void everyCodedValueCarriesADisplayNameBecauseDrosRequiresOne() {
        var cda =
                CdaMetadata.parse(
                        CdaMetadataTest.HEADER
                                .replace(" displayName=\"QFDD\"", "")
                                .getBytes(StandardCharsets.UTF_8));
        var entry =
                Submissions.provide(DOCUMENT, cda, new Code("fmt", null, "1.2"), PROPERTIES)
                        .getDocuments()
                        .getFirst()
                        .getDocumentEntry();
        for (var code :
                java.util.List.of(
                        entry.getTypeCode(),
                        entry.getClassCode(),
                        entry.getFormatCode(),
                        entry.getHealthcareFacilityTypeCode(),
                        entry.getPracticeSettingCode(),
                        entry.getConfidentialityCodes().getFirst())) {
            assertNotNull(code.getDisplayName(), code.toString());
            assertFalse(code.getDisplayName().getValue().isBlank(), code.toString());
        }
        // A missing name falls back to the code; a given name is kept.
        assertEquals("fmt", entry.getFormatCode().getDisplayName().getValue());
        assertEquals("74468-0", entry.getTypeCode().getDisplayName().getValue());
        var named = new Code("c", new LocalizedString("Readable"), "1.2");
        assertEquals("Readable", Submissions.named(named).getDisplayName().getValue());
        var update =
                Submissions.deprecate(
                        "0103660140", "urn:uuid:e", new Code("c", null, "1.2"), PROPERTIES);
        assertEquals(
                "c", update.getSubmissionSet().getContentTypeCode().getDisplayName().getValue());
    }

    @Test
    void everySubmissionGetsFreshIdentifiers() {
        var cda = CdaMetadata.parse(DOCUMENT);
        var format = new Code("f", null, "s");
        var first = Submissions.provide(DOCUMENT, cda, format, PROPERTIES);
        var second = Submissions.provide(DOCUMENT, cda, format, PROPERTIES);
        assertNotEquals(
                first.getSubmissionSet().getUniqueId(), second.getSubmissionSet().getUniqueId());
        assertNotEquals(
                first.getDocuments().getFirst().getDocumentEntry().getEntryUuid(),
                second.getDocuments().getFirst().getDocumentEntry().getEntryUuid());
    }

    @Test
    void deprecationIsAnAvailabilityStatusUpdateWithoutAnyDocument() {
        var contentType = new Code("74468-0", null, "2.16.840.1.113883.6.1");
        var request =
                Submissions.deprecate("0103660140", "urn:uuid:entry-1", contentType, PROPERTIES);

        assertTrue(request.getDocumentEntries().isEmpty());
        assertEquals(1, request.getAssociations().size());
        var update = request.getAssociations().getFirst();
        assertEquals(AssociationType.UPDATE_AVAILABILITY_STATUS, update.getAssociationType());
        assertEquals(request.getSubmissionSet().getEntryUuid(), update.getSourceUuid());
        assertEquals("urn:uuid:entry-1", update.getTargetUuid());
        assertEquals(AvailabilityStatus.APPROVED, update.getOriginalStatus());
        assertEquals(AvailabilityStatus.DEPRECATED, update.getNewStatus());
        assertEquals("0103660140", request.getSubmissionSet().getPatientId().getId());

        var wire = new RegisterDocumentSetTransformer(new EbXMLFactory30()).toEbXML(request);
        assertDoesNotThrow(
                () ->
                        SubmitObjectsRequestValidator.getInstance()
                                .validate(wire, profile(XDS.Interactions.ITI_57)));
    }
}
