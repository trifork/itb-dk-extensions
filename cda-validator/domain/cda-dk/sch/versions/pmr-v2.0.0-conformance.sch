<?xml version='1.0' encoding='UTF-8'?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>PMR-DK-2.0.0 source-derived conformance checks</title>
  <ns prefix="v3" uri="urn:hl7-org:v3" />
  <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance" />
  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema" />
  <pattern id="PMR-DK-2.0.0-HEADER-TEMPLATE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-HEADER-TEMPLATE" test="count(v3:templateId[@root='1.2.208.184.21.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one declaration of template 1.2.208.184.21.1 Source: 2.1 CONF:H0001/H0003; 3.1 CONF:B0002/B0003.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-HEADER-ID-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-HEADER-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document requires one id Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-HEADER-CODE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-HEADER-CODE" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document requires one code Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-HEADER-TITLE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-HEADER-TITLE" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document requires one title Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-HEADER-EFFECTIVETIME-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-HEADER-EFFECTIVETIME" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document requires one effectiveTime Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-HEADER-AUTHOR-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-HEADER-AUTHOR" test="count(v3:author) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document requires one author Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-HEADER-CUSTODIAN-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-HEADER-CUSTODIAN" test="count(v3:custodian) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document requires one custodian Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-DOCUMENT-CODE-code-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PMR-DK-2.0.0-DOCUMENT-CODE-code" test="@code = 'PMR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document code @code must be PMR Source: 2.1 document code constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-DOCUMENT-CODE-codeSystem-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PMR-DK-2.0.0-DOCUMENT-CODE-codeSystem" test="@codeSystem = '1.2.208.184.100.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document code @codeSystem must be 1.2.208.184.100.1 Source: 2.1 document code constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-DOCUMENT-CODE-codeSystemName-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PMR-DK-2.0.0-DOCUMENT-CODE-codeSystemName" test="@codeSystemName = 'MedCom Message Codes'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document code @codeSystemName must be MedCom Message Codes Source: 2.1 document code constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-DOCUMENT-CODE-displayName-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PMR-DK-2.0.0-DOCUMENT-CODE-displayName" test="@displayName = 'Pregnancy Measurement Report'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document code @displayName must be Pregnancy Measurement Report Source: 2.1 document code constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-DOCUMENT-ID-root-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PMR-DK-2.0.0-DOCUMENT-ID-root" test="normalize-space(@root) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">@root must be present and non-empty Source: 2.1 document identifier constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-DOCUMENT-ID-assigningAuthorityName-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PMR-DK-2.0.0-DOCUMENT-ID-assigningAuthorityName" test="normalize-space(@assigningAuthorityName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">@assigningAuthorityName must be present and non-empty Source: 2.1 document identifier constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-DOCUMENT-ID-extension-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PMR-DK-2.0.0-DOCUMENT-ID-extension" test="normalize-space(@extension) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">@extension must be present and non-empty Source: 2.1 document identifier constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-DOCUMENT-UUID-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PMR-DK-2.0.0-DOCUMENT-UUID" test="matches(@extension, '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document identifier extension must be a UUID version 4 Source: 2.1 globally unique document identifier.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-DOCUMENT-OID-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PMR-DK-2.0.0-DOCUMENT-OID" test="matches(@root, '^[0-2](\.[0-9]+)+$')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document identifier root must be an OID Source: 2.1 sending organisation OID.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-TITLE-CPR-pattern">
    <rule context="v3:ClinicalDocument/v3:title">
      <assert id="PMR-DK-2.0.0-TITLE-CPR" test="normalize-space(.) = concat('Pregnancy Measurement Report for ', /v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:id[@root='1.2.208.176.1.2']/@extension)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document title must contain the specified heading and patient CPR Source: 2.1 title constraint.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-PROVIDER-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole">
      <assert id="PMR-DK-2.0.0-PROVIDER" test="count(v3:providerOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Patient role requires one provider organisation Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-AUTHOR-TIME-pattern">
    <rule context="v3:ClinicalDocument/v3:author">
      <assert id="PMR-DK-2.0.0-AUTHOR-TIME" test="count(v3:time) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one time Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-ASSIGNED-AUTHOR-pattern">
    <rule context="v3:ClinicalDocument/v3:author">
      <assert id="PMR-DK-2.0.0-ASSIGNED-AUTHOR" test="count(v3:assignedAuthor) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one assignedAuthor Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-AUTHOR-PERSON-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <assert id="PMR-DK-2.0.0-AUTHOR-PERSON" test="count(v3:assignedPerson) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one assignedPerson Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-AUTHOR-PERSON-NAME-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:assignedPerson">
      <assert id="PMR-DK-2.0.0-AUTHOR-PERSON-NAME" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one name Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-AUTHOR-ORG-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <assert id="PMR-DK-2.0.0-AUTHOR-ORG" test="count(v3:representedOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one representedOrganization Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-AUTHOR-ORG-NAME-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:representedOrganization">
      <assert id="PMR-DK-2.0.0-AUTHOR-ORG-NAME" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one name Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-ASSIGNED-CUSTODIAN-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian">
      <assert id="PMR-DK-2.0.0-ASSIGNED-CUSTODIAN" test="count(v3:assignedCustodian) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one assignedCustodian Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-CUSTODIAN-ORG-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian">
      <assert id="PMR-DK-2.0.0-CUSTODIAN-ORG" test="count(v3:representedCustodianOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one representedCustodianOrganization Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-AUTHOR-TIME-VALUE-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:time">
      <assert id="PMR-DK-2.0.0-AUTHOR-TIME-VALUE" test="normalize-space(@value) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">@value must be present and non-empty Source: 2.1.2 author participation time.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-PROVIDER-ID-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization">
      <assert id="PMR-DK-2.0.0-PROVIDER-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Provider needs one identifier Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-PROVIDER-AUTHORITY-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization/v3:id">
      <assert id="PMR-DK-2.0.0-PROVIDER-AUTHORITY" test="@assigningAuthorityName = 'SOR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Provider identifier authority must be SOR Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-PROVIDER-ROOT-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization/v3:id">
      <assert id="PMR-DK-2.0.0-PROVIDER-ROOT" test="@root = '1.2.208.176.1.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Provider identifier root must be SOR Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-PROVIDER-EXTENSION-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization/v3:id">
      <assert id="PMR-DK-2.0.0-PROVIDER-EXTENSION" test="normalize-space(@extension) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">@extension must be present and non-empty Source: 2.1.1 SOR identifier (registry membership requires external verification).</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-PROVIDER-NAME-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization">
      <assert id="PMR-DK-2.0.0-PROVIDER-NAME" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Provider needs one name Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-AUTHOR-ID-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <assert id="PMR-DK-2.0.0-AUTHOR-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Author needs one identifier Source: 2.1.2.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-AUTHOR-AUTHORITY-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:id">
      <assert id="PMR-DK-2.0.0-AUTHOR-AUTHORITY" test="@assigningAuthorityName = 'SOR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Author identifier authority must be SOR Source: 2.1.2.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-AUTHOR-ROOT-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:id">
      <assert id="PMR-DK-2.0.0-AUTHOR-ROOT" test="@root = '1.2.208.176.1.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Author identifier root must be SOR Source: 2.1.2.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-AUTHOR-EXTENSION-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:id">
      <assert id="PMR-DK-2.0.0-AUTHOR-EXTENSION" test="normalize-space(@extension) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">@extension must be present and non-empty Source: 2.1.2 SOR identifier (registry membership requires external verification).</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-CUSTODIAN-ID-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <assert id="PMR-DK-2.0.0-CUSTODIAN-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Custodian needs one identifier Source: 2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-CUSTODIAN-AUTHORITY-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization/v3:id">
      <assert id="PMR-DK-2.0.0-CUSTODIAN-AUTHORITY" test="@assigningAuthorityName = 'SOR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Custodian identifier authority must be SOR Source: 2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-CUSTODIAN-ROOT-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization/v3:id">
      <assert id="PMR-DK-2.0.0-CUSTODIAN-ROOT" test="@root = '1.2.208.176.1.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Custodian identifier root must be SOR Source: 2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-CUSTODIAN-EXTENSION-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization/v3:id">
      <assert id="PMR-DK-2.0.0-CUSTODIAN-EXTENSION" test="normalize-space(@extension) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">@extension must be present and non-empty Source: 2.1.5 SOR identifier (registry membership requires external verification).</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-CUSTODIAN-NAME-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <assert id="PMR-DK-2.0.0-CUSTODIAN-NAME" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Custodian needs one name Source: 2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-PROVIDER-NO-addr-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization">
      <assert id="PMR-DK-2.0.0-PROVIDER-NO-addr" test="empty(v3:addr)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Provider organisation must not contain addr Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-PROVIDER-NO-telecom-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization">
      <assert id="PMR-DK-2.0.0-PROVIDER-NO-telecom" test="empty(v3:telecom)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Provider organisation must not contain telecom Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-NO-dataEnterer-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-NO-dataEnterer" test="empty(v3:dataEnterer)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Header must not contain dataEnterer Source: 2.1.3.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-NO-informant-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-NO-informant" test="empty(v3:informant)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Header must not contain informant Source: 2.1.4.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-NO-informationRecipient-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-NO-informationRecipient" test="empty(v3:informationRecipient)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Header must not contain informationRecipient Source: 2.1.6.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-NO-legalAuthenticator-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-NO-legalAuthenticator" test="empty(v3:legalAuthenticator)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Header must not contain legalAuthenticator Source: 2.1.7.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-NO-authenticator-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-NO-authenticator" test="empty(v3:authenticator)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Header must not contain authenticator Source: 2.1.8.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-NO-inFulfillmentOf-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-NO-inFulfillmentOf" test="empty(v3:inFulfillmentOf)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Header must not contain inFulfillmentOf Source: 2.1.10.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-DOCUMENTATION-COUNT-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-DOCUMENTATION-COUNT" test="count(v3:documentationOf) &gt;= 2 and count(v3:documentationOf) &lt;= 3" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document requires two or three documentationOf elements Source: 2.1.9.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-VERSION-EVENT-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-VERSION-EVENT" test="count(v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one profile version event Source: 2.1.9.1.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-VERSION-ID-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']">
      <assert id="PMR-DK-2.0.0-VERSION-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Version event requires one id Source: 2.1.9.1.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-VERSION-root-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="PMR-DK-2.0.0-VERSION-root" test="@root = '1.2.208.184.100.10'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Profile version @root must be 1.2.208.184.100.10 Source: 2.1.9.1.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-VERSION-extension-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="PMR-DK-2.0.0-VERSION-extension" test="@extension = 'PMR-v2.0'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Profile version @extension must be PMR-v2.0 Source: 2.1.9.1.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-VERSION-assigningAuthorityName-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="PMR-DK-2.0.0-VERSION-assigningAuthorityName" test="@assigningAuthorityName = 'MedCom'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Profile version @assigningAuthorityName must be MedCom Source: 2.1.9.1.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-TIME-EVENT-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-TIME-EVENT" test="count(v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one clinical content time event Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-TIME-INTERVAL-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']">
      <assert id="PMR-DK-2.0.0-TIME-INTERVAL" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Time event requires one effectiveTime Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-TIME-low-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime">
      <assert id="PMR-DK-2.0.0-TIME-low" test="count(v3:low) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Time interval requires one low Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-TIME-high-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime">
      <assert id="PMR-DK-2.0.0-TIME-high" test="count(v3:high) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Time interval requires one high Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-TIME-START-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:low">
      <assert id="PMR-DK-2.0.0-TIME-START" test="normalize-space(@value) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">@value must be present and non-empty Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-TIME-END-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:high">
      <assert id="PMR-DK-2.0.0-TIME-END" test="@value or @nullFlavor='NA'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Clinical content end needs a value or nullFlavor NA Source: 2.1.9.2 CONF:H0065/H0066.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-EPISODE-CARDINALITY-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-EPISODE-CARDINALITY" test="count(v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">At most one episode event may be supplied Source: 2.1.9.3.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-EPISODE-ID-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']">
      <assert id="PMR-DK-2.0.0-EPISODE-ID" test="exists(v3:id)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">A supplied episode event needs at least one identifier Source: 2.1.9.3.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-EPISODE-UUID-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']/v3:id">
      <assert id="PMR-DK-2.0.0-EPISODE-UUID" test="matches(@extension, '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Episode identifier extension must be a UUID Source: 2.1.9.3.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-EPISODE-root-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']/v3:id">
      <assert id="PMR-DK-2.0.0-EPISODE-root" test="normalize-space(@root) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">@root must be present and non-empty Source: 2.1.9.3.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-EPISODE-assigningAuthorityName-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']/v3:id">
      <assert id="PMR-DK-2.0.0-EPISODE-assigningAuthorityName" test="normalize-space(@assigningAuthorityName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">@assigningAuthorityName must be present and non-empty Source: 2.1.9.3.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-PREGNANCY-AUTHORITY-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']/v3:id[@root='1.2.208.176.7.4.1']">
      <assert id="PMR-DK-2.0.0-PREGNANCY-AUTHORITY" test="@assigningAuthorityName = 'Sundhedsdatastyrelsen'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Pregnancy episode authority must be Sundhedsdatastyrelsen Source: 2.1.9.3 Pregnancy episode-of-care identifier.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0005-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PMR-DK-2.0.0-B0005" test="count(v3:component) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document requires one component Source: 3.1 CONF:B0005.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0006-pattern">
    <rule context="v3:ClinicalDocument/v3:component">
      <assert id="PMR-DK-2.0.0-B0006" test="count(v3:structuredBody) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Document requires one structuredBody Source: 3.1 CONF:B0006.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0008-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PMR-DK-2.0.0-B0008" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR requires one Results section Source: 3.1 CONF:B0007/B0008.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0009-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']">
      <assert id="PMR-DK-2.0.0-B0009" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Result Section @classCode must be DOCSECT Source: 4.1.1 CONF:B0009.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0010-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']">
      <assert id="PMR-DK-2.0.0-B0010" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Result Section @moodCode must be EVN Source: 4.1.1 CONF:B0010.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0011-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']">
      <assert id="PMR-DK-2.0.0-B0011" test="count(v3:templateId[@root='1.2.208.184.21.2.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one declaration of template 1.2.208.184.21.2.1 Source: 4.1.1 CONF:B0011/B0012/B0013.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0011-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:templateId[@root='1.2.208.184.21.2.1']">
      <assert id="PMR-DK-2.0.0-B0011-DATE" test="@extension = '2024-06-01'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Template 1.2.208.184.21.2.1 must use 2024-06-01 Source: 4.1.1 CONF:B0011/B0012/B0013.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0017-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']">
      <assert id="PMR-DK-2.0.0-B0017" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Result Section requires one code Source: 4.1.1 CONF:B0017.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0022-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']">
      <assert id="PMR-DK-2.0.0-B0022" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Result Section requires one title Source: 4.1.1 CONF:B0022.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0023-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']">
      <assert id="PMR-DK-2.0.0-B0023" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Result Section requires one text Source: 4.1.1 CONF:B0023.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0018-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:code">
      <assert id="PMR-DK-2.0.0-B0018" test="@code = '30954-2'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Result Section @code must be 30954-2 Source: 4.1.1 CONF:B0018.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0019-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:code">
      <assert id="PMR-DK-2.0.0-B0019" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Result Section @codeSystem must be 2.16.840.1.113883.6.1 Source: 4.1.1 CONF:B0019.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0014-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']">
      <assert id="PMR-DK-2.0.0-B0014" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.22.2.3']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one declaration of template 2.16.840.1.113883.10.20.22.2.3 Source: 4.1.2 CONF:B0014–B0016.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0014-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:templateId[@root='2.16.840.1.113883.10.20.22.2.3']">
      <assert id="PMR-DK-2.0.0-B0014-DATE" test="@extension = '2015-08-01'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Template 2.16.840.1.113883.10.20.22.2.3 must use 2015-08-01 Source: 4.1.2 CONF:B0014–B0016.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0024-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']">
      <assert id="PMR-DK-2.0.0-B0024" test="count(v3:entry) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR results section requires exactly one entry Source: 4.1.2 CONF:B0024.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0025-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry">
      <assert id="PMR-DK-2.0.0-B0025" test="count(v3:organizer) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR results entry requires one organizer Source: 4.1.2 CONF:B0025.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0028-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer">
      <assert id="PMR-DK-2.0.0-B0028" test="count(v3:templateId[@root='1.2.208.184.21.2.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one declaration of template 1.2.208.184.21.2.2 Source: 5.6 CONF:B0028–B0030.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0028-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:templateId[@root='1.2.208.184.21.2.2']">
      <assert id="PMR-DK-2.0.0-B0028-DATE" test="@extension = '2025-01-15'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Template 1.2.208.184.21.2.2 must use 2025-01-15 Source: 5.6 CONF:B0028–B0030.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0031-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer">
      <assert id="PMR-DK-2.0.0-B0031" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.22.4.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one declaration of template 2.16.840.1.113883.10.20.22.4.1 Source: 5.6 CONF:B0031–B0033.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0031-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:templateId[@root='2.16.840.1.113883.10.20.22.4.1']">
      <assert id="PMR-DK-2.0.0-B0031-DATE" test="@extension = '2023-05-01'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Template 2.16.840.1.113883.10.20.22.4.1 must use 2023-05-01 Source: 5.6 CONF:B0031–B0033.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0026-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer">
      <assert id="PMR-DK-2.0.0-B0026" test="@classCode = 'CLUSTER'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Result organizer @classCode must be CLUSTER Source: 5.6 CONF:B0026.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0027-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer">
      <assert id="PMR-DK-2.0.0-B0027" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Result organizer @moodCode must be EVN Source: 5.6 CONF:B0027.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0034-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer">
      <assert id="PMR-DK-2.0.0-B0034" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR organizer requires one id Source: 5.6 CONF:B0034.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0038-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer">
      <assert id="PMR-DK-2.0.0-B0038" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR organizer requires one code Source: 5.6 CONF:B0038.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0040-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer">
      <assert id="PMR-DK-2.0.0-B0040" test="count(v3:statusCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR organizer requires one statusCode Source: 5.6 CONF:B0040.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0042-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer">
      <assert id="PMR-DK-2.0.0-B0042" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR organizer requires one effectiveTime Source: 5.6 CONF:B0042.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0039-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:code">
      <assert id="PMR-DK-2.0.0-B0039" test="@nullFlavor = 'NI'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR organizer code uses nullFlavor NI Source: 5.6 CONF:B0039.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0041-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:statusCode">
      <assert id="PMR-DK-2.0.0-B0041" test="@code = 'completed'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR organizer status must be completed Source: 5.6 CONF:B0041.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0271-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer">
      <assert id="PMR-DK-2.0.0-B0271" test="exists(v3:component)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR organizer requires at least one component Source: 5.6 CONF:B0271.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0046-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component">
      <assert id="PMR-DK-2.0.0-B0046" test="count(v3:observation) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR organizer component requires one observation Source: 5.6 CONF:B0046.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-3-TEMPLATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']">
      <assert id="PMR-DK-2.0.0-OBS-3-TEMPLATE" test="count(v3:templateId[@root='1.2.208.184.21.2.3']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one declaration of template 1.2.208.184.21.2.3 Source: 5.7 Danish observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-3-TEMPLATE-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']/v3:templateId[@root='1.2.208.184.21.2.3']">
      <assert id="PMR-DK-2.0.0-OBS-3-TEMPLATE-DATE" test="@extension = '2025-01-15'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Template 1.2.208.184.21.2.3 must use 2025-01-15 Source: 5.7 Danish observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-3-CCDA-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']">
      <assert id="PMR-DK-2.0.0-OBS-3-CCDA" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.22.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one declaration of template 2.16.840.1.113883.10.20.22.4.2 Source: 5.7 C-CDA observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-3-CCDA-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']/v3:templateId[@root='2.16.840.1.113883.10.20.22.4.2']">
      <assert id="PMR-DK-2.0.0-OBS-3-CCDA-DATE" test="@extension = '2023-05-01'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Template 2.16.840.1.113883.10.20.22.4.2 must use 2023-05-01 Source: 5.7 C-CDA observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-3-classCode-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']">
      <assert id="PMR-DK-2.0.0-OBS-3-classCode" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation @classCode must be OBS Source: 5.7 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-3-moodCode-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']">
      <assert id="PMR-DK-2.0.0-OBS-3-moodCode" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation @moodCode must be EVN Source: 5.7 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-3-id-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']">
      <assert id="PMR-DK-2.0.0-OBS-3-id" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one id Source: 5.7 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-3-code-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']">
      <assert id="PMR-DK-2.0.0-OBS-3-code" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one code Source: 5.7 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-3-statusCode-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']">
      <assert id="PMR-DK-2.0.0-OBS-3-statusCode" test="count(v3:statusCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one statusCode Source: 5.7 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-3-effectiveTime-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']">
      <assert id="PMR-DK-2.0.0-OBS-3-effectiveTime" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one effectiveTime Source: 5.7 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-3-value-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']">
      <assert id="PMR-DK-2.0.0-OBS-3-value" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one value Source: 5.7 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-3-UUID-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']/v3:id">
      <assert id="PMR-DK-2.0.0-OBS-3-UUID" test="matches(@extension, '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation identifier must be a UUID version 4 Source: 5.7 identifier constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-3-STATUS-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']/v3:statusCode">
      <assert id="PMR-DK-2.0.0-OBS-3-STATUS" test="@code = 'completed'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation status must be completed Source: 5.7 statusCode constraint.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-3-SNOMED-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']/v3:code">
      <assert id="PMR-DK-2.0.0-OBS-3-SNOMED" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation code must use SNOMED CT Source: 5.7 code constraint.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0072-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']/v3:value">
      <assert id="PMR-DK-2.0.0-B0072" test="resolve-QName(@xsi:type, .) = QName('urn:hl7-org:v3', 'PQ')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR PQ observation value must use xsi:type PQ Source: 5.7 CONF:B0072.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-3-TIME-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']/v3:effectiveTime">
      <assert id="PMR-DK-2.0.0-OBS-3-TIME" test="@nullFlavor=('NI','NA') or (matches(@value, '^[0-9]{14}[-+][0-9]{4}$'))" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation time must include seconds and UTC offset, or use nullFlavor NI/NA when unknown or irrelevant. Source: 5.4; 5.7 CONF:B0257/B0261/B0263/B0268 as applicable.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0073-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']/v3:value">
      <assert id="PMR-DK-2.0.0-B0073" test="normalize-space(@unit) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">@unit must be present and non-empty Source: 5.7 CONF:B0073 (code/unit vocabulary not yet checked).</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0074-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.3']/v3:value">
      <assert id="PMR-DK-2.0.0-B0074" test="@value castable as xs:decimal" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Numeric result requires a decimal value Source: 5.7 CONF:B0074.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-5-TEMPLATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']">
      <assert id="PMR-DK-2.0.0-OBS-5-TEMPLATE" test="count(v3:templateId[@root='1.2.208.184.21.2.5']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one declaration of template 1.2.208.184.21.2.5 Source: 5.9 Danish observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-5-TEMPLATE-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']/v3:templateId[@root='1.2.208.184.21.2.5']">
      <assert id="PMR-DK-2.0.0-OBS-5-TEMPLATE-DATE" test="@extension = '2025-01-15'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Template 1.2.208.184.21.2.5 must use 2025-01-15 Source: 5.9 Danish observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-5-CCDA-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']">
      <assert id="PMR-DK-2.0.0-OBS-5-CCDA" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.22.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one declaration of template 2.16.840.1.113883.10.20.22.4.2 Source: 5.9 C-CDA observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-5-CCDA-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']/v3:templateId[@root='2.16.840.1.113883.10.20.22.4.2']">
      <assert id="PMR-DK-2.0.0-OBS-5-CCDA-DATE" test="@extension = '2023-05-01'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Template 2.16.840.1.113883.10.20.22.4.2 must use 2023-05-01 Source: 5.9 C-CDA observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-5-classCode-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']">
      <assert id="PMR-DK-2.0.0-OBS-5-classCode" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation @classCode must be OBS Source: 5.9 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-5-moodCode-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']">
      <assert id="PMR-DK-2.0.0-OBS-5-moodCode" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation @moodCode must be EVN Source: 5.9 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-5-id-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']">
      <assert id="PMR-DK-2.0.0-OBS-5-id" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one id Source: 5.9 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-5-code-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']">
      <assert id="PMR-DK-2.0.0-OBS-5-code" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one code Source: 5.9 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-5-statusCode-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']">
      <assert id="PMR-DK-2.0.0-OBS-5-statusCode" test="count(v3:statusCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one statusCode Source: 5.9 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-5-effectiveTime-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']">
      <assert id="PMR-DK-2.0.0-OBS-5-effectiveTime" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one effectiveTime Source: 5.9 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-5-value-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']">
      <assert id="PMR-DK-2.0.0-OBS-5-value" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one value Source: 5.9 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-5-UUID-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']/v3:id">
      <assert id="PMR-DK-2.0.0-OBS-5-UUID" test="matches(@extension, '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation identifier must be a UUID version 4 Source: 5.9 identifier constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-5-STATUS-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']/v3:statusCode">
      <assert id="PMR-DK-2.0.0-OBS-5-STATUS" test="@code = 'completed'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation status must be completed Source: 5.9 statusCode constraint.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-5-SNOMED-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']/v3:code">
      <assert id="PMR-DK-2.0.0-OBS-5-SNOMED" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation code must use SNOMED CT Source: 5.9 code constraint.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0138-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']/v3:value">
      <assert id="PMR-DK-2.0.0-B0138" test="resolve-QName(@xsi:type, .) = QName('urn:hl7-org:v3', 'CD')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR CD observation value must use xsi:type CD Source: 5.9 CONF:B0138.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-5-TIME-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.5']/v3:effectiveTime">
      <assert id="PMR-DK-2.0.0-OBS-5-TIME" test="@nullFlavor=('NI','NA') or (matches(@value, '^[0-9]{14}[-+][0-9]{4}$'))" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation time must include seconds and UTC offset, or use nullFlavor NI/NA when unknown or irrelevant. Source: 5.4; 5.9 CONF:B0257/B0261/B0263/B0268 as applicable.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-6-TEMPLATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']">
      <assert id="PMR-DK-2.0.0-OBS-6-TEMPLATE" test="count(v3:templateId[@root='1.2.208.184.21.2.6']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one declaration of template 1.2.208.184.21.2.6 Source: 5.10 Danish observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-6-TEMPLATE-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']/v3:templateId[@root='1.2.208.184.21.2.6']">
      <assert id="PMR-DK-2.0.0-OBS-6-TEMPLATE-DATE" test="@extension = '2025-01-15'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Template 1.2.208.184.21.2.6 must use 2025-01-15 Source: 5.10 Danish observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-6-CCDA-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']">
      <assert id="PMR-DK-2.0.0-OBS-6-CCDA" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.22.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one declaration of template 2.16.840.1.113883.10.20.22.4.2 Source: 5.10 C-CDA observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-6-CCDA-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']/v3:templateId[@root='2.16.840.1.113883.10.20.22.4.2']">
      <assert id="PMR-DK-2.0.0-OBS-6-CCDA-DATE" test="@extension = '2023-05-01'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Template 2.16.840.1.113883.10.20.22.4.2 must use 2023-05-01 Source: 5.10 C-CDA observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-6-classCode-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']">
      <assert id="PMR-DK-2.0.0-OBS-6-classCode" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation @classCode must be OBS Source: 5.10 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-6-moodCode-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']">
      <assert id="PMR-DK-2.0.0-OBS-6-moodCode" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation @moodCode must be EVN Source: 5.10 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-6-id-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']">
      <assert id="PMR-DK-2.0.0-OBS-6-id" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one id Source: 5.10 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-6-code-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']">
      <assert id="PMR-DK-2.0.0-OBS-6-code" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one code Source: 5.10 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-6-statusCode-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']">
      <assert id="PMR-DK-2.0.0-OBS-6-statusCode" test="count(v3:statusCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one statusCode Source: 5.10 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-6-effectiveTime-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']">
      <assert id="PMR-DK-2.0.0-OBS-6-effectiveTime" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one effectiveTime Source: 5.10 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-6-value-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']">
      <assert id="PMR-DK-2.0.0-OBS-6-value" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one value Source: 5.10 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-6-UUID-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']/v3:id">
      <assert id="PMR-DK-2.0.0-OBS-6-UUID" test="matches(@extension, '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation identifier must be a UUID version 4 Source: 5.10 identifier constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-6-STATUS-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']/v3:statusCode">
      <assert id="PMR-DK-2.0.0-OBS-6-STATUS" test="@code = 'completed'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation status must be completed Source: 5.10 statusCode constraint.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-6-SNOMED-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']/v3:code">
      <assert id="PMR-DK-2.0.0-OBS-6-SNOMED" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation code must use SNOMED CT Source: 5.10 code constraint.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0265-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']/v3:value">
      <assert id="PMR-DK-2.0.0-B0265" test="resolve-QName(@xsi:type, .) = QName('urn:hl7-org:v3', 'TS')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR TS observation value must use xsi:type TS Source: 5.10 CONF:B0265.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-6-TIME-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']/v3:effectiveTime">
      <assert id="PMR-DK-2.0.0-OBS-6-TIME" test="@nullFlavor=('NI','NA') or (matches(@value, '^[0-9]{14}[-+][0-9]{4}$'))" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation time must include seconds and UTC offset, or use nullFlavor NI/NA when unknown or irrelevant. Source: 5.4; 5.10 CONF:B0257/B0261/B0263/B0268 as applicable.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0266-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.6']/v3:value">
      <assert id="PMR-DK-2.0.0-B0266" test="matches(@value,'^[0-9]{8}$') and concat(substring(@value,1,4),'-',substring(@value,5,2),'-',substring(@value,7,2)) castable as xs:date" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Timestamp result must be a valid date in YYYYMMDD format Source: 5.10 CONF:B0266.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-7-TEMPLATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']">
      <assert id="PMR-DK-2.0.0-OBS-7-TEMPLATE" test="count(v3:templateId[@root='1.2.208.184.21.2.7']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one declaration of template 1.2.208.184.21.2.7 Source: 5.11 Danish observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-7-TEMPLATE-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']/v3:templateId[@root='1.2.208.184.21.2.7']">
      <assert id="PMR-DK-2.0.0-OBS-7-TEMPLATE-DATE" test="@extension = '2025-01-15'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Template 1.2.208.184.21.2.7 must use 2025-01-15 Source: 5.11 Danish observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-7-CCDA-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']">
      <assert id="PMR-DK-2.0.0-OBS-7-CCDA" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.22.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Require one declaration of template 2.16.840.1.113883.10.20.22.4.2 Source: 5.11 C-CDA observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-7-CCDA-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']/v3:templateId[@root='2.16.840.1.113883.10.20.22.4.2']">
      <assert id="PMR-DK-2.0.0-OBS-7-CCDA-DATE" test="@extension = '2023-05-01'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">Template 2.16.840.1.113883.10.20.22.4.2 must use 2023-05-01 Source: 5.11 C-CDA observation template.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-7-classCode-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']">
      <assert id="PMR-DK-2.0.0-OBS-7-classCode" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation @classCode must be OBS Source: 5.11 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-7-moodCode-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']">
      <assert id="PMR-DK-2.0.0-OBS-7-moodCode" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation @moodCode must be EVN Source: 5.11 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-7-id-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']">
      <assert id="PMR-DK-2.0.0-OBS-7-id" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one id Source: 5.11 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-7-code-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']">
      <assert id="PMR-DK-2.0.0-OBS-7-code" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one code Source: 5.11 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-7-statusCode-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']">
      <assert id="PMR-DK-2.0.0-OBS-7-statusCode" test="count(v3:statusCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one statusCode Source: 5.11 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-7-effectiveTime-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']">
      <assert id="PMR-DK-2.0.0-OBS-7-effectiveTime" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one effectiveTime Source: 5.11 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-7-value-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']">
      <assert id="PMR-DK-2.0.0-OBS-7-value" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation requires one value Source: 5.11 observation conformance statements.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-7-UUID-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']/v3:id">
      <assert id="PMR-DK-2.0.0-OBS-7-UUID" test="matches(@extension, '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation identifier must be a UUID version 4 Source: 5.11 identifier constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-7-STATUS-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']/v3:statusCode">
      <assert id="PMR-DK-2.0.0-OBS-7-STATUS" test="@code = 'completed'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation status must be completed Source: 5.11 statusCode constraint.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-7-SNOMED-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']/v3:code">
      <assert id="PMR-DK-2.0.0-OBS-7-SNOMED" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation code must use SNOMED CT Source: 5.11 code constraint.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-B0207-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']/v3:value">
      <assert id="PMR-DK-2.0.0-B0207" test="resolve-QName(@xsi:type, .) = QName('urn:hl7-org:v3', 'IVL_PQ')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR IVL_PQ observation value must use xsi:type IVL_PQ Source: 5.11 CONF:B0207.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-OBS-7-TIME-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']/v3:effectiveTime">
      <assert id="PMR-DK-2.0.0-OBS-7-TIME" test="@nullFlavor=('NI','NA') or (matches(@value, '^[0-9]{14}[-+][0-9]{4}$'))" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">PMR observation time must include seconds and UTC offset, or use nullFlavor NI/NA when unknown or irrelevant. Source: 5.4; 5.11 CONF:B0257/B0261/B0263/B0268 as applicable.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-INTERVAL-low-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']/v3:value/v3:low">
      <assert id="PMR-DK-2.0.0-INTERVAL-low" test="@value castable as xs:decimal and @inclusive=('true','false','1','0') and not(@nullFlavor)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">A supplied numeric interval boundary needs a decimal value, inclusive flag and no nullFlavor Source: 5.11 CONF:B0210–B0216.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-INTERVAL-high-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.21.2.1']/v3:entry/v3:organizer/v3:component/v3:observation[v3:templateId/@root='1.2.208.184.21.2.7']/v3:value/v3:high">
      <assert id="PMR-DK-2.0.0-INTERVAL-high" test="@value castable as xs:decimal and @inclusive=('true','false','1','0') and not(@nullFlavor)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf">A supplied numeric interval boundary needs a decimal value, inclusive flag and no nullFlavor Source: 5.11 CONF:B0210–B0216.</assert>
    </rule>
  </pattern>
  <pattern id="PMR-DK-2.0.0-NULL-FLAVOR-pattern">
    <rule context="v3:ClinicalDocument//v3:*[@nullFlavor] | v3:ClinicalDocument[@nullFlavor]">
      <assert id="PMR-DK-2.0.0-NULL-FLAVOR" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf" test="@nullFlavor=('NI','NA')">Only NI and NA nullFlavor codes are permitted by this profile. Source: 1.5.1, Table 1.</assert>
    </rule>
  </pattern>
</schema>