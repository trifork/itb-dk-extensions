package com.trifork.ihexdsapi.configuration;

import com.trifork.ihexdsapi.dgws.CredentialService;
import com.trifork.ihexdsapi.dgws.DgwsSecurityException;
import com.trifork.ihexdsapi.dgws.impl.AbstractTest;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.PropertySource;

@org.springframework.boot.test.context.TestConfiguration
@Import(IheXdsConfiguration.class)
@EnableAutoConfiguration
@PropertySource("application.properties")
public class TestConfiguration extends AbstractTest {

    @Autowired CredentialService credentialService;

    @PostConstruct
    public void setupDefaultCredentials() throws DgwsSecurityException {

        String publicCertStr = getFileString("/certificates/public-cert1.cer");
        String privateKeyStr = getFileString("/certificates/private-cert1.pem");
        String displayName = "My certificate";

        credentialService.createAndAddCredentialInfo(
                null, displayName, publicCertStr, privateKeyStr);
    }
}
