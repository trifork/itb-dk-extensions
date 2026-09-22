<?xml version='1.0' encoding='UTF-8'?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>PHMR-DK-1.3 source-derived conformance checks</title>
  <ns prefix="v3" uri="urn:hl7-org:v3" />
  <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance" />
  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema" />
  <pattern id="PHMR-DK-1.3-INTERNATIONAL-TEMPLATE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHMR-DK-1.3-INTERNATIONAL-TEMPLATE" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.9']) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/!svn/bc/2690/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-Profile-v1.3.pdf">Require a declaration of template 2.16.840.1.113883.10.20.9 Source: 2.2–2.3 national and international template declarations.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-1.3-DANISH-TEMPLATE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHMR-DK-1.3-DANISH-TEMPLATE" test="count(v3:templateId[@root='1.2.208.184.11.1']) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/!svn/bc/2690/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-Profile-v1.3.pdf">Require a declaration of template 1.2.208.184.11.1 Source: 2.2–2.3 national and international template declarations.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-1.3-DOCUMENT-CODE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHMR-DK-1.3-DOCUMENT-CODE" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/!svn/bc/2690/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-Profile-v1.3.pdf">PHMR requires one document code Source: 2.2–2.3.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-1.3-CODE-code-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PHMR-DK-1.3-CODE-code" test="@code = '53576-5'" flag="error" see="https://svn.medcom.dk/svn/releases/!svn/bc/2690/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-Profile-v1.3.pdf">PHMR document @code must be 53576-5 Source: 2.2–2.3.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-1.3-CODE-codeSystem-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PHMR-DK-1.3-CODE-codeSystem" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/!svn/bc/2690/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-Profile-v1.3.pdf">PHMR document @codeSystem must be 2.16.840.1.113883.6.1 Source: 2.2–2.3.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-1.3-SERVICE-EVENT-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHMR-DK-1.3-SERVICE-EVENT" test="exists(v3:documentationOf/v3:serviceEvent)" flag="error" see="https://svn.medcom.dk/svn/releases/!svn/bc/2690/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-Profile-v1.3.pdf">PHMR requires a monitoring service event Source: 2.14 CONF-PHMR-40.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-1.3-SERVICE-MPROT-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent">
      <assert id="PHMR-DK-1.3-SERVICE-MPROT" test="@classCode = 'MPROT'" flag="error" see="https://svn.medcom.dk/svn/releases/!svn/bc/2690/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-Profile-v1.3.pdf">PHMR service events must be monitoring programmes Source: 2.14 CONF-PHMR-41.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-1.3-MONITORING-INTERVAL-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHMR-DK-1.3-MONITORING-INTERVAL" test="exists(v3:documentationOf/v3:serviceEvent/v3:effectiveTime)" flag="error" see="https://svn.medcom.dk/svn/releases/!svn/bc/2690/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-Profile-v1.3.pdf">PHMR needs the monitoring period Source: 2.14 CONF-PHMR-42.</assert>
    </rule>
  </pattern>
  <pattern id="PHMR-DK-1.3-STRUCTURED-BODY-pattern">
    <rule context="v3:ClinicalDocument/v3:component">
      <assert id="PHMR-DK-1.3-STRUCTURED-BODY" test="count(v3:structuredBody) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/!svn/bc/2690/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-Profile-v1.3.pdf">PHMR requires a structured body Source: 3.1 CONF-PHMR-43.</assert>
    </rule>
  </pattern>
</schema>