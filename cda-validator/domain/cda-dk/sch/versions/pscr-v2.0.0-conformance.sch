<?xml version='1.0' encoding='UTF-8'?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>PSCR-DK-2.0.0 source-derived conformance checks</title>
  <ns prefix="v3" uri="urn:hl7-org:v3" />
  <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance" />
  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema" />
  <pattern id="PSCR-DK-2.0.0-HEADER-TEMPLATE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-HEADER-TEMPLATE" test="count(v3:templateId[@root='1.2.208.184.20.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.1 Source: 2.1 CONF:H0001/H0003; 3.1 CONF:B0002/B0003.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-HEADER-ID-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-HEADER-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Document requires one id Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-HEADER-CODE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-HEADER-CODE" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Document requires one code Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-HEADER-TITLE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-HEADER-TITLE" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Document requires one title Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-HEADER-EFFECTIVETIME-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-HEADER-EFFECTIVETIME" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Document requires one effectiveTime Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-HEADER-AUTHOR-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-HEADER-AUTHOR" test="count(v3:author) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Document requires one author Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-HEADER-CUSTODIAN-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-HEADER-CUSTODIAN" test="count(v3:custodian) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Document requires one custodian Source: 2.1–2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-DOCUMENT-CODE-code-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PSCR-DK-2.0.0-DOCUMENT-CODE-code" test="@code = 'PSCR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Document code @code must be PSCR Source: 2.1 document code constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-DOCUMENT-CODE-codeSystem-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PSCR-DK-2.0.0-DOCUMENT-CODE-codeSystem" test="@codeSystem = '1.2.208.184.100.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Document code @codeSystem must be 1.2.208.184.100.1 Source: 2.1 document code constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-DOCUMENT-CODE-codeSystemName-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PSCR-DK-2.0.0-DOCUMENT-CODE-codeSystemName" test="@codeSystemName = 'MedCom Message Codes'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Document code @codeSystemName must be MedCom Message Codes Source: 2.1 document code constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-DOCUMENT-CODE-displayName-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PSCR-DK-2.0.0-DOCUMENT-CODE-displayName" test="@displayName = 'Pregnancy Shared Care Record'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Document code @displayName must be Pregnancy Shared Care Record Source: 2.1 document code constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-DOCUMENT-ID-root-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PSCR-DK-2.0.0-DOCUMENT-ID-root" test="normalize-space(@root) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@root must be present and non-empty Source: 2.1 document identifier constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-DOCUMENT-ID-assigningAuthorityName-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PSCR-DK-2.0.0-DOCUMENT-ID-assigningAuthorityName" test="normalize-space(@assigningAuthorityName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@assigningAuthorityName must be present and non-empty Source: 2.1 document identifier constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-DOCUMENT-ID-extension-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PSCR-DK-2.0.0-DOCUMENT-ID-extension" test="normalize-space(@extension) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@extension must be present and non-empty Source: 2.1 document identifier constraints.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-DOCUMENT-UUID-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PSCR-DK-2.0.0-DOCUMENT-UUID" test="matches(@extension, '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Document identifier extension must be a UUID version 4 Source: 2.1 globally unique document identifier.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-DOCUMENT-OID-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PSCR-DK-2.0.0-DOCUMENT-OID" test="matches(@root, '^[0-2](\.[0-9]+)+$')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Document identifier root must be an OID Source: 2.1 sending organisation OID.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-PROVIDER-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole">
      <assert id="PSCR-DK-2.0.0-PROVIDER" test="count(v3:providerOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Patient role requires one provider organisation Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-AUTHOR-TIME-pattern">
    <rule context="v3:ClinicalDocument/v3:author">
      <assert id="PSCR-DK-2.0.0-AUTHOR-TIME" test="count(v3:time) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one time Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-ASSIGNED-AUTHOR-pattern">
    <rule context="v3:ClinicalDocument/v3:author">
      <assert id="PSCR-DK-2.0.0-ASSIGNED-AUTHOR" test="count(v3:assignedAuthor) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one assignedAuthor Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-AUTHOR-PERSON-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <assert id="PSCR-DK-2.0.0-AUTHOR-PERSON" test="count(v3:assignedPerson) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one assignedPerson Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-AUTHOR-PERSON-NAME-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:assignedPerson">
      <assert id="PSCR-DK-2.0.0-AUTHOR-PERSON-NAME" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one name Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-AUTHOR-ORG-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <assert id="PSCR-DK-2.0.0-AUTHOR-ORG" test="count(v3:representedOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one representedOrganization Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-AUTHOR-ORG-NAME-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:representedOrganization">
      <assert id="PSCR-DK-2.0.0-AUTHOR-ORG-NAME" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one name Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-ASSIGNED-CUSTODIAN-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian">
      <assert id="PSCR-DK-2.0.0-ASSIGNED-CUSTODIAN" test="count(v3:assignedCustodian) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one assignedCustodian Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-CUSTODIAN-ORG-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian">
      <assert id="PSCR-DK-2.0.0-CUSTODIAN-ORG" test="count(v3:representedCustodianOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one representedCustodianOrganization Source: 2.1.2/2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-AUTHOR-TIME-VALUE-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:time">
      <assert id="PSCR-DK-2.0.0-AUTHOR-TIME-VALUE" test="normalize-space(@value) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@value must be present and non-empty Source: 2.1.2 author participation time.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-PROVIDER-ID-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization">
      <assert id="PSCR-DK-2.0.0-PROVIDER-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Provider needs one identifier Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-PROVIDER-AUTHORITY-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization/v3:id">
      <assert id="PSCR-DK-2.0.0-PROVIDER-AUTHORITY" test="@assigningAuthorityName = 'SOR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Provider identifier authority must be SOR Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-PROVIDER-ROOT-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization/v3:id">
      <assert id="PSCR-DK-2.0.0-PROVIDER-ROOT" test="@root = '1.2.208.176.1.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Provider identifier root must be SOR Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-PROVIDER-EXTENSION-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization/v3:id">
      <assert id="PSCR-DK-2.0.0-PROVIDER-EXTENSION" test="normalize-space(@extension) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@extension must be present and non-empty Source: 2.1.1 SOR identifier (registry membership requires external verification).</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-PROVIDER-NAME-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization">
      <assert id="PSCR-DK-2.0.0-PROVIDER-NAME" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Provider needs one name Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-AUTHOR-ID-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <assert id="PSCR-DK-2.0.0-AUTHOR-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Author needs one identifier Source: 2.1.2.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-AUTHOR-AUTHORITY-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:id">
      <assert id="PSCR-DK-2.0.0-AUTHOR-AUTHORITY" test="@assigningAuthorityName = 'SOR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Author identifier authority must be SOR Source: 2.1.2.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-AUTHOR-ROOT-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:id">
      <assert id="PSCR-DK-2.0.0-AUTHOR-ROOT" test="@root = '1.2.208.176.1.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Author identifier root must be SOR Source: 2.1.2.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-AUTHOR-EXTENSION-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:id">
      <assert id="PSCR-DK-2.0.0-AUTHOR-EXTENSION" test="normalize-space(@extension) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@extension must be present and non-empty Source: 2.1.2 SOR identifier (registry membership requires external verification).</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-CUSTODIAN-ID-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <assert id="PSCR-DK-2.0.0-CUSTODIAN-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Custodian needs one identifier Source: 2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-CUSTODIAN-AUTHORITY-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization/v3:id">
      <assert id="PSCR-DK-2.0.0-CUSTODIAN-AUTHORITY" test="@assigningAuthorityName = 'SOR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Custodian identifier authority must be SOR Source: 2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-CUSTODIAN-ROOT-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization/v3:id">
      <assert id="PSCR-DK-2.0.0-CUSTODIAN-ROOT" test="@root = '1.2.208.176.1.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Custodian identifier root must be SOR Source: 2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-CUSTODIAN-EXTENSION-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization/v3:id">
      <assert id="PSCR-DK-2.0.0-CUSTODIAN-EXTENSION" test="normalize-space(@extension) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@extension must be present and non-empty Source: 2.1.5 SOR identifier (registry membership requires external verification).</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-CUSTODIAN-NAME-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <assert id="PSCR-DK-2.0.0-CUSTODIAN-NAME" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Custodian needs one name Source: 2.1.5.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-PROVIDER-NO-addr-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization">
      <assert id="PSCR-DK-2.0.0-PROVIDER-NO-addr" test="empty(v3:addr)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Provider organisation must not contain addr Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-PROVIDER-NO-telecom-pattern">
    <rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:providerOrganization">
      <assert id="PSCR-DK-2.0.0-PROVIDER-NO-telecom" test="empty(v3:telecom)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Provider organisation must not contain telecom Source: 2.1.1.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-NO-dataEnterer-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-NO-dataEnterer" test="empty(v3:dataEnterer)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Header must not contain dataEnterer Source: 2.1.3.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-NO-informant-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-NO-informant" test="empty(v3:informant)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Header must not contain informant Source: 2.1.4.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-NO-informationRecipient-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-NO-informationRecipient" test="empty(v3:informationRecipient)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Header must not contain informationRecipient Source: 2.1.6.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-NO-legalAuthenticator-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-NO-legalAuthenticator" test="empty(v3:legalAuthenticator)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Header must not contain legalAuthenticator Source: 2.1.7.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-NO-authenticator-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-NO-authenticator" test="empty(v3:authenticator)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Header must not contain authenticator Source: 2.1.8.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-NO-inFulfillmentOf-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-NO-inFulfillmentOf" test="empty(v3:inFulfillmentOf)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Header must not contain inFulfillmentOf Source: 2.1.10.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-DOCUMENTATION-COUNT-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-DOCUMENTATION-COUNT" test="count(v3:documentationOf) &gt;= 2 and count(v3:documentationOf) &lt;= 3" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Document requires two or three documentationOf elements Source: 2.1.9.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-VERSION-EVENT-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-VERSION-EVENT" test="count(v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one profile version event Source: 2.1.9.1.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-VERSION-ID-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']">
      <assert id="PSCR-DK-2.0.0-VERSION-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Version event requires one id Source: 2.1.9.1.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-VERSION-root-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="PSCR-DK-2.0.0-VERSION-root" test="@root = '1.2.208.184.100.10'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Profile version @root must be 1.2.208.184.100.10 Source: 2.1.9.1.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-VERSION-extension-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="PSCR-DK-2.0.0-VERSION-extension" test="@extension = 'PSCR-v2.0'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Profile version @extension must be PSCR-v2.0 Source: 2.1.9.1.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-VERSION-assigningAuthorityName-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="PSCR-DK-2.0.0-VERSION-assigningAuthorityName" test="@assigningAuthorityName = 'MedCom'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Profile version @assigningAuthorityName must be MedCom Source: 2.1.9.1.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-TIME-EVENT-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-TIME-EVENT" test="count(v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one clinical content time event Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-TIME-INTERVAL-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']">
      <assert id="PSCR-DK-2.0.0-TIME-INTERVAL" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Time event requires one effectiveTime Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-TIME-low-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime">
      <assert id="PSCR-DK-2.0.0-TIME-low" test="count(v3:low) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Time interval requires one low Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-TIME-high-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime">
      <assert id="PSCR-DK-2.0.0-TIME-high" test="count(v3:high) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Time interval requires one high Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-TIME-START-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:low">
      <assert id="PSCR-DK-2.0.0-TIME-START" test="normalize-space(@value) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@value must be present and non-empty Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-TIME-END-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:high">
      <assert id="PSCR-DK-2.0.0-TIME-END" test="@nullFlavor = 'NA'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Clinical content end must use nullFlavor NA Source: 2.1.9.2.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-EPISODE-CARDINALITY-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-EPISODE-CARDINALITY" test="count(v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one episode event may be supplied Source: 2.1.9.3.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-EPISODE-ID-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']">
      <assert id="PSCR-DK-2.0.0-EPISODE-ID" test="exists(v3:id)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">A supplied episode event needs at least one identifier Source: 2.1.9.3.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-EPISODE-UUID-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']/v3:id">
      <assert id="PSCR-DK-2.0.0-EPISODE-UUID" test="matches(@extension, '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Episode identifier extension must be a UUID version 4 Source: 2.1.9.3.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-EPISODE-root-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']/v3:id">
      <assert id="PSCR-DK-2.0.0-EPISODE-root" test="normalize-space(@root) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@root must be present and non-empty Source: 2.1.9.3.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-EPISODE-assigningAuthorityName-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']/v3:id">
      <assert id="PSCR-DK-2.0.0-EPISODE-assigningAuthorityName" test="normalize-space(@assigningAuthorityName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@assigningAuthorityName must be present and non-empty Source: 2.1.9.3.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-PREGNANCY-AUTHORITY-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.12']/v3:id[@root='1.2.208.176.7.4.1']">
      <assert id="PSCR-DK-2.0.0-PREGNANCY-AUTHORITY" test="@assigningAuthorityName = 'Sundhedsdatastyrelsen'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Pregnancy episode authority must be Sundhedsdatastyrelsen Source: 2.1.9.3 Pregnancy episode-of-care identifier.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0005-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PSCR-DK-2.0.0-B0005" test="count(v3:component) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Document requires one component Source: 3.1 CONF:B0005.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0006-pattern">
    <rule context="v3:ClinicalDocument/v3:component">
      <assert id="PSCR-DK-2.0.0-B0006" test="count(v3:structuredBody) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Document requires one structuredBody Source: 3.1 CONF:B0006.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-1-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-1" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.1']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one Estimated Date of Delivery Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0039-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.1']">
      <assert id="PSCR-DK-2.0.0-B0039" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Estimated Date of Delivery Section @classCode must be DOCSECT Source: 4.1.1 CONF:B0039.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0040-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.1']">
      <assert id="PSCR-DK-2.0.0-B0040" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Estimated Date of Delivery Section @moodCode must be EVN Source: 4.1.1 CONF:B0040.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0041-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.1']">
      <assert id="PSCR-DK-2.0.0-B0041" test="count(v3:templateId[@root='1.2.208.184.20.2.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.1 Source: 4.1.1 CONF:B0041/B0042/B0043.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0041-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.1']/v3:templateId[@root='1.2.208.184.20.2.1']">
      <assert id="PSCR-DK-2.0.0-B0041-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.1 must use 2024-04-19 Source: 4.1.1 CONF:B0041/B0042/B0043.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0044-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.1']">
      <assert id="PSCR-DK-2.0.0-B0044" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Estimated Date of Delivery Section requires one code Source: 4.1.1 CONF:B0044.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0049-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.1']">
      <assert id="PSCR-DK-2.0.0-B0049" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Estimated Date of Delivery Section requires one title Source: 4.1.1 CONF:B0049.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0050-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.1']">
      <assert id="PSCR-DK-2.0.0-B0050" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Estimated Date of Delivery Section requires one text Source: 4.1.1 CONF:B0050.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0045-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.1']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0045" test="@code = '161714006'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Estimated Date of Delivery Section @code must be 161714006 Source: 4.1.1 CONF:B0045.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0046-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.1']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0046" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Estimated Date of Delivery Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.1.1 CONF:B0046.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0048-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.1']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0048" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.1.1 CONF:B0048.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-6-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-6" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.6']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one Education Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0061-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.6']">
      <assert id="PSCR-DK-2.0.0-B0061" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Education Section @classCode must be DOCSECT Source: 4.2.1 CONF:B0061.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0062-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.6']">
      <assert id="PSCR-DK-2.0.0-B0062" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Education Section @moodCode must be EVN Source: 4.2.1 CONF:B0062.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0063-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.6']">
      <assert id="PSCR-DK-2.0.0-B0063" test="count(v3:templateId[@root='1.2.208.184.20.2.6']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.6 Source: 4.2.1 CONF:B0063/B0064/B0065.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0063-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.6']/v3:templateId[@root='1.2.208.184.20.2.6']">
      <assert id="PSCR-DK-2.0.0-B0063-DATE" test="@extension = '2025-01-15'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.6 must use 2025-01-15 Source: 4.2.1 CONF:B0063/B0064/B0065.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0066-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.6']">
      <assert id="PSCR-DK-2.0.0-B0066" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Education Section requires one code Source: 4.2.1 CONF:B0066.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0071-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.6']">
      <assert id="PSCR-DK-2.0.0-B0071" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Education Section requires one title Source: 4.2.1 CONF:B0071.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0072-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.6']">
      <assert id="PSCR-DK-2.0.0-B0072" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Education Section requires one text Source: 4.2.1 CONF:B0072.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0067-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.6']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0067" test="@code = '224285004'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Education Section @code must be 224285004 Source: 4.2.1 CONF:B0067.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0068-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.6']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0068" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Education Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.2.1 CONF:B0068.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0070-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.6']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0070" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.2.1 CONF:B0070.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-8-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-8" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.8']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one Employment Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0077-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.8']">
      <assert id="PSCR-DK-2.0.0-B0077" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Employment Section @classCode must be DOCSECT Source: 4.3.1 CONF:B0077.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0078-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.8']">
      <assert id="PSCR-DK-2.0.0-B0078" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Employment Section @moodCode must be EVN Source: 4.3.1 CONF:B0078.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0079-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.8']">
      <assert id="PSCR-DK-2.0.0-B0079" test="count(v3:templateId[@root='1.2.208.184.20.2.8']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.8 Source: 4.3.1 CONF:B0079/B0080/B0081.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0079-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.8']/v3:templateId[@root='1.2.208.184.20.2.8']">
      <assert id="PSCR-DK-2.0.0-B0079-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.8 must use 2024-04-19 Source: 4.3.1 CONF:B0079/B0080/B0081.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0082-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.8']">
      <assert id="PSCR-DK-2.0.0-B0082" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Employment Section requires one code Source: 4.3.1 CONF:B0082.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0087-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.8']">
      <assert id="PSCR-DK-2.0.0-B0087" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Employment Section requires one title Source: 4.3.1 CONF:B0087.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0088-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.8']">
      <assert id="PSCR-DK-2.0.0-B0088" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Employment Section requires one text Source: 4.3.1 CONF:B0088.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0083-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.8']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0083" test="@code = '364703007'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Employment Section @code must be 364703007 Source: 4.3.1 CONF:B0083.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0084-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.8']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0084" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Employment Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.3.1 CONF:B0084.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0086-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.8']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0086" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.3.1 CONF:B0086.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-10-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-10" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.10']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one Tobacco Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0093-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.10']">
      <assert id="PSCR-DK-2.0.0-B0093" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Tobacco Section @classCode must be DOCSECT Source: 4.4.1 CONF:B0093.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0094-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.10']">
      <assert id="PSCR-DK-2.0.0-B0094" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Tobacco Section @moodCode must be EVN Source: 4.4.1 CONF:B0094.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0095-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.10']">
      <assert id="PSCR-DK-2.0.0-B0095" test="count(v3:templateId[@root='1.2.208.184.20.2.10']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.10 Source: 4.4.1 CONF:B0095/B0096/B0097.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0095-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.10']/v3:templateId[@root='1.2.208.184.20.2.10']">
      <assert id="PSCR-DK-2.0.0-B0095-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.10 must use 2024-04-19 Source: 4.4.1 CONF:B0095/B0096/B0097.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0098-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.10']">
      <assert id="PSCR-DK-2.0.0-B0098" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Tobacco Section requires one code Source: 4.4.1 CONF:B0098.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0103-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.10']">
      <assert id="PSCR-DK-2.0.0-B0103" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Tobacco Section requires one title Source: 4.4.1 CONF:B0103.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0104-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.10']">
      <assert id="PSCR-DK-2.0.0-B0104" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Tobacco Section requires one text Source: 4.4.1 CONF:B0104.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0099-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.10']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0099" test="@code = '229819007'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Tobacco Section @code must be 229819007 Source: 4.4.1 CONF:B0099.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0100-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.10']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0100" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Tobacco Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.4.1 CONF:B0100.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0102-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.10']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0102" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.4.1 CONF:B0102.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-17-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-17" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.17']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one Nicotine Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0117-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.17']">
      <assert id="PSCR-DK-2.0.0-B0117" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Nicotine Section @classCode must be DOCSECT Source: 4.5.1 CONF:B0117.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0118-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.17']">
      <assert id="PSCR-DK-2.0.0-B0118" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Nicotine Section @moodCode must be EVN Source: 4.5.1 CONF:B0118.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0119-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.17']">
      <assert id="PSCR-DK-2.0.0-B0119" test="count(v3:templateId[@root='1.2.208.184.20.2.17']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.17 Source: 4.5.1 CONF:B0119/B0120/B0121.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0119-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.17']/v3:templateId[@root='1.2.208.184.20.2.17']">
      <assert id="PSCR-DK-2.0.0-B0119-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.17 must use 2024-04-19 Source: 4.5.1 CONF:B0119/B0120/B0121.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0122-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.17']">
      <assert id="PSCR-DK-2.0.0-B0122" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Nicotine Section requires one code Source: 4.5.1 CONF:B0122.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0127-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.17']">
      <assert id="PSCR-DK-2.0.0-B0127" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Nicotine Section requires one title Source: 4.5.1 CONF:B0127.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0128-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.17']">
      <assert id="PSCR-DK-2.0.0-B0128" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Nicotine Section requires one text Source: 4.5.1 CONF:B0128.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0123-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.17']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0123" test="@code = '647981000005104'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Nicotine Section @code must be 647981000005104 Source: 4.5.1 CONF:B0123.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0124-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.17']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0124" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Nicotine Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.5.1 CONF:B0124.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0126-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.17']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0126" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.5.1 CONF:B0126.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-26-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-26" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.26']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one Alcohol Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0147-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.26']">
      <assert id="PSCR-DK-2.0.0-B0147" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Alcohol Section @classCode must be DOCSECT Source: 4.6.1 CONF:B0147.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0148-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.26']">
      <assert id="PSCR-DK-2.0.0-B0148" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Alcohol Section @moodCode must be EVN Source: 4.6.1 CONF:B0148.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0149-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.26']">
      <assert id="PSCR-DK-2.0.0-B0149" test="count(v3:templateId[@root='1.2.208.184.20.2.26']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.26 Source: 4.6.1 CONF:B0149/B0150/B0151.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0149-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.26']/v3:templateId[@root='1.2.208.184.20.2.26']">
      <assert id="PSCR-DK-2.0.0-B0149-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.26 must use 2024-04-19 Source: 4.6.1 CONF:B0149/B0150/B0151.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0152-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.26']">
      <assert id="PSCR-DK-2.0.0-B0152" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Alcohol Section requires one code Source: 4.6.1 CONF:B0152.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0157-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.26']">
      <assert id="PSCR-DK-2.0.0-B0157" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Alcohol Section requires one title Source: 4.6.1 CONF:B0157.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0158-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.26']">
      <assert id="PSCR-DK-2.0.0-B0158" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Alcohol Section requires one text Source: 4.6.1 CONF:B0158.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0153-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.26']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0153" test="@code = '363905002'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Alcohol Section @code must be 363905002 Source: 4.6.1 CONF:B0153.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0154-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.26']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0154" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Alcohol Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.6.1 CONF:B0154.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0156-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.26']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0156" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.6.1 CONF:B0156.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-33-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-33" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.33']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one Drugs Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0167-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.33']">
      <assert id="PSCR-DK-2.0.0-B0167" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Drugs Section @classCode must be DOCSECT Source: 4.7.1 CONF:B0167.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0168-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.33']">
      <assert id="PSCR-DK-2.0.0-B0168" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Drugs Section @moodCode must be EVN Source: 4.7.1 CONF:B0168.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0169-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.33']">
      <assert id="PSCR-DK-2.0.0-B0169" test="count(v3:templateId[@root='1.2.208.184.20.2.33']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.33 Source: 4.7.1 CONF:B0169/B0170/B0171.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0169-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.33']/v3:templateId[@root='1.2.208.184.20.2.33']">
      <assert id="PSCR-DK-2.0.0-B0169-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.33 must use 2024-04-19 Source: 4.7.1 CONF:B0169/B0170/B0171.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0172-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.33']">
      <assert id="PSCR-DK-2.0.0-B0172" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Drugs Section requires one code Source: 4.7.1 CONF:B0172.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0177-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.33']">
      <assert id="PSCR-DK-2.0.0-B0177" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Drugs Section requires one title Source: 4.7.1 CONF:B0177.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0178-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.33']">
      <assert id="PSCR-DK-2.0.0-B0178" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Drugs Section requires one text Source: 4.7.1 CONF:B0178.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0173-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.33']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0173" test="@code = '363908000'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Drugs Section @code must be 363908000 Source: 4.7.1 CONF:B0173.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0174-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.33']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0174" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Drugs Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.7.1 CONF:B0174.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0176-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.33']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0176" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.7.1 CONF:B0176.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-35-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-35" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.35']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one Nutrition Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0181-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.35']">
      <assert id="PSCR-DK-2.0.0-B0181" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Nutrition Section @classCode must be DOCSECT Source: 4.8.1 CONF:B0181.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0182-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.35']">
      <assert id="PSCR-DK-2.0.0-B0182" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Nutrition Section @moodCode must be EVN Source: 4.8.1 CONF:B0182.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0183-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.35']">
      <assert id="PSCR-DK-2.0.0-B0183" test="count(v3:templateId[@root='1.2.208.184.20.2.35']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.35 Source: 4.8.1 CONF:B0183/B0184/B0185.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0183-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.35']/v3:templateId[@root='1.2.208.184.20.2.35']">
      <assert id="PSCR-DK-2.0.0-B0183-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.35 must use 2024-04-19 Source: 4.8.1 CONF:B0183/B0184/B0185.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0186-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.35']">
      <assert id="PSCR-DK-2.0.0-B0186" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Nutrition Section requires one code Source: 4.8.1 CONF:B0186.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0191-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.35']">
      <assert id="PSCR-DK-2.0.0-B0191" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Nutrition Section requires one title Source: 4.8.1 CONF:B0191.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0192-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.35']">
      <assert id="PSCR-DK-2.0.0-B0192" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Nutrition Section requires one text Source: 4.8.1 CONF:B0192.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0187-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.35']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0187" test="@code = '364393001'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Nutrition Section @code must be 364393001 Source: 4.8.1 CONF:B0187.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0188-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.35']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0188" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Nutrition Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.8.1 CONF:B0188.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0190-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.35']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0190" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.8.1 CONF:B0190.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-36-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-36" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.36']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one Exercise Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0195-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.36']">
      <assert id="PSCR-DK-2.0.0-B0195" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Exercise Section @classCode must be DOCSECT Source: 4.9.1 CONF:B0195.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0196-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.36']">
      <assert id="PSCR-DK-2.0.0-B0196" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Exercise Section @moodCode must be EVN Source: 4.9.1 CONF:B0196.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0197-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.36']">
      <assert id="PSCR-DK-2.0.0-B0197" test="count(v3:templateId[@root='1.2.208.184.20.2.36']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.36 Source: 4.9.1 CONF:B0197/B0198/B0199.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0197-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.36']/v3:templateId[@root='1.2.208.184.20.2.36']">
      <assert id="PSCR-DK-2.0.0-B0197-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.36 must use 2024-04-19 Source: 4.9.1 CONF:B0197/B0198/B0199.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0200-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.36']">
      <assert id="PSCR-DK-2.0.0-B0200" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Exercise Section requires one code Source: 4.9.1 CONF:B0200.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0205-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.36']">
      <assert id="PSCR-DK-2.0.0-B0205" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Exercise Section requires one title Source: 4.9.1 CONF:B0205.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0206-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.36']">
      <assert id="PSCR-DK-2.0.0-B0206" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Exercise Section requires one text Source: 4.9.1 CONF:B0206.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0201-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.36']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0201" test="@code = '256235009'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Exercise Section @code must be 256235009 Source: 4.9.1 CONF:B0201.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0202-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.36']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0202" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Exercise Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.9.1 CONF:B0202.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0204-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.36']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0204" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.9.1 CONF:B0204.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-37-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-37" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.37']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one Partner Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0209-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.37']">
      <assert id="PSCR-DK-2.0.0-B0209" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Partner Section @classCode must be DOCSECT Source: 4.10.1 CONF:B0209.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0210-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.37']">
      <assert id="PSCR-DK-2.0.0-B0210" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Partner Section @moodCode must be EVN Source: 4.10.1 CONF:B0210.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0211-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.37']">
      <assert id="PSCR-DK-2.0.0-B0211" test="count(v3:templateId[@root='1.2.208.184.20.2.37']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.37 Source: 4.10.1 CONF:B0211/B0212/B0213.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0211-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.37']/v3:templateId[@root='1.2.208.184.20.2.37']">
      <assert id="PSCR-DK-2.0.0-B0211-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.37 must use 2024-04-19 Source: 4.10.1 CONF:B0211/B0212/B0213.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0214-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.37']">
      <assert id="PSCR-DK-2.0.0-B0214" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Partner Section requires one code Source: 4.10.1 CONF:B0214.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0219-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.37']">
      <assert id="PSCR-DK-2.0.0-B0219" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Partner Section requires one title Source: 4.10.1 CONF:B0219.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0220-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.37']">
      <assert id="PSCR-DK-2.0.0-B0220" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Partner Section requires one text Source: 4.10.1 CONF:B0220.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0215-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.37']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0215" test="@code = '648091000005104'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Partner Section @code must be 648091000005104 Source: 4.10.1 CONF:B0215.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0216-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.37']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0216" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Partner Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.10.1 CONF:B0216.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0218-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.37']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0218" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.10.1 CONF:B0218.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-44-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-44" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.44']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one Place of Delivery Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0235-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.44']">
      <assert id="PSCR-DK-2.0.0-B0235" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Place of Delivery Section @classCode must be DOCSECT Source: 4.11.1 CONF:B0235.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0236-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.44']">
      <assert id="PSCR-DK-2.0.0-B0236" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Place of Delivery Section @moodCode must be EVN Source: 4.11.1 CONF:B0236.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0237-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.44']">
      <assert id="PSCR-DK-2.0.0-B0237" test="count(v3:templateId[@root='1.2.208.184.20.2.44']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.44 Source: 4.11.1 CONF:B0237/B0238/B0239.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0237-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.44']/v3:templateId[@root='1.2.208.184.20.2.44']">
      <assert id="PSCR-DK-2.0.0-B0237-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.44 must use 2024-04-19 Source: 4.11.1 CONF:B0237/B0238/B0239.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0240-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.44']">
      <assert id="PSCR-DK-2.0.0-B0240" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Place of Delivery Section requires one code Source: 4.11.1 CONF:B0240.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0245-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.44']">
      <assert id="PSCR-DK-2.0.0-B0245" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Place of Delivery Section requires one title Source: 4.11.1 CONF:B0245.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0246-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.44']">
      <assert id="PSCR-DK-2.0.0-B0246" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Place of Delivery Section requires one text Source: 4.11.1 CONF:B0246.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0241-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.44']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0241" test="@code = '169812000'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Place of Delivery Section @code must be 169812000 Source: 4.11.1 CONF:B0241.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0242-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.44']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0242" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Place of Delivery Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.11.1 CONF:B0242.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0244-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.44']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0244" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.11.1 CONF:B0244.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-48-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-48" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.48']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one Midwife Clinic Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0253-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.48']">
      <assert id="PSCR-DK-2.0.0-B0253" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Midwife Clinic Section @classCode must be DOCSECT Source: 4.12.1 CONF:B0253.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0254-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.48']">
      <assert id="PSCR-DK-2.0.0-B0254" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Midwife Clinic Section @moodCode must be EVN Source: 4.12.1 CONF:B0254.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0255-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.48']">
      <assert id="PSCR-DK-2.0.0-B0255" test="count(v3:templateId[@root='1.2.208.184.20.2.48']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.48 Source: 4.12.1 CONF:B0255/B0256/B0257.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0255-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.48']/v3:templateId[@root='1.2.208.184.20.2.48']">
      <assert id="PSCR-DK-2.0.0-B0255-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.48 must use 2024-04-19 Source: 4.12.1 CONF:B0255/B0256/B0257.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0258-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.48']">
      <assert id="PSCR-DK-2.0.0-B0258" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Midwife Clinic Section requires one code Source: 4.12.1 CONF:B0258.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0263-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.48']">
      <assert id="PSCR-DK-2.0.0-B0263" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Midwife Clinic Section requires one title Source: 4.12.1 CONF:B0263.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0264-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.48']">
      <assert id="PSCR-DK-2.0.0-B0264" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Midwife Clinic Section requires one text Source: 4.12.1 CONF:B0264.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0259-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.48']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0259" test="@code = '550631000005103'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Midwife Clinic Section @code must be 550631000005103 Source: 4.12.1 CONF:B0259.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0260-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.48']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0260" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Midwife Clinic Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.12.1 CONF:B0260.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0262-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.48']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0262" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.12.1 CONF:B0262.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-54-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-54" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.54']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one Health Visitors Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0275-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.54']">
      <assert id="PSCR-DK-2.0.0-B0275" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Health Visitors Section @classCode must be DOCSECT Source: 4.13.1 CONF:B0275.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0276-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.54']">
      <assert id="PSCR-DK-2.0.0-B0276" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Health Visitors Section @moodCode must be EVN Source: 4.13.1 CONF:B0276.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0277-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.54']">
      <assert id="PSCR-DK-2.0.0-B0277" test="count(v3:templateId[@root='1.2.208.184.20.2.54']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.54 Source: 4.13.1 CONF:B0277/B0278/B0279.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0277-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.54']/v3:templateId[@root='1.2.208.184.20.2.54']">
      <assert id="PSCR-DK-2.0.0-B0277-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.54 must use 2024-04-19 Source: 4.13.1 CONF:B0277/B0278/B0279.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0280-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.54']">
      <assert id="PSCR-DK-2.0.0-B0280" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Health Visitors Section requires one code Source: 4.13.1 CONF:B0280.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0285-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.54']">
      <assert id="PSCR-DK-2.0.0-B0285" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Health Visitors Section requires one title Source: 4.13.1 CONF:B0285.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0286-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.54']">
      <assert id="PSCR-DK-2.0.0-B0286" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Health Visitors Section requires one text Source: 4.13.1 CONF:B0286.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0281-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.54']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0281" test="@code = '554021000005101'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Health Visitors Section @code must be 554021000005101 Source: 4.13.1 CONF:B0281.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0282-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.54']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0282" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Health Visitors Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.13.1 CONF:B0282.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0284-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.54']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0284" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.13.1 CONF:B0284.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-56-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-56" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.56']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one General Clinical State Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0289-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.56']">
      <assert id="PSCR-DK-2.0.0-B0289" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">General Clinical State Section @classCode must be DOCSECT Source: 4.14.1 CONF:B0289.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0290-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.56']">
      <assert id="PSCR-DK-2.0.0-B0290" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">General Clinical State Section @moodCode must be EVN Source: 4.14.1 CONF:B0290.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0291-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.56']">
      <assert id="PSCR-DK-2.0.0-B0291" test="count(v3:templateId[@root='1.2.208.184.20.2.56']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.56 Source: 4.14.1 CONF:B0291/B0292/B0293.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0291-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.56']/v3:templateId[@root='1.2.208.184.20.2.56']">
      <assert id="PSCR-DK-2.0.0-B0291-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.56 must use 2024-04-19 Source: 4.14.1 CONF:B0291/B0292/B0293.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0294-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.56']">
      <assert id="PSCR-DK-2.0.0-B0294" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">General Clinical State Section requires one code Source: 4.14.1 CONF:B0294.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0299-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.56']">
      <assert id="PSCR-DK-2.0.0-B0299" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">General Clinical State Section requires one title Source: 4.14.1 CONF:B0299.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0300-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.56']">
      <assert id="PSCR-DK-2.0.0-B0300" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">General Clinical State Section requires one text Source: 4.14.1 CONF:B0300.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0295-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.56']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0295" test="@code = '278844005'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">General Clinical State Section @code must be 278844005 Source: 4.14.1 CONF:B0295.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0296-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.56']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0296" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">General Clinical State Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.14.1 CONF:B0296.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0298-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.56']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0298" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.14.1 CONF:B0298.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-65-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-65" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.65']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one Summary Report Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0311-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.65']">
      <assert id="PSCR-DK-2.0.0-B0311" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Summary Report Section @classCode must be DOCSECT Source: 4.15.1 CONF:B0311.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0312-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.65']">
      <assert id="PSCR-DK-2.0.0-B0312" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Summary Report Section @moodCode must be EVN Source: 4.15.1 CONF:B0312.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0313-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.65']">
      <assert id="PSCR-DK-2.0.0-B0313" test="count(v3:templateId[@root='1.2.208.184.20.2.65']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.65 Source: 4.15.1 CONF:B0313/B0314/B0315.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0313-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.65']/v3:templateId[@root='1.2.208.184.20.2.65']">
      <assert id="PSCR-DK-2.0.0-B0313-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.65 must use 2024-04-19 Source: 4.15.1 CONF:B0313/B0314/B0315.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0316-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.65']">
      <assert id="PSCR-DK-2.0.0-B0316" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Summary Report Section requires one code Source: 4.15.1 CONF:B0316.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0321-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.65']">
      <assert id="PSCR-DK-2.0.0-B0321" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Summary Report Section requires one title Source: 4.15.1 CONF:B0321.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0322-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.65']">
      <assert id="PSCR-DK-2.0.0-B0322" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Summary Report Section requires one text Source: 4.15.1 CONF:B0322.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0317-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.65']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0317" test="@code = '371534008'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Summary Report Section @code must be 371534008 Source: 4.15.1 CONF:B0317.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0318-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.65']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0318" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Summary Report Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.15.1 CONF:B0318.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0320-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.65']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0320" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.15.1 CONF:B0320.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-SECTION-MAX-67-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PSCR-DK-2.0.0-SECTION-MAX-67" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.67']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">At most one Receipt of Benefit Status Section may be supplied Source: 3.1 section cardinalities.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0325-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.67']">
      <assert id="PSCR-DK-2.0.0-B0325" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Receipt of Benefit Status Section @classCode must be DOCSECT Source: 4.16.1 CONF:B0325.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0326-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.67']">
      <assert id="PSCR-DK-2.0.0-B0326" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Receipt of Benefit Status Section @moodCode must be EVN Source: 4.16.1 CONF:B0326.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0327-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.67']">
      <assert id="PSCR-DK-2.0.0-B0327" test="count(v3:templateId[@root='1.2.208.184.20.2.67']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Require one declaration of template 1.2.208.184.20.2.67 Source: 4.16.1 CONF:B0327/B0328/B0329.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0327-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.67']/v3:templateId[@root='1.2.208.184.20.2.67']">
      <assert id="PSCR-DK-2.0.0-B0327-DATE" test="@extension = '2024-04-19'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Template 1.2.208.184.20.2.67 must use 2024-04-19 Source: 4.16.1 CONF:B0327/B0328/B0329.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0330-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.67']">
      <assert id="PSCR-DK-2.0.0-B0330" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Receipt of Benefit Status Section requires one code Source: 4.16.1 CONF:B0330.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0335-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.67']">
      <assert id="PSCR-DK-2.0.0-B0335" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Receipt of Benefit Status Section requires one title Source: 4.16.1 CONF:B0335.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0336-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.67']">
      <assert id="PSCR-DK-2.0.0-B0336" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Receipt of Benefit Status Section requires one text Source: 4.16.1 CONF:B0336.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0331-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.67']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0331" test="@code = '228163007'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Receipt of Benefit Status Section @code must be 228163007 Source: 4.16.1 CONF:B0331.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0332-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.67']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0332" test="@codeSystem = '2.16.840.1.113883.6.96'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">Receipt of Benefit Status Section @codeSystem must be 2.16.840.1.113883.6.96 Source: 4.16.1 CONF:B0332.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-B0334-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.20.2.67']/v3:code">
      <assert id="PSCR-DK-2.0.0-B0334" test="normalize-space(@displayName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf">@displayName must be present and non-empty Source: 4.16.1 CONF:B0334.</assert>
    </rule>
  </pattern>
  <pattern id="PSCR-DK-2.0.0-NULL-FLAVOR-pattern">
    <rule context="v3:ClinicalDocument//v3:*[@nullFlavor] | v3:ClinicalDocument[@nullFlavor]">
      <assert id="PSCR-DK-2.0.0-NULL-FLAVOR" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf" test="@nullFlavor=('NI','NA')">Only NI and NA nullFlavor codes are permitted by this profile. Source: 1.5.1, Table 1.</assert>
    </rule>
  </pattern>
</schema>