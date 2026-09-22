<?xml version="1.0" encoding="UTF-8"?>
<!-- Source: https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:title>QRD-DK 1.3.2 release identity checks</sch:title>
  <sch:ns prefix="v3" uri="urn:hl7-org:v3" />
  <sch:pattern id="qrd.v1.3.2">
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="CDA-DK-PROFILE-TEMPLATE" flag="error" test="count(v3:templateId[@root='1.2.208.184.13.1']) = 1">QRD-DK 1.3.2 requires the document template 1.2.208.184.13.1.</sch:assert>
      <sch:assert id="CDA-DK-PROFILE-VERSION" flag="error" test="count(v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'qrd-v')]) = 1 and v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'qrd-v')]/@extension = 'qrd-v1.3'">Selected target QRD-DK 1.3.2 requires exactly one profile version declaration 'qrd-v1.3' in documentationOf/serviceEvent/id. Source: 2.2.11 DocumentationOf.</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
