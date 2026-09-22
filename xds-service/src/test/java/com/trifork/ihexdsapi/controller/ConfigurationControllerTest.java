package com.trifork.ihexdsapi.controller;

import static org.mockito.Mockito.*;

import com.trifork.ihexdsapi.service.ConfigsService;
import java.util.List;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openapitools.model.ConfigResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

class ConfigurationControllerTest {

    private ConfigsService configsService;
    private ConfigurationController subject;

    @BeforeEach
    void setup() {
        configsService = mock(ConfigsService.class);
        subject = new ConfigurationController(configsService);
    }

    @Test
    void Testv1ConfigGet() {

        // When
        ResponseEntity<List<ConfigResponse>> responseEntity = subject.v1ConfigGet();

        // Then
        Assertions.assertNotNull(responseEntity);
        Assertions.assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        Assertions.assertNotNull(responseEntity.getBody());
    }
}
