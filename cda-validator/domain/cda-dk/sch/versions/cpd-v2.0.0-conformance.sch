<?xml version='1.0' encoding='UTF-8'?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>CPD-DK-2.0.0 source-derived conformance checks</title>
  <ns prefix="v3" uri="urn:hl7-org:v3" />
  <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance" />
  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema" />
  <pattern id="CPD-DK-2.0.0-DOCUMENT-TEMPLATE-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="CPD-DK-2.0.0-DOCUMENT-TEMPLATE" test="count(v3:templateId[@root='1.2.208.184.15.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Require one declaration of template 1.2.208.184.15.1 Source: 2.1.1; 3.1 (C1 root typo, national root from header).</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-ID-root-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="CPD-DK-2.0.0-ID-root" test="normalize-space(@root) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">@root must be present and non-empty Source: 2.1.2 CONF H:1/H:2.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-ID-assigningAuthorityName-pattern">
    <rule context="v3:ClinicalDocument/v3:id">
      <assert id="CPD-DK-2.0.0-ID-assigningAuthorityName" test="normalize-space(@assigningAuthorityName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">@assigningAuthorityName must be present and non-empty Source: 2.1.2 CONF H:1/H:2.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-DOCUMENT-CODE-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="CPD-DK-2.0.0-DOCUMENT-CODE" test="@code = '81215-6'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Care plan document code must be 81215-6 Source: 2.1.4.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-DOCUMENT-LOINC-pattern">
    <rule context="v3:ClinicalDocument/v3:code">
      <assert id="CPD-DK-2.0.0-DOCUMENT-LOINC" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Care plan document code must use LOINC Source: 2.1.4.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-H3-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="CPD-DK-2.0.0-H3" test="count(v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">CPD requires one validity interval event Source: 2.1.5 CONF H3.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-H4-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="CPD-DK-2.0.0-H4" test="count(v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">CPD requires one profile version event Source: 2.1.5 CONF H4.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-H8-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime">
      <assert id="CPD-DK-2.0.0-H8" test="count(v3:low) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">CPD requires one low Source: 2.1.5 CONF H8.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-H10-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime">
      <assert id="CPD-DK-2.0.0-H10" test="count(v3:high) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">CPD requires one high Source: 2.1.5 CONF H10.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-TIME-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']">
      <assert id="CPD-DK-2.0.0-TIME" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">CPD requires one effectiveTime Source: 2.1.5 CONF TIME.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-H14-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']">
      <assert id="CPD-DK-2.0.0-H14" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">CPD requires one id Source: 2.1.5 CONF H14.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-H9-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:low">
      <assert id="CPD-DK-2.0.0-H9" test="normalize-space(@value) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">@value must be present and non-empty Source: 2.1.5.1 CONF H:9.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-H11-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.11']/v3:effectiveTime/v3:high">
      <assert id="CPD-DK-2.0.0-H11" test="@value or @nullFlavor" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Care plan end needs a value or nullFlavor Source: 2.1.5.1 CONF H:11.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-VERSION-root-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="CPD-DK-2.0.0-VERSION-root" test="@root = '1.2.208.184'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">CPD version @root must be 1.2.208.184 Source: 2.1.5.2 CONF H:15–17, table (prose marker typo).</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-VERSION-extension-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="CPD-DK-2.0.0-VERSION-extension" test="@extension = 'cpd-v2.0.0'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">CPD version @extension must be cpd-v2.0.0 Source: 2.1.5.2 CONF H:15–17, table (prose marker typo).</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-VERSION-assigningAuthorityName-pattern">
    <rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10']/v3:id">
      <assert id="CPD-DK-2.0.0-VERSION-assigningAuthorityName" test="@assigningAuthorityName = 'MedCom'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">CPD version @assigningAuthorityName must be MedCom Source: 2.1.5.2 CONF H:15–17, table (prose marker typo).</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C4-pattern">
    <rule context="v3:ClinicalDocument">
      <assert id="CPD-DK-2.0.0-C4" test="count(v3:component) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Care plan requires one component Source: 3.1 CONF:4.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C5-pattern">
    <rule context="v3:ClinicalDocument/v3:component">
      <assert id="CPD-DK-2.0.0-C5" test="count(v3:structuredBody) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Care plan requires one structuredBody Source: 3.1 CONF:5.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-SECTION-1-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="CPD-DK-2.0.0-SECTION-1" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Health concerns section cardinality must follow the document template Source: 3.1 CONF:6–13.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C15-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.1']">
      <assert id="CPD-DK-2.0.0-C15" test="count(v3:templateId[@root='1.2.208.184.15.1.10.20.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Require one declaration of template 1.2.208.184.15.1.10.20.1 Source: 4.1 CONF:15–17.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C15-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.1']/v3:templateId[@root='1.2.208.184.15.1.10.20.1']">
      <assert id="CPD-DK-2.0.0-C15-DATE" test="@extension = '2018-09-28'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Template 1.2.208.184.15.1.10.20.1 must use 2018-09-28 Source: 4.1 CONF:15–17.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C18-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.1']">
      <assert id="CPD-DK-2.0.0-C18" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Health concerns section requires one code Source: 4.1 CONF:18.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C21-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.1']">
      <assert id="CPD-DK-2.0.0-C21" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Health concerns section requires one title Source: 4.1 CONF:21.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C22-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.1']">
      <assert id="CPD-DK-2.0.0-C22" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Health concerns section requires one text Source: 4.1 CONF:22.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C19-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.1']/v3:code">
      <assert id="CPD-DK-2.0.0-C19" test="@code = '75310-3'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Health concerns section @code must be 75310-3 Source: 4.1 CONF:19.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C20-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.1']/v3:code">
      <assert id="CPD-DK-2.0.0-C20" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Health concerns section @codeSystem must be 2.16.840.1.113883.6.1 Source: 4.1 CONF:20.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C241-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.1']">
      <assert id="CPD-DK-2.0.0-C241" test="v3:entry/v3:observation[v3:templateId/@root='1.2.208.184.15.1.10.20.1.20'] or v3:entry/v3:act[v3:templateId/@root='1.2.208.184.15.1.10.20.1.21']" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Health concerns needs a Health Status Observation or Health Concern Act Source: 4.1 CONF:241.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-SECTION-2-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="CPD-DK-2.0.0-SECTION-2" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Goals section cardinality must follow the document template Source: 3.1 CONF:6–13.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C28-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.2']">
      <assert id="CPD-DK-2.0.0-C28" test="count(v3:templateId[@root='1.2.208.184.15.1.10.20.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Require one declaration of template 1.2.208.184.15.1.10.20.2 Source: 4.2 CONF:28–30.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C28-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.2']/v3:templateId[@root='1.2.208.184.15.1.10.20.2']">
      <assert id="CPD-DK-2.0.0-C28-DATE" test="@extension = '2018-09-28'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Template 1.2.208.184.15.1.10.20.2 must use 2018-09-28 Source: 4.2 CONF:28–30.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C31-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.2']">
      <assert id="CPD-DK-2.0.0-C31" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Goals section requires one code Source: 4.2 CONF:31.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C34-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.2']">
      <assert id="CPD-DK-2.0.0-C34" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Goals section requires one title Source: 4.2 CONF:34.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C35-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.2']">
      <assert id="CPD-DK-2.0.0-C35" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Goals section requires one text Source: 4.2 CONF:35.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C32-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.2']/v3:code">
      <assert id="CPD-DK-2.0.0-C32" test="@code = '61146-7'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Goals section @code must be 61146-7 Source: 4.2 CONF:32.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C33-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.2']/v3:code">
      <assert id="CPD-DK-2.0.0-C33" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Goals section @codeSystem must be 2.16.840.1.113883.6.1 Source: 4.2 CONF:33.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C36-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.2']">
      <assert id="CPD-DK-2.0.0-C36" test="exists(v3:entry)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Goals section needs at least one entry Source: 4.2 CONF:36.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C37-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.2']/v3:entry">
      <assert id="CPD-DK-2.0.0-C37" test="count(v3:observation[v3:templateId/@root='1.2.208.184.15.1.10.20.2.20'])=1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Goals entry requires its prescribed observation Source: 4.2 CONF:37.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-SECTION-3-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="CPD-DK-2.0.0-SECTION-3" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.3']) = 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Interventions section cardinality must follow the document template Source: 3.1 CONF:6–13.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C38-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.3']">
      <assert id="CPD-DK-2.0.0-C38" test="count(v3:templateId[@root='1.2.208.184.15.1.10.20.3']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Require one declaration of template 1.2.208.184.15.1.10.20.3 Source: 4.3 CONF:38–40.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C38-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.3']/v3:templateId[@root='1.2.208.184.15.1.10.20.3']">
      <assert id="CPD-DK-2.0.0-C38-DATE" test="@extension = '2018-09-28'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Template 1.2.208.184.15.1.10.20.3 must use 2018-09-28 Source: 4.3 CONF:38–40.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C41-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.3']">
      <assert id="CPD-DK-2.0.0-C41" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Interventions section requires one code Source: 4.3 CONF:41.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C44-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.3']">
      <assert id="CPD-DK-2.0.0-C44" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Interventions section requires one title Source: 4.3 CONF:44.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C45-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.3']">
      <assert id="CPD-DK-2.0.0-C45" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Interventions section requires one text Source: 4.3 CONF:45.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C42-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.3']/v3:code">
      <assert id="CPD-DK-2.0.0-C42" test="@code = '62387-6'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Interventions section @code must be 62387-6 Source: 4.3 CONF:42.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C43-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.3']/v3:code">
      <assert id="CPD-DK-2.0.0-C43" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Interventions section @codeSystem must be 2.16.840.1.113883.6.1 Source: 4.3 CONF:43.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C46-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.3']">
      <assert id="CPD-DK-2.0.0-C46" test="exists(v3:entry)" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Interventions section needs at least one entry Source: 4.3 CONF:46.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C47-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.3']/v3:entry">
      <assert id="CPD-DK-2.0.0-C47" test="count(v3:act[v3:templateId/@root='1.2.208.184.15.1.10.20.3.20'])=1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Interventions entry requires its prescribed act Source: 4.3 CONF:47.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-SECTION-4-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <assert id="CPD-DK-2.0.0-SECTION-4" test="count(v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.4']) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Outcomes section cardinality must follow the document template Source: 3.1 CONF:6–13.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C49-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.4']">
      <assert id="CPD-DK-2.0.0-C49" test="count(v3:templateId[@root='1.2.208.184.15.1.10.20.4']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Require one declaration of template 1.2.208.184.15.1.10.20.4 Source: 4.4 CONF:49–51.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C49-DATE-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.4']/v3:templateId[@root='1.2.208.184.15.1.10.20.4']">
      <assert id="CPD-DK-2.0.0-C49-DATE" test="@extension = '2018-09-28'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Template 1.2.208.184.15.1.10.20.4 must use 2018-09-28 Source: 4.4 CONF:49–51.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C52-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.4']">
      <assert id="CPD-DK-2.0.0-C52" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Outcomes section requires one code Source: 4.4 CONF:52.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C55-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.4']">
      <assert id="CPD-DK-2.0.0-C55" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Outcomes section requires one title Source: 4.4 CONF:55.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C56-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.4']">
      <assert id="CPD-DK-2.0.0-C56" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Outcomes section requires one text Source: 4.4 CONF:56.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C53-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.4']/v3:code">
      <assert id="CPD-DK-2.0.0-C53" test="@code = '11383-7'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Outcomes section @code must be 11383-7 Source: 4.4 CONF:53.</assert>
    </rule>
  </pattern>
  <pattern id="CPD-DK-2.0.0-C54-pattern">
    <rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section[v3:templateId/@root='1.2.208.184.15.1.10.20.4']/v3:code">
      <assert id="CPD-DK-2.0.0-C54" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf">Outcomes section @codeSystem must be 2.16.840.1.113883.6.1 Source: 4.4 CONF:54.</assert>
    </rule>
  </pattern>
</schema>