<?xml version="1.0" encoding="utf-8" ?>
<sch:schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
	schemaVersion="ISO19757-3">
	<sch:ns prefix="v3" uri="urn:hl7-org:v3" />
	<sch:ns prefix="sdtc" uri="urn:hl7-org:sdtc" />
	<sch:pattern name="CONF-QFDD">
		<sch:rule id="CONF-QFDD-DK-1" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:templateId[@root='1.2.208.184.12.1']">
				templateId SHALL contain exactly one [1..1] @root=”1.2.208.184.12.1”.
			</sch:assert>
		</sch:rule>
		
		<!-- Possible to evaluate by a machine? -->
		<!-- This code SHALL specify the Questionnaire Form Definition Document (CONF-DK: 2). -->
		
		<sch:rule id="CONF-QFDD-DK-3" context="v3:ClinicalDocument/v3:code">
			<sch:assert flag="error" test="@code='74468-0' and @codeSystem='2.16.840.1.113883.6.1'">
				This code SHALL be code = 74468-0 from (CodeSystem: LOINC 2.16.840.1.113883.6.1).
			</sch:assert>
		</sch:rule>
		
		<sch:rule id="CONF-QFDD-DK-4" context="v3:ClinicalDocument/v3:confidentialityCode">
			<sch:assert flag="error" test="@code='N'">
				confidentialityCode contains a code which SHALL always be set to “N”.
			</sch:assert>
		</sch:rule>		
		
		<sch:rule id="CONF-QFDD-DK-5" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="count(v3:author/v3:assignedAuthor) = 1">
				There SHALL be exactly one assignedAuthor/assignedPerson.
			</sch:assert>
		</sch:rule>		
		
		<sch:rule id="CONF-QFDD-DK-6" context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
			<sch:assert flag="error" test="(v3:representedOrganization and not(v3:assignedPerson) and v3:id[@nullFlavor='NA']) or 
										   (v3:assignedPerson and v3:representedOrganization) or
										   (v3:assignedPerson and not(v3:representedOrganization)) or
										   (not(v3:assignedPerson) and not(v3:representedOrganization))">
				If assignedAuthor has an associated representedOrganization and no assignedPerson, 
				then the value for "ClinicalDocument/author/assignedAuthor/id/@NullFlavor" SHALL be 
				"NA" "Not applicable" 2.16.840.1.113883.5.1008 NullFlavor STATIC.
			</sch:assert>
		</sch:rule>		
		
		<!-- SHALL conform to the Danish Profile Questionnaire Form Definition Document Header template (templateId: 1.2.208.184.12.1) (CONF-DK: 7). -->
		<!-- Kind of what we are trying to answer... -->
		
		<!-- SHALL contain exactly one [1..1] @root="1.2.208.184.12.1.1.1" (CONF-DK: 8). -->
		<!-- Conflicts with CONF-QFDD-DK-1, in agreement with MDM expected root of CONF-QFDD-DK-1 was changed -->		
	</sch:pattern>
</sch:schema> 
