<?xml version="1.0" encoding="UTF-8"?>
<!-- Source: https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:title>QFDD-DK 1.2 release identity checks</sch:title>
  <sch:ns prefix="v3" uri="urn:hl7-org:v3" />
  <sch:pattern id="qfdd.v1.2">
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="CDA-DK-PROFILE-TEMPLATE" flag="error" test="count(v3:templateId[@root='1.2.208.184.12.1']) = 1">QFDD-DK 1.2 requires the document template 1.2.208.184.12.1.</sch:assert>
      <sch:assert id="QFDD-DK-1.2-DOCUMENT-TEMPLATE" flag="error" test="count(v3:templateId[@root='1.2.208.184.12.1.1.1']) = 1">QFDD-DK 1.2 requires its document-level template (section 3.1). The guide does not define a distinct profile-version marker; the target release is explicitly selected by the test.</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
