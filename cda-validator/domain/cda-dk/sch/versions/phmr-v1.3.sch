<?xml version="1.0" encoding="UTF-8"?>
<!-- PHMR-DK 1.3 guide and examples at MedCom SVN revision 2690. See rulesets.json. -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:title>PHMR-DK 1.3 release checks</sch:title>
  <sch:ns prefix="v3" uri="urn:hl7-org:v3" />
  <sch:pattern id="phmr.v1.3">
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="CDA-DK-PROFILE-TEMPLATE" flag="error" test="count(v3:templateId[@root='1.2.208.184.11.1']) = 1">PHMR-DK 1.3 requires the document template 1.2.208.184.11.1.</sch:assert>
      <!-- The guide does not mandate a release marker; the published example supplies one. -->
    </sch:rule>
    <sch:rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section/v3:entry/v3:organizer/v3:component/v3:observation">
      <sch:assert id="PHMR-DK-1.3-METHOD-CARDINALITY" flag="error" test="count(v3:methodCode) = 2">PHMR-DK 1.3 requires exactly two methodCode elements (guide updated 2 March 2020, methodCode cardinality table).</sch:assert>
    </sch:rule>
    <!-- Check existing declarations at the id itself, including duplicate declarations. -->
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'phmr-v')]">
      <sch:assert id="CDA-DK-PROFILE-VERSION" flag="error" test="@extension = 'phmr-v1.3' and count(../../../v3:documentationOf/v3:serviceEvent/v3:id[starts-with(@extension, 'phmr-v')]) = 1">Selected target PHMR-DK 1.3 expects a single declaration 'phmr-v1.3'; found '<sch:value-of select="@extension"/>'. Check the version and remove any duplicate PHMR declarations.</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
