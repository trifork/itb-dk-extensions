<?xml version="1.0" encoding="UTF-8"?>
<!-- Source: https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:title>APD-DK 2.0.1 release identity checks</sch:title>
  <sch:ns prefix="v3" uri="urn:hl7-org:v3" />
  <sch:pattern id="apd.v2.0.1">
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="CDA-DK-PROFILE-TEMPLATE" flag="error" test="count(v3:templateId[@root='1.2.208.184.14.1']) = 1">APD-DK 2.0.1 requires the document template 1.2.208.184.14.1.</sch:assert>
      <sch:assert id="CDA-DK-PROFILE-VERSION" flag="error" test="count(v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'apd-v')]) = 1 and v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'apd-v')]/@extension = 'apd-v2.0.1'">Selected target APD-DK 2.0.1 requires exactly one profile version declaration 'apd-v2.0.1' in documentationOf/serviceEvent/id. Source: 2.2.12, CONF-DK-APD:9f67.</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
