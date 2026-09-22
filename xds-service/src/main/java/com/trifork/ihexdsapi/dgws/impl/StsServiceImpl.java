package com.trifork.ihexdsapi.dgws.impl;

import com.trifork.ihexdsapi.dgws.CredentialInfo;
import com.trifork.ihexdsapi.dgws.DgwsClientInfo;
import com.trifork.ihexdsapi.dgws.DgwsSecurityException;
import com.trifork.ihexdsapi.dgws.StsService;
import dk.nsp.seal.security.SignAndValidate;
import dk.sosi.seal.SOSIFactory;
import dk.sosi.seal.model.*;
import dk.sosi.seal.model.constants.IDValues;
import dk.sosi.seal.model.constants.SubjectIdentifierTypeValues;
import dk.sosi.seal.pki.SOSITestFederation;
import dk.sosi.seal.pki.SignatureProviderFactory;
import dk.sosi.seal.vault.CredentialVault;
import dk.sosi.seal.xml.XmlUtil;
import java.io.IOException;
import java.util.Properties;
import org.openapitools.model.HealthcareProfessionalContext;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;
import org.w3c.dom.Document;

public class StsServiceImpl implements StsService {

    private String stsUrl;

    private RestTemplate restTemplate = new RestTemplate();

    private String itSystem;

    public StsServiceImpl(String stsUrl) {
        this(stsUrl, 45000);
    }

    public StsServiceImpl(String stsUrl, int timeoutMillis) {
        var factory = new org.springframework.http.client.SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(timeoutMillis);
        factory.setReadTimeout(timeoutMillis);
        this.restTemplate = new RestTemplate(factory);
        this.stsUrl = stsUrl;
        this.itSystem = "IheXdsApi";
    }

    // User  Moces
    @Override
    public DgwsClientInfo getDgwsClientInfoForSystem(
            CredentialInfo credentialInfo, String patientId, HealthcareProfessionalContext context)
            throws DgwsSecurityException {
        if (credentialInfo == null) {
            throw new DgwsSecurityException(1000, "CredentialInfo is null");
        }

        Properties properties = new Properties(System.getProperties());
        properties.setProperty(SOSIFactory.PROPERTYNAME_SOSI_VALIDATE, Boolean.toString(true));
        SOSIFactory sosiFactory =
                new SOSIFactory(
                        new SOSITestFederation(properties),
                        credentialInfo.getCredentialVault(),
                        properties);

        if (!CredentialInfo.HEALTHCAREPROFESSIONAL.equals(credentialInfo.getType())) {
            throw new DgwsSecurityException(
                    1000, "Search and retrieval require a healthcare professional credential");
        }
        if (context == null)
            throw new DgwsSecurityException(1000, "Healthcare professional context is required");
        String cvr = credentialInfo.getCvr();

        String authorizationCode = context.getAuthorizationCode();

        UserIDCard userIDCard =
                getUserIdCard(
                        credentialInfo, sosiFactory, cvr, context.getRole(), authorizationCode);

        Request request = sosiFactory.createNewRequest(false, null);
        request.setIDCard(userIDCard);
        if (context.getConsentOverride() == null) {
            throw new DgwsSecurityException(1000, "Consent override must be a valid boolean value");
        }
        return new DgwsClientInfo(
                request.serialize2DOMDocument(),
                userIDCard.getUserInfo().getCPR(),
                patientId,
                userIDCard.getUserInfo().getAuthorizationCode(),
                cvr,
                context.getConsentOverride());
    }

    @Override
    public DgwsClientInfo getDgwsClientInfoForSystem(CredentialInfo credentialInfo)
            throws DgwsSecurityException {
        if (credentialInfo == null || !CredentialInfo.SYSTEM.equals(credentialInfo.getType())) {
            throw new DgwsSecurityException(
                    1000, "System authentication requires an organisation or function credential");
        }
        Properties properties = new Properties(System.getProperties());
        properties.setProperty(SOSIFactory.PROPERTYNAME_SOSI_VALIDATE, Boolean.toString(true));
        SOSIFactory sosiFactory =
                new SOSIFactory(
                        new SOSITestFederation(properties),
                        credentialInfo.getCredentialVault(),
                        properties);

        SystemIDCard systemIDCard =
                getSystemIdCardFromSTS(
                        credentialInfo,
                        credentialInfo.getCvr(),
                        credentialInfo.getOrganisationName(),
                        sosiFactory);

        Request request = sosiFactory.createNewRequest(false, null);
        request.setIDCard(systemIDCard);
        return new DgwsClientInfo(request.serialize2DOMDocument());
    }

