package com.trifork.ihexdsapi.utility;

import com.trifork.ihexdsapi.dgws.DgwsSecurityException;
import dk.sosi.seal.vault.GenericCredentialVault;
import java.io.*;
import java.security.*;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;
import java.util.Properties;

public final class VaultGenerator {
    private VaultGenerator() {}

    private static final SecureRandom RANDOM = new SecureRandom();

    private static PrivateKey getPrivateKeyFromString(String privateKey)
            throws NoSuchAlgorithmException, InvalidKeySpecException {
        String pkcs8Pem =
                privateKey
                        .replace("-----BEGIN PRIVATE KEY-----", "")
                        .replace("-----END PRIVATE KEY-----", "")
                        .replaceAll("\\s+", "");

        // Base64 decode the result
        byte[] pkcs8EncodedBytes = Base64.getDecoder().decode(pkcs8Pem);

        // extract the private key
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(pkcs8EncodedBytes);
        KeyFactory kf = KeyFactory.getInstance("RSA");
        return kf.generatePrivate(keySpec);
    }

    private static KeyStore createKeystore(
            String alias, String password, String publicCertStr, String privateKeyStr)
            throws KeyStoreException,
                    CertificateException,
                    IOException,
                    NoSuchAlgorithmException,
                    InvalidKeySpecException {
        // Create the keystore
        KeyStore keyStore = KeyStore.getInstance("jks");
        keyStore.load(null);

        // Load the certificate chain (in X.509 DER encoding).
        CertificateFactory certificateFactory = CertificateFactory.getInstance("X.509");
        java.security.cert.Certificate[] chain = {};
        InputStream certificateStream =
                new ByteArrayInputStream(
                        publicCertStr.getBytes(java.nio.charset.StandardCharsets.US_ASCII));
        chain = certificateFactory.generateCertificates(certificateStream).toArray(chain);
        certificateStream.close();

        // Load the private key (in PKCS#8 DER encoding).
        PrivateKey privateKey = getPrivateKeyFromString(privateKeyStr);
        if (chain.length == 0) throw new CertificateException("Missing certificate");
        try {
            // Prove that the loaded private key belongs to the leaf certificate.
            Signature signature = Signature.getInstance("SHA256withRSA");
            byte[] challenge = new byte[32];
            RANDOM.nextBytes(challenge);
            signature.initSign(privateKey);
            signature.update(challenge);
            byte[] signed = signature.sign();
            signature.initVerify(chain[0].getPublicKey());
            signature.update(challenge);
            if (!signature.verify(signed))
                throw new CertificateException("Certificate and private key do not match");
        } catch (GeneralSecurityException e) {
            throw new CertificateException("Invalid certificate/private key pair", e);
        }
        keyStore.setEntry(
                alias,
                new KeyStore.PrivateKeyEntry(privateKey, chain),
                new KeyStore.PasswordProtection(password.toCharArray()));
        return keyStore;
    }

    public static GenericCredentialVault generateGenericCredentialVault(
            String publicCertStr, String privateKeyStr, String password)
            throws DgwsSecurityException {
        if (password == null || password.isBlank()) {
            throw new IllegalStateException(
                    "Configure xds.vault.password (XDS_VAULT_PASSWORD) before loading signing credentials");
        }
        Properties properties = new Properties();
        KeyStore keystore;
        try {
            keystore =
                    createKeystore(
                            GenericCredentialVault.ALIAS_SYSTEM,
                            password,
                            publicCertStr,
                            privateKeyStr);
        } catch (KeyStoreException
                | NoSuchAlgorithmException
                | InvalidKeySpecException
                | IOException
                | IllegalArgumentException e) {

            throw new DgwsSecurityException(e, 2, "Invalid private key");
        } catch (CertificateException e) {

            throw new DgwsSecurityException(e, 1, "Invalid certificate");
        }

        try {
            return new GenericCredentialVault(properties, keystore, password);
        } catch (dk.sosi.seal.pki.PKIException e) {
            throw new IllegalArgumentException("Invalid certificate identity", e);
        }
    }
}
