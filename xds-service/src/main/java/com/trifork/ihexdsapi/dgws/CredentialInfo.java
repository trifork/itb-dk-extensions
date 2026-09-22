package com.trifork.ihexdsapi.dgws;

import dk.sosi.seal.vault.CredentialVault;
import java.io.IOException;
import java.security.cert.X509Certificate;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.bouncycastle.asn1.*;
import org.bouncycastle.asn1.x500.RDN;
import org.bouncycastle.asn1.x500.X500Name;
import org.bouncycastle.asn1.x500.style.BCStyle;
import org.bouncycastle.asn1.x509.CertificatePolicies;
import org.bouncycastle.asn1.x509.Extension;
import org.bouncycastle.asn1.x509.PolicyInformation;

/** Parsed identity only; certificate trust and user authorisation are checked by STS. */
public class CredentialInfo {
    private static final int LEGACY_NAME_PARTS = 2;
    public static final String SYSTEM = "SYSTEM";
    public static final String HEALTHCAREPROFESSIONAL = "HEALTHCAREPROFESSIONAL";
    private static final Pattern LEGACY_SERIAL = Pattern.compile("CVR:(\\d{8})-(RID|UID):.+");
    private static final Pattern LEGACY_ORG = Pattern.compile("^(.*)//\\s*CVR:(\\d{8})$");
    // OCES 3 policy: nq.{medarbejder=2, virksomhed=3}.version; VOCES and FOCES share policy 3.
    private static final Pattern OCES3_POLICY =
            Pattern.compile("1\\.2\\.208\\.169\\.1\\.1\\.1\\.([23])\\.\\d+(?:\\.\\d+)?");
    private final CredentialVault credentialVault;
    private final String displayName;
    private final String serialNumber;
    private final String type;
    private final String organisationName;
    private final String cvr;
    private final String givenName;
    private final String surname;

    public CredentialInfo(CredentialVault credentialVault, String displayName) {
        this.credentialVault = credentialVault;
        X509Certificate certificate = credentialVault.getSystemCredentialPair().getCertificate();
        X500Name subject = X500Name.getInstance(certificate.getSubjectX500Principal().getEncoded());
        serialNumber = required(attribute(subject, BCStyle.SERIALNUMBER), "subject serial number");
        String commonName = required(attribute(subject, BCStyle.CN), "common name");
        this.displayName = displayName == null || displayName.isBlank() ? commonName : displayName;
        String organisation = required(attribute(subject, BCStyle.O), "organisation");
        String organisationId = attribute(subject, BCStyle.ORGANIZATION_IDENTIFIER);
        Matcher legacy = LEGACY_SERIAL.matcher(serialNumber);
        if (organisationId != null) {
            if (!organisationId.matches("NTRDK-\\d{8}")) {
                throw new IllegalArgumentException(
                        "Certificate must identify a Danish CVR organisation");
            }
            cvr = organisationId.substring(6);
            organisationName = organisation;
            type = oces3Type(certificate);
        } else if (legacy.matches()) {
            cvr = legacy.group(1);
            type = "RID".equals(legacy.group(2)) ? HEALTHCAREPROFESSIONAL : SYSTEM;
            Matcher legacyOrg = LEGACY_ORG.matcher(organisation);
            if (!legacyOrg.matches() || !cvr.equals(legacyOrg.group(2))) {
                throw new IllegalArgumentException(
                        "Certificate organisation and subject CVR do not match");
            }
            organisationName = legacyOrg.group(1).trim();
        } else {
            throw new IllegalArgumentException("Unsupported OCES certificate identity");
        }
        String[] names = personNames(subject, commonName, organisationId == null, type);
        givenName = names[0];
        surname = names[1];
    }

    private static String[] personNames(
            X500Name subject, String commonName, boolean legacyIdentity, String type) {
        String first = attribute(subject, BCStyle.GIVENNAME);
        String last = attribute(subject, BCStyle.SURNAME);
        if (HEALTHCAREPROFESSIONAL.equals(type)) {
            if (legacyIdentity && first == null && last == null) {
                String[] names = commonName.trim().split("\\s+", 2);
                first = names[0];
                if (names.length == LEGACY_NAME_PARTS) last = names[1];
            }
            return new String[] {required(first, "given name"), required(last, "surname")};
        } else {
            return new String[] {null, null};
        }
    }

    private static String attribute(X500Name subject, ASN1ObjectIdentifier oid) {
        String result = null;
        for (RDN rdn : subject.getRDNs(oid)) {
            for (var value : rdn.getTypesAndValues()) {
                if (oid.equals(value.getType())) {
                    if (result != null)
                        throw new IllegalArgumentException(
                                "Duplicate certificate identity attribute");
                    if (!(value.getValue() instanceof ASN1String))
                        throw new IllegalArgumentException(
                                "Invalid certificate identity attribute");
                    result = ((ASN1String) value.getValue()).getString();
                }
            }
        }
        return result;
    }

    private static String required(String value, String field) {
        if (value == null || value.isBlank())
            throw new IllegalArgumentException("Certificate is missing " + field);
        return value;
    }

    private static String oces3Type(X509Certificate certificate) {
        byte[] extension = certificate.getExtensionValue(Extension.certificatePolicies.getId());
        if (extension == null)
            throw new IllegalArgumentException("Missing OCES 3 certificate policy");
        try {
            var policies =
                    CertificatePolicies.getInstance(
                            ASN1Primitive.fromByteArray(
                                    ASN1OctetString.getInstance(extension).getOctets()));
            Set<String> kinds = new HashSet<>();
            for (PolicyInformation policy : policies.getPolicyInformation()) {
                Matcher matcher = OCES3_POLICY.matcher(policy.getPolicyIdentifier().getId());
                if (matcher.matches()) kinds.add(matcher.group(1));
            }
            if (kinds.isEmpty() || kinds.size() > 1)
                throw new IllegalArgumentException(
                        "Unsupported or conflicting OCES 3 certificate policies");
            return kinds.contains("2") ? HEALTHCAREPROFESSIONAL : SYSTEM;
        } catch (IOException e) {
            throw new IllegalArgumentException("Invalid certificate policies", e);
        }
    }

    public CredentialVault getCredentialVault() {
        return credentialVault;
    }

    public String getDisplayName() {
        return displayName;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public String getType() {
        return type;
    }

    public String getOrganisationName() {
        return organisationName;
    }

    public String getCvr() {
        return cvr;
    }

    public String getGivenName() {
        return givenName;
    }

    public String getSurname() {
        return surname;
    }
}
