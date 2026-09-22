package com.trifork.ihexdsapi.configuration;

import com.trifork.ihexdsapi.dgws.CredentialService;
import com.trifork.ihexdsapi.dgws.DgwsSecurityException;
import com.trifork.ihexdsapi.utility.Pkcs12Credential;
import jakarta.annotation.PostConstruct;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.GeneralSecurityException;
import java.util.Arrays;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableConfigurationProperties(CredentialProperties.class)
public class CredentialConfiguration {
    private final CredentialService credentialService;
    private final CredentialProperties properties;

    public CredentialConfiguration(
            CredentialService credentialService, CredentialProperties properties) {
        this.credentialService = credentialService;
        this.properties = properties;
    }

    @PostConstruct
    public void loadCredentials()
            throws IOException, GeneralSecurityException, DgwsSecurityException {
        for (var credential : properties.credentials().values()) {
            if (credential.pkcs12() != null && !credential.pkcs12().isBlank()) {
                registerPkcs12(credential);
            } else {
                credentialService.createAndAddCredentialInfo(
                        null,
                        credential.displayName(),
                        Files.readString(Path.of(credential.certificate())),
                        Files.readString(Path.of(credential.privateKey())));
            }
        }
    }

    private void registerPkcs12(CredentialProperties.Credential credential)
            throws IOException, GeneralSecurityException, DgwsSecurityException {
        // Secret files may have a final newline; preserve other password characters.
        char[] password =
                Files.readString(Path.of(credential.passwordFile()))
                        .replaceFirst("\\r?\\n$", "")
                        .toCharArray();
        try {
            var material =
                    Pkcs12Credential.load(
                            Path.of(credential.pkcs12()), password, credential.alias());
            credentialService.createAndAddCredentialInfo(
                    null,
                    credential.displayName(),
                    material.certificatePem(),
                    material.privateKeyPem());
        } finally {
            Arrays.fill(password, '\0');
        }
    }
}
