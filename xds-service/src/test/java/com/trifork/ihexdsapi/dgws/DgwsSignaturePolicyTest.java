package com.trifork.ihexdsapi.dgws;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class DgwsSignaturePolicyTest {
    @Test
    void defaultLeavesTheJdkPolicyUntouched() {
        var original = java.security.Security.getProperty("jdk.xml.dsig.secureValidationPolicy");
        DgwsSignaturePolicy.configure(false);
        assertEquals(
                original,
                java.security.Security.getProperty("jdk.xml.dsig.secureValidationPolicy"));
    }

    @Test
    void permitsOnlyTheTwoLegacyAlgorithmsAndPreservesAllOtherLimits() {
        String retained =
                "disallowAlg http://www.w3.org/2000/09/xmldsig#dsa-sha1,disallowAlg"
                        + " http://www.w3.org/2001/04/xmldsig-more#rsa-md5,maxTransforms"
                        + " 5,maxReferences 30,disallowReferenceUriSchemes file http https,minKeySize"
                        + " RSA 1024,minKeySize DSA 1024,minKeySize EC"
                        + " 224,noDuplicateIds,noRetrievalMethodLoops,futureJdkRestriction true";
        String original =
                retained
                        + ",disallowAlg http://www.w3.org/2000/09/xmldsig#rsa-sha1,"
                        + " disallowAlg http://www.w3.org/2000/09/xmldsig#sha1";
        assertEquals(retained, DgwsSignaturePolicy.allowLegacyDgwsAlgorithms(original));
        assertEquals(retained, DgwsSignaturePolicy.allowLegacyDgwsAlgorithms(retained));
    }

    @Test
    void refusesToReplaceAnUnknownPolicy() {
        assertThrows(
                IllegalStateException.class,
                () -> DgwsSignaturePolicy.allowLegacyDgwsAlgorithms(null));
        assertThrows(
                IllegalStateException.class,
                () -> DgwsSignaturePolicy.allowLegacyDgwsAlgorithms(" "));
    }
}
