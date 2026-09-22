<?xml version='1.0' encoding='UTF-8'?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>PHMR-DK-2.1.0 source-derived conformance checks</title>
  <ns prefix="v3" uri="urn:hl7-org:v3" />
  <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance" />
  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema" />
  <pattern id="PHMR-DK-2.1.0-INTERNATIONAL-TEMPLATE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHMR-DK-2.1.0-INTERNATIONAL-TEMPLATE" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.9']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">Require one declaration of template 2.16.840.1.113883.10.20.9 Source: 2.1 national and international template declarations.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-DANISH-TEMPLATE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHMR-DK-2.1.0-DANISH-TEMPLATE" test="count(v3:templateId[@root='1.2.208.184.11.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">Require one declaration of template 1.2.208.184.11.1 Source: 2.1 national and international template declarations.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-DOCUMENT-CODE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHMR-DK-2.1.0-DOCUMENT-CODE" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR requires one document code Source: 2.1.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-CODE-code-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PHMR-DK-2.1.0-CODE-code" test="@code = '53576-5'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR document @code must be 53576-5 Source: 2.1.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-CODE-codeSystem-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PHMR-DK-2.1.0-CODE-codeSystem" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR document @codeSystem must be 2.16.840.1.113883.6.1 Source: 2.1.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-SERVICE-EVENT-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHMR-DK-2.1.0-SERVICE-EVENT" test="exists(v3:documentationOf/v3:serviceEvent)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR requires a monitoring service event Source: 2.2.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-SERVICE-MPROT-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent">
      <assert id="PHMR-DK-2.1.0-SERVICE-MPROT" test="@classCode = 'MPROT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR service events must be monitoring programmes Source: 2.2 CONF-PHMR-DK-50/60/70.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-MONITORING-INTERVAL-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHMR-DK-2.1.0-MONITORING-INTERVAL" test="exists(v3:documentationOf/v3:serviceEvent/v3:effectiveTime)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR needs the monitoring period Source: 2.2.1.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-STRUCTURED-BODY-pattern">
    <rule context="v3:ClinicalDocument/v3:component">
      <assert id="PHMR-DK-2.1.0-STRUCTURED-BODY" test="count(v3:structuredBody) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR requires a structured body Source: 3 CONF-PHMR-DK-80.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-C6-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PHMR-DK-2.1.0-C6" test="matches(@extension, '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR document identifier must be a UUID version 4 Source: 2.1.2 CONF-PHMR-DK-6.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-ID-root-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PHMR-DK-2.1.0-ID-root" test="normalize-space(@root) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">@root must be present and non-empty Source: 2.1.2 CONF-PHMR-DK-7/8.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-ID-assigningAuthorityName-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PHMR-DK-2.1.0-ID-assigningAuthorityName" test="normalize-space(@assigningAuthorityName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">@assigningAuthorityName must be present and non-empty Source: 2.1.2 CONF-PHMR-DK-7/8.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-C12-13-codeSystemName-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PHMR-DK-2.1.0-C12-13-codeSystemName" test="@codeSystemName = 'LOINC'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR document @codeSystemName must be LOINC Source: 2.1.3 CONF-PHMR-DK-12/13.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-C12-13-displayName-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PHMR-DK-2.1.0-C12-13-displayName" test="@displayName = 'Personal Health Monitoring Report'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR document @displayName must be Personal Health Monitoring Report Source: 2.1.3 CONF-PHMR-DK-12/13.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-TITLE-pattern">
    <rule context="v3:ClinicalDocument/v3:title">
      <assert id="PHMR-DK-2.1.0-TITLE" test="normalize-space(.)='Hjemmemålinger'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR title must be Hjemmemålinger Source: 2.1.4.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-C78-pattern">
    <rule context="v3:ClinicalDocument/v3:component">
      <assert id="PHMR-DK-2.1.0-C78" test="@typeCode = 'COMP'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR @typeCode must be COMP Source: 3 CONF-PHMR-DK-78.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-C81-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PHMR-DK-2.1.0-C81" test="@classCode = 'DOCBODY'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR @classCode must be DOCBODY Source: 3 CONF-PHMR-DK-81.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-C82-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="PHMR-DK-2.1.0-C82" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR @moodCode must be EVN Source: 3 CONF-PHMR-DK-82.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-C85-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component">
      <assert id="PHMR-DK-2.1.0-C85" test="@typeCode = 'COMP'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR @typeCode must be COMP Source: 3 CONF-PHMR-DK-85.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-C87-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
      <assert id="PHMR-DK-2.1.0-C87" test="@classCode = 'DOCSECT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR @classCode must be DOCSECT Source: 3 CONF-PHMR-DK-87.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-C88-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
      <assert id="PHMR-DK-2.1.0-C88" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR @moodCode must be EVN Source: 3 CONF-PHMR-DK-88.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-C86-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component">
      <assert id="PHMR-DK-2.1.0-C86" test="count(v3:section) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR component requires one section Source: 3 CONF-PHMR-DK-86.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-C93-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
      <assert id="PHMR-DK-2.1.0-C94" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR section requires one code Source: 4 CONF-PHMR-DK-94.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-C101-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
      <assert id="PHMR-DK-2.1.0-C101" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR section requires one title Source: 4 CONF-PHMR-DK-101.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-C104-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
      <assert id="PHMR-DK-2.1.0-C104" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR section requires one text Source: 4 CONF-PHMR-DK-104.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-C105-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
      <assert id="PHMR-DK-2.1.0-C105" test="exists(v3:entry)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR section requires at least one entry Source: 4 CONF-PHMR-DK-105.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-SECTION-CODE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:code">
      <assert id="PHMR-DK-2.1.0-SECTION-CODE" test="@code=('8716-3','30954-2') and @codeSystem='2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf">PHMR section must identify Vital signs or Results in LOINC Source: 4 CONF-PHMR-DK-95–97.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-2.1.0-PROTOCOL-MEASUREMENT-INDEX-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:organizer/v3:component/v3:observation/v3:code">
      <assert id="PHMR-DK-2.1.0-PROTOCOL-MEASUREMENT-INDEX" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Testprotokol/PHMR_Testprotokol_Afsendelse.docx" test="some $header in /v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent/v3:code satisfies ($header/@code = @code and $header/@codeSystem = @codeSystem)">Each body measurement code and code system must be represented in a header service event. Source: PHMR sender test protocol, documentationOf measurement-code test; PHMR-DK 2.1.0 section 2.2.3.</assert>
    </rule>
  </pattern>
</schema>