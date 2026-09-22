package com.trifork.ihexdsapi.controller.exception;

import static org.junit.jupiter.api.Assertions.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.trifork.ihexdsapi.controller.ErrorController;
import java.io.*;
import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockHttpServletRequest;

class ExceptionContractTest {
    @Test
    void translationPreservesCauseAndSerializesTheSameRestError() throws Exception {
        var cause = new IOException("fixture upstream failure");
        var original =
                BadRequestException.createException(
                        BadRequestException.ERROR_CODE.GENERIC,
                        "Unable to retrieve",
                        List.of("registry detail"),
                        cause);
        original.getError().setPath("/v1/iti43");
        assertSame(cause, original.getCause());
        var restored = roundTrip(original, BadRequestException.class);
        var json = new ObjectMapper().registerModule(new JavaTimeModule());
        assertEquals(json.valueToTree(original.getError()), json.valueToTree(restored.getError()));
        assertEquals(cause.getClass(), restored.getCause().getClass());
        assertEquals(cause.getMessage(), restored.getCause().getMessage());
        var response =
                new ErrorController()
                        .handleBadRequest(
                                restored, new MockHttpServletRequest("POST", "/v1/iti43"));
        assertEquals(400, response.getStatusCode().value());
        assertEquals("Unable to retrieve", response.getBody().getError());
    }

    @Test
    void notFoundErrorRetainsItsDetailsAcrossSerialization() throws Exception {
        var original =
                ResourceNotFoundException.createException("fixture missing", List.of("detail"));
        var restored = roundTrip(original, ResourceNotFoundException.class);
        assertEquals(original.getError(), restored.getError());
    }

    @Test
    void serviceExceptionRetainsMessageCauseAndRegistryDetails() throws Exception {
        var cause = new IOException("fixture cause");
        var error = new org.openapitools.model.RegistryError().codeContext("fixture detail");
        var original =
                new com.trifork.ihexdsapi.dgws.ItiException(
                        cause, 1000, "fixture failure", List.of(error));
        var restored = roundTrip(original, com.trifork.ihexdsapi.dgws.ItiException.class);
        assertEquals("fixture failure", restored.getMessage());
        assertEquals("fixture cause", restored.getCause().getMessage());
        assertEquals(List.of(error), restored.getOtherErrors());
    }

    @Test
    void objectLevelValidationReturnsAUsefulBadRequest() throws Exception {
        var binding =
                new org.springframework.validation.BeanPropertyBindingResult(
                        new Object(), "request");
        binding.addError(
                new org.springframework.validation.ObjectError("request", "Inconsistent query"));
        var method =
                com.trifork.ihexdsapi.controller.IheXdsController.class.getMethod(
                        "v1Iti18Post", org.openapitools.model.Iti18Request.class);
        var exception =
                new org.springframework.web.bind.MethodArgumentNotValidException(
                        new org.springframework.core.MethodParameter(method, 0), binding);
        var response =
                new ErrorController()
                        .handleMethodArgumentNotValidException(
                                exception, new MockHttpServletRequest("POST", "/v1/iti18"));
        assertEquals(400, response.getStatusCode().value());
        assertEquals("Inconsistent query", response.getBody().getError());
    }

    private static <T> T roundTrip(T value, Class<T> type) throws Exception {
        var bytes = new ByteArrayOutputStream();
        try (var output = new ObjectOutputStream(bytes)) {
            output.writeObject(value);
        }
        try (var input = new ObjectInputStream(new ByteArrayInputStream(bytes.toByteArray()))) {
            return type.cast(input.readObject());
        }
    }
}
