package com.trifork.ihexdsapi.controller;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.trifork.ihexdsapi.dao.CacheRequestResponseHandle;
import com.trifork.ihexdsapi.dgws.*;
import com.trifork.ihexdsapi.service.*;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

class RegistryRestTest {
    @Test
    void discoversNamesAndRoutesAllReadOperationsWithoutAcceptingUnknownIds() throws Exception {
        var one = mock(DgwsService.class);
        var two = mock(DgwsService.class);
        when(two.getHealthCareProfessionalClientInfo(anyString(), anyString(), any()))
                .thenThrow(new DgwsSecurityException(1000, "Selected STS fixture"));
        var routing =
                new RegistryRouting(
                        List.of(
                                new RegistryRouting.Target(
                                        "one",
                                        "DDS One",
                                        one,
                                        mock(Iti18Service.class),
                                        mock(Iti43Service.class)),
                                new RegistryRouting.Target(
                                        "two",
                                        "DDS Two",
                                        two,
                                        mock(Iti18Service.class),
                                        mock(Iti43Service.class))));
        var controller =
                new IheXdsController(
                        routing,
                        mock(CacheRequestResponseHandle.class),
                        mock(IDContextService.class));
        var http =
                MockMvcBuilders.standaloneSetup(controller)
                        .setControllerAdvice(new ErrorController())
                        .build();
        var json = new ObjectMapper();
        var discovery = http.perform(get("/v1/registries")).andReturn().getResponse();
        assertEquals(200, discovery.getStatus());
        assertEquals(
                json.readTree(
                        "[{\"id\":\"one\",\"name\":\"DDS One\"},{\"id\":\"two\",\"name\":\"DDS Two\"}]"),
                json.readTree(discovery.getContentAsByteArray()));
        for (String registry : List.of("two", "unknown")) {
            for (String path : List.of("/v1/iti18", "/v1/iti18/uniqueID", "/v1/iti43")) {
                var context =
                        Map.of(
                                "role",
                                "Læge",
                                "authorizationCode",
                                "FT001",
                                "consentOverride",
                                false);
                var query = new java.util.LinkedHashMap<String, Object>();
                query.put("patientId", "2512489996");
                query.put("documentId", "document");
                query.put("repositoryId", "repository");
                query.put("availabilityStatus", "Approved");
                query.put("documentType", List.of("STABLE"));
                if (path.endsWith("uniqueID")) {
                    query.put("credentialId", "employee");
                    query.put("context", context);
                }
                var request =
                        Map.of(
                                "registryId",
                                registry,
                                "credentialId",
                                "employee",
                                "context",
                                context,
                                "queryParameters",
                                query);
                var response =
                        http.perform(
                                        post(path)
                                                .contentType(MediaType.APPLICATION_JSON)
                                                .content(json.writeValueAsBytes(request)))
                                .andReturn()
                                .getResponse();
                assertEquals(400, response.getStatus(), response.getContentAsString());
                assertEquals(
                        registry.equals("two")
                                ? "Selected STS fixture"
                                : "Choose a configured XDS registry ID",
                        json.readTree(response.getContentAsByteArray()).path("error").asText());
            }
        }
        verify(two, times(3))
                .getHealthCareProfessionalClientInfo(eq("2512489996"), eq("employee"), any());
        verifyNoInteractions(one);
    }
}
