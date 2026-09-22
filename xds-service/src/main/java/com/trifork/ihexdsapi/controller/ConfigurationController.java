package com.trifork.ihexdsapi.controller;

import com.trifork.ihexdsapi.service.ConfigsService;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.openapitools.api.ConfigApi;
import org.openapitools.model.ConfigResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ConfigurationController implements ConfigApi {

    private ConfigsService configsService;

    public ConfigurationController(ConfigsService configsService) {
        this.configsService = configsService;
    }

    @Override
    public ResponseEntity<List<ConfigResponse>> v1ConfigGet() {
        try {
            Collection<ConfigResponse> responses = configsService.getListOfConfigResponses();
            return ResponseEntity.ok(new ArrayList<>(responses));
        } catch (Exception e) {
            // Add correct error InternaL??
            throw new RuntimeException(e);
        }
    }
}
