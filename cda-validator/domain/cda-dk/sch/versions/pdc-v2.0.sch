<?xml version="1.0" encoding="UTF-8"?>
<!-- Source: https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:title>PDC-DK 2.0 release identity checks</sch:title>
  <sch:ns prefix="v3" uri="urn:hl7-org:v3" />
  <sch:pattern id="pdc.v2.0">
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="CDA-DK-PROFILE-TEMPLATE" flag="error" test="count(v3:templateId[@root='1.2.208.184.16.1']) = 1">PDC-DK 2.0 requires the document template 1.2.208.184.16.1.</sch:assert>
      <sch:assert id="CDA-DK-PROFILE-VERSION" flag="error" test="count(v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'pdc-v')]) = 1 and v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'pdc-v')]/@extension = 'pdc-v2.0'">Selected target PDC-DK 2.0 requires exactly one profile version declaration 'pdc-v2.0' in documentationOf/serviceEvent/id. Source: Header/version example; apply the published errata.</sch:assert>
      <sch:assert id="CDA-DK-PROFILE-TEMPLATE-VERSION" flag="error" test="not(v3:templateId[@root='1.2.208.184.16.1']/@extension) or v3:templateId[@root='1.2.208.184.16.1']/@extension = '2.0'">The PDC document template must not declare a different release when testing PDC-DK 2.0.</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
