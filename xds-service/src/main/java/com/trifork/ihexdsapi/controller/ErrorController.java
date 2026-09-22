package com.trifork.ihexdsapi.controller;

import com.trifork.ihexdsapi.controller.exception.BadRequestException;
import com.trifork.ihexdsapi.controller.exception.ResourceNotFoundException;
import jakarta.servlet.http.HttpServletRequest;
import java.time.OffsetDateTime;
import org.openapitools.model.BasicError;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ErrorController {
    private static final String BAD_REQUEST = "Bad Request";
    private static final String UNKNOWN_PATIENT = "ID does not exists";

    @ExceptionHandler(BadRequestException.class)
    public ResponseEntity<BasicError> handleBadRequest(
            BadRequestException e, HttpServletRequest request) {
        var error = e.getError();
        error.setPath(request.getRequestURI());

        return ResponseEntity.badRequest().body(error);
    }

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<BasicError> handleBadRequest(
            ResourceNotFoundException e, HttpServletRequest request) {
        var error = e.getError();
        error.setPath(request.getRequestURI());

        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<BasicError> handleMethodArgumentNotValidException(
            MethodArgumentNotValidException e, HttpServletRequest request) {

        BasicError error = new BasicError();

        error.setPath(request.getRequestURI());
        error.setErrorCode(1000);
        error.setStatus(400);
        error.setStatusText(BAD_REQUEST);
        error.setTimestamp(OffsetDateTime.now(java.time.ZoneId.systemDefault()));

        var fieldError = e.getBindingResult().getFieldError();
        if (fieldError != null) {
            error.setError(fieldError.getField() + " " + fieldError.getDefaultMessage());
        } else {
            var globalError = e.getBindingResult().getGlobalError();
            error.setError(globalError == null ? BAD_REQUEST : globalError.getDefaultMessage());
        }

        return ResponseEntity.badRequest().body(error);
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<BasicError> handleRuntimeErrors(
            RuntimeException e, HttpServletRequest request) {
        BasicError error = new BasicError();
        if (UNKNOWN_PATIENT.equals(e.getMessage())) {

            error.setPath(request.getRequestURI());
            error.setErrorCode(1000);
            error.setStatus(400);
            error.setStatusText(BAD_REQUEST);
            error.setTimestamp(OffsetDateTime.now(java.time.ZoneId.systemDefault()));

            error.setError("Patient-" + e.getMessage());

            return ResponseEntity.badRequest().body(error);
        }

        error.setError(e.getMessage());
        error.setPath(request.getRequestURI());
        error.setErrorCode(1000);
        error.setStatus(400);
        error.setStatusText(BAD_REQUEST);
        error.setTimestamp(OffsetDateTime.now(java.time.ZoneId.systemDefault()));

        return ResponseEntity.badRequest().body(error);
    }
}
