package com.trifork.ihexdsapi.controller;

import com.trifork.ihexdsapi.controller.exception.BadRequestException;
import com.trifork.ihexdsapi.dgws.CredentialInfo;
import com.trifork.ihexdsapi.dgws.CredentialService;
import com.trifork.ihexdsapi.dgws.DgwsSecurityException;
import java.util.*;
import org.openapitools.api.CredentialsApi;
import org.openapitools.model.CreateCredentialRequest;
import org.openapitools.model.CredentialInfoResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
// CORS - Consider if this is needed in your application. Only here to make Swagger UI work.
// @CrossOrigin(origins = "http://localhost:3000", methods =  {RequestMethod.GET,
// RequestMethod.PUT})
public class CredentialInfoController implements CredentialsApi {

    private final CredentialService credentialService;

    public CredentialInfoController(CredentialService credentialService) {
        this.credentialService = credentialService;
    }

    private static final Logger LOGGER = LoggerFactory.getLogger(CredentialInfoController.class);

    @Override
    public ResponseEntity<List<CredentialInfoResponse>> v1CredentialinfoGet(
            String owner, String type) {
        LOGGER.debug("Loading credential metadata for type {}", type);

        CredentialInfoResponse.CredentialTypeEnum typeEnum = credentialType(type);
        try {
            List<CredentialInfoResponse> responses =
                    credentialService.populateResponses(owner, typeEnum);

            return ResponseEntity.ok(responses);
        } catch (Exception e) {
            throw BadRequestException.createException(
                    BadRequestException.ERROR_CODE.fromInt(1000), e.getMessage(), e);
        }
    }

    private CredentialInfoResponse.CredentialTypeEnum credentialType(String type) {
        if (type == null || type.isEmpty()) return null;
        if (CredentialInfo.HEALTHCAREPROFESSIONAL.equalsIgnoreCase(type)) {
            return CredentialInfoResponse.CredentialTypeEnum.HEALTHCAREPROFESSIONAL;
        }
        if (CredentialInfo.SYSTEM.equals(type))
            return CredentialInfoResponse.CredentialTypeEnum.SYSTEM;
        throw BadRequestException.createException(
                BadRequestException.ERROR_CODE.GENERIC, "Bad type query");
    }

    @Override
    public ResponseEntity<Void> v1CredentialinfoPut(
            CreateCredentialRequest createCredentialResponse) {

        try {
            credentialService.createAndAddCredentialInfo(
                    createCredentialResponse.getOwner(), createCredentialResponse.getDisplayName(),
                    createCredentialResponse.getPublicCertStr(),
                            createCredentialResponse.getPrivateKeyStr());

            return ResponseEntity.status(HttpStatus.CREATED).build();

        } catch (DgwsSecurityException e) {
            throw BadRequestException.createException(
                    BadRequestException.ERROR_CODE.fromInt(e.getErrorCode()), e.getMessage(), e);
        }
    }
}
