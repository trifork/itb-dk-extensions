package com.trifork.ihexdsapi.dgws.impl;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import com.trifork.ihexdsapi.dao.CredentialRepository;
import com.trifork.ihexdsapi.dao.entity.CredentialInfoEntity;
import com.trifork.ihexdsapi.dgws.CredentialInfo;
import com.trifork.ihexdsapi.dgws.DgwsSecurityException;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.NullAndEmptySource;
import org.junit.jupiter.params.provider.ValueSource;

class CredentialServiceImplTest extends AbstractTest {

    private CredentialServiceImpl credentialService;
    private CredentialRepository credentialRepository;

    @BeforeEach
    void setup() {
        credentialRepository = mock(CredentialRepository.class);
        credentialService =
                new CredentialServiceImpl(credentialRepository, "fixture-vault-password");
    }

    @ParameterizedTest
    @NullAndEmptySource
    @ValueSource(strings = {" ", "\t\n"})
    void missingVaultPasswordRejectsCredentialsBeforeSaving(String password) {
        var service = new CredentialServiceImpl(credentialRepository, password);
        var error =
                assertThrows(
                        IllegalStateException.class,
                        () ->
                                service.createAndAddCredentialInfo(
                                        null, "Fixture", "certificate", "key"));
        assertTrue(error.getMessage().contains("XDS_VAULT_PASSWORD"));
        verifyNoInteractions(credentialRepository);
    }

    @Test
    void vaultUsesTheConfiguredPasswordWithoutTrimmingIt() throws Exception {
        String password = "  fixture-vault-secret  ";
        var service = new CredentialServiceImpl(credentialRepository, password);
        var info =
                service.createAndAddCredentialInfo(
                        null,
                        "Fixture",
                        getFileString("/certificates/public-cert1.cer"),
                        getFileString("/certificates/private-cert1.pem"));
        var vault = info.getCredentialVault();
        assertNotNull(vault.getSystemCredentialPair());
        assertNotNull(
                vault.getKeyStore()
                        .getKey(
                                dk.sosi.seal.vault.GenericCredentialVault.ALIAS_SYSTEM,
                                password.toCharArray()));
        assertThrows(
                java.security.UnrecoverableKeyException.class,
                () ->
                        vault.getKeyStore()
                                .getKey(
                                        dk.sosi.seal.vault.GenericCredentialVault.ALIAS_SYSTEM,
                                        password.trim().toCharArray()));
    }

    @Test
    void testCreateCredentialVaultWithLegalCertificatePair() throws DgwsSecurityException {

        // Given
        String publicCertStr = getFileString("/certificates/public-cert1.cer");
        String privateKeyStr = getFileString("/certificates/private-cert1.pem");
        String owner = "me";
        String displayName = "My cetifiacte";

        // When
        CredentialInfo info =
                credentialService.createAndAddCredentialInfo(
                        owner, displayName, publicCertStr, privateKeyStr);
        // Then
        assertNotNull(info);
    }

    @Test
    void testCreateCredentialVaultWithNonsenseInput() {

        // Given
        String publicCertStr = "Not a cert";
        String privateKeyStr = "Not a key";
        String owner = "me";
        String displayName = "My cetifiacte";

        // When
        assertThrows(
                DgwsSecurityException.class,
                () ->
                        credentialService.createAndAddCredentialInfo(
                                owner, displayName, publicCertStr, privateKeyStr));
    }

    @Test
    void testCreateCredentialVaultWithNonMatchingCertAndKey() {

        // Given
        String publicCertStr = getFileString("/certificates/other-cert.cer");
        String privateKeyStr = getFileString("/certificates/private-cert1.pem");
        String owner = "me";
        String displayName = "My cetifiacte";

        var exception =
                org.junit.jupiter.api.Assertions.assertThrows(
                        DgwsSecurityException.class,
                        () ->
                                credentialService.createAndAddCredentialInfo(
                                        owner, displayName, publicCertStr, privateKeyStr));
        org.junit.jupiter.api.Assertions.assertEquals(1, exception.getErrorCode());
    }

    @Test
    void TestgetCredentialInfoFromId() {

        String publicCertStr = getFileString("/certificates/public-cert1.cer");
        String privateKeyStr = getFileString("/certificates/private-cert1.pem");
        String owner = "me";
        String displayName = "My cetifiacte";
        String id = "MyID";
        String serialNumber = "test";
        String type = "test";

        when(credentialRepository.findCredentialInfoByID(id))
                .then(
                        a -> {
                            return new CredentialInfoEntity(
                                    owner,
                                    id,
                                    displayName,
                                    publicCertStr,
                                    privateKeyStr,
                                    serialNumber,
                                    type);
                        });

        // Test muck data mod metode

        CredentialInfo result = credentialService.getCredentialInfoFromId(id);
        Assertions.assertNotNull(result);
    }
}