    private UserIDCard getUserIdCard(
            CredentialInfo credentialInfo,
            SOSIFactory sosiFactory,
            String cvr,
            String role,
            String authCode)
            throws DgwsSecurityException {
        CredentialVault credentialVault = credentialInfo.getCredentialVault();

        if (role == null || role.isEmpty()) {
            throw new DgwsSecurityException(1000, "UserRole must be specified");
        }
        UserInfo userInfo =
                new UserInfo(
                        null,
                        credentialInfo.getGivenName(),
                        credentialInfo.getSurname(),
                        null,
                        null,
                        role,
                        authCode);
        CareProvider careProvider =
                new CareProvider(
                        SubjectIdentifierTypeValues.CVR_NUMBER,
                        cvr,
                        credentialInfo.getOrganisationName());
        UserIDCard selfSigned =
                sosiFactory.createNewUserIDCard(
                        itSystem,
                        userInfo,
                        careProvider,
                        AuthenticationLevel.MOCES_TRUSTED_USER,
                        null,
                        null,
                        null,
                        null);

        SecurityTokenRequest securityTokenRequest = sosiFactory.createNewSecurityTokenRequest();
        securityTokenRequest.setIDCard(selfSigned);
        Document doc = securityTokenRequest.serialize2DOMDocument();

        SignatureConfiguration signatureConfiguration =
                new SignatureConfiguration(
                        new String[] {IDValues.IDCARD}, IDValues.IDCARD, IDValues.id);
        SignAndValidate.sign(
                SignatureProviderFactory.fromCredentialVault(credentialVault),
                doc,
                signatureConfiguration);
        String requestXml = XmlUtil.node2String(doc, false, true);

        String responseXml;
        try {
            responseXml = sendRequest(requestXml);

        } catch (IOException e) {
            throw new DgwsSecurityException(e, 1000, "Something went wrong");
        }

        SecurityTokenResponse securityTokenResponse =
                sosiFactory.deserializeSecurityTokenResponse(responseXml);

        if (securityTokenResponse.isFault() || securityTokenResponse.getIDCard() == null) {
            throw new DgwsSecurityException(1000, securityTokenResponse.getFaultString());
        } else {
            return (UserIDCard) securityTokenResponse.getIDCard();
        }
    }

    // Voces / Org certicate
    private SystemIDCard getSystemIdCardFromSTS(
            CredentialInfo credentialInfo, String cvr, String organisation, SOSIFactory sosiFactory)
            throws DgwsSecurityException {
        CredentialVault credentialVault = credentialInfo.getCredentialVault();

        CareProvider careProvider =
                new CareProvider(SubjectIdentifierTypeValues.CVR_NUMBER, cvr, organisation);

        SystemIDCard selfSignedSystemIdCard =
                sosiFactory.createNewSystemIDCard(
                        itSystem,
                        careProvider,
                        AuthenticationLevel.VOCES_TRUSTED_SYSTEM,
                        null,
                        null,
                        credentialVault.getSystemCredentialPair().getCertificate(),
                        null);

        SecurityTokenRequest securityTokenRequest = sosiFactory.createNewSecurityTokenRequest();
        securityTokenRequest.setIDCard(selfSignedSystemIdCard);
        Document doc = securityTokenRequest.serialize2DOMDocument();

        String requestXml = XmlUtil.node2String(doc, false, true);

        String responseXml;
        try {
            responseXml = sendRequest(requestXml);
        } catch (IOException e) {
            throw new DgwsSecurityException(e, 1000, "Something went wrong");
        }
        SecurityTokenResponse securityTokenResponse =
                sosiFactory.deserializeSecurityTokenResponse(responseXml);

        if (securityTokenResponse.isFault() || securityTokenResponse.getIDCard() == null) {
            throw new DgwsSecurityException(1000, securityTokenResponse.getFaultString());
        }

        return (SystemIDCard) securityTokenResponse.getIDCard();
    }

    private String sendRequest(String postBody) throws IOException {
        org.springframework.util.MultiValueMap<String, String> headers = new HttpHeaders();
        headers.set("Content-Type", "text/xml; charset=utf-8");
        headers.set("SOAPAction", "\"Issue\"");

        HttpEntity<String> entity = new HttpEntity<>(postBody, headers);

        ResponseEntity<String> result =
                restTemplate.exchange(stsUrl, HttpMethod.POST, entity, String.class);

        int statusCode = result.getStatusCode().value();
        if (statusCode != org.springframework.http.HttpStatus.OK.value()) {
            throw new IOException("HTTP POST failed (" + statusCode + "): " + result.getBody());
        }

        return result.getBody();
    }
}
