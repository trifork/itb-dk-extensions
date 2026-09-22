package com.trifork.ihexdsapi.gitb;

import com.trifork.ihexdsapi.service.XdsOperations;
import jakarta.xml.ws.Endpoint;
import org.springframework.web.bind.annotation.*;

@RestController
public class ReadinessController {
    private final XdsOperations operations;
    private final Endpoint endpoint;

    public ReadinessController(XdsOperations operations, Endpoint endpoint) {
        this.operations = operations;
        this.endpoint = endpoint;
    }

    @GetMapping("/health/ready")
    public String ready() {
        if (!endpoint.isPublished()) throw new IllegalStateException("GITB endpoint is not ready");
        operations.identities();
        operations.codes(false);
        operations.codes(true);
        return "OK";
    }
}
