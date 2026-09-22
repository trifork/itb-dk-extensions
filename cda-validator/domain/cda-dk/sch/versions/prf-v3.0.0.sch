<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:title>PRF-DK 3.0.0 release identity checks</sch:title>
  <sch:ns prefix="v3" uri="urn:hl7-org:v3"/>
  <sch:pattern id="prf.v3.0.0">
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="CDA-DK-PROFILE-TEMPLATE" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf" test="count(v3:templateId[@root='1.2.208.184.19.1']) = 1">Selected target PRF-DK 3.0.0 requires document template 1.2.208.184.19.1. Source: 2.1.1 / 3.1.</sch:assert>
<sch:assert id="CDA-DK-PROFILE-VERSION" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf" test="count(v3:documentationOf/v3:serviceEvent/v3:id[@extension='PRF-v3.0']) = 1">Selected target PRF-DK 3.0.0 requires one PRF-v3.0 profile version declaration. Source: 2.1.9.1.</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
