<?xml version="1.0" encoding="utf-8" ?>
<sch:schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
	schemaVersion="ISO19757-3">
	<sch:ns prefix="v3" uri="urn:hl7-org:v3" />
	<sch:ns prefix="sdtc" uri="urn:hl7-org:sdtc" />
	<sch:pattern name="CONF-PDC">
		<sch:rule id="CONF-PDC-DK-159" context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
			<sch:assert flag="error" test="count(v3:entry[v3:observation[v3:templateId[@root='1.2.208.184.16.1.10.20.1.23'][@extension='2019-08-14']]]) &gt;= 0">
				Observation of custody information returned from the CPR-register (identifier: urn:hl7ii:1.2.208.184.16.1.10.20.1.23:2019-08-14) [0..*].
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-PDC-DK-165" context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
			<sch:assert flag="error" test="count(v3:entry[v3:observation[v3:templateId[@root='1.2.208.184.16.1.10.20.1.26'][@extension='2019-08-14']]]) = 1">
				Observation of citizen’s name and address returned from the CPR-register (identifier: urn:hl7ii:1.2.208.184.16.1.10.20.1.26:2019-08-14) [1..1].
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-PDC-DK-171" context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
			<sch:assert flag="error" test="count(v3:entry[v3:observation[v3:templateId[@root='1.2.208.184.16.1.10.20.1.27'][@extension='2019-08-14']]]) = 1">
				Observation of the citizen’s coverage groupreturned from the CPR-register (identifier: urn:hl7ii:1.2.208.184.16.1.10.20.1.27:2019-08-14) [1..1]
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-PDC-DK-177" context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
			<sch:assert flag="error" test="count(v3:entry[v3:observation[v3:templateId[@root='1.2.208.184.16.1.10.20.1.28'][@extension='2019-08-14']]]) = 1">
				Observation of the citizen’s organ donor registration returned from Dansk Center for Organ Donation (identifier: urn:hl7ii:1.2.208.184.16.1.10.20.1.28:2019-08-14) [1..1]
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-PDC-DK-183" context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
			<sch:assert flag="error" test="count(v3:entry[v3:observation[v3:templateId[@root='1.2.208.184.16.1.10.20.1.29'][@extension='2019-08-14']]]) = 1">
				Observation of the citizen’s treatment will registration returned from Sundhedsdatastyrelsen (identifier: urn:hl7ii:1.2.208.184.16.1.10.20.1.29:2019-08-14) [1..1]
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-PDC-DK-189" context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
			<sch:assert flag="error" test="count(v3:entry[v3:observation[v3:templateId[@root='1.2.208.184.16.1.10.20.1.30'][@extension='2019-08-14']]]) = 1">
				Observation of the citizen’s living will registration returned from Sundhedsdatastyrelsen (identifier: urn:hl7ii:1.2.208.184.16.1.10.20.1.30:2019-08-14) [1..1]
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-PDC-DK-195" context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
			<let name="count" value="count(v3:entry[v3:observation[v3:templateId[@root='1.2.208.184.16.1.10.20.1.20'][@extension='2019-08-14']]])"/>
			<sch:assert flag="error" test="$count &gt;= 0 and $count &lt;= 1">
				Observation of manually entered spoken language (identifier: urn:hl7ii:1.2.208.184.16.1.10.20.1.20:2019-08-14) [1..1]
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-PDC-DK-201" context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
			<let name="count" value="count(v3:entry[v3:observation[v3:templateId[@root='1.2.208.184.16.1.10.20.1.21'][@extension='2019-08-14']]])"/>
			<sch:assert flag="error" test="$count &gt;= 0 and $count &lt;= 1">
				Observation of temporary address (identifier: urn:hl7ii:1.2.208.184.16.1.10.20.1.21:2019-08-14) [1..1]
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-PDC-DK-207" context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
			<let name="count" value="count(v3:entry[v3:observation[v3:templateId[@root='1.2.208.184.16.1.10.20.1.22'][@extension='2019-08-14']]])"/>
			<sch:assert flag="error" test="$count &gt;= 0 and $count &lt;= 1">
				Observation of manually entered dentist information (identifier: urn:hl7ii:1.2.208.184.16.1.10.20.1.22:2019-08-14) [1..1]
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-PDC-DK-213" context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
			<let name="count" value="count(v3:entry[v3:observation[v3:templateId[@root='1.2.208.184.16.1.10.20.1.24'][@extension='2019-08-14']]])"/>
			<sch:assert flag="error" test="$count &gt;= 0 and $count &lt;= 1">
				Observation of manually entered contact information (identifier: urn:hl7ii:1.2.208.184.16.1.10.20.1.24:2019-08-14)
			</sch:assert>
		</sch:rule>

		<sch:rule id="CONF-PDC-DK-219" context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component/v3:section">
			<sch:assert flag="error" test="count(v3:entry[v3:observation[v3:templateId[@root='1.2.208.184.16.1.10.20.1.25'][@extension='2019-08-14']]]) &gt;= 0">
				Observation of manually entered information about a Releative: urn:hl7ii:1.2.208.184.16.1.10.20.1.25:2019-08-14)
			</sch:assert>
		</sch:rule>
	</sch:pattern>
</sch:schema> 
