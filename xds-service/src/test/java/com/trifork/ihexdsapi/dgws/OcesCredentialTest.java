package com.trifork.ihexdsapi.dgws;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

import com.trifork.ihexdsapi.configuration.CredentialConfiguration;
import com.trifork.ihexdsapi.configuration.CredentialProperties;
import com.trifork.ihexdsapi.dgws.impl.StsServiceImpl;
import com.trifork.ihexdsapi.utility.Pkcs12Credential;
import com.trifork.ihexdsapi.utility.VaultGenerator;
import dk.nsp.seal.security.SignAndValidate;
import dk.sosi.seal.pki.SOSITestFederation;
import java.io.*;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.security.*;
import java.security.cert.X509Certificate;
import java.time.Instant;
import java.util.*;
import javax.xml.parsers.DocumentBuilderFactory;
import org.bouncycastle.asn1.ASN1ObjectIdentifier;
import org.bouncycastle.asn1.x500.X500Name;
import org.bouncycastle.asn1.x509.*;
import org.bouncycastle.cert.jcajce.JcaX509CertificateConverter;
import org.bouncycastle.cert.jcajce.JcaX509v3CertificateBuilder;
import org.bouncycastle.operator.jcajce.JcaContentSignerBuilder;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.io.TempDir;
import org.openapitools.model.HealthcareProfessionalContext;
import org.springframework.http.*;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.web.client.RestTemplate;
import org.w3c.dom.Document;

class OcesCredentialTest {
    private static KeyPair keys;
    private static final String PERSON =
            "C=DK, O=Testorganisation, 2.5.4.97=NTRDK-12345678,"
                    + " SERIALNUMBER=UI:DK-E:G:00000000-0000-0000-0000-000000000001, GIVENNAME=Anne"
                    + " Marie, SURNAME=Østergaard, CN=Anne Marie Østergaard";
    @TempDir Path directory;

    @BeforeAll
    static void keys() throws Exception {
        DgwsSignaturePolicy.configure(true);
        SignAndValidate.setupCryptoProviderForJVM();
        KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
        generator.initialize(2048);
        keys = generator.generateKeyPair();
    }

    static X509Certificate certificate(String subject, String... policyIds) throws Exception {
        var name = new X500Name(subject);
        var builder =
                new JcaX509v3CertificateBuilder(
                        name,
                        BigInteger.ONE,
                        Date.from(Instant.now().minusSeconds(60)),
                        Date.from(Instant.now().plusSeconds(3600)),
                        name,
                        keys.getPublic());
        if (policyIds.length > 0)
            builder.addExtension(
                    Extension.certificatePolicies,
                    false,
                    new CertificatePolicies(
                            Arrays.stream(policyIds)
                                    .map(p -> new PolicyInformation(new ASN1ObjectIdentifier(p)))
                                    .toArray(PolicyInformation[]::new)));
        return new JcaX509CertificateConverter()
                .getCertificate(
                        builder.build(
                                new JcaContentSignerBuilder("SHA256withRSA")
                                        .build(keys.getPrivate())));
    }

    static String pem(String label, byte[] bytes) {
        return "-----BEGIN "
                + label
                + "-----\n"
                + Base64.getMimeEncoder().encodeToString(bytes)
                + "\n-----END "
                + label
                + "-----\n";
    }

    static CredentialInfo info(X509Certificate cert) throws Exception {
        return new CredentialInfo(
                VaultGenerator.generateGenericCredentialVault(
                        pem("CERTIFICATE", cert.getEncoded()),
                        pem("PRIVATE KEY", keys.getPrivate().getEncoded()),
                        "fixture-vault-password"),
                null);
    }

    @Test
    void readsOces3EmployeeFieldsAndPreservesUuid() throws Exception {
        CredentialInfo info = info(certificate(PERSON, "1.2.208.169.1.1.1.2.7.1"));
        assertEquals(CredentialInfo.HEALTHCAREPROFESSIONAL, info.getType());
        assertEquals("12345678", info.getCvr());
        assertEquals("Testorganisation", info.getOrganisationName());
        assertEquals("Anne Marie", info.getGivenName());
        assertEquals("Østergaard", info.getSurname());
        assertEquals("Anne Marie Østergaard", info.getDisplayName());
        assertEquals("UI:DK-E:G:00000000-0000-0000-0000-000000000001", info.getSerialNumber());
    }

