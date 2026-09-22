package com.trifork.ihexdsapi.controller;

import static org.mockito.Mockito.*;

import com.trifork.ihexdsapi.service.CodesService;
import java.util.List;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openapitools.model.Code;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

class CodesControllerTest {

    private CodesService codesService;
    private CodesController subject;

    @BeforeEach
    void setup() {
        codesService = mock(CodesService.class);
        subject = new CodesController(codesService);
    }

    @Test
    void Testv1CodesTypeCodeGet() {

        // When
        ResponseEntity<List<Code>> responseEntity = subject.v1CodesTypeCodeGet();

        // Then
        Assertions.assertNotNull(responseEntity);
        Assertions.assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        Assertions.assertNotNull(responseEntity.getBody());
    }
}
