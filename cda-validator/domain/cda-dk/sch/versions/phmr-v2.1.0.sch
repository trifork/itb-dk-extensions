<?xml version="1.0" encoding="UTF-8"?>
<!-- Source: https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:title>PHMR-DK 2.1.0 release identity checks</sch:title>
  <sch:ns prefix="v3" uri="urn:hl7-org:v3" />
  <sch:pattern id="phmr.v2.1.0">
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="CDA-DK-PROFILE-TEMPLATE" flag="error" test="count(v3:templateId[@root='1.2.208.184.11.1']) = 1">PHMR-DK 2.1.0 requires the document template 1.2.208.184.11.1.</sch:assert>
      <sch:assert id="PHMR-DK-2.1.0-1" flag="error" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.9']) = 1">PHMR-DK 2.1.0 requires the international PHMR document template (CONF-PHMR-DK-1/2).</sch:assert>
      <sch:assert id="PHMR-DK-2.1.0-LEGAL-AUTHENTICATOR" flag="error" test="count(v3:legalAuthenticator) &lt;= 1">PHMR-DK 2.1.0 permits zero or one legalAuthenticator (section 2.1.12).</sch:assert>
      <!-- Missing elements have no source line; report these at the closest existing parent. -->
      <sch:assert id="CDA-DK-PROFILE-VERSION" flag="error" test="exists(v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'phmr-v')])">Selected target PHMR-DK 2.1.0 requires a profile version declaration 'phmr-v2.1' in documentationOf/serviceEvent/id (CONF-PHMR-DK-57 through 66).</sch:assert>
      <sch:assert id="PHMR-DK-2.1.0-83" flag="error" test="exists(v3:component)">PHMR-DK 2.1.0 requires a structured body with one or two sections (CONF-PHMR-DK-83); the document component is missing.</sch:assert>
    </sch:rule>
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent/v3:code | v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:organizer/v3:component/v3:observation/v3:code">
      <sch:assert id="PHMR-DK-2.1.0-MCS-CODESYSTEM" flag="error" test="not(starts-with(@code, 'MCS')) or @codeSystem = '1.2.208.184.100.8'">PHMR-DK 2.1.0 uses code system 1.2.208.184.100.8 for MCS measurement codes (CONF-PHMR-DK-75/133).</sch:assert>
      <sch:assert id="PHMR-DK-2.1.0-NPU-CODESYSTEM" flag="error" test="not(starts-with(@code, 'NPU') or starts-with(@code, 'DNK')) or @codeSystem = '1.2.208.176.2.1'">PHMR-DK 2.1.0 uses code system 1.2.208.176.2.1 for NPU and DNK measurements (CONF-PHMR-DK-74/132).</sch:assert>
    </sch:rule>
    <!-- Check existing declarations at the id itself, including duplicate declarations. -->
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'phmr-v')]">
      <sch:assert id="CDA-DK-PROFILE-VERSION" flag="error" test="@extension = 'phmr-v2.1' and count(../../../v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'phmr-v')]) = 1">Selected target PHMR-DK 2.1.0 expects a single declaration 'phmr-v2.1'; found '<sch:value-of select="@extension"/>'. Check the version and remove any duplicate PHMR declarations.</sch:assert>
    </sch:rule>
    <sch:rule context="v3:ClinicalDocument/v3:component">
      <sch:assert id="PHMR-DK-2.1.0-83" flag="error" test="exists(v3:structuredBody)">PHMR-DK 2.1.0 requires a structured body with one or two sections (CONF-PHMR-DK-83); structuredBody is missing.</sch:assert>
    </sch:rule>
    <sch:rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <sch:assert id="PHMR-DK-2.1.0-83" flag="error" test="count(v3:component) &gt;= 1 and count(v3:component) &lt;= 2">PHMR-DK 2.1.0 requires one or two body sections (CONF-PHMR-DK-83); found <sch:value-of select="count(v3:component)"/>.</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
