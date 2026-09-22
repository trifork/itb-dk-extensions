package com.trifork.ihexdsapi.service;

import com.trifork.ihexdsapi.service.impl.ConfigsServiceImpl;
import java.util.List;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openapitools.model.ConfigResponse;

class ConfigurationServiceImplTest {

    private ConfigsService subject;

    @BeforeEach
    void setup() {

        String sts = "http://test1.ekstern-test.nspop.dk:8080/sts/services/NewSecurityTokenService";
        String xdsIti18 = "http://test1-cnsp.ekstern-test.nspop.dk:8080/ddsregistry";

        subject = new ConfigsServiceImpl(sts, xdsIti18, "");
    }

    @Test
    void TestGetConfigResponsesList() {
        List<ConfigResponse> responses = subject.getListOfConfigResponses();

        Assertions.assertEquals(3, responses.size());
        Assertions.assertEquals("iti-18.url", responses.get(0).getConfigKey());

        Assertions.assertEquals(
                "http://test1-cnsp.ekstern-test.nspop.dk:8080/ddsregistry",
                responses.get(0).getConfigValue());
    }
}
