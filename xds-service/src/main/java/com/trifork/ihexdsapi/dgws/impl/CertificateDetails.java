package com.trifork.ihexdsapi.dgws.impl;

import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import org.bouncycastle.asn1.ASN1OctetString;
import org.bouncycastle.asn1.ASN1Primitive;
import org.bouncycastle.asn1.x509.CertificatePolicies;
import org.bouncycastle.asn1.x509.Extension;
import org.openapitools.model.CredentialInfoResponse;

/** Public certificate metadata only; dates do not establish trust or authorisation. */
final class CertificateDetails {
    private static final java.util.regex.Pattern COMPANY_POLICY =
            java.util.regex.Pattern.compile("1\\.2\\.208\\.169\\.1\\.1\\.1\\.3\\.\\d+(?:\\.\\d+)?");

    private CertificateDetails() {}

    static void populate(CredentialInfoResponse response, String pem) {
        try {
            X509Certificate certificate =
                    (X509Certificate)
                            CertificateFactory.getInstance("X.509")
                                    .generateCertificate(
                                            new ByteArrayInputStream(
                                                    pem.getBytes(StandardCharsets.US_ASCII)));
            response.setValidFrom(certificate.getNotBefore().toInstant().toString());
            response.setValidUntil(certificate.getNotAfter().toInstant().toString());
            response.setCertificateKind(kind(response, certificate));
        } catch (java.security.cert.CertificateException | java.io.IOException e) {
            throw new IllegalStateException("Unable to read stored certificate metadata", e);
        }
    }

    private static String kind(CredentialInfoResponse response, X509Certificate certificate)
            throws java.io.IOException {
        if (response.getCredentialType()
                == CredentialInfoResponse.CredentialTypeEnum.HEALTHCAREPROFESSIONAL) {
            return "MOCES";
        }
        if (hasCompanyPolicy(certificate)) {
            // OCES 3 shares a company policy; contentCommitment distinguishes VOCES from FOCES.
            boolean[] usage = certificate.getKeyUsage();
            if (usage != null && usage.length > 1) return usage[1] ? "VOCES" : "FOCES";
        }
        return "SYSTEM"; // Do not infer a specific legacy system profile from its display name.
    }

    private static boolean hasCompanyPolicy(X509Certificate certificate)
            throws java.io.IOException {
        byte[] policies = certificate.getExtensionValue(Extension.certificatePolicies.getId());
        if (policies == null) return false;
        var sequence =
                ASN1Primitive.fromByteArray(ASN1OctetString.getInstance(policies).getOctets());
        for (var policy : CertificatePolicies.getInstance(sequence).getPolicyInformation()) {
            if (COMPANY_POLICY.matcher(policy.getPolicyIdentifier().getId()).matches()) return true;
        }
        return false;
    }
}
