package com.trifork.ihexdsapi.controller;

import com.trifork.ihexdsapi.controller.exception.BadRequestException;
import com.trifork.ihexdsapi.controller.mapping.RestXdsResponses;
import com.trifork.ihexdsapi.dao.CacheRequestResponseHandle;
import com.trifork.ihexdsapi.dgws.*;
import com.trifork.ihexdsapi.service.*;
import jakarta.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import org.openapitools.api.*;
import org.openapitools.model.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
// CORS - Consider if this is needed in your application. Only here to make Swagger UI work.
// @CrossOrigin(origins = "http://localhost:*")
public class IheXdsController implements IhexdsApi, RequestResultApi, ResponseResultApi {

    private final RegistryRouting registries;

    private CacheRequestResponseHandle cacheRequestResponseHandle;

    private IDContextService iDContextService;

    public IheXdsController(
            RegistryRouting registries,
            CacheRequestResponseHandle cacheRequestResponseHandle,
            IDContextService iDContextService) {
        this.registries = registries;
        this.cacheRequestResponseHandle = cacheRequestResponseHandle;
        this.iDContextService = iDContextService;
    }

    @Override
    public ResponseEntity<List<RegistryChoice>> v1RegistriesGet() {
        return ResponseEntity.ok(
                registries.choices().stream()
                        .map(choice -> new RegistryChoice().id(choice.id()).name(choice.name()))
                        .toList());
    }

    @Override
    public ResponseEntity<Iti18Response> v1Iti18Post(@Valid Iti18Request iti18Request) {
        var target = registries.target(iti18Request.getRegistryId());
        try {

            DgwsClientInfo clientInfo =
                    target.dgws()
                            .getHealthCareProfessionalClientInfo(
                                    iti18Request.getQueryParameters().getPatientId(),
                                    iti18Request.getCredentialId(),
                                    iti18Request.getContext());
            Iti18Response iti18Response =
                    RestXdsResponses.populateIti18Response(
                            iti18Request.getQueryParameters().getPatientId(),
                            target.search()
                                    .queryForDocument(
                                            iti18Request.getQueryParameters(), clientInfo),
                            new Iti18Response());
            iti18Response.setResponseId(iDContextService.getId("tempRes"));
            iti18Response.setRequestId(iDContextService.getId("tempReq"));

            return new ResponseEntity<>(iti18Response, HttpStatus.OK);
        } catch (DgwsSecurityException | ItiException e) {
            throw BadRequestException.createException(
                    BadRequestException.ERROR_CODE.fromInt(e.getErrorCode()), e.getMessage(), e);
        }
    }

    @Override
    public ResponseEntity<Iti18ResponseUnique> v1Iti18UniqueIDPost(
            Iti18RequestUnique iti18RequestUnique) {
        var query =
                java.util.Objects.requireNonNull(
                        iti18RequestUnique.getQueryParameters(), "Query parameters are required");
        var target = registries.target(iti18RequestUnique.getRegistryId());
        try {
            DgwsClientInfo clientInfo =
                    target.dgws()
                            .getHealthCareProfessionalClientInfo(
                                    query.getPatientId(),
                                    query.getCredentialId(),
                                    query.getContext());
            Iti18ResponseUnique response =
                    RestXdsResponses.populateUniqueIti18Response(
                            target.search().queryForDocument(iti18RequestUnique, clientInfo),
                            new Iti18ResponseUnique());
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (DgwsSecurityException e) {
            throw BadRequestException.createException(
                    BadRequestException.ERROR_CODE.fromInt(e.getErrorCode()), e.getMessage(), e);
        }
    }

    @Override
    public ResponseEntity<Iti43Response> v1Iti43Post(Iti43Request iti43Request) {
        var target = registries.target(iti43Request.getRegistryId());
        try {
            DgwsClientInfo clientInfo =
                    target.dgws()
                            .getHealthCareProfessionalClientInfo(
                                    iti43Request.getQueryParameters().getPatientId(),
                                    iti43Request.getCredentialId(),
                                    iti43Request.getContext());
            Iti43Response iti43Response =
                    RestXdsResponses.retrieval(
                            target.retrieval()
                                    .getDocument(iti43Request.getQueryParameters(), clientInfo),
                            !Boolean.FALSE.equals(
                                    iti43Request
                                            .getQueryParameters()
                                            .getIncludeFormattedResponse()));
            return new ResponseEntity<>(iti43Response, HttpStatus.OK);
        } catch (DgwsSecurityException e) {

            throw BadRequestException.createException(
                    BadRequestException.ERROR_CODE.fromInt(e.getErrorCode()), e.getMessage(), e);
        } catch (ItiException e) {
            List<String> errors = new ArrayList<>();

            if (e.getOtherErrors() == null || e.getOtherErrors().isEmpty()) {
                throw BadRequestException.createException(
                        BadRequestException.ERROR_CODE.fromInt(e.getErrorCode()),
                        e.getMessage(),
                        null,
                        e);
            }
            StringBuilder errorMessage = new StringBuilder(e.getMessage()).append("\n");
            for (RegistryError err : e.getOtherErrors()) {
                errors.add(
                        ""
                                + err.getCodeContext()
                                + ", "
                                + err.getErrorCode()
                                + ", "
                                + err.getSeverity()
                                + ", "
                                + err.getCustomErrorCode());
                errorMessage.append(err.getCodeContext());
            }

            throw BadRequestException.createException(
                    BadRequestException.ERROR_CODE.fromInt(e.getErrorCode()),
                    errorMessage.toString(),
                    errors,
                    e);
        }
    }

    @Override
    public ResponseEntity<DownloadLog> v1RequestRequestIdGet(String requestId) {
        return logResponse(requestId);
    }

    @Override
    public ResponseEntity<DownloadLog> v1ResponseResponseIdGet(String responseId) {
        return logResponse(responseId);
    }

    private ResponseEntity<DownloadLog> logResponse(String id) {
        DownloadLog response = new DownloadLog();
        response.setPayload(cacheRequestResponseHandle.getRequestAndResponse(id));
        return ResponseEntity.ok(response);
    }
}
