<?xml version='1.0' encoding='UTF-8'?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>PRF-DK-3.0.0 source-derived conformance checks</title>
  <ns prefix="v3" uri="urn:hl7-org:v3" />
  <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance" />
  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema" />
  <pattern id="PRF-DK-3.0.0-HEADER-TEMPLATE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-HEADER-TEMPLATE" test="count(v3:templateId[@root='1.2.208.184.19.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.1 Source: 2.1 CONF:H0001/H0003; 3.1 CONF:B0002/B0003.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-HEADER-ID-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-HEADER-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document requires one id Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-HEADER-CODE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-HEADER-CODE" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document requires one code Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-HEADER-TITLE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-HEADER-TITLE" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document requires one title Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-HEADER-EFFECTIVETIME-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-HEADER-EFFECTIVETIME" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document requires one effectiveTime Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-HEADER-AUTHOR-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-HEADER-AUTHOR" test="count(v3:author) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document requires one author Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-HEADER-CUSTODIAN-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-HEADER-CUSTODIAN" test="count(v3:custodian) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document requires one custodian Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-DOCUMENT-CODE-code-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PRF-DK-3.0.0-DOCUMENT-CODE-code" test="@code = 'PRF'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document code @code must be PRF Source: 2.1 document code constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-DOCUMENT-CODE-codeSystem-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PRF-DK-3.0.0-DOCUMENT-CODE-codeSystem" test="@codeSystem = '1.2.208.184.100.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document code @codeSystem must be 1.2.208.184.100.1 Source: 2.1 document code constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-DOCUMENT-CODE-codeSystemName-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PRF-DK-3.0.0-DOCUMENT-CODE-codeSystemName" test="@codeSystemName = 'MedCom Message Codes'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document code @codeSystemName must be MedCom Message Codes Source: 2.1 document code constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-DOCUMENT-CODE-displayName-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PRF-DK-3.0.0-DOCUMENT-CODE-displayName" test="@displayName = 'Pregnancy Referral Form'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document code @displayName must be Pregnancy Referral Form Source: 2.1 document code constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-DOCUMENT-ID-root-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PRF-DK-3.0.0-DOCUMENT-ID-root" test="normalize-space(@root) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@root must be present and non-empty Source: 2.1 document identifier constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-DOCUMENT-ID-assigningAuthorityName-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PRF-DK-3.0.0-DOCUMENT-ID-assigningAuthorityName" test="normalize-space(@assigningAuthorityName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@assigningAuthorityName must be present and non-empty Source: 2.1 document identifier constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-DOCUMENT-ID-extension-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PRF-DK-3.0.0-DOCUMENT-ID-extension" test="normalize-space(@extension) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@extension must be present and non-empty Source: 2.1 document identifier constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-DOCUMENT-UUID-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PRF-DK-3.0.0-DOCUMENT-UUID" test="matches(@extension, '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document identifier extension must be a UUID version 4 Source: 2.1 globally unique document identifier.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-DOCUMENT-OID-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PRF-DK-3.0.0-DOCUMENT-OID" test="matches(@root, '^[0-2](\.[0-9]+)+$')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document identifier root must be an OID Source: 2.1 sending organisation OID.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-TITLE-CPR-pattern">
    <rule context="v3:ClinicalDocument/v3:title">
      <assert id="PRF-DK-3.0.0-TITLE-CPR" test="normalize-space(.) = concat('Pregnancy Referral Form for ', /v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:id[@root='1.2.208.176.1.2']/@extension)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document title must contain the specified heading and patient CPR Source: 2.1 title constraint.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-PROVIDER-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole">
      <assert id="PRF-DK-3.0.0-PROVIDER" test="count(v3:providerOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Patient role requires one provider organisation Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-AUTHOR-TIME-pattern">
    <rule context="v3:ClinicalDocument/v3:author">
      <assert id="PRF-DK-3.0.0-AUTHOR-TIME" test="count(v3:time) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one time Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-ASSIGNED-AUTHOR-pattern">
    <rule context="v3:ClinicalDocument/v3:author">
      <assert id="PRF-DK-3.0.0-ASSIGNED-AUTHOR" test="count(v3:assignedAuthor) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one assignedAuthor Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-AUTHOR-PERSON-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <assert id="PRF-DK-3.0.0-AUTHOR-PERSON" test="count(v3:assignedPerson) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one assignedPerson Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-AUTHOR-PERSON-NAME-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:assignedPerson">
      <assert id="PRF-DK-3.0.0-AUTHOR-PERSON-NAME" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one name Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-AUTHOR-ORG-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <assert id="PRF-DK-3.0.0-AUTHOR-ORG" test="count(v3:representedOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one representedOrganization Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-AUTHOR-ORG-NAME-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:representedOrganization">
      <assert id="PRF-DK-3.0.0-AUTHOR-ORG-NAME" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one name Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-ASSIGNED-CUSTODIAN-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian">
      <assert id="PRF-DK-3.0.0-ASSIGNED-CUSTODIAN" test="count(v3:assignedCustodian) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one assignedCustodian Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-CUSTODIAN-ORG-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian">
      <assert id="PRF-DK-3.0.0-CUSTODIAN-ORG" test="count(v3:representedCustodianOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one representedCustodianOrganization Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-AUTHOR-TIME-VALUE-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:time">
      <assert id="PRF-DK-3.0.0-AUTHOR-TIME-VALUE" test="normalize-space(@value) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@value must be present and non-empty Source: 2.1.2 author participation time.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-PROVIDER-ID-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization">
      <assert id="PRF-DK-3.0.0-PROVIDER-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Provider needs one identifier Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-PROVIDER-AUTHORITY-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization/v3:id">
      <assert id="PRF-DK-3.0.0-PROVIDER-AUTHORITY" test="@assigningAuthorityName = 'SOR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Provider identifier authority must be SOR Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-PROVIDER-EXTENSION-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization/v3:id">
      <assert id="PRF-DK-3.0.0-PROVIDER-EXTENSION" test="normalize-space(@extension) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@extension must be present and non-empty Source: 2.1.1 SOR identifier (registry membership requires external verification).</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-PROVIDER-NAME-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization">
      <assert id="PRF-DK-3.0.0-PROVIDER-NAME" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Provider needs one name Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-AUTHOR-ID-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <assert id="PRF-DK-3.0.0-AUTHOR-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Author needs one identifier Source: 2.1.2.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-AUTHOR-AUTHORITY-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:id">
      <assert id="PRF-DK-3.0.0-AUTHOR-AUTHORITY" test="@assigningAuthorityName = 'SOR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Author identifier authority must be SOR Source: 2.1.2.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-AUTHOR-ROOT-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:id">
      <assert id="PRF-DK-3.0.0-AUTHOR-ROOT" test="@root = '1.2.208.176.1.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Author identifier root must be SOR Source: 2.1.2.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-AUTHOR-EXTENSION-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:id">
      <assert id="PRF-DK-3.0.0-AUTHOR-EXTENSION" test="normalize-space(@extension) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@extension must be present and non-empty Source: 2.1.2 SOR identifier (registry membership requires external verification).</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-CUSTODIAN-ID-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <assert id="PRF-DK-3.0.0-CUSTODIAN-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Custodian needs one identifier Source: 2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-CUSTODIAN-AUTHORITY-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization/v3:id">
      <assert id="PRF-DK-3.0.0-CUSTODIAN-AUTHORITY" test="@assigningAuthorityName = 'SOR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Custodian identifier authority must be SOR Source: 2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-CUSTODIAN-ROOT-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization/v3:id">
      <assert id="PRF-DK-3.0.0-CUSTODIAN-ROOT" test="@root = '1.2.208.176.1.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Custodian identifier root must be SOR Source: 2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-CUSTODIAN-EXTENSION-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization/v3:id">
      <assert id="PRF-DK-3.0.0-CUSTODIAN-EXTENSION" test="normalize-space(@extension) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@extension must be present and non-empty Source: 2.1.5 SOR identifier (registry membership requires external verification).</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-CUSTODIAN-NAME-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <assert id="PRF-DK-3.0.0-CUSTODIAN-NAME" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Custodian needs one name Source: 2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-PROVIDER-NO-addr-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization">
      <assert id="PRF-DK-3.0.0-PROVIDER-NO-addr" test="empty(v3:addr)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Provider organisation must not contain addr Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-PROVIDER-NO-telecom-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization">
      <assert id="PRF-DK-3.0.0-PROVIDER-NO-telecom" test="empty(v3:telecom)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Provider organisation must not contain telecom Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-NO-dataEnterer-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-NO-dataEnterer" test="empty(v3:dataEnterer)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Header must not contain dataEnterer Source: 2.1.3.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-NO-informant-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-NO-informant" test="empty(v3:informant)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Header must not contain informant Source: 2.1.4.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-NO-informationRecipient-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-NO-informationRecipient" test="empty(v3:informationRecipient)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Header must not contain informationRecipient Source: 2.1.6.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-NO-legalAuthenticator-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-NO-legalAuthenticator" test="empty(v3:legalAuthenticator)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Header must not contain legalAuthenticator Source: 2.1.7.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-NO-authenticator-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-NO-authenticator" test="empty(v3:authenticator)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Header must not contain authenticator Source: 2.1.8.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-NO-inFulfillmentOf-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-NO-inFulfillmentOf" test="empty(v3:inFulfillmentOf)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Header must not contain inFulfillmentOf Source: 2.1.10.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-DOCUMENTATION-COUNT-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-DOCUMENTATION-COUNT" test="count(v3:documentationOf) &gt;= 2 and count(v3:documentationOf) &lt;= 3" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document requires two or three documentationOf elements Source: 2.1.9.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-VERSION-EVENT-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-VERSION-EVENT" test="count(v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one profile version event Source: 2.1.9.1.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-VERSION-ID-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']">
      <assert id="PRF-DK-3.0.0-VERSION-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Version event requires one id Source: 2.1.9.1.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-VERSION-root-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="PRF-DK-3.0.0-VERSION-root" test="@root = '1.2.208.184.100.10'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Profile version @root must be 1.2.208.184.100.10 Source: 2.1.9.1.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-VERSION-extension-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="PRF-DK-3.0.0-VERSION-extension" test="@extension = 'PRF-v3.0'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Profile version @extension must be PRF-v3.0 Source: 2.1.9.1.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-VERSION-assigningAuthorityName-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="PRF-DK-3.0.0-VERSION-assigningAuthorityName" test="@assigningAuthorityName = 'MedCom'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Profile version @assigningAuthorityName must be MedCom Source: 2.1.9.1.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-TIME-EVENT-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-TIME-EVENT" test="count(v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one clinical content time event Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-TIME-INTERVAL-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']">
      <assert id="PRF-DK-3.0.0-TIME-INTERVAL" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Time event requires one effectiveTime Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-TIME-low-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime">
      <assert id="PRF-DK-3.0.0-TIME-low" test="count(v3:low) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Time interval requires one low Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-TIME-high-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime">
      <assert id="PRF-DK-3.0.0-TIME-high" test="count(v3:high) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Time interval requires one high Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-TIME-START-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:low">
      <assert id="PRF-DK-3.0.0-TIME-START" test="normalize-space(@value) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@value must be present and non-empty Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-TIME-END-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:high">
      <assert id="PRF-DK-3.0.0-TIME-END" test="@nullFlavor = 'NA'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Clinical content end must use nullFlavor NA Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-EPISODE-CARDINALITY-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-EPISODE-CARDINALITY" test="count(v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one episode event may be supplied Source: 2.1.9.3.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-EPISODE-ID-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']">
      <assert id="PRF-DK-3.0.0-EPISODE-ID" test="exists(v3:id)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">A supplied episode event needs at least one identifier Source: 2.1.9.3.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-EPISODE-UUID-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']/v3:id">
      <assert id="PRF-DK-3.0.0-EPISODE-UUID" test="matches(@extension, '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Episode identifier extension must be a UUID version 4 Source: 2.1.9.3.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-EPISODE-root-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']/v3:id">
      <assert id="PRF-DK-3.0.0-EPISODE-root" test="normalize-space(@root) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@root must be present and non-empty Source: 2.1.9.3.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-EPISODE-assigningAuthorityName-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']/v3:id">
      <assert id="PRF-DK-3.0.0-EPISODE-assigningAuthorityName" test="normalize-space(@assigningAuthorityName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@assigningAuthorityName must be present and non-empty Source: 2.1.9.3.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-PREGNANCY-AUTHORITY-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']/v3:id[@root='1.2.208.176.7.4.1']">
      <assert id="PRF-DK-3.0.0-PREGNANCY-AUTHORITY" test="@assigningAuthorityName = 'Sundhedsdatastyrelsen'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Pregnancy episode authority must be Sundhedsdatastyrelsen Source: 2.1.9.3 Pregnancy episode-of-care identifier.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0005-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PRF-DK-3.0.0-B0005" test="count(v3:component) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document requires one component Source: 3.1 CONF:B0005.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0006-pattern">
    <rule context="v3:ClinicalDocument/v3:component">
      <assert id="PRF-DK-3.0.0-B0006" test="count(v3:structuredBody) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Document requires one structuredBody Source: 3.1 CONF:B0006.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-1-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-1" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.1']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Language Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0049-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.1']">
      <assert id="PRF-DK-3.0.0-B0049" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Language Section @classCode must be DOCSECT Source: 4.1.1 CONF:B0049.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0050-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.1']">
      <assert id="PRF-DK-3.0.0-B0050" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Language Section @moodCode must be EVN Source: 4.1.1 CONF:B0050.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0051-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.1']">
      <assert id="PRF-DK-3.0.0-B0051" test="count(v3:templateId[@root='1.2.208.184.19.2.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.1 Source: 4.1.1 CONF:B0051/B0052/B0053.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0051-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.1']/v3:templateId[@root='1.2.208.184.19.2.1']">
      <assert id="PRF-DK-3.0.0-B0051-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.1 must use 2024-04-19 Source: 4.1.1 CONF:B0051/B0052/B0053.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0054-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.1']">
      <assert id="PRF-DK-3.0.0-B0054" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Language Section requires one code Source: 4.1.1 CONF:B0054.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0059-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.1']">
      <assert id="PRF-DK-3.0.0-B0059" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Language Section requires one title Source: 4.1.1 CONF:B0059.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0060-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.1']">
      <assert id="PRF-DK-3.0.0-B0060" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Language Section requires one text Source: 4.1.1 CONF:B0060.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0055-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.1']/v3:code">
      <assert id="PRF-DK-3.0.0-B0055" test="@code = '363915008'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Language Section @code must be 363915008 Source: 4.1.1 CONF:B0055.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0056-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.1']/v3:code">
      <assert id="PRF-DK-3.0.0-B0056" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Language Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.1.1 CONF:B0056.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0058-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.1']/v3:code">
      <assert id="PRF-DK-3.0.0-B0058" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.1.1 CONF:B0058.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-5-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-5" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.5']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Body Measure Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0067-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.5']">
      <assert id="PRF-DK-3.0.0-B0067" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Body Measure Section @classCode must be DOCSECT Source: 4.2.1 CONF:B0067.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0068-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.5']">
      <assert id="PRF-DK-3.0.0-B0068" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Body Measure Section @moodCode must be EVN Source: 4.2.1 CONF:B0068.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0069-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.5']">
      <assert id="PRF-DK-3.0.0-B0069" test="count(v3:templateId[@root='1.2.208.184.19.2.5']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.5 Source: 4.2.1 CONF:B0069/B0070/B0071.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0069-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.5']/v3:templateId[@root='1.2.208.184.19.2.5']">
      <assert id="PRF-DK-3.0.0-B0069-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.5 must use 2024-04-19 Source: 4.2.1 CONF:B0069/B0070/B0071.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0072-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.5']">
      <assert id="PRF-DK-3.0.0-B0072" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Body Measure Section requires one code Source: 4.2.1 CONF:B0072.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0077-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.5']">
      <assert id="PRF-DK-3.0.0-B0077" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Body Measure Section requires one title Source: 4.2.1 CONF:B0077.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0078-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.5']">
      <assert id="PRF-DK-3.0.0-B0078" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Body Measure Section requires one text Source: 4.2.1 CONF:B0078.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0073-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.5']/v3:code">
      <assert id="PRF-DK-3.0.0-B0073" test="@code = '248326004'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Body Measure Section @code must be 248326004 Source: 4.2.1 CONF:B0073.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0074-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.5']/v3:code">
      <assert id="PRF-DK-3.0.0-B0074" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Body Measure Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.2.1 CONF:B0074.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0076-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.5']/v3:code">
      <assert id="PRF-DK-3.0.0-B0076" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.2.1 CONF:B0076.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-9-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-9" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.9']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Household, Family, and Support Network Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0085-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.9']">
      <assert id="PRF-DK-3.0.0-B0085" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Household, Family, and Support Network Section @classCode must be DOCSECT Source: 4.3.1 CONF:B0085.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0086-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.9']">
      <assert id="PRF-DK-3.0.0-B0086" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Household, Family, and Support Network Section @moodCode must be EVN Source: 4.3.1 CONF:B0086.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0087-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.9']">
      <assert id="PRF-DK-3.0.0-B0087" test="count(v3:templateId[@root='1.2.208.184.19.2.9']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.9 Source: 4.3.1 CONF:B0087/B0088/B0089.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0087-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.9']/v3:templateId[@root='1.2.208.184.19.2.9']">
      <assert id="PRF-DK-3.0.0-B0087-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.9 must use 2024-04-19 Source: 4.3.1 CONF:B0087/B0088/B0089.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0090-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.9']">
      <assert id="PRF-DK-3.0.0-B0090" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Household, Family, and Support Network Section requires one code Source: 4.3.1 CONF:B0090.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0095-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.9']">
      <assert id="PRF-DK-3.0.0-B0095" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Household, Family, and Support Network Section requires one title Source: 4.3.1 CONF:B0095.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0096-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.9']">
      <assert id="PRF-DK-3.0.0-B0096" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Household, Family, and Support Network Section requires one text Source: 4.3.1 CONF:B0096.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0091-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.9']/v3:code">
      <assert id="PRF-DK-3.0.0-B0091" test="@code = '302160007'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Household, Family, and Support Network Section @code must be 302160007 Source: 4.3.1 CONF:B0091.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0092-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.9']/v3:code">
      <assert id="PRF-DK-3.0.0-B0092" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Household, Family, and Support Network Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.3.1 CONF:B0092.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0094-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.9']/v3:code">
      <assert id="PRF-DK-3.0.0-B0094" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.3.1 CONF:B0094.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-15-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-15" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.15']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Prior Births Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0105-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.15']">
      <assert id="PRF-DK-3.0.0-B0105" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Prior Births Section @classCode must be DOCSECT Source: 4.4.1 CONF:B0105.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0106-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.15']">
      <assert id="PRF-DK-3.0.0-B0106" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Prior Births Section @moodCode must be EVN Source: 4.4.1 CONF:B0106.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0107-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.15']">
      <assert id="PRF-DK-3.0.0-B0107" test="count(v3:templateId[@root='1.2.208.184.19.2.15']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.15 Source: 4.4.1 CONF:B0107/B0108/B0109.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0107-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.15']/v3:templateId[@root='1.2.208.184.19.2.15']">
      <assert id="PRF-DK-3.0.0-B0107-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.15 must use 2024-04-19 Source: 4.4.1 CONF:B0107/B0108/B0109.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0110-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.15']">
      <assert id="PRF-DK-3.0.0-B0110" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Prior Births Section requires one code Source: 4.4.1 CONF:B0110.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0115-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.15']">
      <assert id="PRF-DK-3.0.0-B0115" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Prior Births Section requires one title Source: 4.4.1 CONF:B0115.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0116-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.15']">
      <assert id="PRF-DK-3.0.0-B0116" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Prior Births Section requires one text Source: 4.4.1 CONF:B0116.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0111-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.15']/v3:code">
      <assert id="PRF-DK-3.0.0-B0111" test="@code = '248983002'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Prior Births Section @code must be 248983002 Source: 4.4.1 CONF:B0111.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0112-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.15']/v3:code">
      <assert id="PRF-DK-3.0.0-B0112" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Prior Births Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.4.1 CONF:B0112.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0114-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.15']/v3:code">
      <assert id="PRF-DK-3.0.0-B0114" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.4.1 CONF:B0114.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-32-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-32" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.32']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Prior Abortions Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0119-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.32']">
      <assert id="PRF-DK-3.0.0-B0119" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Prior Abortions Section @classCode must be DOCSECT Source: 4.5.1 CONF:B0119.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0120-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.32']">
      <assert id="PRF-DK-3.0.0-B0120" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Prior Abortions Section @moodCode must be EVN Source: 4.5.1 CONF:B0120.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0121-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.32']">
      <assert id="PRF-DK-3.0.0-B0121" test="count(v3:templateId[@root='1.2.208.184.19.2.32']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.32 Source: 4.5.1 CONF:B0121/B0122/B0123.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0121-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.32']/v3:templateId[@root='1.2.208.184.19.2.32']">
      <assert id="PRF-DK-3.0.0-B0121-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.32 must use 2024-04-19 Source: 4.5.1 CONF:B0121/B0122/B0123.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0124-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.32']">
      <assert id="PRF-DK-3.0.0-B0124" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Prior Abortions Section requires one code Source: 4.5.1 CONF:B0124.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0129-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.32']">
      <assert id="PRF-DK-3.0.0-B0129" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Prior Abortions Section requires one title Source: 4.5.1 CONF:B0129.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0130-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.32']">
      <assert id="PRF-DK-3.0.0-B0130" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Prior Abortions Section requires one text Source: 4.5.1 CONF:B0130.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0125-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.32']/v3:code">
      <assert id="PRF-DK-3.0.0-B0125" test="@code = '713651007'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Prior Abortions Section @code must be 713651007 Source: 4.5.1 CONF:B0125.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0126-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.32']/v3:code">
      <assert id="PRF-DK-3.0.0-B0126" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Prior Abortions Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.5.1 CONF:B0126.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0128-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.32']/v3:code">
      <assert id="PRF-DK-3.0.0-B0128" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.5.1 CONF:B0128.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-35-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-35" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.35']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Fertility Treatment Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0133-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.35']">
      <assert id="PRF-DK-3.0.0-B0133" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Fertility Treatment Section @classCode must be DOCSECT Source: 4.6.1 CONF:B0133.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0134-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.35']">
      <assert id="PRF-DK-3.0.0-B0134" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Fertility Treatment Section @moodCode must be EVN Source: 4.6.1 CONF:B0134.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0135-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.35']">
      <assert id="PRF-DK-3.0.0-B0135" test="count(v3:templateId[@root='1.2.208.184.19.2.35']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.35 Source: 4.6.1 CONF:B0135/B0136/B0137.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0135-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.35']/v3:templateId[@root='1.2.208.184.19.2.35']">
      <assert id="PRF-DK-3.0.0-B0135-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.35 must use 2024-04-19 Source: 4.6.1 CONF:B0135/B0136/B0137.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0138-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.35']">
      <assert id="PRF-DK-3.0.0-B0138" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Fertility Treatment Section requires one code Source: 4.6.1 CONF:B0138.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0143-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.35']">
      <assert id="PRF-DK-3.0.0-B0143" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Fertility Treatment Section requires one title Source: 4.6.1 CONF:B0143.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0144-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.35']">
      <assert id="PRF-DK-3.0.0-B0144" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Fertility Treatment Section requires one text Source: 4.6.1 CONF:B0144.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0139-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.35']/v3:code">
      <assert id="PRF-DK-3.0.0-B0139" test="@code = '55767001'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Fertility Treatment Section @code must be 55767001 Source: 4.6.1 CONF:B0139.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0140-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.35']/v3:code">
      <assert id="PRF-DK-3.0.0-B0140" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Fertility Treatment Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.6.1 CONF:B0140.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0142-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.35']/v3:code">
      <assert id="PRF-DK-3.0.0-B0142" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.6.1 CONF:B0142.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-39-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-39" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.39']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Family History Of Hereditary Disease Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0153-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.39']">
      <assert id="PRF-DK-3.0.0-B0153" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Family History Of Hereditary Disease Section @classCode must be DOCSECT Source: 4.7.1 CONF:B0153.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0154-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.39']">
      <assert id="PRF-DK-3.0.0-B0154" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Family History Of Hereditary Disease Section @moodCode must be EVN Source: 4.7.1 CONF:B0154.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0155-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.39']">
      <assert id="PRF-DK-3.0.0-B0155" test="count(v3:templateId[@root='1.2.208.184.19.2.39']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.39 Source: 4.7.1 CONF:B0155/B0156/B0157.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0155-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.39']/v3:templateId[@root='1.2.208.184.19.2.39']">
      <assert id="PRF-DK-3.0.0-B0155-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.39 must use 2024-04-19 Source: 4.7.1 CONF:B0155/B0156/B0157.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0158-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.39']">
      <assert id="PRF-DK-3.0.0-B0158" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Family History Of Hereditary Disease Section requires one code Source: 4.7.1 CONF:B0158.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0163-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.39']">
      <assert id="PRF-DK-3.0.0-B0163" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Family History Of Hereditary Disease Section requires one title Source: 4.7.1 CONF:B0163.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0164-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.39']">
      <assert id="PRF-DK-3.0.0-B0164" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Family History Of Hereditary Disease Section requires one text Source: 4.7.1 CONF:B0164.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0159-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.39']/v3:code">
      <assert id="PRF-DK-3.0.0-B0159" test="@code = '416471007'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Family History Of Hereditary Disease Section @code must be 416471007 Source: 4.7.1 CONF:B0159.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0160-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.39']/v3:code">
      <assert id="PRF-DK-3.0.0-B0160" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Family History Of Hereditary Disease Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.7.1 CONF:B0160.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0162-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.39']/v3:code">
      <assert id="PRF-DK-3.0.0-B0162" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.7.1 CONF:B0162.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-50-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-50" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.50']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Antenatal Ultrasound Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0179-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.50']">
      <assert id="PRF-DK-3.0.0-B0179" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Ultrasound Section @classCode must be DOCSECT Source: 4.8.1 CONF:B0179.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0180-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.50']">
      <assert id="PRF-DK-3.0.0-B0180" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Ultrasound Section @moodCode must be EVN Source: 4.8.1 CONF:B0180.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0181-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.50']">
      <assert id="PRF-DK-3.0.0-B0181" test="count(v3:templateId[@root='1.2.208.184.19.2.50']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.50 Source: 4.8.1 CONF:B0181/B0182/B0183.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0181-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.50']/v3:templateId[@root='1.2.208.184.19.2.50']">
      <assert id="PRF-DK-3.0.0-B0181-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.50 must use 2024-04-19 Source: 4.8.1 CONF:B0181/B0182/B0183.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0184-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.50']">
      <assert id="PRF-DK-3.0.0-B0184" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Ultrasound Section requires one code Source: 4.8.1 CONF:B0184.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0189-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.50']">
      <assert id="PRF-DK-3.0.0-B0189" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Ultrasound Section requires one title Source: 4.8.1 CONF:B0189.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0190-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.50']">
      <assert id="PRF-DK-3.0.0-B0190" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Ultrasound Section requires one text Source: 4.8.1 CONF:B0190.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0185-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.50']/v3:code">
      <assert id="PRF-DK-3.0.0-B0185" test="@code = '304602002'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Ultrasound Section @code must be 304602002 Source: 4.8.1 CONF:B0185.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0186-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.50']/v3:code">
      <assert id="PRF-DK-3.0.0-B0186" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Ultrasound Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.8.1 CONF:B0186.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0188-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.50']/v3:code">
      <assert id="PRF-DK-3.0.0-B0188" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.8.1 CONF:B0188.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-53-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-53" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.53']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Antenatal Risk Assessment Wanted Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0195-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.53']">
      <assert id="PRF-DK-3.0.0-B0195" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Risk Assessment Wanted Section @classCode must be DOCSECT Source: 4.9.1 CONF:B0195.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0196-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.53']">
      <assert id="PRF-DK-3.0.0-B0196" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Risk Assessment Wanted Section @moodCode must be EVN Source: 4.9.1 CONF:B0196.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0197-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.53']">
      <assert id="PRF-DK-3.0.0-B0197" test="count(v3:templateId[@root='1.2.208.184.19.2.53']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.53 Source: 4.9.1 CONF:B0197/B0198/B0199.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0197-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.53']/v3:templateId[@root='1.2.208.184.19.2.53']">
      <assert id="PRF-DK-3.0.0-B0197-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.53 must use 2024-04-19 Source: 4.9.1 CONF:B0197/B0198/B0199.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0200-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.53']">
      <assert id="PRF-DK-3.0.0-B0200" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Risk Assessment Wanted Section requires one code Source: 4.9.1 CONF:B0200.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0205-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.53']">
      <assert id="PRF-DK-3.0.0-B0205" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Risk Assessment Wanted Section requires one title Source: 4.9.1 CONF:B0205.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0206-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.53']">
      <assert id="PRF-DK-3.0.0-B0206" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Risk Assessment Wanted Section requires one text Source: 4.9.1 CONF:B0206.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0201-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.53']/v3:code">
      <assert id="PRF-DK-3.0.0-B0201" test="@code = '568011000005108'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Risk Assessment Wanted Section @code must be 568011000005108 Source: 4.9.1 CONF:B0201.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0202-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.53']/v3:code">
      <assert id="PRF-DK-3.0.0-B0202" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Risk Assessment Wanted Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.9.1 CONF:B0202.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0204-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.53']/v3:code">
      <assert id="PRF-DK-3.0.0-B0204" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.9.1 CONF:B0204.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-55-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-55" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.55']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Consanguinity Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0209-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.55']">
      <assert id="PRF-DK-3.0.0-B0209" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Consanguinity Section @classCode must be DOCSECT Source: 4.10.1 CONF:B0209.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0210-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.55']">
      <assert id="PRF-DK-3.0.0-B0210" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Consanguinity Section @moodCode must be EVN Source: 4.10.1 CONF:B0210.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0211-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.55']">
      <assert id="PRF-DK-3.0.0-B0211" test="count(v3:templateId[@root='1.2.208.184.19.2.55']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.55 Source: 4.10.1 CONF:B0211/B0212/B0213.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0211-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.55']/v3:templateId[@root='1.2.208.184.19.2.55']">
      <assert id="PRF-DK-3.0.0-B0211-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.55 must use 2024-04-19 Source: 4.10.1 CONF:B0211/B0212/B0213.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0214-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.55']">
      <assert id="PRF-DK-3.0.0-B0214" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Consanguinity Section requires one code Source: 4.10.1 CONF:B0214.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0219-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.55']">
      <assert id="PRF-DK-3.0.0-B0219" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Consanguinity Section requires one title Source: 4.10.1 CONF:B0219.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0220-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.55']">
      <assert id="PRF-DK-3.0.0-B0220" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Consanguinity Section requires one text Source: 4.10.1 CONF:B0220.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0215-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.55']/v3:code">
      <assert id="PRF-DK-3.0.0-B0215" test="@code = '842009'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Consanguinity Section @code must be 842009 Source: 4.10.1 CONF:B0215.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0216-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.55']/v3:code">
      <assert id="PRF-DK-3.0.0-B0216" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Consanguinity Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.10.1 CONF:B0216.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0218-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.55']/v3:code">
      <assert id="PRF-DK-3.0.0-B0218" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.10.1 CONF:B0218.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-57-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-57" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.57']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Work-Enviroment Health Status Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0223-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.57']">
      <assert id="PRF-DK-3.0.0-B0223" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Work-Enviroment Health Status Section @classCode must be DOCSECT Source: 4.11.1 CONF:B0223.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0224-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.57']">
      <assert id="PRF-DK-3.0.0-B0224" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Work-Enviroment Health Status Section @moodCode must be EVN Source: 4.11.1 CONF:B0224.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0225-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.57']">
      <assert id="PRF-DK-3.0.0-B0225" test="count(v3:templateId[@root='1.2.208.184.19.2.57']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.57 Source: 4.11.1 CONF:B0225/B0226/B1545.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0225-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.57']/v3:templateId[@root='1.2.208.184.19.2.57']">
      <assert id="PRF-DK-3.0.0-B0225-DATE" test="@extension = '2025-06-30'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.57 must use 2025-06-30 Source: 4.11.1 CONF:B0225/B0226/B1545.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0228-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.57']">
      <assert id="PRF-DK-3.0.0-B0228" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Work-Enviroment Health Status Section requires one code Source: 4.11.1 CONF:B0228.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0233-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.57']">
      <assert id="PRF-DK-3.0.0-B0233" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Work-Enviroment Health Status Section requires one title Source: 4.11.1 CONF:B0233.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0234-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.57']">
      <assert id="PRF-DK-3.0.0-B0234" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Work-Enviroment Health Status Section requires one text Source: 4.11.1 CONF:B0234.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0229-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.57']/v3:code">
      <assert id="PRF-DK-3.0.0-B0229" test="@code = '598021000005104'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Work-Enviroment Health Status Section @code must be 598021000005104 Source: 4.11.1 CONF:B0229.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0230-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.57']/v3:code">
      <assert id="PRF-DK-3.0.0-B0230" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Work-Enviroment Health Status Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.11.1 CONF:B0230.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0232-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.57']/v3:code">
      <assert id="PRF-DK-3.0.0-B0232" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.11.1 CONF:B0232.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-64-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-64" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.64']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Employment Status Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0243-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.64']">
      <assert id="PRF-DK-3.0.0-B0243" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Employment Status Section @classCode must be DOCSECT Source: 4.12.1 CONF:B0243.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0244-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.64']">
      <assert id="PRF-DK-3.0.0-B0244" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Employment Status Section @moodCode must be EVN Source: 4.12.1 CONF:B0244.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0245-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.64']">
      <assert id="PRF-DK-3.0.0-B0245" test="count(v3:templateId[@root='1.2.208.184.19.2.64']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.64 Source: 4.12.1 CONF:B0245/B0246/B0247.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0245-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.64']/v3:templateId[@root='1.2.208.184.19.2.64']">
      <assert id="PRF-DK-3.0.0-B0245-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.64 must use 2024-04-19 Source: 4.12.1 CONF:B0245/B0246/B0247.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0248-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.64']">
      <assert id="PRF-DK-3.0.0-B0248" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Employment Status Section requires one code Source: 4.12.1 CONF:B0248.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0253-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.64']">
      <assert id="PRF-DK-3.0.0-B0253" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Employment Status Section requires one title Source: 4.12.1 CONF:B0253.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0254-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.64']">
      <assert id="PRF-DK-3.0.0-B0254" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Employment Status Section requires one text Source: 4.12.1 CONF:B0254.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0249-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.64']/v3:code">
      <assert id="PRF-DK-3.0.0-B0249" test="@code = '224362002'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Employment Status Section @code must be 224362002 Source: 4.12.1 CONF:B0249.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0250-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.64']/v3:code">
      <assert id="PRF-DK-3.0.0-B0250" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Employment Status Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.12.1 CONF:B0250.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0252-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.64']/v3:code">
      <assert id="PRF-DK-3.0.0-B0252" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.12.1 CONF:B0252.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-67-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-67" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.67']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Fetal Allergy Status Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0261-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.67']">
      <assert id="PRF-DK-3.0.0-B0261" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Fetal Allergy Status Section @classCode must be DOCSECT Source: 4.13.1 CONF:B0261.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0262-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.67']">
      <assert id="PRF-DK-3.0.0-B0262" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Fetal Allergy Status Section @moodCode must be EVN Source: 4.13.1 CONF:B0262.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0263-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.67']">
      <assert id="PRF-DK-3.0.0-B0263" test="count(v3:templateId[@root='1.2.208.184.19.2.67']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.67 Source: 4.13.1 CONF:B0263/B0264/B0265.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0263-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.67']/v3:templateId[@root='1.2.208.184.19.2.67']">
      <assert id="PRF-DK-3.0.0-B0263-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.67 must use 2024-04-19 Source: 4.13.1 CONF:B0263/B0264/B0265.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0266-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.67']">
      <assert id="PRF-DK-3.0.0-B0266" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Fetal Allergy Status Section requires one code Source: 4.13.1 CONF:B0266.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0271-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.67']">
      <assert id="PRF-DK-3.0.0-B0271" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Fetal Allergy Status Section requires one title Source: 4.13.1 CONF:B0271.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0272-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.67']">
      <assert id="PRF-DK-3.0.0-B0272" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Fetal Allergy Status Section requires one text Source: 4.13.1 CONF:B0272.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0267-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.67']/v3:code">
      <assert id="PRF-DK-3.0.0-B0267" test="@code=('2903021000005101','1300212001')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">The ambiguous allergy template 1.2.208.184.19.2.67 must use one of its two published codes. Source: 4.13.1 CONF:B0267 and conflicting 4.14.1 CONF:B0281. Maternal and fetal allergy cannot be distinguished by this copied root alone.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0268-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.67']/v3:code">
      <assert id="PRF-DK-3.0.0-B0268" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Fetal Allergy Status Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.13.1 CONF:B0268.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0270-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.67']/v3:code">
      <assert id="PRF-DK-3.0.0-B0270" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.13.1 CONF:B0270.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-71-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-71" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.71']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Antenatal Screening Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0289-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.71']">
      <assert id="PRF-DK-3.0.0-B0289" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Screening Section @classCode must be DOCSECT Source: 4.15.1 CONF:B0289.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0290-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.71']">
      <assert id="PRF-DK-3.0.0-B0290" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Screening Section @moodCode must be EVN Source: 4.15.1 CONF:B0290.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0291-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.71']">
      <assert id="PRF-DK-3.0.0-B0291" test="count(v3:templateId[@root='1.2.208.184.19.2.71']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.71 Source: 4.15.1 CONF:B0291/B0292/B0293.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0291-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.71']/v3:templateId[@root='1.2.208.184.19.2.71']">
      <assert id="PRF-DK-3.0.0-B0291-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.71 must use 2024-04-19 Source: 4.15.1 CONF:B0291/B0292/B0293.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0294-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.71']">
      <assert id="PRF-DK-3.0.0-B0294" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Screening Section requires one code Source: 4.15.1 CONF:B0294.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0299-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.71']">
      <assert id="PRF-DK-3.0.0-B0299" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Screening Section requires one title Source: 4.15.1 CONF:B0299.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0300-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.71']">
      <assert id="PRF-DK-3.0.0-B0300" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Screening Section requires one text Source: 4.15.1 CONF:B0300.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0295-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.71']/v3:code">
      <assert id="PRF-DK-3.0.0-B0295" test="@code = '313199003'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Screening Section @code must be 313199003 Source: 4.15.1 CONF:B0295.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0296-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.71']/v3:code">
      <assert id="PRF-DK-3.0.0-B0296" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Antenatal Screening Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.15.1 CONF:B0296.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0298-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.71']/v3:code">
      <assert id="PRF-DK-3.0.0-B0298" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.15.1 CONF:B0298.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-76-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-76" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.76']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Past History Of Procedure Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0303-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.76']">
      <assert id="PRF-DK-3.0.0-B0303" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Past History Of Procedure Section @classCode must be DOCSECT Source: 4.16.1 CONF:B0303.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0304-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.76']">
      <assert id="PRF-DK-3.0.0-B0304" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Past History Of Procedure Section @moodCode must be EVN Source: 4.16.1 CONF:B0304.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0305-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.76']">
      <assert id="PRF-DK-3.0.0-B0305" test="count(v3:templateId[@root='1.2.208.184.19.2.76']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.76 Source: 4.16.1 CONF:B0305/B0306/B0307.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0305-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.76']/v3:templateId[@root='1.2.208.184.19.2.76']">
      <assert id="PRF-DK-3.0.0-B0305-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.76 must use 2024-04-19 Source: 4.16.1 CONF:B0305/B0306/B0307.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0308-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.76']">
      <assert id="PRF-DK-3.0.0-B0308" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Past History Of Procedure Section requires one code Source: 4.16.1 CONF:B0308.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0313-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.76']">
      <assert id="PRF-DK-3.0.0-B0313" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Past History Of Procedure Section requires one title Source: 4.16.1 CONF:B0313.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0314-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.76']">
      <assert id="PRF-DK-3.0.0-B0314" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Past History Of Procedure Section requires one text Source: 4.16.1 CONF:B0314.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0309-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.76']/v3:code">
      <assert id="PRF-DK-3.0.0-B0309" test="@code = '416940007'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Past History Of Procedure Section @code must be 416940007 Source: 4.16.1 CONF:B0309.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0310-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.76']/v3:code">
      <assert id="PRF-DK-3.0.0-B0310" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Past History Of Procedure Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.16.1 CONF:B0310.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0312-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.76']/v3:code">
      <assert id="PRF-DK-3.0.0-B0312" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.16.1 CONF:B0312.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-78-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-78" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.78']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one History Of Disorder Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0321-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.78']">
      <assert id="PRF-DK-3.0.0-B0321" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">History Of Disorder Section @classCode must be DOCSECT Source: 4.17.1 CONF:B0321.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0322-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.78']">
      <assert id="PRF-DK-3.0.0-B0322" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">History Of Disorder Section @moodCode must be EVN Source: 4.17.1 CONF:B0322.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0323-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.78']">
      <assert id="PRF-DK-3.0.0-B0323" test="count(v3:templateId[@root='1.2.208.184.19.2.78']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.78 Source: 4.17.1 CONF:B0323/B0324/B0325.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0323-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.78']/v3:templateId[@root='1.2.208.184.19.2.78']">
      <assert id="PRF-DK-3.0.0-B0323-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.78 must use 2024-04-19 Source: 4.17.1 CONF:B0323/B0324/B0325.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0326-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.78']">
      <assert id="PRF-DK-3.0.0-B0326" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">History Of Disorder Section requires one code Source: 4.17.1 CONF:B0326.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0331-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.78']">
      <assert id="PRF-DK-3.0.0-B0331" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">History Of Disorder Section requires one title Source: 4.17.1 CONF:B0331.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0332-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.78']">
      <assert id="PRF-DK-3.0.0-B0332" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">History Of Disorder Section requires one text Source: 4.17.1 CONF:B0332.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0327-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.78']/v3:code">
      <assert id="PRF-DK-3.0.0-B0327" test="@code = '312850006'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">History Of Disorder Section @code must be 312850006 Source: 4.17.1 CONF:B0327.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0328-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.78']/v3:code">
      <assert id="PRF-DK-3.0.0-B0328" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">History Of Disorder Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.17.1 CONF:B0328.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0330-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.78']/v3:code">
      <assert id="PRF-DK-3.0.0-B0330" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.17.1 CONF:B0330.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-80-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-80" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.80']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one History Of Psychiatric Disorder Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0339-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.80']">
      <assert id="PRF-DK-3.0.0-B0339" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">History Of Psychiatric Disorder Section @classCode must be DOCSECT Source: 4.18.1 CONF:B0339.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0340-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.80']">
      <assert id="PRF-DK-3.0.0-B0340" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">History Of Psychiatric Disorder Section @moodCode must be EVN Source: 4.18.1 CONF:B0340.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0341-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.80']">
      <assert id="PRF-DK-3.0.0-B0341" test="count(v3:templateId[@root='1.2.208.184.19.2.80']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.80 Source: 4.18.1 CONF:B0341/B0342/B0343.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0341-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.80']/v3:templateId[@root='1.2.208.184.19.2.80']">
      <assert id="PRF-DK-3.0.0-B0341-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.80 must use 2024-04-19 Source: 4.18.1 CONF:B0341/B0342/B0343.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0344-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.80']">
      <assert id="PRF-DK-3.0.0-B0344" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">History Of Psychiatric Disorder Section requires one code Source: 4.18.1 CONF:B0344.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0349-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.80']">
      <assert id="PRF-DK-3.0.0-B0349" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">History Of Psychiatric Disorder Section requires one title Source: 4.18.1 CONF:B0349.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0350-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.80']">
      <assert id="PRF-DK-3.0.0-B0350" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">History Of Psychiatric Disorder Section requires one text Source: 4.18.1 CONF:B0350.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0345-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.80']/v3:code">
      <assert id="PRF-DK-3.0.0-B0345" test="@code = '161464003'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">History Of Psychiatric Disorder Section @code must be 161464003 Source: 4.18.1 CONF:B0345.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0346-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.80']/v3:code">
      <assert id="PRF-DK-3.0.0-B0346" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">History Of Psychiatric Disorder Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.18.1 CONF:B0346.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0348-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.80']/v3:code">
      <assert id="PRF-DK-3.0.0-B0348" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.18.1 CONF:B0348.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-84-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-84" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.84']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Social Wellbeing Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0357-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.84']">
      <assert id="PRF-DK-3.0.0-B0357" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Social Wellbeing Section @classCode must be DOCSECT Source: 4.19.1 CONF:B0357.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0358-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.84']">
      <assert id="PRF-DK-3.0.0-B0358" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Social Wellbeing Section @moodCode must be EVN Source: 4.19.1 CONF:B0358.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0359-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.84']">
      <assert id="PRF-DK-3.0.0-B0359" test="count(v3:templateId[@root='1.2.208.184.19.2.84']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.84 Source: 4.19.1 CONF:B0359/B0360/B0361.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0359-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.84']/v3:templateId[@root='1.2.208.184.19.2.84']">
      <assert id="PRF-DK-3.0.0-B0359-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.84 must use 2024-04-19 Source: 4.19.1 CONF:B0359/B0360/B0361.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0362-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.84']">
      <assert id="PRF-DK-3.0.0-B0362" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Social Wellbeing Section requires one code Source: 4.19.1 CONF:B0362.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0367-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.84']">
      <assert id="PRF-DK-3.0.0-B0367" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Social Wellbeing Section requires one title Source: 4.19.1 CONF:B0367.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0368-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.84']">
      <assert id="PRF-DK-3.0.0-B0368" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Social Wellbeing Section requires one text Source: 4.19.1 CONF:B0368.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0363-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.84']/v3:code">
      <assert id="PRF-DK-3.0.0-B0363" test="@code = '699089001'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Social Wellbeing Section @code must be 699089001 Source: 4.19.1 CONF:B0363.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0364-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.84']/v3:code">
      <assert id="PRF-DK-3.0.0-B0364" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Social Wellbeing Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.19.1 CONF:B0364.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0366-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.84']/v3:code">
      <assert id="PRF-DK-3.0.0-B0366" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.19.1 CONF:B0366.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-87-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-87" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.87']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Medicine Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0373-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.87']">
      <assert id="PRF-DK-3.0.0-B0373" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Medicine Section @classCode must be DOCSECT Source: 4.20.1 CONF:B0373.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0374-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.87']">
      <assert id="PRF-DK-3.0.0-B0374" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Medicine Section @moodCode must be EVN Source: 4.20.1 CONF:B0374.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0375-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.87']">
      <assert id="PRF-DK-3.0.0-B0375" test="count(v3:templateId[@root='1.2.208.184.19.2.87']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.87 Source: 4.20.1 CONF:B0375/B0376/B0377.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0375-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.87']/v3:templateId[@root='1.2.208.184.19.2.87']">
      <assert id="PRF-DK-3.0.0-B0375-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.87 must use 2024-04-19 Source: 4.20.1 CONF:B0375/B0376/B0377.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0378-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.87']">
      <assert id="PRF-DK-3.0.0-B0378" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Medicine Section requires one code Source: 4.20.1 CONF:B0378.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0383-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.87']">
      <assert id="PRF-DK-3.0.0-B0383" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Medicine Section requires one title Source: 4.20.1 CONF:B0383.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0384-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.87']">
      <assert id="PRF-DK-3.0.0-B0384" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Medicine Section requires one text Source: 4.20.1 CONF:B0384.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0379-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.87']/v3:code">
      <assert id="PRF-DK-3.0.0-B0379" test="@code = '129019007'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Medicine Section @code must be 129019007 Source: 4.20.1 CONF:B0379.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0380-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.87']/v3:code">
      <assert id="PRF-DK-3.0.0-B0380" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Medicine Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.20.1 CONF:B0380.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0382-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.87']/v3:code">
      <assert id="PRF-DK-3.0.0-B0382" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.20.1 CONF:B0382.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-SECTION-MAX-88-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PRF-DK-3.0.0-SECTION-MAX-88" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.88']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">At most one Vaccine Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0387-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.88']">
      <assert id="PRF-DK-3.0.0-B0387" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Vaccine Section @classCode must be DOCSECT Source: 4.21.1 CONF:B0387.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0388-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.88']">
      <assert id="PRF-DK-3.0.0-B0388" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Vaccine Section @moodCode must be EVN Source: 4.21.1 CONF:B0388.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0389-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.88']">
      <assert id="PRF-DK-3.0.0-B0389" test="count(v3:templateId[@root='1.2.208.184.19.2.88']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Require one declaration of template 1.2.208.184.19.2.88 Source: 4.21.1 CONF:B0389/B0390/B0391.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0389-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.88']/v3:templateId[@root='1.2.208.184.19.2.88']">
      <assert id="PRF-DK-3.0.0-B0389-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Template 1.2.208.184.19.2.88 must use 2024-04-19 Source: 4.21.1 CONF:B0389/B0390/B0391.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0392-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.88']">
      <assert id="PRF-DK-3.0.0-B0392" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Vaccine Section requires one code Source: 4.21.1 CONF:B0392.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0397-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.88']">
      <assert id="PRF-DK-3.0.0-B0397" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Vaccine Section requires one title Source: 4.21.1 CONF:B0397.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0398-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.88']">
      <assert id="PRF-DK-3.0.0-B0398" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Vaccine Section requires one text Source: 4.21.1 CONF:B0398.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0393-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.88']/v3:code">
      <assert id="PRF-DK-3.0.0-B0393" test="@code = '429684009'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Vaccine Section @code must be 429684009 Source: 4.21.1 CONF:B0393.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0394-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.88']/v3:code">
      <assert id="PRF-DK-3.0.0-B0394" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">Vaccine Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.21.1 CONF:B0394.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-B0396-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.19.2.88']/v3:code">
      <assert id="PRF-DK-3.0.0-B0396" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf">@displayName must be present and non-empty Source: 4.21.1 CONF:B0396.</assert>
    </rule>
  </pattern>
  <pattern id="PRF-DK-3.0.0-NULL-FLAVOR-pattern">
    <rule context="v3:ClinicalDocument//v3:*[@nullFlavor] | v3:ClinicalDocument[@nullFlavor]">
      <assert id="PRF-DK-3.0.0-NULL-FLAVOR" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf" test="@nullFlavor=('NI','NA')">Only NI and NA nullFlavor codes are permitted by this profile. Source: 1.5.1, Table 1.</assert>
    </rule>
  </pattern>
</schema>