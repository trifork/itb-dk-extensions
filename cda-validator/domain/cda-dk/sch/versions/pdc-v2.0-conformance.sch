<?xml version='1.0' encoding='UTF-8'?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>PDC-DK-2.0 source-derived conformance checks</title>
  <ns prefix="v3" uri="urn:hl7-org:v3" />
  <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance" />
  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema" />
  <pattern id="PDC-DK-2.0-C102-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PDC-DK-2.0-C102" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one id Source: 2.1–2.1.4 CONF-DK:102.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C104-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PDC-DK-2.0-C104" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one code Source: 2.1–2.1.4 CONF-DK:104.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C109-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PDC-DK-2.0-C109" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one title Source: 2.1–2.1.4 CONF-DK:109.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C111-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PDC-DK-2.0-C111" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one effectiveTime Source: 2.1–2.1.4 CONF-DK:111.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C112-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PDC-DK-2.0-C112" test="count(v3:author) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one author Source: 2.1–2.1.4 CONF-DK:112.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C113-pattern">
    <rule context="v3:ClinicalDocument/v3:author">
      <assert id="PDC-DK-2.0-C113" test="count(v3:time) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one time Source: 2.1–2.1.4 CONF-DK:113.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C115-pattern">
    <rule context="v3:ClinicalDocument/v3:author">
      <assert id="PDC-DK-2.0-C115" test="count(v3:assignedAuthor) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one assignedAuthor Source: 2.1–2.1.4 CONF-DK:115.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C116-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <assert id="PDC-DK-2.0-C116" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one id Source: 2.1–2.1.4 CONF-DK:116.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C119-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <assert id="PDC-DK-2.0-C119" test="count(v3:representedOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one representedOrganization Source: 2.1–2.1.4 CONF-DK:119.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C120-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:representedOrganization">
      <assert id="PDC-DK-2.0-C120" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one name Source: 2.1–2.1.4 CONF-DK:120.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C123-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PDC-DK-2.0-C123" test="count(v3:custodian) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one custodian Source: 2.1–2.1.4 CONF-DK:123.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C124-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian">
      <assert id="PDC-DK-2.0-C124" test="count(v3:assignedCustodian) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one assignedCustodian Source: 2.1–2.1.4 CONF-DK:124.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C125-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian">
      <assert id="PDC-DK-2.0-C125" test="count(v3:representedCustodianOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one representedCustodianOrganization Source: 2.1–2.1.4 CONF-DK:125.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C126-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <assert id="PDC-DK-2.0-C126" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one id Source: 2.1–2.1.4 CONF-DK:126.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C129-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <assert id="PDC-DK-2.0-C129" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one name Source: 2.1–2.1.4 CONF-DK:129.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C105-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PDC-DK-2.0-C105" test="@code = 'PDC'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC document @code must be PDC Source: 2.1 CONF-DK:105.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C106-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PDC-DK-2.0-C106" test="@codeSystem = '1.2.208.184.100.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC document @codeSystem must be 1.2.208.184.100.1 Source: 2.1 CONF-DK:106.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C107-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PDC-DK-2.0-C107" test="@codeSystemName = 'MedCom Message Codes'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC document @codeSystemName must be MedCom Message Codes Source: 2.1 CONF-DK:107.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C108-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PDC-DK-2.0-C108" test="@displayName = 'Stamkort'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC document @displayName must be Stamkort Source: 2.1 CONF-DK:108.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C110-pattern">
    <rule context="v3:ClinicalDocument/v3:title">
      <assert id="PDC-DK-2.0-C110" test="normalize-space(.)=concat('Personal Data Card for ', /v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:id[@root='1.2.208.176.1.2']/@extension)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC title must contain the prescribed heading and patient CPR Source: 2.1 CONF-DK:110.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-AUTHOR-root-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:id">
      <assert id="PDC-DK-2.0-AUTHOR-root" test="@root = '1.2.208.176.1.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf">PDC author must identify Sundhedsdatastyrelsen SOR 1126211000016009 Source: 2.1.1/2.1.4; PDC 2.0 errata items 2/3 where applicable.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-AUTHOR-extension-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:id">
      <assert id="PDC-DK-2.0-AUTHOR-extension" test="@extension = '1126211000016009'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf">PDC author must identify Sundhedsdatastyrelsen SOR 1126211000016009 Source: 2.1.1/2.1.4; PDC 2.0 errata items 2/3 where applicable.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-CUSTODIAN-root-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization/v3:id">
      <assert id="PDC-DK-2.0-CUSTODIAN-root" test="@root = '1.2.208.176.1.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf">PDC custodian must identify Sundhedsdatastyrelsen SOR 1126211000016009 Source: 2.1.1/2.1.4; PDC 2.0 errata items 2/3 where applicable.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-CUSTODIAN-extension-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization/v3:id">
      <assert id="PDC-DK-2.0-CUSTODIAN-extension" test="@extension = '1126211000016009'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf">PDC custodian must identify Sundhedsdatastyrelsen SOR 1126211000016009 Source: 2.1.1/2.1.4; PDC 2.0 errata items 2/3 where applicable.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C489-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:id">
      <assert id="PDC-DK-2.0-C489" test="@assigningAuthorityName = 'SOR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf">PDC author identifier authority must be SOR Source: 2.1.1 CONF-DK:489; PDC 2.0 errata item 2 where applicable.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C120-NAME-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:representedOrganization/v3:name">
      <assert id="PDC-DK-2.0-C120-NAME" test="normalize-space(.)='Sundhedsdatastyrelsen'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf">PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C129-NAME-pattern">
    <rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization/v3:name">
      <assert id="PDC-DK-2.0-C129-NAME" test="normalize-space(.)='Sundhedsdatastyrelsen'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf">PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C121-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PDC-DK-2.0-C121" test="empty(v3:dataEnterer)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC header must not contain dataEnterer Source: 2.1.2–2.1.8 CONF-DK:121.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C122-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PDC-DK-2.0-C122" test="empty(v3:informant)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC header must not contain informant Source: 2.1.2–2.1.8 CONF-DK:122.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C130-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PDC-DK-2.0-C130" test="empty(v3:informationRecipient)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC header must not contain informationRecipient Source: 2.1.2–2.1.8 CONF-DK:130.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C131-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PDC-DK-2.0-C131" test="empty(v3:legalAuthenticator)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC header must not contain legalAuthenticator Source: 2.1.2–2.1.8 CONF-DK:131.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C132-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PDC-DK-2.0-C132" test="empty(v3:authenticator)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC header must not contain authenticator Source: 2.1.2–2.1.8 CONF-DK:132.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C133-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PDC-DK-2.0-C133" test="empty(v3:participant)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC header must not contain participant Source: 2.1.2–2.1.8 CONF-DK:133.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C134-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PDC-DK-2.0-C134" test="count(v3:documentationOf/v3:serviceEvent/v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC requires one service event time Source: 2.1.9 CONF-DK:134.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C135-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent/v3:effectiveTime">
      <assert id="PDC-DK-2.0-C135" test="count(v3:low) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC service interval requires one low Source: 2.1.9 CONF-DK:135.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C137-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent/v3:effectiveTime">
      <assert id="PDC-DK-2.0-C137" test="count(v3:high) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC service interval requires one high Source: 2.1.9 CONF-DK:137.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C138-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent/v3:effectiveTime/v3:high">
      <assert id="PDC-DK-2.0-C138" test="@nullFlavor = 'NA'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC service end must use nullFlavor NA Source: 2.1.9 CONF-DK:138.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C136-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent/v3:effectiveTime/v3:low">
      <assert id="PDC-DK-2.0-C136" test="(@value = /v3:ClinicalDocument/v3:effectiveTime/@value) or (if (replace(string(@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8') castable as xs:dateTime and replace(string(/v3:ClinicalDocument/v3:effectiveTime/@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8') castable as xs:dateTime) then xs:dateTime(replace(string(@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8')) = xs:dateTime(replace(string(/v3:ClinicalDocument/v3:effectiveTime/@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8')) else false())" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC service start must equal document creation time Source: 2.1.9 CONF-DK:136.</assert>
    </rule>
  </pattern>
  <pattern id="PDC-DK-2.0-C114-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:time">
      <assert id="PDC-DK-2.0-C114" test="(@value = /v3:ClinicalDocument/v3:effectiveTime/@value) or (if (replace(string(@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8') castable as xs:dateTime and replace(string(/v3:ClinicalDocument/v3:effectiveTime/@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8') castable as xs:dateTime) then xs:dateTime(replace(string(@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8')) = xs:dateTime(replace(string(/v3:ClinicalDocument/v3:effectiveTime/@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8')) else false())" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf">PDC author time must equal document creation time Source: 2.1.1 CONF-DK:114.</assert>
    </rule>
  </pattern>
</schema>