package com.trifork.ihexdsapi.controller;

import static org.mockito.Mockito.*;

import com.trifork.ihexdsapi.dao.CacheRequestResponseHandle;
import com.trifork.ihexdsapi.dao.impl.CacheRequestResponseHandleImpl;
import com.trifork.ihexdsapi.dgws.DgwsClientInfo;
import com.trifork.ihexdsapi.dgws.DgwsSecurityException;
import com.trifork.ihexdsapi.dgws.DgwsService;
import com.trifork.ihexdsapi.dgws.ItiException;
import com.trifork.ihexdsapi.service.*;
import com.trifork.ihexdsapi.service.impl.*;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openapitools.model.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

class IheXdsControllerTest {

    DgwsService dgwsService;
    Iti18Service iti18Service;

    Iti43Service iti43Service;

    CacheRequestResponseHandle cacheRequestResponseHandle;

    IDContextService iDContextService;

    IheXdsController subject;

    @BeforeEach
    void setup() {
        // Configure mocks senere
        this.dgwsService = mock(DgwsServiceImpl.class);
        this.iti18Service = mock(Iti18ServiceImpl.class);
        this.iti43Service = mock(Iti43ServiceImpl.class);
        this.cacheRequestResponseHandle = mock(CacheRequestResponseHandleImpl.class);
        this.iDContextService = mock((IDContextServiceImpl.class));

        subject =
                new IheXdsController(
                        com.trifork.ihexdsapi.service.RegistryRouting.legacy(
                                dgwsService, iti18Service, iti43Service),
                        cacheRequestResponseHandle,
                        iDContextService);
    }

    @Test
    void testv1Iti18HealthcareProfessionalGet() throws DgwsSecurityException, ItiException {
        // Given
        when(iDContextService.getId("tempRes"))
                .then(
                        a -> {
                            return "Response";
                        });
        when(iDContextService.getId("tempReq"))
                .then(
                        a -> {
                            return "Request";
                        });

        when(dgwsService.getHealthCareProfessionalClientInfo(any(), any(), any()))
                .then(
                        a -> {
                            return new DgwsClientInfo(null, null, null, null, null, false);
                        });

        when(iti18Service.queryForDocument((Iti18QueryParameter) any(), any()))
                .then(
                        a -> {
                            return new org.openehealth.ipf.commons.ihe.xds.core.responses
                                    .QueryResponse();
                        });

        Iti18Request request = new Iti18Request();
        HealthcareProfessionalContext context = new HealthcareProfessionalContext();
        context.setAuthorizationCode("CBNH1");
        context.setConsentOverride(false);
        request.setContext(context);
        Iti18QueryParameter queryParameters = new Iti18QueryParameter();
        queryParameters.setPatientId("2512489996");
        request.setQueryParameters(queryParameters);
        request.setCredentialId("DEFAULT");

        // When
        ResponseEntity<Iti18Response> responseEntity = subject.v1Iti18Post(request);

        // Then
        Assertions.assertNotNull(responseEntity);
        Assertions.assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        Assertions.assertNotNull(responseEntity.getBody());
    }

    @Test
    void testv1PrevRequestGet() {
        // When
        String test = "test";
        ResponseEntity<DownloadLog> responseEntity = subject.v1RequestRequestIdGet(test);

        // Then
        Assertions.assertNotNull(responseEntity);
        Assertions.assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        Assertions.assertNotNull(responseEntity.getBody());
    }

    @Test
    void testv1PrevResponseGet() {
        // When
        String test = "test";
        ResponseEntity<DownloadLog> responseEntity = subject.v1ResponseResponseIdGet(test);

        // Then
        Assertions.assertNotNull(responseEntity);
        Assertions.assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        Assertions.assertNotNull(responseEntity.getBody());
    }

    @Test
    void testv1Iti43Post() throws Exception {
        when(iti43Service.getDocument(any(), any()))
                .thenReturn(
                        new RetrievedBytes(
                                "<ClinicalDocument/>"
                                        .getBytes(java.nio.charset.StandardCharsets.UTF_8),
                                java.util.List.of()));

        Iti43Request request = new Iti43Request();
        HealthcareProfessionalContext context = new HealthcareProfessionalContext();
        context.setAuthorizationCode("CBNH1");
        context.setConsentOverride(false);
        request.setContext(context);
        Iti43QueryParameter queryParameters = new Iti43QueryParameter();
        queryParameters.setPatientId("2512489996");
        request.setQueryParameters(queryParameters);
        request.setCredentialId("DEFAULT");

        // When
        ResponseEntity<Iti43Response> responseEntity = subject.v1Iti43Post(request);

        // Then
        Assertions.assertNotNull(responseEntity);
        Assertions.assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
    }
}
