<?xml version="1.0" encoding="utf-8" ?>
<sch:schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
	schemaVersion="ISO19757-3">
	<sch:ns prefix="v3" uri="urn:hl7-org:v3" />
	<sch:pattern name="CONF-QRD">
		<sch:rule id="CONF-QRD-1" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:realmCode">
				The
				ClinicalDocument/realmCode element SHALL be present.
			</sch:assert>
		</sch:rule>

		<!-- CONF-QRD-2 -->
		<!-- Conditional online validation against registry which makes little 
			sense -->

		<sch:rule id="CONF-QRD-3" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:typeId">
				The ClinicalDocument SHALL
				contain exactly one [1..1] typeId
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-QRD-4" context="v3:ClinicalDocument/v3:typeId">
			<sch:assert flag="error" test="@root='2.16.840.1.113883.1.3'">
				This typeId SHALL contain
				exactly one [1..1] @root="2.16.840.1.113883.1.3"
			</sch:assert>
		</sch:rule>
		<sch:rule id="CONF-QRD-5" context="v3:ClinicalDocument/v3:typeId">
			<sch:assert flag="error" test="@extension='POCD_HD000040'">
				This typeId SHALL contain
				exactly one [1..1] @extension="POCD_HD000040"
			</sch:assert>
		</sch:rule>

		<!-- CONF-QRD-6 -->
		<!-- Not mentioned -->

		<!-- CONF-QRD-7 -->
		<!-- Not mentioned -->

		<!-- CONF-QRD-8 -->
		<!-- Not mentioned -->

		<sch:rule id="CONF-QRD-9" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:id">
				The ClinicalDocument SHALL
				contain exactly one [1..1] id
			</sch:assert>
		</sch:rule>

		<!-- CONF-QRD-10 -->
		<!-- Not computable -->

		<sch:rule id="CONF-QRD-11" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:code">
				The ClinicalDocument SHALL
				contain exactly one [1..1] code
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-QRD-14" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:title">
				The ClinicalDocument SHALL
				contain exactly one [1..1] title
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-QRD-15" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:effectiveTime">
				The ClinicalDocument SHALL
				contain exactly one [1..1] effectiveTime
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-QRD-16" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:confidentialityCode">
				The ClinicalDocument SHALL
				contain exactly one [1..1] confidentialityCode and be selected from
				ValueSet HL7 BasicConfidentialityKind
				2.16.840.1.113883.1.11.16926
				STATIC
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-QRD-17" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:languageCode">
				The ClinicalDocument SHALL
				contain exactly one [1..1] languageCode, which SHALL be
				selected from ValueSet Language 2.16.840.1.113883.1.11.11526
				DYNAMIC
			</sch:assert>
		</sch:rule>
	</sch:pattern>
</sch:schema> 