    @Test
    void recognisesSystemPoliciesWithoutInferringTypeFromUuid() throws Exception {
        // VOCES and FOCES share this policy; neither should enter the employee path.
        assertEquals(
                CredentialInfo.SYSTEM,
                info(certificate(PERSON, "1.2.208.169.1.1.1.3.7.1")).getType());
    }

    @Test
    void rejectsUnknownConflictingAndIncompleteIdentities() throws Exception {
        for (String[] policy :
                List.of(
                        new String[] {},
                        new String[] {"1.2.3"},
                        new String[] {"1.2.208.169.1.1.1.2.7.1", "1.2.208.169.1.1.1.3.7.1"})) {
            X509Certificate cert = certificate(PERSON, policy);
            assertThrows(IllegalArgumentException.class, () -> info(cert));
        }
        for (String subject :
                List.of(
                        PERSON.replace("NTRDK-12345678", "NTRSE-12345678"),
                        PERSON.replace("SURNAME=Østergaard, ", ""),
                        PERSON + ", 2.5.4.97=NTRDK-99999999")) {
            var cert = certificate(subject, "1.2.208.169.1.1.1.2.7.1");
            assertThrows(IllegalArgumentException.class, () -> info(cert));
        }
    }

    @Test
    void legacyMultiValuedRdnsStillWorkInEitherOrder() throws Exception {
        for (String identity :
                List.of(
                        "CN=Anne Østergaard+SERIALNUMBER=CVR:12345678-RID:1234",
                        "SERIALNUMBER=CVR:12345678-RID:1234+CN=Anne Østergaard")) {
            var info = info(certificate("C=DK, O=Testorganisation // CVR:12345678, " + identity));
            assertEquals("12345678", info.getCvr());
            assertEquals("Anne", info.getGivenName());
            assertEquals("Østergaard", info.getSurname());
        }
        var system =
                info(
                        certificate(
                                "CN=Testorganisation, SERIALNUMBER=CVR:12345678-UID:1234,"
                                        + " O=Testorganisation // CVR:12345678, C=DK"));
        assertEquals(CredentialInfo.SYSTEM, system.getType());
    }

    Path bundle(String... aliases) throws Exception {
        var store = KeyStore.getInstance("PKCS12");
        store.load(null, null);
        var cert = certificate(PERSON, "1.2.208.169.1.1.1.2.7.1");
        for (String alias : aliases)
            store.setKeyEntry(
                    alias,
                    keys.getPrivate(),
                    "fixture-password".toCharArray(),
                    new java.security.cert.Certificate[] {cert});
        Path path = directory.resolve("fixture.p12");
        try (var output = Files.newOutputStream(path)) {
            store.store(output, "fixture-password".toCharArray());
        }
        return path;
    }

    @Test
    void loadsPkcs12AndRejectsWrongPasswordAndAmbiguousAliases() throws Exception {
        Path path = bundle("employee");
        var material = Pkcs12Credential.load(path, "fixture-password".toCharArray(), "");
        var info =
                new CredentialInfo(
                        VaultGenerator.generateGenericCredentialVault(
                                material.certificatePem(),
                                material.privateKeyPem(),
                                "fixture-vault-password"),
                        null);
        assertEquals("Anne Marie Østergaard", info.getDisplayName());
        assertFalse(material.toString().contains("PRIVATE KEY"));
        assertThrows(
                IOException.class, () -> Pkcs12Credential.load(path, "wrong".toCharArray(), ""));
        assertThrows(
                GeneralSecurityException.class,
                () -> Pkcs12Credential.load(path, "fixture-password".toCharArray(), "missing"));
        bundle("one", "two");
        assertThrows(
                GeneralSecurityException.class,
                () -> Pkcs12Credential.load(path, "fixture-password".toCharArray(), ""));
        assertNotNull(Pkcs12Credential.load(path, "fixture-password".toCharArray(), "two"));
    }

    @Test
    void rejectsMismatchedPrivateKey() throws Exception {
        var certificate = certificate(PERSON, "1.2.208.169.1.1.1.2.7.1");
        var generator = KeyPairGenerator.getInstance("RSA");
        generator.initialize(2048);
        var other = generator.generateKeyPair();
        assertThrows(
                DgwsSecurityException.class,
                () ->
                        VaultGenerator.generateGenericCredentialVault(
                                pem("CERTIFICATE", certificate.getEncoded()),
                                pem("PRIVATE KEY", other.getPrivate().getEncoded()),
                                "fixture-vault-password"));
    }

