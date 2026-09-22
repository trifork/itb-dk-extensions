package com.trifork.ihexdsapi.dgws.impl;

import static org.junit.jupiter.api.Assertions.*;

import java.math.BigInteger;
import java.security.KeyPairGenerator;
import java.time.Instant;
import java.util.Base64;
import java.util.Date;
import org.bouncycastle.asn1.ASN1ObjectIdentifier;
import org.bouncycastle.asn1.x500.X500Name;
import org.bouncycastle.asn1.x509.*;
import org.bouncycastle.cert.jcajce.JcaX509CertificateConverter;
import org.bouncycastle.cert.jcajce.JcaX509v3CertificateBuilder;
import org.bouncycastle.operator.jcajce.JcaContentSignerBuilder;
import org.junit.jupiter.api.Test;
import org.openapitools.model.CredentialInfoResponse;

class CertificateDetailsTest {
    @Test
    void datesAndOces3KindsComeFromCertificateExtensions() throws Exception {
        var generator = KeyPairGenerator.getInstance("RSA");
        generator.initialize(2048);
        var key = generator.generateKeyPair();
        for (String kind : new String[] {"MOCES", "FOCES", "VOCES", "SYSTEM"}) {
            var name = new X500Name("CN=Fixture");
            var builder =
                    new JcaX509v3CertificateBuilder(
                            name,
                            BigInteger.ONE,
                            Date.from(Instant.parse("2021-01-01T00:00:00Z")),
                            Date.from(Instant.parse("2024-01-01T00:00:00Z")),
                            name,
                            key.getPublic());
            if (!"SYSTEM".equals(kind)) {
                String policy =
                        "MOCES".equals(kind)
                                ? "1.2.208.169.1.1.1.2.7.1"
                                : "1.2.208.169.1.1.1.3.7.1";
                builder.addExtension(
                        Extension.certificatePolicies,
                        false,
                        new CertificatePolicies(
                                new PolicyInformation(new ASN1ObjectIdentifier(policy))));
                int usage = KeyUsage.digitalSignature | KeyUsage.keyEncipherment;
                if ("VOCES".equals(kind)) usage |= KeyUsage.nonRepudiation;
                builder.addExtension(Extension.keyUsage, true, new KeyUsage(usage));
            }
            var cert =
                    new JcaX509CertificateConverter()
                            .getCertificate(
                                    builder.build(
                                            new JcaContentSignerBuilder("SHA256withRSA")
                                                    .build(key.getPrivate())));
            String pem =
                    "-----BEGIN CERTIFICATE-----\n"
                            + Base64.getMimeEncoder().encodeToString(cert.getEncoded())
                            + "\n-----END CERTIFICATE-----";
            var response = new CredentialInfoResponse();
            response.setCredentialType(
                    "MOCES".equals(kind)
                            ? CredentialInfoResponse.CredentialTypeEnum.HEALTHCAREPROFESSIONAL
                            : CredentialInfoResponse.CredentialTypeEnum.SYSTEM);
            CertificateDetails.populate(response, pem);
            assertEquals(kind, response.getCertificateKind());
            assertEquals("2021-01-01T00:00:00Z", response.getValidFrom());
            assertEquals("2024-01-01T00:00:00Z", response.getValidUntil());
        }
    }
}
