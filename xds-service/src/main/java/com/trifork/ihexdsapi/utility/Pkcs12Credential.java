package com.trifork.ihexdsapi.utility;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.GeneralSecurityException;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.cert.X509Certificate;
import java.util.Base64;
import java.util.Collections;

/** Converts a local PKCS#12 bundle in memory for the existing credential repository. */
public record Pkcs12Credential(String certificatePem, String privateKeyPem) {
    public static Pkcs12Credential load(Path path, char[] password, String alias)
            throws IOException, GeneralSecurityException {
        KeyStore store = KeyStore.getInstance("PKCS12");
        try (InputStream input = Files.newInputStream(path)) {
            store.load(input, password);
        }
        String selectedAlias = selectAlias(store, alias);
        if (selectedAlias == null || !store.isKeyEntry(selectedAlias)) {
            throw new GeneralSecurityException("No private key for the configured PKCS#12 alias");
        }
        if (!(store.getKey(selectedAlias, password) instanceof PrivateKey key)
                || !"RSA".equals(key.getAlgorithm())) {
            throw new GeneralSecurityException(
                    "An RSA private key is required by the current DGWS client");
        }
        var chain = store.getCertificateChain(selectedAlias);
        if (chain == null || chain.length == 0)
            throw new GeneralSecurityException("PKCS#12 certificate chain is missing");
        ((X509Certificate) chain[0]).checkValidity();
        StringBuilder pem = new StringBuilder();
        for (var certificate : chain) pem.append(pem("CERTIFICATE", certificate.getEncoded()));
        return new Pkcs12Credential(pem.toString(), pem("PRIVATE KEY", key.getEncoded()));
    }

    private static String selectAlias(KeyStore store, String alias)
            throws GeneralSecurityException {
        String selectedAlias = alias;
        if (selectedAlias == null || selectedAlias.isBlank()) {
            for (String candidate : Collections.list(store.aliases())) {
                if (store.isKeyEntry(candidate)) {
                    if (selectedAlias != null && !selectedAlias.isBlank()) {
                        throw new GeneralSecurityException(
                                "Multiple private keys in PKCS#12; configure an alias");
                    }
                    selectedAlias = candidate;
                }
            }
        }
        return selectedAlias;
    }

    private static String pem(String label, byte[] bytes) {
        return "-----BEGIN "
                + label
                + "-----\n"
                + Base64.getMimeEncoder(64, new byte[] {'\n'}).encodeToString(bytes)
                + "\n-----END "
                + label
                + "-----\n";
    }

    @Override
    public String toString() {
        return "Pkcs12Credential[redacted]";
    }
}
