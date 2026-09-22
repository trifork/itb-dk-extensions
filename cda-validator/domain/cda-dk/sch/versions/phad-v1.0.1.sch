<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:title>PHAD-DK 1.0.1 release identity checks</sch:title>
  <sch:ns prefix="v3" uri="urn:hl7-org:v3"/>
  <sch:pattern id="phad.v1.0.1">
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="CDA-DK-PROFILE-TEMPLATE" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf" test="count(v3:templateId[@root='1.2.208.184.22.1']) = 1">Selected target PHAD-DK 1.0.1 requires document template 1.2.208.184.22.1. Source: 2.1.1 / 3.1.</sch:assert>

    </sch:rule>
  </sch:pattern>
</sch:schema>
