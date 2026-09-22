<?xml version='1.0' encoding='UTF-8'?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>PHAD-DK-1.0.1 source-derived conformance checks</title>
  <ns prefix="v3" uri="urn:hl7-org:v3" />
  <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance" />
  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema" />
  <pattern id="PHAD-DK-1.0.1-TEMPLATE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHAD-DK-1.0.1-TEMPLATE" test="count(v3:templateId[@root='1.2.208.184.22.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">Require one declaration of template 1.2.208.184.22.1 Source: 2.1.1; 3.1 CONF:2 (template extension conflicting with revision history).</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-HEADER-id-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHAD-DK-1.0.1-HEADER-id" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD requires one id Source: 2.1.2–2.1.4.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-HEADER-code-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHAD-DK-1.0.1-HEADER-code" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD requires one code Source: 2.1.2–2.1.4.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-HEADER-title-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHAD-DK-1.0.1-HEADER-title" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD requires one title Source: 2.1.2–2.1.4.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-ID-root-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PHAD-DK-1.0.1-ID-root" test="normalize-space(@root) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">@root must be present and non-empty Source: 2.1.2 CONF H:1/H:2.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-ID-assigningAuthorityName-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="PHAD-DK-1.0.1-ID-assigningAuthorityName" test="normalize-space(@assigningAuthorityName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">@assigningAuthorityName must be present and non-empty Source: 2.1.2 CONF H:1/H:2.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-CODE-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PHAD-DK-1.0.1-CODE" test="@code = '103140-0'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD document code must be 103140-0 Source: 2.1.4.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-CODE-SYSTEM-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="PHAD-DK-1.0.1-CODE-SYSTEM" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD document code must use LOINC Source: 2.1.4.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-H3-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHAD-DK-1.0.1-H3" test="count(v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD requires one validity interval event Source: 2.1.5 CONF H3.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-H4-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHAD-DK-1.0.1-H4" test="count(v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD requires one profile version event Source: 2.1.5 CONF H4.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-H8-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime">
      <assert id="PHAD-DK-1.0.1-H8" test="count(v3:low) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD requires one low Source: 2.1.5 CONF H8.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-H10-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime">
      <assert id="PHAD-DK-1.0.1-H10" test="count(v3:high) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD requires one high Source: 2.1.5 CONF H10.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-TIME-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']">
      <assert id="PHAD-DK-1.0.1-TIME" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD requires one effectiveTime Source: 2.1.5 CONF TIME.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-H14-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']">
      <assert id="PHAD-DK-1.0.1-H14" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD requires one id Source: 2.1.5 CONF H14.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-H9-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:low">
      <assert id="PHAD-DK-1.0.1-H9" test="normalize-space(@value) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">@value must be present and non-empty Source: 2.1.5.1 CONF H:9.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-H11-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:high">
      <assert id="PHAD-DK-1.0.1-H11" test="@value or @nullFlavor" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">Validity end needs a value or nullFlavor Source: 2.1.5.1 CONF H:11.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-H15-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="PHAD-DK-1.0.1-H15" test="@root = '1.2.208.184'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD version identifier root must be 1.2.208.184 Source: 2.1.5.2 CONF H:15.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-H17-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="PHAD-DK-1.0.1-H17" test="@assigningAuthorityName = 'MedCom'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD version authority must be MedCom Source: 2.1.5.2 CONF H:17.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-H16-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="PHAD-DK-1.0.1-H16" test="@extension=('phad-v1.0','phad-v1.0.0')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD version must use a marker printed in the guide; the guide disagrees between phad-v1.0 and phad-v1.0.0 Source: 2.1.5.2 CONF H:16, prose/table conflict.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-C3-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="PHAD-DK-1.0.1-C3" test="count(v3:component) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD requires one component Source: 3.1 CONF:3.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-C4-pattern">
    <rule context="v3:ClinicalDocument/v3:component">
      <assert id="PHAD-DK-1.0.1-C4" test="count(v3:nonXMLBody) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD requires one nonXMLBody Source: 3.1 CONF:4.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-C5-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:nonXMLBody">
      <assert id="PHAD-DK-1.0.1-C5" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD requires one text Source: 3.1 CONF:5.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-C6-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:nonXMLBody/v3:text">
      <assert id="PHAD-DK-1.0.1-C6" test="@mediaType = 'application/pdf'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD attachment must be a PDF Source: 3.1 Table 5 CONF:6.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-C7-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:nonXMLBody/v3:text">
      <assert id="PHAD-DK-1.0.1-C7" test="@representation = 'B64'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD attachment must be Base64 encoded Source: 3.1 Table 5 CONF:7.</assert>
    </rule>
  </pattern>
  <pattern id="PHAD-DK-1.0.1-PDF-BASE64-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:nonXMLBody/v3:text">
      <assert id="PHAD-DK-1.0.1-PDF-BASE64" test="normalize-space(.) castable as xs:base64Binary" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf">PHAD attachment text must contain valid Base64 Source: 3.1 CONF:7.</assert>
    </rule>
  </pattern>
</schema>