    @Test
    void loadsMixedNamedCredentials() throws Exception {
        var service = mock(CredentialService.class);
        Path password = directory.resolve("password");
        Files.writeString(password, "fixture-password\n");
        Path bundle = bundle("employee");
        var credential =
                new CredentialProperties.Credential(
                        null, null, bundle.toString(), password.toString(), "", "");
        var material = Pkcs12Credential.load(bundle, "fixture-password".toCharArray(), "");
        Path certificate = directory.resolve("employee.cer");
        Path key = directory.resolve("employee.pem");
        Files.writeString(certificate, material.certificatePem());
        Files.writeString(key, material.privateKeyPem());
        var pem =
                new CredentialProperties.Credential(
                        certificate.toString(), key.toString(), null, null, null, "PEM identity");
        var properties = new CredentialProperties(Map.of("employee", credential, "alternate", pem));
        new CredentialConfiguration(service, properties).loadCredentials();
        verify(service)
                .createAndAddCredentialInfo(
                        isNull(),
                        eq(""),
                        contains("BEGIN CERTIFICATE"),
                        contains("BEGIN PRIVATE KEY"));
        verify(service)
                .createAndAddCredentialInfo(
                        isNull(),
                        eq("PEM identity"),
                        eq(material.certificatePem()),
                        eq(material.privateKeyPem()));
        verifyNoMoreInteractions(service);
    }

    @Test
    void createsSignedUserRequestWithOces3IdentityBeforeCallingSts() throws Exception {
        var info = info(certificate(PERSON, "1.2.208.169.1.1.1.2.7.1"));
        var rest = mock(RestTemplate.class);
        var service = new StsServiceImpl("https://sts.invalid");
        ReflectionTestUtils.setField(service, "restTemplate", rest);
        var context = new HealthcareProfessionalContext();
        context.setRole("Læge");
        context.setConsentOverride(false);
        RuntimeException reachedTransport = new RuntimeException("mock transport reached");
        when(rest.exchange(
                        eq("https://sts.invalid"),
                        eq(HttpMethod.POST),
                        any(HttpEntity.class),
                        eq(String.class)))
                .thenAnswer(
                        call -> {
                            String xml = (String) ((HttpEntity<?>) call.getArgument(2)).getBody();
                            assertTrue(xml.contains("Anne Marie"));
                            assertTrue(xml.contains("Østergaard"));
                            assertTrue(xml.contains("12345678"));
                            assertTrue(xml.contains("Testorganisation"));
                            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                            factory.setNamespaceAware(true);
                            Document doc =
                                    factory.newDocumentBuilder()
                                            .parse(
                                                    new ByteArrayInputStream(
                                                            xml.getBytes(StandardCharsets.UTF_8)));
                            var signatures =
                                    doc.getElementsByTagNameNS(
                                            "http://www.w3.org/2000/09/xmldsig#", "Signature");
                            assertEquals(1, signatures.getLength());
                            assertTrue(
                                    SignAndValidate.validateDGWS(
                                            signatures.item(0),
                                            new SOSITestFederation(new Properties()),
                                            info.getCredentialVault(),
                                            false));
                            assertThrows(
                                    dk.sosi.seal.model.ModelException.class,
                                    () ->
                                            SignAndValidate.validateDGWS(
                                                    signatures.item(0),
                                                    null,
                                                    mock(dk.sosi.seal.vault.CredentialVault.class),
                                                    true));
                            var signedAttribute =
                                    doc.getElementsByTagNameNS(
                                                    "urn:oasis:names:tc:SAML:2.0:assertion",
                                                    "AttributeValue")
                                            .item(0);
                            assertNotNull(signedAttribute);
                            signedAttribute.setTextContent("tampered");
                            assertFalse(
                                    SignAndValidate.validateDGWS(
                                            signatures.item(0),
                                            null,
                                            info.getCredentialVault(),
                                            false));
                            throw reachedTransport;
                        });
        assertSame(
                reachedTransport,
                assertThrows(
                        RuntimeException.class,
                        () ->
                                service.getDgwsClientInfoForSystem(
                                        info, "synthetic-patient", context)));
        verify(rest)
                .exchange(
                        anyString(), eq(HttpMethod.POST), any(HttpEntity.class), eq(String.class));
    }

    @Test
    void rejectsSystemCredentialForEmployeeFlowWithoutCallingSts() throws Exception {
        var system = info(certificate(PERSON, "1.2.208.169.1.1.1.3.7.1"));
        var service = new StsServiceImpl("https://sts.invalid");
        assertThrows(
                DgwsSecurityException.class,
                () ->
                        service.getDgwsClientInfoForSystem(
                                system, "synthetic-patient", new HealthcareProfessionalContext()));
    }
}
