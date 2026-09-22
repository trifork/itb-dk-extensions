package com.trifork.ihexdsapi.controller.mapping;

import com.trifork.ihexdsapi.dgws.ItiException;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.util.*;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import org.openapitools.model.*;
import org.openapitools.model.Iti43Response;
import org.openehealth.ipf.commons.ihe.xds.core.metadata.*;
import org.openehealth.ipf.commons.ihe.xds.core.metadata.Code;
import org.openehealth.ipf.commons.ihe.xds.core.responses.QueryResponse;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public final class RestXdsResponses {
    private RestXdsResponses() {}

    public static Iti18Response populateIti18Response(
            String patientId, QueryResponse queryResponse, Iti18Response iti18Response) {

        // Query parameters
        List<Iti18QueryResponse> queryResponses = new LinkedList<>();
        for (DocumentEntry documentEntry : queryResponse.getDocumentEntries()) {

            String documentTypeString = documentEntry.getTypeCode().getDisplayName().getValue();

            Iti18QueryResponse iti18QueryResponse = new Iti18QueryResponse();
            iti18QueryResponse.setPatientId(patientId);
            iti18QueryResponse.setDocumentId(documentEntry.getUniqueId());
            iti18QueryResponse.setRepositoryID(documentEntry.getRepositoryUniqueId());
            iti18QueryResponse.setDocumentType(documentTypeString);

            if (documentEntry.getServiceStartTime() != null) {
                iti18QueryResponse.setServiceStart(
                        documentEntry
                                .getServiceStartTime()
                                .getDateTime()
                                .toInstant()
                                .toEpochMilli());
            }
            if (documentEntry.getServiceStopTime() != null) {
                iti18QueryResponse.setServiceEnd(
                        documentEntry
                                .getServiceStopTime()
                                .getDateTime()
                                .toInstant()
                                .toEpochMilli());
            }
            queryResponses.add(iti18QueryResponse);
        }

        List<RegistryError> errors = RegistryErrors.toRest(queryResponse.getErrors(), false);

        iti18Response.setQueryResponse(queryResponses);
        iti18Response.setErrors(errors);

        return iti18Response;
    }

    public static Iti18ResponseUnique populateUniqueIti18Response(
            QueryResponse queryResponse, Iti18ResponseUnique metaDataResponse) {

        // Set document data

        if (!queryResponse.getDocumentEntries().isEmpty()) {
            DocumentEntry entry = queryResponse.getDocumentEntries().get(0);

            populateDocumentEntry(entry, metaDataResponse);
        }

        List<RegistryError> errors = RegistryErrors.toRest(queryResponse.getErrors(), true);

        metaDataResponse.errors(errors);

        return metaDataResponse;
    }

    private static void populateDocumentEntry(
            DocumentEntry entry, Iti18ResponseUnique metaDataResponse) {
        String authorP =
                ""
                        + entry.getAuthors().getFirst().getAuthorPerson().getName().getGivenName()
                        + " "
                        + entry.getAuthors().getFirst().getAuthorPerson().getName().getFamilyName()
                        + ", "
                        + entry.getAuthors().getFirst().getAuthorPerson().getName().getPrefix();
        metaDataResponse.setAuthorPerson(authorP);

        StringBuilder orgName = new StringBuilder();
        StringBuilder orgCodeScheme = new StringBuilder();
        StringBuilder orgCode = new StringBuilder();
        for (Organization o : entry.getAuthors().getFirst().getAuthorInstitution()) {
            orgName.append(o.getOrganizationName()).append(",");
            orgCode.append(o.getIdNumber()).append(",");

            orgCodeScheme.append(o.getAssigningAuthority().toString()).append(",");
        }
        metaDataResponse.setAuthorInstitution(
                makeCodeObject(orgName.toString(), orgCode.toString(), orgCodeScheme.toString()));
        metaDataResponse.setAvailabilityStatus(
                makeCodeObject(
                        entry.getAvailabilityStatus().name(),
                        entry.getAvailabilityStatus().getOpcode(),
                        entry.getAvailabilityStatus().getQueryOpcode()));
        metaDataResponse.setClassCode(
                makeCodeObject(
                        entry.getClassCode().getDisplayName().getValue(),
                        entry.getClassCode().getCode(),
                        entry.getClassCode().getSchemeName()));

        if (entry.getComments() != null) {
            metaDataResponse.setComments(entry.getComments().getValue());
        }
        StringBuilder confidentialityName = new StringBuilder();
        StringBuilder confidentialityCodeScheme = new StringBuilder();
        StringBuilder confidentialityCode = new StringBuilder();
        for (Code c : entry.getConfidentialityCodes()) {
            confidentialityName.append(c.getDisplayName().getValue());
            confidentialityCodeScheme.append(c.getCode());
            confidentialityCode.append(c.getSchemeName());
        }
        metaDataResponse.setConfidentialityCode(
                makeCodeObject(
                        confidentialityName.toString(),
                        confidentialityCode.toString(),
                        confidentialityCodeScheme.toString()));
        if (entry.getCreationTime() != null) {
            metaDataResponse.setCreationTime(
                    entry.getCreationTime().getDateTime().toInstant().toEpochMilli());
        }
        if (entry.getDocumentAvailability() != null) {
            metaDataResponse.setAvailabilityStatus(
                    makeCodeObject(
                            entry.getDocumentAvailability().name(),
                            entry.getDocumentAvailability().getOpcode(),
                            entry.getDocumentAvailability().getFullQualified()));
        }

        metaDataResponse.setEntryUuid(entry.getEntryUuid());

        List<org.openapitools.model.Code> eventCode = new LinkedList<>();

        for (Code c : entry.getEventCodeList()) {
            eventCode.add(
                    makeCodeObject(c.getDisplayName().getValue(), c.getCode(), c.getSchemeName()));
        }
        metaDataResponse.setEventCode(eventCode);

        if (entry.getExtraMetadata() != null) {
            String extraData = "";
            for (Map.Entry<String, java.util.List<String>> e :
                    entry.getExtraMetadata().entrySet()) {
                extraData =
                        "Key: "
                                + e.getKey()
                                + " Value: "
                                + Arrays.toString(e.getValue().toArray())
                                + "\n";
            }

            metaDataResponse.setExtraMetadata(extraData);
        }

        populateDocumentDetails(entry, metaDataResponse);
    }

    private static void populateDocumentDetails(
            DocumentEntry entry, Iti18ResponseUnique metaDataResponse) {
        metaDataResponse.setFormatCode(
                makeCodeObject(
                        entry.getFormatCode().getDisplayName().getValue(),
                        entry.getFormatCode().getCode(),
                        entry.getFormatCode().getSchemeName()));

        metaDataResponse.setHash(entry.getHash());

        metaDataResponse.setHealthCareFacilityType(
                makeCodeObject(
                        entry.getHealthcareFacilityTypeCode().getDisplayName().getValue(),
                        entry.getHealthcareFacilityTypeCode().getCode(),
                        entry.getHealthcareFacilityTypeCode().getSchemeName()));

        metaDataResponse.setHomeComunity(entry.getHomeCommunityId());

        metaDataResponse.setLanguageCode(entry.getLanguageCode());

        if (entry.getLegalAuthenticator() != null) {
            metaDataResponse.setLegalAuthenticator(
                    entry.getLegalAuthenticator().getName().getGivenName()
                            + " "
                            + entry.getLegalAuthenticator().getName().getFamilyName());
        }

        metaDataResponse.setLogicalUuid(entry.getLogicalUuid());
        metaDataResponse.setMimeType(entry.getMimeType());
        metaDataResponse.setObjectType(entry.getType().toString());

        metaDataResponse.setPracticeSettingCode(
                makeCodeObject(
                        entry.getPracticeSettingCode().getDisplayName().getValue(),
                        entry.getPracticeSettingCode().getCode(),
                        entry.getPracticeSettingCode().getSchemeName()));

        metaDataResponse.setRepositoryUniqueId(entry.getRepositoryUniqueId());

        if (entry.getServiceStartTime() != null) {
            metaDataResponse.setServiceStartTime(
                    entry.getServiceStartTime().getDateTime().toInstant().toEpochMilli());
        }
        if (entry.getServiceStopTime() != null) {
            metaDataResponse.setServiceStopTime(
                    entry.getServiceStopTime().getDateTime().toInstant().toEpochMilli());
        }

        metaDataResponse.setSize(entry.getSize().intValue());

        metaDataResponse.setSourcePatientId(
                makeCodeObject(
                        null,
                        entry.getPatientId().getId(),
                        entry.getPatientId().getAssigningAuthority().getUniversalId()));

        Iti18ResponseUniqueSourcePatientInfo patientInfo =
                new Iti18ResponseUniqueSourcePatientInfo();
        patientInfo.setName(
                entry.getSourcePatientInfo().getNames().next().getGivenName()
                        + " "
                        + entry.getSourcePatientInfo().getNames().next().getFamilyName());
        patientInfo.setGender(
                Iti18ResponseUniqueSourcePatientInfo.GenderEnum.fromValue(
                        entry.getSourcePatientInfo().getGender()));
        patientInfo.setBirthTime(
                entry.getSourcePatientInfo()
                        .getDateOfBirth()
                        .getDateTime()
                        .toInstant()
                        .toEpochMilli());

        metaDataResponse.setSourcePatientInfo(patientInfo);

        metaDataResponse.setTitle(entry.getTitle().getValue());

        metaDataResponse.setType(
                makeCodeObject(
                        entry.getType().name(), entry.getType().name(), entry.getType().getUuid()));

        metaDataResponse.setTypeCode(
                makeCodeObject(
                        entry.getTypeCode().getDisplayName().getValue(),
                        entry.getTypeCode().getCode(),
                        entry.getTypeCode().getSchemeName()));
        metaDataResponse.setUniqueId(entry.getUniqueId());

        metaDataResponse.setUri(entry.getUri());

        metaDataResponse.setVersion(entry.getVersion().getVersionName());
    }

    private static org.openapitools.model.Code makeCodeObject(
            String name, String code, String codeScheme) {
        org.openapitools.model.Code c = new org.openapitools.model.Code();
        c.setName(name);
        c.setScheme(codeScheme);
        c.setCode(code);
        return c;
    }

    public static Iti43Response retrieval(
            com.trifork.ihexdsapi.service.RetrievedBytes result, boolean formatted)
            throws ItiException {
        if (result.bytes() == null)
            throw new ItiException(
                    1000,
                    "Failed to retrieve document",
                    RegistryErrors.toRest(result.errors(), false));
        var response = new Iti43Response();
        response.setResponseBase64(result.bytes());
        if (formatted)
            try {
                response.setResponse(formatXML(result.bytes()));
            } catch (TransformerException
                    | SAXException
                    | IOException
                    | ParserConfigurationException
                    | XPathExpressionException e) {
                throw new IllegalStateException(e);
            }
        return response;
    }

    private static String formatXML(byte[] bytes)
            throws TransformerException,
                    SAXException,
                    IOException,
                    ParserConfigurationException,
                    XPathExpressionException {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
        Document xmlDocument;
        try (java.io.InputStream stream = new ByteArrayInputStream(bytes)) {
            xmlDocument = factory.newDocumentBuilder().parse(stream);
        }

        XPath xPath = XPathFactory.newInstance().newXPath();
        NodeList nodeList =
                (NodeList)
                        xPath.evaluate(
                                "//text()[normalize-space()='']",
                                xmlDocument,
                                XPathConstants.NODESET);

        for (int i = 0; i < nodeList.getLength(); ++i) {
            Node node = nodeList.item(i);
            node.getParentNode().removeChild(node);
        }

        TransformerFactory transformerFactory = TransformerFactory.newDefaultInstance();
        transformerFactory.setAttribute(javax.xml.XMLConstants.ACCESS_EXTERNAL_DTD, "");
        transformerFactory.setAttribute(javax.xml.XMLConstants.ACCESS_EXTERNAL_STYLESHEET, "");
        Transformer transformer = transformerFactory.newTransformer();
        transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
        transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");

        StringWriter stringWriter = new StringWriter();
        StreamResult streamResult = new StreamResult(stringWriter);

        transformer.transform(new DOMSource(xmlDocument), streamResult);
        return stringWriter.toString();
    }
}
