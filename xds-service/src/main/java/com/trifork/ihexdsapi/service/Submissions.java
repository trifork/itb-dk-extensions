package com.trifork.ihexdsapi.service;

import com.trifork.ihexdsapi.configuration.SubmissionProperties;
import com.trifork.ihexdsapi.xds.Codes;
import jakarta.activation.DataHandler;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HexFormat;
import org.apache.cxf.attachment.ByteDataSource;
import org.openehealth.ipf.commons.ihe.xds.core.metadata.*;
import org.openehealth.ipf.commons.ihe.xds.core.requests.ProvideAndRegisterDocumentSet;
import org.openehealth.ipf.commons.ihe.xds.core.requests.RegisterDocumentSet;

/** Builds the ITI-41 and ITI-57 payloads from a CDA header and operator configuration. */
public final class Submissions {
    private Submissions() {}

    public static ProvideAndRegisterDocumentSet provide(
            byte[] document,
            DocumentMetadata cda,
            Code formatCode,
            SubmissionProperties properties) {
        var entry = new DocumentEntry();
        entry.assignEntryUuid();
        entry.setUniqueId(cda.uniqueId());
        entry.setPatientId(cpr(cda.patientId()));
        entry.setSourcePatientId(cpr(cda.patientId()));
        entry.setAvailabilityStatus(AvailabilityStatus.APPROVED);
        entry.setType(DocumentEntryType.STABLE);
        entry.setMimeType(cda.mimeType());
        entry.setLanguageCode(cda.languageCode());
        if (!cda.title().isEmpty()) entry.setTitle(new LocalizedString(cda.title()));
        var type = typeCode(cda);
        entry.setTypeCode(type);
        entry.setClassCode(type);
        entry.setFormatCode(named(formatCode));
        entry.setHealthcareFacilityTypeCode(named(properties.facilityType()));
        entry.setPracticeSettingCode(named(properties.practiceSetting()));
        entry.getConfidentialityCodes()
                .add(named(new Code(cda.confidentialityCode(), null, cda.confidentialityScheme())));
        entry.setCreationTime(
                cda.creationTime().isEmpty()
                        ? Timestamp.now()
                        : Timestamp.fromHL7(cda.creationTime()));
        entry.setSize((long) document.length);
        entry.setHash(sha1(document));
        if (!cda.authorFamilyName().isEmpty()) {
            var author = new Author();
            author.setAuthorPerson(
                    new Person(
                            null,
                            new XcnName(
                                    cda.authorFamilyName(),
                                    cda.authorGivenName(),
                                    null,
                                    null,
                                    null,
                                    null)));
            entry.getAuthors().add(author);
        }
        var submission =
                submissionSet(cda.patientId(), type, properties, "ITB document submission");
        var attachment =
                new Document(entry, new DataHandler(new ByteDataSource(document, cda.mimeType())));
        var member = new Association();
        member.assignEntryUuid();
        member.setAssociationType(AssociationType.HAS_MEMBER);
        member.setLabel(AssociationLabel.ORIGINAL);
        member.setSourceUuid(submission.getEntryUuid());
        member.setTargetUuid(entry.getEntryUuid());
        return ProvideAndRegisterDocumentSet.builderWith(submission)
                .withDocument(attachment)
                .withAssociation(member)
                .build();
    }

    /** Moves one document from Approved to Deprecated; no document is sent. */
    public static RegisterDocumentSet deprecate(
            String patientId, String entryUuid, Code contentType, SubmissionProperties properties) {
        var submission = submissionSet(patientId, contentType, properties, "ITB deprecation");
        var status = new Association();
        status.assignEntryUuid();
        status.setAssociationType(AssociationType.UPDATE_AVAILABILITY_STATUS);
        status.setSourceUuid(submission.getEntryUuid());
        status.setTargetUuid(entryUuid);
        status.setOriginalStatus(AvailabilityStatus.APPROVED);
        status.setNewStatus(AvailabilityStatus.DEPRECATED);
        return RegisterDocumentSet.builderWith(submission).withAssociation(status).build();
    }

    private static SubmissionSet submissionSet(
            String patientId, Code contentType, SubmissionProperties properties, String title) {
        var set = new SubmissionSet();
        set.assignEntryUuid();
        set.setUniqueId(DocumentMetadata.newOid());
        set.setSourceId(properties.sourceId());
        set.setPatientId(cpr(patientId));
        set.setSubmissionTime(Timestamp.now());
        set.setContentTypeCode(named(contentType));
        set.setTitle(new LocalizedString(title));
        set.setAvailabilityStatus(AvailabilityStatus.APPROVED);
        return set;
    }

    private static Code typeCode(DocumentMetadata cda) {
        return named(
                new Code(
                        cda.typeCode(),
                        cda.typeDisplayName().isEmpty()
                                ? null
                                : new LocalizedString(cda.typeDisplayName()),
                        cda.typeScheme()));
    }

    /**
     * DROS requires a display name on every coded value, even when the source gave none. As the
     * original ihe-xds-api did, a missing name falls back to the code itself.
     */
    static Code named(Code code) {
        if (code.getDisplayName() != null
                && code.getDisplayName().getValue() != null
                && !code.getDisplayName().getValue().isBlank()) return code;
        return new Code(code.getCode(), new LocalizedString(code.getCode()), code.getSchemeName());
    }

    private static Identifiable cpr(String id) {
        return new Identifiable(id, new AssigningAuthority(Codes.DK_CPR_CLASSIFICAION_OID));
    }

    // XDS defines DocumentEntry.hash as a SHA-1 digest; it is an integrity check, not a security
    // control.
    @SuppressWarnings("java:S4790")
    private static String sha1(byte[] content) {
        try {
            return HexFormat.of().formatHex(MessageDigest.getInstance("SHA-1").digest(content));
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException(e);
        }
    }
}
