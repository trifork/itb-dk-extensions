package com.trifork.ihexdsapi.service.impl;

import com.trifork.ihexdsapi.dgws.ItiException;
import com.trifork.ihexdsapi.xds.Codes;
import java.time.Instant;
import java.time.ZoneOffset;
import java.util.*;
import org.openapitools.model.*;
import org.openehealth.ipf.commons.ihe.xds.core.metadata.*;
import org.openehealth.ipf.commons.ihe.xds.core.metadata.Code;
import org.openehealth.ipf.commons.ihe.xds.core.requests.QueryRegistry;
import org.openehealth.ipf.commons.ihe.xds.core.requests.query.*;
import org.openehealth.ipf.commons.ihe.xds.core.stub.ebrs30.query.AdhocQueryRequest;
import org.openehealth.ipf.commons.ihe.xds.core.transform.requests.QueryRegistryTransformer;

/** Maps the existing REST contract to and from IPF XDS objects. */
final class Iti18Mapper {
    AdhocQueryRequest createQuery(Iti18QueryParameter iti18Request) throws ItiException {

        FindDocumentsQuery fdq = new FindDocumentsQuery();

        // Patient ID
        if (iti18Request.getPatientId() != null && !iti18Request.getPatientId().isEmpty()) {
            AssigningAuthority authority = new AssigningAuthority(Codes.DK_CPR_CLASSIFICAION_OID);
            Identifiable patientIdentifiable =
                    new Identifiable(iti18Request.getPatientId(), authority);
            fdq.setPatientId(patientIdentifiable);
        } else {
            throw new ItiException(1000, "Patient-ID is empty", null);
        }

        applyCodeFilters(iti18Request, fdq);
        applyTimeFilters(iti18Request, fdq);
        applyDocumentTypes(iti18Request, fdq);
        return createAdhocQueryRequest(fdq, QueryReturnType.LEAF_CLASS);
    }

    AdhocQueryRequest buildAdhocQueryRequest(String documentId) {
        List<String> uniqueIds = new LinkedList<String>();
        uniqueIds.add(documentId);

        GetDocumentsQuery gdq = new GetDocumentsQuery();
        gdq.setUniqueIds(uniqueIds);

        return createAdhocQueryRequest(gdq, QueryReturnType.LEAF_CLASS);
    }

    private AdhocQueryRequest createAdhocQueryRequest(Query query, QueryReturnType qrt) {
        QueryRegistry queryRegistry = new QueryRegistry(query);
        if (qrt != null) {
            queryRegistry.setReturnType(qrt);
        }
        QueryRegistryTransformer queryRegistryTransformer = new QueryRegistryTransformer();
        var ebxmlAdhocQueryRequest = queryRegistryTransformer.toEbXML(queryRegistry);
        return ebxmlAdhocQueryRequest.getInternal();
    }

    private List<Code> getCode(String code, String scheme) {
        List<Code> result = new ArrayList<>();
        Code c = new Code();
        c.setCode(code);
        c.setSchemeName(scheme);

        result.add(c);

        return result;
    }

    private Timestamp dateFormatterForRequest(Long date) {
        return new Timestamp(
                Instant.ofEpochMilli(date).atZone(ZoneOffset.UTC), Timestamp.Precision.SECOND);
    }

    private void applyCodeFilters(Iti18QueryParameter iti18Request, FindDocumentsQuery fdq) {
        var practiceSettingCode = iti18Request.getPracticeSettingCode();
        var healthcareFacilityTypeCode = iti18Request.getHealthcareFacilityTypeCode();
        // Availability status
        if (iti18Request.getAvailabilityStatus() != null
                && !iti18Request.getAvailabilityStatus().trim().isEmpty()) {
            List<AvailabilityStatus> status = new ArrayList<>();
            status.add(AvailabilityStatus.valueOfOpcode(iti18Request.getAvailabilityStatus()));
            fdq.setStatus(status);
        }

        fdq.setTypeCodes(
                CodeQueryValues.combine(iti18Request.getTypeCode(), iti18Request.getTypeCodes()));
        fdq.setFormatCodes(
                CodeQueryValues.combine(
                        iti18Request.getFormatCode(), iti18Request.getFormatCodes()));

        applyEventFilter(iti18Request, fdq);
        // HealthcareFacilityType code
        if (healthcareFacilityTypeCode != null && !healthcareFacilityTypeCode.getCode().isEmpty()) {

            fdq.setHealthcareFacilityTypeCodes(
                    getCode(
                            healthcareFacilityTypeCode.getCode(),
                            healthcareFacilityTypeCode.getCodeScheme()));
        }

        // Practicesetting code
        if (practiceSettingCode != null && !practiceSettingCode.getCode().isEmpty()) {

            fdq.setPracticeSettingCodes(
                    getCode(practiceSettingCode.getCode(), practiceSettingCode.getCodeScheme()));
        }
    }

    private void applyTimeFilters(Iti18QueryParameter iti18Request, FindDocumentsQuery fdq) {
        // ServiceStart
        if (iti18Request.getStartFromDate() != null) {

            fdq.getServiceStartTime()
                    .setFrom(dateFormatterForRequest(iti18Request.getStartFromDate()));
        }

        if (iti18Request.getStartToDate() != null) {
            fdq.getServiceStartTime().setTo(dateFormatterForRequest(iti18Request.getStartToDate()));
        }
        // ServiceStop

        if (iti18Request.getEndFromDate() != null) {
            fdq.getServiceStopTime()
                    .setFrom(dateFormatterForRequest(iti18Request.getEndFromDate()));
        }

        if (iti18Request.getEndToDate() != null) {
            fdq.getServiceStopTime().setTo(dateFormatterForRequest(iti18Request.getEndToDate()));
        }
    }

    private void applyDocumentTypes(Iti18QueryParameter iti18Request, FindDocumentsQuery fdq)
            throws ItiException {
        // Document Type
        if (iti18Request.getDocumentType() == null) {

            throw new ItiException(1000, "List is null", null);
        }
        if (iti18Request.getDocumentType().contains("STABLE")) {
            if (fdq.getDocumentEntryTypes() == null) {
                fdq.setDocumentEntryTypes(new LinkedList<>());
            }
            fdq.getDocumentEntryTypes().add(DocumentEntryType.STABLE);
        }
        if (iti18Request.getDocumentType().contains("ON-DEMAND")) {
            if (fdq.getDocumentEntryTypes() == null) {
                fdq.setDocumentEntryTypes(new LinkedList<>());
            }
            fdq.getDocumentEntryTypes().add(DocumentEntryType.ON_DEMAND);
        }
    }

    private void applyEventFilter(Iti18QueryParameter iti18Request, FindDocumentsQuery fdq) {
        var eventCode = iti18Request.getEventCode();
        // Event code
        if (eventCode != null
                && !eventCode.getCode().isEmpty()
                && eventCode.getCodeScheme() != null
                && !eventCode.getCodeScheme().isEmpty()) {

            fdq.setEventCodes(new QueryList<Code>());
            fdq.getEventCodes()
                    .getOuterList()
                    .add(getCode(eventCode.getCode(), eventCode.getCodeScheme()));
        }
    }
}
