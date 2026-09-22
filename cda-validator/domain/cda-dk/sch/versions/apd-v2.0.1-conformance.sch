<?xml version='1.0' encoding='UTF-8'?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>APD-DK-2.0.1 source-derived conformance checks</title>
  <ns prefix="v3" uri="urn:hl7-org:v3" />
  <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance" />
  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema" />
  <pattern id="APD-DK-2.0.1-cdc3-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-cdc3" test="count(v3:realmCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD requires one realmCode Source: 2.1 CONF-DK-APD:cdc3.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-b962-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-b962" test="count(v3:typeId) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD requires one typeId Source: 2.1 CONF-DK-APD:b962.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-a5bd-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-a5bd" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD requires one id Source: 2.1 CONF-DK-APD:a5bd.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-f917-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-f917" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD requires one code Source: 2.1 CONF-DK-APD:f917.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-17da-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-17da" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD requires one title Source: 2.1 CONF-DK-APD:17da.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-1640-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-1640" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD requires one effectiveTime Source: 2.1 CONF-DK-APD:1640.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-cdc3-CODE-pattern">
    <rule context="v3:ClinicalDocument/v3:realmCode">
      <assert id="APD-DK-2.0.1-cdc3-CODE" test="@code = 'DK'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD realm must be DK Source: 2.1 CONF-DK-APD:cdc3.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-9a86-pattern">
    <rule context="v3:ClinicalDocument/v3:typeId">
      <assert id="APD-DK-2.0.1-9a86" test="@root = '2.16.840.1.113883.1.3'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD @root must be 2.16.840.1.113883.1.3 Source: 2.1 CONF-DK-APD:9a86.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-dc34-pattern">
    <rule context="v3:ClinicalDocument/v3:typeId">
      <assert id="APD-DK-2.0.1-dc34" test="@extension = 'POCD_HD000040'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD @extension must be POCD_HD000040 Source: 2.1 CONF-DK-APD:dc34.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-7d26-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="APD-DK-2.0.1-7d26" test="@code = '39289-4'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD @code must be 39289-4 Source: 2.1 CONF-DK-APD:7d26.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-4660-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="APD-DK-2.0.1-4660" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD @codeSystem must be 2.16.840.1.113883.6.1 Source: 2.1 CONF-DK-APD:4660.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-e56b-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="APD-DK-2.0.1-e56b" test="@displayName = 'Dato og tidspunkt for møde mellem patient og sundhedsperson'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD @displayName must be Dato og tidspunkt for møde mellem patient og sundhedsperson Source: 2.1 CONF-DK-APD:e56b.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-9ac6-pattern">
    <rule context="v3:ClinicalDocument/v3:title">
      <assert id="APD-DK-2.0.1-9ac6" test="normalize-space(.) = concat('Aftale for ', /v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:id[@root='1.2.208.176.1.2']/@extension)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD title must identify the patient as Aftale for followed by the CPR Source: 2.1 CONF-DK-APD:9ac6.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-61c6-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-61c6" test="count(v3:author) &gt;= 1 and count(v3:author) &lt;= 2" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf">APD requires a responsible author and permits one requester Source: errata item 10, CONF-DK-APD:61c6.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-40d4-pattern">
    <rule context="v3:ClinicalDocument/v3:author[2]">
      <assert id="APD-DK-2.0.1-40d4" test="not(@nullFlavor) and count(v3:assignedAuthor) = 1 and v3:assignedAuthor/v3:code/@code = 'REFB'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf">A supplied requester author must identify a requester with REFB Source: errata items 1 and 11, CONF-DK-APD:40d4/47aa.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-8cd7-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <assert id="APD-DK-2.0.1-8cd7" test="exists(v3:addr)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf">APD authors require addr Source: 2.1.2 and errata item 14, CONF-DK-APD:8cd7.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-c79d-pattern">
    <rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <assert id="APD-DK-2.0.1-c79d" test="exists(v3:telecom)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf">APD authors require telecom Source: 2.1.2 and errata item 14, CONF-DK-APD:c79d.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-4b90-9199-pattern">
    <rule context="v3:ClinicalDocument/v3:author[1]/v3:assignedAuthor">
      <assert id="APD-DK-2.0.1-4b90-9199" test="exists(v3:id[@root=('1.2.208.176.1.1','1.2.208.176.1.4')][normalize-space(@extension)])" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf">Responsible author needs a SOR or provider identifier Source: errata item 14, CONF-DK-APD:4b90/9199.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-7616-pattern">
    <rule context="v3:ClinicalDocument/v3:author[2]/v3:assignedAuthor">
      <assert id="APD-DK-2.0.1-7616" test="count(v3:id)=1 and v3:id/@root='1.2.208.176.1.1' and normalize-space(v3:id/@extension) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Requester requires one SOR identifier Source: 2.1.2.2 CONF-DK-APD:7616.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-PROHIBIT-dataEnterer-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-PROHIBIT-dataEnterer" test="empty(v3:dataEnterer)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD must not contain header dataEnterer Source: 2.1.3.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-PROHIBIT-informant-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-PROHIBIT-informant" test="empty(v3:informant)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD must not contain header informant Source: 2.1.4.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-PROHIBIT-informationRecipient-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-PROHIBIT-informationRecipient" test="empty(v3:informationRecipient)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD must not contain header informationRecipient Source: 2.1.6.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-PROHIBIT-legalAuthenticator-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-PROHIBIT-legalAuthenticator" test="empty(v3:legalAuthenticator)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD must not contain header legalAuthenticator Source: 2.1.7.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-PROHIBIT-authenticator-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-PROHIBIT-authenticator" test="empty(v3:authenticator)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD must not contain header authenticator Source: 2.1.8.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-PROHIBIT-participant-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-PROHIBIT-participant" test="empty(v3:participant)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD must not contain header participant Source: 2.1.9.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-PROHIBIT-inFulfillmentOf-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-PROHIBIT-inFulfillmentOf" test="empty(v3:inFulfillmentOf)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD must not contain header inFulfillmentOf Source: 2.1.11.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-851d-37d2-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-851d-37d2" test="count(v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD requires one time interval event Source: 2.1.10 CONF-DK-APD:851d-37d2.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-69ee-5363-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-69ee-5363" test="count(v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD requires one profile version event Source: 2.1.10 CONF-DK-APD:69ee-5363.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-0b52-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']">
      <assert id="APD-DK-2.0.1-0b52" test="count(v3:effectiveTime/v3:low) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD interval requires one start Source: 2.1.10.1 CONF-DK-APD:0b52.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-2d8c-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']">
      <assert id="APD-DK-2.0.1-2d8c" test="count(v3:effectiveTime/v3:high) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD interval requires one end, which may be unknown Source: 2.1.10.1 CONF-DK-APD:2d8c.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-592c-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:low">
      <assert id="APD-DK-2.0.1-592c" test="@value and not(@nullFlavor)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Appointment start cannot be null Source: 2.1.10.1 CONF-DK-APD:0561/592c.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-42aa-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:high">
      <assert id="APD-DK-2.0.1-42aa" test="@value or @nullFlavor" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Appointment end needs a value or nullFlavor Source: 2.1.10.1 CONF-DK-APD:eff6/42aa.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-a879-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="APD-DK-2.0.1-a879" test="@root = '1.2.208.184.100.10'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf">APD version identifier @root must be 1.2.208.184.100.10 Source: errata items 6/7; 2.1.10.2 CONF-DK-APD:a879.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-c69d-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="APD-DK-2.0.1-c69d" test="@assigningAuthorityName = 'MedCom'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf">APD version identifier @assigningAuthorityName must be MedCom Source: errata items 6/7; 2.1.10.2 CONF-DK-APD:c69d.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-ad38-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:effectiveTime/v3:low">
      <assert id="APD-DK-2.0.1-ad38" test="((@value = /v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:low/@value) or (if (replace(string(@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8') castable as xs:dateTime and replace(string(/v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:low/@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8') castable as xs:dateTime) then xs:dateTime(replace(string(@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8')) = xs:dateTime(replace(string(/v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:low/@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8')) else false())) or (@nullFlavor = /v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:low/@nullFlavor)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Body and header appointment low must agree Source: 2.1.10.1 CONF-DK-APD:ad38.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-7e5c-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:effectiveTime/v3:high">
      <assert id="APD-DK-2.0.1-7e5c" test="((@value = /v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:high/@value) or (if (replace(string(@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8') castable as xs:dateTime and replace(string(/v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:high/@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8') castable as xs:dateTime) then xs:dateTime(replace(string(@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8')) = xs:dateTime(replace(string(/v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:high/@value), '^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([+-][0-9]{2})([0-9]{2})$', '$1-$2-$3T$4:$5:$6$7:$8')) else false())) or (@nullFlavor = /v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:high/@nullFlavor)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Body and header appointment high must agree Source: 2.1.10.1 CONF-DK-APD:7e5c.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-7ccb-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="APD-DK-2.0.1-7ccb" test="count(v3:component) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD requires one component Source: 3.1/4.1 CONF-DK-APD:7ccb.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-30fc-pattern">
    <rule context="v3:ClinicalDocument/v3:component">
      <assert id="APD-DK-2.0.1-30fc" test="count(v3:structuredBody) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD requires one structuredBody Source: 3.1/4.1 CONF-DK-APD:30fc.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-63ff-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="APD-DK-2.0.1-63ff" test="count(v3:component) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD requires one component Source: 3.1/4.1 CONF-DK-APD:63ff.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-4981-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component">
      <assert id="APD-DK-2.0.1-4981" test="count(v3:section) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD requires one section Source: 3.1/4.1 CONF-DK-APD:4981.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-8506-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
      <assert id="APD-DK-2.0.1-8506" test="count(v3:entry) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD requires one entry Source: 3.1/4.1 CONF-DK-APD:8506.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-dfed-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry">
      <assert id="APD-DK-2.0.1-dfed" test="count(v3:encounter) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD requires one encounter Source: 3.1/4.1 CONF-DK-APD:dfed.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-9b39-efbf-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
      <assert id="APD-DK-2.0.1-9b39-efbf" test="count(v3:templateId[@root='1.2.208.184.14.11.1'][@extension='2019-09-10'])=1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD template must identify the 2019-09-10 release Source: 4.1/5.1/5.3.1 CONF-DK-APD:9b39-efbf.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-49d8-ad5b-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter">
      <assert id="APD-DK-2.0.1-49d8-ad5b" test="count(v3:templateId[@root='1.2.208.184.14.11.2'][@extension='2019-09-10'])=1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD template must identify the 2019-09-10 release Source: 4.1/5.1/5.3.1 CONF-DK-APD:49d8-ad5b.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-cce6-7df6-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:participant/v3:participantRole">
      <assert id="APD-DK-2.0.1-cce6-7df6" test="count(v3:templateId[@root='1.2.208.184.14.11.3'][@extension='2019-09-10'])=1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD template must identify the 2019-09-10 release Source: 4.1/5.1/5.3.1 CONF-DK-APD:cce6-7df6.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-d9f0-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
      <assert id="APD-DK-2.0.1-d9f0" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD section requires one title Source: 4.1 CONF-DK-APD:d9f0; CONF:1098-7725/14749.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-C7725-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
      <assert id="APD-DK-2.0.1-C7725" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD section requires one text Source: 4.1 CONF-DK-APD:d9f0; CONF:1098-7725/14749.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-C14749-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
      <assert id="APD-DK-2.0.1-C14749" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD section requires one code Source: 4.1 CONF-DK-APD:d9f0; CONF:1098-7725/14749.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-C14750-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:code">
      <assert id="APD-DK-2.0.1-C14750" test="@code = '18776-5'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD section code must be 18776-5 Source: 4.1 CONF:1098-14750.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-C8564-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter">
      <assert id="APD-DK-2.0.1-C8564" test="@classCode = 'ENC'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD encounter @classCode must be ENC Source: 5.1 CONF:1098-8564; CONF-DK-APD:8f97.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-8f97-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter">
      <assert id="APD-DK-2.0.1-8f97" test="@moodCode = 'APT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">APD encounter @moodCode must be APT Source: 5.1 CONF:1098-8564; CONF-DK-APD:8f97.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-7493-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter">
      <assert id="APD-DK-2.0.1-7493" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Appointment encounter requires one id Source: 5.1 CONF-DK-APD:7493.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-C14749-ENCOUNTER-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter">
      <assert id="APD-DK-2.0.1-C14749-ENCOUNTER" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Appointment encounter requires one code Source: 5.1 CONF:1098-14749 (encounter code cardinality).</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-C134-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter">
      <assert id="APD-DK-2.0.1-C134" test="count(v3:statusCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Appointment encounter requires one statusCode Source: 5.1 CONF:134 (statusCode cardinality).</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-4021-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter">
      <assert id="APD-DK-2.0.1-4021" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Appointment encounter requires one effectiveTime Source: 5.1 CONF-DK-APD:4021.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-63d8-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter">
      <assert id="APD-DK-2.0.1-63d8" test="count(v3:performer) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Appointment encounter requires one performer Source: 5.1 CONF-DK-APD:63d8.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-4ec7-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter">
      <assert id="APD-DK-2.0.1-4ec7" test="count(v3:participant) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Appointment encounter requires one participant Source: 5.1 CONF-DK-APD:4ec7.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-9245-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:code">
      <assert id="APD-DK-2.0.1-9245" test="@code=('MunicipalityAppointment','RegionalAppointment','PractitionerAppointment')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf">Appointment category must use the published MedCom codes Source: 5.1 CONF-DK-APD:9245; errata item 5.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-ed37-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:code">
      <assert id="APD-DK-2.0.1-ed37" test="@codeSystem = '1.2.208.184.100.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Appointment category must use the MedCom code system Source: 5.1 CONF-DK-APD:ed37.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-0da6-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:statusCode">
      <assert id="APD-DK-2.0.1-0da6" test="@code = 'active'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Appointment encounter status must be active Source: 5.1 CONF-DK-APD:0da6.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-8bfe-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:effectiveTime">
      <assert id="APD-DK-2.0.1-8bfe" test="count(v3:low) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Encounter interval requires one low Source: 5.1 CONF-DK-APD:8bfe.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-5df9-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:effectiveTime">
      <assert id="APD-DK-2.0.1-5df9" test="count(v3:high) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Encounter interval requires one high Source: 5.1 CONF-DK-APD:5df9.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-6f0d-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:performer">
      <assert id="APD-DK-2.0.1-6f0d" test="count(v3:assignedEntity) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf">Performer requires one assignedEntity Source: errata item 17, CONF-DK-APD:6f0d.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-ad1e-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:performer/v3:assignedEntity">
      <assert id="APD-DK-2.0.1-ad1e" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf">Performer requires one id Source: errata item 17, CONF-DK-APD:ad1e.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-cd01-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:performer/v3:assignedEntity">
      <assert id="APD-DK-2.0.1-cd01" test="count(v3:addr) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf">Performer requires one addr Source: errata item 17, CONF-DK-APD:cd01.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-bf38-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:performer/v3:assignedEntity">
      <assert id="APD-DK-2.0.1-bf38" test="count(v3:telecom) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf">Performer requires one telecom Source: errata item 17, CONF-DK-APD:bf38.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-0d10-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:performer/v3:assignedEntity">
      <assert id="APD-DK-2.0.1-0d10" test="count(v3:representedOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf">Performer requires one representedOrganization Source: errata item 17, CONF-DK-APD:0d10.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-b770-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:performer/v3:assignedEntity/v3:representedOrganization">
      <assert id="APD-DK-2.0.1-b770" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf">Performer requires one name Source: errata item 17, CONF-DK-APD:b770.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-44cd-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:participant">
      <assert id="APD-DK-2.0.1-44cd" test="count(v3:participantRole) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Location requires one participantRole Source: 5.3.1 CONF-DK-APD:44cd.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-7dc2-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:participant/v3:participantRole">
      <assert id="APD-DK-2.0.1-7dc2" test="@classCode = 'SDLOC'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Location role must be SDLOC Source: 5.3.1 CONF-DK-APD:7dc2.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-LOCATION-TYPE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:participant">
      <assert id="APD-DK-2.0.1-LOCATION-TYPE" test="@typeCode=('LOC','SBJ','DST')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Location participation must be LOC, SBJ or DST Source: 5.1 CONF-DK-APD:889e/9b47/F98b.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-3315-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:participant/v3:participantRole[../@typeCode='LOC']">
      <assert id="APD-DK-2.0.1-3315" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">SOR location requires one id Source: 5.3.2 CONF-DK-APD:3315.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-ff1c-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:participant/v3:participantRole[../@typeCode='LOC']">
      <assert id="APD-DK-2.0.1-ff1c" test="count(v3:addr) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">SOR location requires one addr Source: 5.3.2 CONF-DK-APD:ff1c.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-c7e3-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:participant/v3:participantRole[../@typeCode='LOC']">
      <assert id="APD-DK-2.0.1-c7e3" test="count(v3:telecom) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">SOR location requires one telecom Source: 5.3.2 CONF-DK-APD:c7e3.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-91ea-062f-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:participant/v3:participantRole/v3:id">
      <assert id="APD-DK-2.0.1-91ea-062f" test="@root='1.2.208.176.1.1' and normalize-space(@extension)!='' and @assigningAuthorityName='SOR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Location identifiers must identify SOR entries Source: 5.3 CONF-DK-APD:91ea/4862/062f.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-d9a4-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:participant/v3:participantRole">
      <assert id="APD-DK-2.0.1-d9a4" test="count(v3:playingEntity) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Location requires one playingEntity Source: 5.3 CONF-DK-APD:d9a4.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-87c3-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:participant/v3:participantRole/v3:playingEntity">
      <assert id="APD-DK-2.0.1-87c3" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Location requires one name element Source: 5.3 CONF-DK-APD:87c3.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-ae0f-68a1-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter">
      <assert id="APD-DK-2.0.1-ae0f-68a1" test="count(v3:entryRelationship[@typeCode='RSON']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Appointment requires one reason relationship Source: 5.1 CONF-DK-APD:ae0f/68a1.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-250e-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:entryRelationship[@typeCode='RSON']">
      <assert id="APD-DK-2.0.1-250e" test="count(v3:observation) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Reason requires one observation Source: 5.1 CONF-DK-APD:250e.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-c362-7e02-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:entryRelationship[@typeCode='RSON']/v3:observation">
      <assert id="APD-DK-2.0.1-c362-7e02" test="@classCode='OBS' and @moodCode='EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Reason observation must be OBS/EVN Source: 5.1 CONF-DK-APD:c362/7e02.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-8993-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:entryRelationship[@typeCode='RSON']/v3:observation">
      <assert id="APD-DK-2.0.1-8993" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Reason requires one code element Source: 5.1 CONF-DK-APD:8993.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-4c2c-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:entryRelationship[@typeCode='RSON']/v3:observation/v3:code">
      <assert id="APD-DK-2.0.1-4c2c" test="normalize-space(@displayName)!=''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Reason needs a readable displayName Source: 5.1 CONF-DK-APD:4c2c/a7d3.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-8768-4c94-bb46-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:precondition[v3:templateId/@root='1.2.208.184.14.11.4']">
      <assert id="APD-DK-2.0.1-8768-4c94-bb46" test="count(v3:templateId[@root='1.2.208.184.14.11.4'][@extension='2019-09-10'])=1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Appointment precondition needs its dated template Source: 5.4/5.5 CONF-DK-APD:8768-4c94-bb46.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-CRITERION-4-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:precondition[v3:templateId/@root='1.2.208.184.14.11.4']">
      <assert id="APD-DK-2.0.1-CRITERION-4" test="count(v3:criterion) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Precondition requires one criterion Source: 5.4/5.5 CONF-DK-APD:4464/488b.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-CODE-4-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:precondition[v3:templateId/@root='1.2.208.184.14.11.4']/v3:criterion">
      <assert id="APD-DK-2.0.1-CODE-4" test="count(v3:code)=1 and v3:code/@code='RepeatingDocumentType' and v3:code/@codeSystem='1.2.208.184.100.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Precondition must use RepeatingDocumentType in the MedCom code system Source: 5.4/5.5 CONF-DK-APD:72b5/e3ff/2b78/ab85.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-d425-e881-e24d-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:precondition[v3:templateId/@root='1.2.208.184.14.11.5']">
      <assert id="APD-DK-2.0.1-d425-e881-e24d" test="count(v3:templateId[@root='1.2.208.184.14.11.5'][@extension='2019-09-10'])=1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Appointment precondition needs its dated template Source: 5.4/5.5 CONF-DK-APD:d425-e881-e24d.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-CRITERION-5-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:precondition[v3:templateId/@root='1.2.208.184.14.11.5']">
      <assert id="APD-DK-2.0.1-CRITERION-5" test="count(v3:criterion) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Precondition requires one criterion Source: 5.4/5.5 CONF-DK-APD:4464/488b.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-CODE-5-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:precondition[v3:templateId/@root='1.2.208.184.14.11.5']/v3:criterion">
      <assert id="APD-DK-2.0.1-CODE-5" test="count(v3:code)=1 and v3:code/@code='GuidedIntervalType' and v3:code/@codeSystem='1.2.208.184.100.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Precondition must use GuidedIntervalType in the MedCom code system Source: 5.4/5.5 CONF-DK-APD:72b5/e3ff/2b78/ab85.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-d38c-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:precondition[v3:templateId/@root='1.2.208.184.14.11.4']/v3:criterion">
      <assert id="APD-DK-2.0.1-d38c" test="count(v3:value)&lt;=1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf">A repetition identifier remains optional and singular Source: errata item 16, CONF-DK-APD:d38c.</assert>
    </rule>
  </pattern>
  <pattern id="APD-DK-2.0.1-40c2-b4af-6245-4b55-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:encounter/v3:precondition[v3:templateId/@root='1.2.208.184.14.11.4']/v3:criterion/v3:value">
      <assert id="APD-DK-2.0.1-40c2-b4af-6245-4b55" test="@nullFlavor or (resolve-QName(@xsi:type, .) = QName('urn:hl7-org:v3', 'II') and @root='1.2.208.184' and matches(@extension, '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$') and @assigningAuthorityName='MedCom')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf">Supplied repetition identifier must be an II with a UUID extension Source: 5.4 CONF-DK-APD:40c2/b4af/6245/4b55.</assert>
    </rule>
  </pattern>
</schema>