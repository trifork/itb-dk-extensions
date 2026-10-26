<?xml version="1.0" encoding="UTF-8"?>
<!-- Source: https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v3.0.0.pdf -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:title>PDC-DK 3.0.0 release identity checks</sch:title>
  <sch:ns prefix="v3" uri="urn:hl7-org:v3" />
  <sch:pattern id="pdc.v3.0.0">
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="CDA-DK-PROFILE-TEMPLATE" flag="error" test="count(v3:templateId[@root='1.2.208.184.16.1']) = 1">PDC-DK 3.0.0 requires the document template 1.2.208.184.16.1.</sch:assert>
      <sch:assert id="PDC-DK-3.0.0-524" flag="error" test="exists(v3:templateId[@root='1.2.208.184.16.1'])">PDC-DK 3.0.0 requires extension 3.0 on its document template (CONF-DK:524).</sch:assert>
    </sch:rule>
    <sch:rule context="v3:ClinicalDocument/v3:templateId[@root='1.2.208.184.16.1']">
      <sch:assert id="PDC-DK-3.0.0-524" flag="error" test="@extension = '3.0'">PDC-DK 3.0.0 requires extension 3.0 on its document template (CONF-DK:524).</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="pdc-v3.0.0-version-location">
    <!-- Check declarations where they occur; keep the same release and cardinality requirements. -->
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'pdc-v') or ../v3:templateId/@root='1.2.208.184.10.1.10']">
      <sch:let name="document" value="ancestor::v3:ClinicalDocument"/>
      <sch:assert id="CDA-DK-PROFILE-VERSION" flag="error" test="count($document/v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'pdc-v')]) = 1 and $document/v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'pdc-v')]/@extension = 'pdc-v3.0'">Selected target PDC-DK 3.0.0 requires exactly one profile version declaration 'pdc-v3.0' in documentationOf/serviceEvent/id. Source: 2.1 CONF-DK:524; 2.1.9 version example.</sch:assert>
    </sch:rule>
    <!-- Missing declarations have no source node. Prefer the version serviceEvent,
         then the nearest existing container, and emit only one missing finding. -->
    <sch:rule context="v3:ClinicalDocument | v3:ClinicalDocument/v3:documentationOf | v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent">
      <sch:let name="document" value="ancestor-or-self::v3:ClinicalDocument"/>
      <sch:let name="container" value="($document/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10'], $document/v3:documentationOf/v3:serviceEvent, $document/v3:documentationOf, $document)[1]"/>
      <sch:assert id="CDA-DK-PROFILE-VERSION" flag="error" test="not(. is $container) or exists($document/v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'pdc-v') or ../v3:templateId/@root='1.2.208.184.10.1.10'])">Selected target PDC-DK 3.0.0 requires exactly one profile version declaration 'pdc-v3.0' in documentationOf/serviceEvent/id. Source: 2.1 CONF-DK:524; 2.1.9 version example.</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
