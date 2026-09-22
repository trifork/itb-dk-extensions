package com.trifork.ihexdsapi.configuration;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.util.StringUtils;

/** Operator-configured credentials keyed by meaningful, deployment-specific names. */
@ConfigurationProperties(prefix = "xds")
public record CredentialProperties(Map<String, Credential> credentials) {
    public CredentialProperties {
        credentials =
                credentials == null
                        ? Map.of()
                        : Collections.unmodifiableMap(new LinkedHashMap<>(credentials));
    }

    public record Credential(
            String certificate,
            String privateKey,
            String pkcs12,
            String passwordFile,
            String alias,
            String displayName) {
        public Credential {
            boolean pem = StringUtils.hasText(certificate) || StringUtils.hasText(privateKey);
            boolean bundle = StringUtils.hasText(pkcs12);
            if (pem == bundle) {
                throw new IllegalArgumentException(
                        "Configure either a PEM certificate/private-key pair or a PKCS#12 bundle");
            }
            if (bundle) {
                if (!StringUtils.hasText(passwordFile)) {
                    throw new IllegalArgumentException("password-file is required for PKCS#12");
                }
            } else {
                if (!StringUtils.hasText(certificate) || !StringUtils.hasText(privateKey)) {
                    throw new IllegalArgumentException(
                            "Both certificate and private-key are required for PEM");
                }
                if (StringUtils.hasText(passwordFile) || StringUtils.hasText(alias)) {
                    throw new IllegalArgumentException(
                            "password-file and alias apply only to PKCS#12");
                }
            }
        }
    }
}
