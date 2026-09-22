<?xml version="1.0" encoding="utf-8" ?>
<sch:schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
	schemaVersion="ISO19757-3">
	<sch:ns prefix="v3" uri="urn:hl7-org:v3" />
	<sch:pattern name="CONF-PHMR-DK">
		<sch:rule id="CONF-PHMR-DK-2" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:templateId/@root='1.2.208.184.11.1'">A
				ClinicalDocument/templateId element SHALL be present where @root is
				1.2.208.184.11.1. This indicates conformance to this profile.
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-PHMR-DK-3" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:code">
				The ClinicalDocument/code element SHALL be present.
			</sch:assert>
		</sch:rule>
		<sch:rule id="CONF-PHMR-DK-3" context="v3:ClinicalDocument/v3:code">
			<sch:assert flag="error" test="@code='53576-5'">
				The value for "ClinicalDocument/code" code attribute SHALL be
				"53576-5".
			</sch:assert>
			<sch:assert flag="error" test="@codeSystem='2.16.840.1.113883.6.1'">
				The value for "ClinicalDocument/code" codeSystem attribute SHALL be
				2.16.840.1.113883.6.1.
			</sch:assert>
			<sch:assert flag="error" test="@codeSystemName='LOINC'">
				The value for "ClinicalDocument/code" codeSystemName SHALL be LOINC®.
			</sch:assert>
			<sch:assert flag="error"
				test="@displayName='Personal Health Monitoring Report'">
				The value for "ClinicalDocument/code" displayName attribute SHALL be
				"Personal Health Monitoring Report".
			</sch:assert>
		</sch:rule>

		<!-- CONF-PHMR-DK-4 -->
		<!-- Validation of social security numbers are handled in java -->

		<!-- CONF-PHMR-DK-5 -->
		<sch:rule id="CONF-PHMR-DK-5"
			context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:id">
			<sch:assert flag="error" test="@root">
				ID must have a root.
			</sch:assert>
			<sch:assert flag="error" test="@root='1.2.208.176.1.2'">
				ID has a root that differs from '1.2.208.176.1.2'.
			</sch:assert>
		</sch:rule>

		<!-- CONF-PHMR-DK-6 -->
		<sch:rule id="CONF-PHMR-DK-6" context="*[@classCode = 'PSN']/v3:name">
			<sch:assert flag="error" test="count(v3:family) = 1">
				SHALL contain exactly one [1..1] family element.
			</sch:assert>
		</sch:rule>
		<sch:rule id="CONF-PHMR-DK-6" context="*[@classCode = 'PSN']/v3:name/v3:family">
			<sch:assert flag="warning" test="not(@qualifier)">
				In this profile the @qualifier is not used.
			</sch:assert>
		</sch:rule>

		<!-- CONF-PHMR-DK-7 -->
		<sch:rule id="CONF-PHMR-DK-7" context="*[@classCode = 'PSN']/v3:name">
			<sch:assert flag="error" test="count(v3:given) >= 1">
				SHALL contain at least one [1..*] given element.
			</sch:assert>
		</sch:rule>
		<sch:rule id="CONF-PHMR-DK-7" context="*[@classCode = 'PSN']/v3:name/v3:given">
			<sch:assert flag="warning" test="not(@qualifier)">
				In this profile the @qualifier is not used.
			</sch:assert>
		</sch:rule>

		<!-- CONF-PHMR-DK-8 -->
		<sch:rule id="CONF-PHMR-DK-8" context="*[@classCode = 'PSN']/v3:name">
			<sch:assert flag="error"
				test="count(v3:prefix) = 0 or count(v3:prefix) = 1">
				MAY contain one [0..1] prefix element, e.g. to include the tittle for a
				health professional.
			</sch:assert>
		</sch:rule>
		<sch:rule id="CONF-PHMR-DK-8" context="*[@classCode = 'PSN']/v3:name/v3:given">
			<sch:assert flag="warning" test="not(@qualifier)">
				In this profile the @qualifier is not used.
			</sch:assert>
		</sch:rule>

		<!-- CONF-PHMR-DK-9 -->
		<sch:rule id="CONF-PHMR-DK-9" context="*/v3:addr">
			<sch:assert flag="warning" test="count(@use) = 1">
				SHOULD contain exactly one [1..1] @use.
			</sch:assert>
			<sch:assert flag="error"
				test="count(@use) = 0 or (@use = 'H' or @use = 'WP')">
				@use SHALL be selected from ValueSet PostalAddressUse in Table 1 of the
				profile.
			</sch:assert>
		</sch:rule>

		<!-- CONF-PHMR-DK-10 -->
		<sch:rule id="CONF-PHMR-DK-10" context="*/v3:addr">
			<sch:assert flag="error"
				test="count(v3:streetAddressLine) >= 1 and 4 >= count(v3:streetAddressLine)">
				SHALL contain at least one and not more than 4 streetAddressLine.
			</sch:assert>
		</sch:rule>

	</sch:pattern>
</sch:schema> 
