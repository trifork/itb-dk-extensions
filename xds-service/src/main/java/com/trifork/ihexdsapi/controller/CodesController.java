package com.trifork.ihexdsapi.controller;

import com.trifork.ihexdsapi.service.CodesService;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.openapitools.api.*;
import org.openapitools.model.Code;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CodesController
        implements TypeCodeApi,
                AvailabilityCodesApi,
                ClassCodesApi,
                EventCodeApi,
                FormatCodesApi,
                HealthCareFacilityTypeCodesApi,
                ObjectTypeCodeApi,
                PracticeSettingCodeApi {
    private CodesService codesService;

    public CodesController(CodesService codesService) {
        this.codesService = codesService;
    }

    @Override
    public ResponseEntity<List<Code>> v1CodesAvailabilityStatusCodeGet() {
        try {
            Collection<Code> codes = codesService.getAvailabilityStatusList();
            return ResponseEntity.ok(new ArrayList<>(codes));
        } catch (Exception e) {
            // Add correct error InternaL??
            throw new RuntimeException(e);
        }
    }

    @Override
    public ResponseEntity<List<Code>> v1CodesClassCodeGet() {
        return null;
    }

    @Override
    public ResponseEntity<List<Code>> v1CodesEventCodeGet() {
        try {
            Collection<Code> codes = codesService.getEventCodesList();
            return ResponseEntity.ok(new ArrayList<>(codes));
        } catch (Exception e) {
            // Add correct error InternaL??
            throw new RuntimeException(e);
        }
    }

    @Override
    public ResponseEntity<List<Code>> v1CodesFormatCodeGet() {
        try {
            Collection<Code> codes = codesService.getFormatCodesList();
            return ResponseEntity.ok(new ArrayList<>(codes));
        } catch (Exception e) {
            // Add correct error InternaL??
            throw new RuntimeException(e);
        }
    }

    @Override
    public ResponseEntity<List<Code>> v1CodesHealthCareFacilityTypeGet() {
        try {
            Collection<Code> codes = codesService.getHealthcareFacilityTypeCodesList();
            return ResponseEntity.ok(new ArrayList<>(codes));
        } catch (Exception e) {
            // Add correct error InternaL??
            throw new RuntimeException(e);
        }
    }

    @Override
    public ResponseEntity<List<Code>> v1CodesObjectTypeCodeGet() {
        try {
            Collection<Code> codes = codesService.getDocumentTypeList();
            return ResponseEntity.ok(new ArrayList<>(codes));
        } catch (Exception e) {
            // Add correct error InternaL??
            throw new RuntimeException(e);
        }
    }

    @Override
    public ResponseEntity<List<Code>> v1CodesPracticeSettingCodeGet() {
        try {
            Collection<Code> codes = codesService.getPractiseSettingCodesList();

            return ResponseEntity.ok(new ArrayList<>(codes));
        } catch (Exception e) {
            // Add correct error InternaL??
            throw new RuntimeException(e);
        }
    }

    @Override
    public ResponseEntity<List<Code>> v1CodesTypeCodeGet() {
        try {
            Collection<Code> codes = codesService.getTypeCodesList();

            return ResponseEntity.ok(new ArrayList<>(codes));
        } catch (Exception e) {
            // Add correct error InternaL??
            throw new RuntimeException(e);
        }
    }
}
