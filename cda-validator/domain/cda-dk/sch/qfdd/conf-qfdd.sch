<?xml version="1.0" encoding="utf-8" ?>
<sch:schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
	schemaVersion="ISO19757-3">
	<sch:ns prefix="v3" uri="urn:hl7-org:v3" />
	<sch:ns prefix="sdtc" uri="urn:hl7-org:sdtc" />
	<sch:pattern name="CONF-QFDD">
		<sch:rule id="CONF-QFDD-1" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:realmCode">
				The
				ClinicalDocument/realmCode element SHALL be present.
			</sch:assert>
		</sch:rule>

		<!-- CONF-QFDD-2 -->
		<!-- Conditional online validation against registry which makes little 
			sense -->

		<sch:rule id="CONF-QFDD-3" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:typeId">
				The ClinicalDocument SHALL
				contain exactly one [1..1] typeId
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-QFDD-4" context="v3:ClinicalDocument/v3:typeId">
			<sch:assert flag="error" test="@root='2.16.840.1.113883.1.3'">
				This typeId SHALL contain
				exactly one [1..1] @root="2.16.840.1.113883.1.3"
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-QFDD-5" context="v3:ClinicalDocument/v3:typeId">
			<sch:assert flag="error" test="@extension='POCD_HD000040'">
				This typeId SHALL contain
				exactly one [1..1] @extension="POCD_HD000040"
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-QFDD-6" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:templateId">
				The ClinicalDocument SHALL
				contain exactly one [1..1] header-level templateId
			</sch:assert>
		</sch:rule>

		<!-- CONF-QFDD-7 -->
		<!-- Not mentioned -->

		<sch:rule id="CONF-QFDD-8" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:id">
				The ClinicalDocument SHALL
				contain exactly one [1..1] id
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-QFDD-10" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:code">
				The ClinicalDocument SHALL
				contain exactly one [1..1] code
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-QFDD-13" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="v3:title">
				The ClinicalDocument SHALL
				contain exactly one [1..1] title
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-QFDD-14" context="v3:ClinicalDocument">
			<sch:assert flag="error" test="sdtc:statusCode">
				The ClinicalDocument SHALL
				contain exactly one [1..1] sdtc:statusCode
			</sch:assert>
		</sch:rule>
 
		<sch:rule id="CONF-QFDD-15" context="v3:ClinicalDocument/sdtc:statusCode">
			<sch:assert flag="error" test="@code='NEW'">
				This statusCode SHALL
				contain exactly one [1..1] @code="NEW" (CodeSystem: ActStatus
				2.16.840.1.113883.5.14)
			</sch:assert>
		</sch:rule>
	</sch:pattern>
</sch:schema> 
