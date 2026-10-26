<?xml version="1.0" encoding="UTF-8"?>
<!-- Source: https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:title>CPD-DK 2.0.0 release identity checks</sch:title>
  <sch:ns prefix="v3" uri="urn:hl7-org:v3" />
  <sch:pattern id="cpd.v2.0.0">
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="CDA-DK-PROFILE-TEMPLATE" flag="error" test="count(v3:templateId[@root='1.2.208.184.15.1']) = 1">CPD-DK 2.0.0 requires the document template 1.2.208.184.15.1.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="cpd-v2.0.0-version-location">
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'cpd-v') or ../v3:templateId/@root='1.2.208.184.10.1.10']">
      <sch:let name="document" value="ancestor::v3:ClinicalDocument"/>
      <sch:assert id="CDA-DK-PROFILE-VERSION" flag="error" test="count($document/v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'cpd-v')]) = 1 and $document/v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'cpd-v')]/@extension = 'cpd-v2.0.0'">Selected target CPD-DK 2.0.0 requires exactly one profile version declaration 'cpd-v2.0.0' in documentationOf/serviceEvent/id. Source: Header constraint table, CONF H:16 (prose has a conflicting spelling).</sch:assert>
    </sch:rule>
    <!-- Missing declarations use the nearest existing version container. -->
    <sch:rule context="v3:ClinicalDocument | v3:ClinicalDocument/v3:documentationOf | v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent">
      <sch:let name="document" value="ancestor-or-self::v3:ClinicalDocument"/>
      <sch:let name="container" value="($document/v3:documentationOf/v3:serviceEvent[v3:templateId/@root='1.2.208.184.10.1.10'], $document/v3:documentationOf/v3:serviceEvent, $document/v3:documentationOf, $document)[1]"/>
      <sch:assert id="CDA-DK-PROFILE-VERSION" flag="error" test="not(. is $container) or exists($document/v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'cpd-v') or ../v3:templateId/@root='1.2.208.184.10.1.10'])">Selected target CPD-DK 2.0.0 requires exactly one profile version declaration 'cpd-v2.0.0' in documentationOf/serviceEvent/id. Source: Header constraint table, CONF H:16 (prose has a conflicting spelling).</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
