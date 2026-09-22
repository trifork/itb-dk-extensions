<?xml version='1.0' encoding='UTF-8'?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:title>QFDD-DK 1.2: conformance extracted from MedCom specifications</sch:title>
  <sch:ns prefix="v3" uri="urn:hl7-org:v3"/>
  <sch:ns prefix="sdtc" uri="urn:hl7-org:sdtc"/>
  <sch:ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
  <sch:ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
  <sch:pattern id="QFDD-DK-1.2-C1-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, C1. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QFDD-DK-1.2-C1" test="count(v3:realmCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: realmCode cardinality must be 1..1. Source: qfdd 2.2, p. 10, C1.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C3-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, C3. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QFDD-DK-1.2-C3" test="count(v3:typeId) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: typeId cardinality must be 1..1. Source: qfdd 2.2, p. 10, C3.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C8-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, C8. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QFDD-DK-1.2-C8" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: id cardinality must be 1..1. Source: qfdd 2.2, p. 10, C8.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C10-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, C10. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QFDD-DK-1.2-C10" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: code cardinality must be 1..1. Source: qfdd 2.2, p. 10, C10.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C13-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, C13. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QFDD-DK-1.2-C13" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: title cardinality must be 1..1. Source: qfdd 2.2, p. 10, C13.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C16-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, C16. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QFDD-DK-1.2-C16" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: effectiveTime cardinality must be 1..1. Source: qfdd 2.2, p. 10, C16.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C17-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, C17. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QFDD-DK-1.2-C17" test="count(v3:confidentialityCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: confidentialityCode cardinality must be 1..1. Source: qfdd 2.2, p. 10, C17.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C18-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, C18. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QFDD-DK-1.2-C18" test="count(v3:languageCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: languageCode cardinality must be 1..1. Source: qfdd 2.2, p. 10, C18.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C4-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, C4. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:typeId">
      <sch:assert id="QFDD-DK-1.2-C4" test="@root = '2.16.840.1.113883.1.3'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: @root must be 2.16.840.1.113883.1.3. Source: qfdd 2.2, p. 10, C4.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C5-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, C5. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:typeId">
      <sch:assert id="QFDD-DK-1.2-C5" test="@extension = 'POCD_HD000040'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: @extension must be POCD_HD000040. Source: qfdd 2.2, p. 10, C5.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-DK4-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, DK4. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:confidentialityCode">
      <sch:assert id="QFDD-DK-1.2-DK4" test="@code = 'N'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: @code must be N. Source: qfdd 2.2, p. 10, DK4.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-DK14-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, DK14. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:id">
      <sch:assert id="QFDD-DK-1.2-DK14" test="matches(string(@extension), &quot;^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89aAbB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$&quot;)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: Document id extension must be a version 4 UUID; global uniqueness requires registry checking. Source: qfdd 2.2, p. 10, DK14.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-DK15-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, DK15. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:id">
      <sch:assert id="QFDD-DK-1.2-DK15" test="matches(string(@root), '^([01]\.([0-9]|[12][0-9]|3[0-9])|2\.(0|[1-9][0-9]*))(\.(0|[1-9][0-9]*))*$')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: Document id root must have OID syntax; ownership requires external verification. Source: qfdd 2.2, p. 10, DK15.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-DK16-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, DK16. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:id">
      <sch:assert id="QFDD-DK-1.2-DK16" test="normalize-space(@assigningAuthorityName) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: Document id must name the responsible organisation; its identity requires external verification. Source: qfdd 2.2, p. 10, DK16.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C14-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, C14. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QFDD-DK-1.2-C14" test="count(sdtc:statusCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: sdtc:statusCode cardinality must be 1..1. Source: qfdd 2.2, p. 10, C14.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C15-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, C15. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/sdtc:statusCode">
      <sch:assert id="QFDD-DK-1.2-C15" test="@code = 'NEW'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: @code must be NEW. Source: qfdd 2.2, p. 10, C15.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-DK3-CODE-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, DK3-CODE. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:code">
      <sch:assert id="QFDD-DK-1.2-DK3-CODE" test="@code = '74468-0'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: @code must be 74468-0. Source: qfdd 2.2, p. 10, DK3-CODE.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-DK3-SYSTEM-pattern">
    <sch:p>Source: qfdd, section 2.2, PDF page 10, DK3-SYSTEM. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:code">
      <sch:assert id="QFDD-DK-1.2-DK3-SYSTEM" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=10">QFDD-DK 1.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qfdd 2.2, p. 10, DK3-SYSTEM.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C19-pattern">
    <sch:p>Source: qfdd, section 2.2.1, PDF page 12, C19. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QFDD-DK-1.2-C19" test="count(v3:recordTarget) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=12">QFDD-DK 1.2: recordTarget cardinality must be 1..1. Source: qfdd 2.2.1, p. 12, C19.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C20-pattern">
    <sch:p>Source: qfdd, section 2.2.1, PDF page 12, C20. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:recordTarget">
      <sch:assert id="QFDD-DK-1.2-C20" test="count(v3:patientRole) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=12">QFDD-DK 1.2: patientRole cardinality must be 1..1. Source: qfdd 2.2.1, p. 12, C20.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C21-pattern">
    <sch:p>Source: qfdd, section 2.2.1, PDF page 12, C21. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole">
      <sch:assert id="QFDD-DK-1.2-C21" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=12">QFDD-DK 1.2: id cardinality must be 1..1. Source: qfdd 2.2.1, p. 12, C21.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C22-pattern">
    <sch:p>Source: qfdd, section 2.2.1, PDF page 12, C22. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:id">
      <sch:assert id="QFDD-DK-1.2-C22" test="@nullFlavor = 'NI'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=12">QFDD-DK 1.2: @nullFlavor must be NI. Source: qfdd 2.2.1, p. 12, C22.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C23-pattern">
    <sch:p>Source: qfdd, section 2.2.2, PDF page 13, C23. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QFDD-DK-1.2-C23" test="count(v3:author) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=13">QFDD-DK 1.2: author cardinality must be 1..*. Source: qfdd 2.2.2, p. 13, C23.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C24-pattern">
    <sch:p>Source: qfdd, section 2.2.2, PDF page 13, C24. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author">
      <sch:assert id="QFDD-DK-1.2-C24" test="count(v3:time) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=13">QFDD-DK 1.2: time cardinality must be 1..1. Source: qfdd 2.2.2, p. 13, C24.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C25-pattern">
    <sch:p>Source: qfdd, section 2.2.2, PDF page 13, C25. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author">
      <sch:assert id="QFDD-DK-1.2-C25" test="count(v3:assignedAuthor) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=13">QFDD-DK 1.2: assignedAuthor cardinality must be 1..1. Source: qfdd 2.2.2, p. 13, C25.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C26-pattern">
    <sch:p>Source: qfdd, section 2.2.2, PDF page 13, C26. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <sch:assert id="QFDD-DK-1.2-C26" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=13">QFDD-DK 1.2: id cardinality must be 1..1. Source: qfdd 2.2.2, p. 13, C26.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C27-pattern">
    <sch:p>Source: qfdd, section 2.2.2, PDF page 13, C27. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <sch:assert id="QFDD-DK-1.2-C27" test="count(v3:addr) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=13">QFDD-DK 1.2: addr cardinality must be 1..*. Source: qfdd 2.2.2, p. 13, C27.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C28-pattern">
    <sch:p>Source: qfdd, section 2.2.2, PDF page 13, C28. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <sch:assert id="QFDD-DK-1.2-C28" test="count(v3:telecom) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=13">QFDD-DK 1.2: telecom cardinality must be 1..*. Source: qfdd 2.2.2, p. 13, C28.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C35-pattern">
    <sch:p>Source: qfdd, section 2.2.2, PDF page 13, C35. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <sch:assert id="QFDD-DK-1.2-C35" test="count(v3:representedOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=13">QFDD-DK 1.2: representedOrganization cardinality must be 1..1. Source: qfdd 2.2.2, p. 13, C35.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C31-pattern">
    <sch:p>Source: qfdd, section 2.2.2, PDF page 13, C31. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:assignedPerson">
      <sch:assert id="QFDD-DK-1.2-C31" test="count(v3:name) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=13">QFDD-DK 1.2: name cardinality must be 1..*. Source: qfdd 2.2.2, p. 13, C31.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C30-pattern">
    <sch:p>Source: qfdd, section 2.2.2, PDF page 13, C30. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <sch:assert id="QFDD-DK-1.2-C30" test="count(v3:assignedPerson) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=13">QFDD-DK 1.2: assignedPerson cardinality must be 0..1. Source: qfdd 2.2.2, p. 13, C30.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-DK6-pattern">
    <sch:p>Source: qfdd, section 2.2.2, PDF page 13, DK6. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <sch:assert id="QFDD-DK-1.2-DK6" test="v3:assignedPerson or not(v3:representedOrganization) or v3:id/@nullFlavor='NA'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=13">QFDD-DK 1.2: An organisation-only author must use id/@nullFlavor=NA. Source: qfdd 2.2.2, p. 13, DK6.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C37-pattern">
    <sch:p>Source: qfdd, section 2.2.3, PDF page 15, C37. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QFDD-DK-1.2-C37" test="count(v3:custodian) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=15">QFDD-DK 1.2: custodian cardinality must be 1..1. Source: qfdd 2.2.3, p. 15, C37.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C38-pattern">
    <sch:p>Source: qfdd, section 2.2.3, PDF page 15, C38. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:custodian">
      <sch:assert id="QFDD-DK-1.2-C38" test="count(v3:assignedCustodian) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=15">QFDD-DK 1.2: assignedCustodian cardinality must be 1..1. Source: qfdd 2.2.3, p. 15, C38.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C39-pattern">
    <sch:p>Source: qfdd, section 2.2.3, PDF page 15, C39. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian">
      <sch:assert id="QFDD-DK-1.2-C39" test="count(v3:representedCustodianOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=15">QFDD-DK 1.2: representedCustodianOrganization cardinality must be 1..1. Source: qfdd 2.2.3, p. 15, C39.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C40-pattern">
    <sch:p>Source: qfdd, section 2.2.3, PDF page 15, C40. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <sch:assert id="QFDD-DK-1.2-C40" test="count(v3:id) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=15">QFDD-DK 1.2: id cardinality must be 1..*. Source: qfdd 2.2.3, p. 15, C40.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C41-pattern">
    <sch:p>Source: qfdd, section 2.2.3, PDF page 15, C41. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <sch:assert id="QFDD-DK-1.2-C41" test="count(v3:name) = 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=15">QFDD-DK 1.2: name cardinality must be 1..1. Source: qfdd 2.2.3, p. 15, C41.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C42-pattern">
    <sch:p>Source: qfdd, section 2.2.3, PDF page 15, C42. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <sch:assert id="QFDD-DK-1.2-C42" test="count(v3:telecom) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=15">QFDD-DK 1.2: telecom cardinality must be 1..1. Source: qfdd 2.2.3, p. 15, C42.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C43-pattern">
    <sch:p>Source: qfdd, section 2.2.3, PDF page 15, C43. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <sch:assert id="QFDD-DK-1.2-C43" test="count(v3:addr) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=15">QFDD-DK 1.2: addr cardinality must be 1..1. Source: qfdd 2.2.3, p. 15, C43.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C47-pattern">
    <sch:p>Source: qfdd, section 3.1, PDF page 17, C47. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QFDD-DK-1.2-C47" test="count(v3:component) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=17">QFDD-DK 1.2: component cardinality must be 1..1. Source: qfdd 3.1, p. 17, C47.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C48-pattern">
    <sch:p>Source: qfdd, section 3.1, PDF page 17, C48. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:component">
      <sch:assert id="QFDD-DK-1.2-C48" test="count(v3:structuredBody) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=17">QFDD-DK 1.2: structuredBody cardinality must be 1..1. Source: qfdd 3.1, p. 17, C48.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C49-pattern">
    <sch:p>Source: qfdd, section 3.1, PDF page 17, C49. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <sch:assert id="QFDD-DK-1.2-C49" test="count(v3:component) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=17">QFDD-DK 1.2: component cardinality must be 1..*. Source: qfdd 3.1, p. 17, C49.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C50-pattern">
    <sch:p>Source: qfdd, section 3.1, PDF page 17, C50. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component">
      <sch:assert id="QFDD-DK-1.2-C50" test="count(v3:section) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=17">QFDD-DK 1.2: section cardinality must be 1..1. Source: qfdd 3.1, p. 17, C50.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-COPY-C61-62-pattern">
    <sch:p>Source: qfdd, section 4.2 (QFDD imported by QRD 1.6.1), PDF page 20, COPY-C61-62. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']]">
      <sch:assert id="QFDD-DK-1.2-COPY-C61-62" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.2.2'] cardinality must be 1..1. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C61-62.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-COPY-C63-pattern">
    <sch:p>Source: qfdd, section 4.2 (QFDD imported by QRD 1.6.1), PDF page 20, COPY-C63. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']]">
      <sch:assert id="QFDD-DK-1.2-COPY-C63" test="count(v3:title) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20">QFDD-DK 1.2: title cardinality must be 0..1. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C63.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-COPY-C64-pattern">
    <sch:p>Source: qfdd, section 4.2 (QFDD imported by QRD 1.6.1), PDF page 20, COPY-C64. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']]">
      <sch:assert id="QFDD-DK-1.2-COPY-C64" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20">QFDD-DK 1.2: text cardinality must be 1..1. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C64.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-COPY-C65-pattern">
    <sch:p>Source: qfdd, section 4.2 (QFDD imported by QRD 1.6.1), PDF page 20, COPY-C65. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']]">
      <sch:assert id="QFDD-DK-1.2-COPY-C65" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20">QFDD-DK 1.2: languageCode cardinality must be 0..1. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C65.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-COPY-C66-pattern">
    <sch:p>Source: qfdd, section 4.2 (QFDD imported by QRD 1.6.1), PDF page 20, COPY-C66. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']]">
      <sch:assert id="QFDD-DK-1.2-COPY-C66" test="count(v3:entry) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20">QFDD-DK 1.2: entry cardinality must be 1..*. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C66.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-COPY-C67-pattern">
    <sch:p>Source: qfdd, section 4.2 (QFDD imported by QRD 1.6.1), PDF page 20, COPY-C67. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']]/v3:entry">
      <sch:assert id="QFDD-DK-1.2-COPY-C67" test="@typeCode = 'DRIV'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20">QFDD-DK 1.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-COPY-C68-pattern">
    <sch:p>Source: qfdd, section 4.2 (QFDD imported by QRD 1.6.1), PDF page 20, COPY-C68. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']]/v3:entry">
      <sch:assert id="QFDD-DK-1.2-COPY-C68" test="count(v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.21']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20">QFDD-DK 1.2: observation[templateId/@root='2.16.840.1.113883.10.20.32.4.21'] cardinality must be 1..1. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C68.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C101-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C101. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C101" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QFDD-DK 1.2: @classCode must be OBS. Source: qfdd 5.5, p. 28, SHARED-C101.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C102-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C102. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C102" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QFDD-DK 1.2: @moodCode must be EVN. Source: qfdd 5.5, p. 28, SHARED-C102.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C103-104-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C103-104. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C103-104" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.19'] cardinality must be 1..1. Source: qfdd 5.5, p. 28, SHARED-C103-104.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C105-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C105. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C105" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QFDD-DK 1.2: code cardinality must be 1..1. Source: qfdd 5.5, p. 28, SHARED-C105.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C106-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C106. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-SHARED-C106" test="@code = '48767-8'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QFDD-DK 1.2: @code must be 48767-8. Source: qfdd 5.5, p. 28, SHARED-C106.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C107-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C107. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-SHARED-C107" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QFDD-DK 1.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qfdd 5.5, p. 28, SHARED-C107.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C108-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C108. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C108" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QFDD-DK 1.2: value cardinality must be 1..1. Source: qfdd 5.5, p. 28, SHARED-C108.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C109-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C109. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]/v3:value">
      <sch:assert id="QFDD-DK-1.2-SHARED-C109" test="if (@xsi:type and matches(normalize-space(@xsi:type), '^[\i-[:]][\c-[:]]*(:[\i-[:]][\c-[:]]*)?$') and (not(contains(@xsi:type, ':')) or namespace-uri-for-prefix(substring-before(@xsi:type, ':'), .) != '')) then resolve-QName(@xsi:type, .) = (QName('urn:hl7-org:v3', 'ST')) else false()" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QFDD-DK 1.2: xsi:type must identify a CDA datatype: ST. Source: qfdd 5.5, p. 28, SHARED-C109.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C110-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C110. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C110" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QFDD-DK 1.2: languageCode cardinality must be 0..1. Source: qfdd 5.5, p. 28, SHARED-C110.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C120-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C120. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C120" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QFDD-DK 1.2: @classCode must be OBS. Source: qfdd 5.7, p. 30, SHARED-C120.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C121-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C121. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C121" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QFDD-DK 1.2: @moodCode must be EVN. Source: qfdd 5.7, p. 30, SHARED-C121.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C122-123-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C122-123. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C122-123" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.20'] cardinality must be 1..1. Source: qfdd 5.7, p. 30, SHARED-C122-123.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C124-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C124. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C124" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QFDD-DK 1.2: code cardinality must be 1..1. Source: qfdd 5.7, p. 30, SHARED-C124.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C125-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C125. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-SHARED-C125" test="@code = '74467-2'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QFDD-DK 1.2: @code must be 74467-2. Source: qfdd 5.7, p. 30, SHARED-C125.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C126-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C126. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-SHARED-C126" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QFDD-DK 1.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qfdd 5.7, p. 30, SHARED-C126.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C127-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C127. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C127" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QFDD-DK 1.2: value cardinality must be 1..1. Source: qfdd 5.7, p. 30, SHARED-C127.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C128-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C128. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]/v3:value">
      <sch:assert id="QFDD-DK-1.2-SHARED-C128" test="if (@xsi:type and matches(normalize-space(@xsi:type), '^[\i-[:]][\c-[:]]*(:[\i-[:]][\c-[:]]*)?$') and (not(contains(@xsi:type, ':')) or namespace-uri-for-prefix(substring-before(@xsi:type, ':'), .) != '')) then resolve-QName(@xsi:type, .) = (QName('urn:hl7-org:v3', 'IVL_INT')) else false()" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QFDD-DK 1.2: xsi:type must identify a CDA datatype: IVL_INT. Source: qfdd 5.7, p. 30, SHARED-C128.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C129-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C129. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]/v3:value">
      <sch:assert id="QFDD-DK-1.2-SHARED-C129" test="count(v3:low) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QFDD-DK 1.2: low cardinality must be 1..1. Source: qfdd 5.7, p. 30, SHARED-C129.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C130-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C130. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]/v3:value">
      <sch:assert id="QFDD-DK-1.2-SHARED-C130" test="count(v3:high) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QFDD-DK 1.2: high cardinality must be 1..1. Source: qfdd 5.7, p. 30, SHARED-C130.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C139-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C139. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C139" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QFDD-DK 1.2: @classCode must be OBS. Source: qfdd 5.9, p. 33, SHARED-C139.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C140-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C140. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C140" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QFDD-DK 1.2: @moodCode must be EVN. Source: qfdd 5.9, p. 33, SHARED-C140.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C141-142-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C141-142. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C141-142" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.21'] cardinality must be 1..1. Source: qfdd 5.9, p. 33, SHARED-C141-142.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C143-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C143. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C143" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QFDD-DK 1.2: code cardinality must be 1..1. Source: qfdd 5.9, p. 33, SHARED-C143.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C144-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C144. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-SHARED-C144" test="@code = 'COPY'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QFDD-DK 1.2: @code must be COPY. Source: qfdd 5.9, p. 33, SHARED-C144.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C145-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C145. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-SHARED-C145" test="@codeSystem = '2.16.840.1.113883.5.4'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QFDD-DK 1.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C146-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C146. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C146" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QFDD-DK 1.2: value cardinality must be 1..1. Source: qfdd 5.9, p. 33, SHARED-C146.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C147-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C147. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]/v3:value">
      <sch:assert id="QFDD-DK-1.2-SHARED-C147" test="if (@xsi:type and matches(normalize-space(@xsi:type), '^[\i-[:]][\c-[:]]*(:[\i-[:]][\c-[:]]*)?$') and (not(contains(@xsi:type, ':')) or namespace-uri-for-prefix(substring-before(@xsi:type, ':'), .) != '')) then resolve-QName(@xsi:type, .) = (QName('urn:hl7-org:v3', 'ST')) else false()" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QFDD-DK 1.2: xsi:type must identify a CDA datatype: ST. Source: qfdd 5.9, p. 33, SHARED-C147.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SHARED-C148-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C148. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]">
      <sch:assert id="QFDD-DK-1.2-SHARED-C148" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QFDD-DK 1.2: languageCode cardinality must be 0..1. Source: qfdd 5.9, p. 33, SHARED-C148.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C69-pattern">
    <sch:p>Source: qfdd, section 5.1, PDF page 23, C69. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.1']]">
      <sch:assert id="QFDD-DK-1.2-C69" test="@classCode = 'BATTERY'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23">QFDD-DK 1.2: @classCode must be BATTERY. Source: qfdd 5.1, p. 23, C69.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C70-pattern">
    <sch:p>Source: qfdd, section 5.1, PDF page 23, C70. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.1']]">
      <sch:assert id="QFDD-DK-1.2-C70" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23">QFDD-DK 1.2: @moodCode must be EVN. Source: qfdd 5.1, p. 23, C70.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C71-72-pattern">
    <sch:p>Source: qfdd, section 5.1, PDF page 23, C71-72. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.1']]">
      <sch:assert id="QFDD-DK-1.2-C71-72" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.1'] cardinality must be 1..1. Source: qfdd 5.1, p. 23, C71-72.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C73-pattern">
    <sch:p>Source: qfdd, section 5.1, PDF page 23, C73. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.1']]">
      <sch:assert id="QFDD-DK-1.2-C73" test="count(v3:id) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23">QFDD-DK 1.2: id cardinality must be 1..*. Source: qfdd 5.1, p. 23, C73.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C74-pattern">
    <sch:p>Source: qfdd, section 5.1, PDF page 23, C74. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.1']]">
      <sch:assert id="QFDD-DK-1.2-C74" test="count(v3:code) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23">QFDD-DK 1.2: code cardinality must be 0..1. Source: qfdd 5.1, p. 23, C74.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C75-pattern">
    <sch:p>Source: qfdd, section 5.1, PDF page 23, C75. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.1']]">
      <sch:assert id="QFDD-DK-1.2-C75" test="count(v3:statusCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23">QFDD-DK 1.2: statusCode cardinality must be 1..1. Source: qfdd 5.1, p. 23, C75.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C76-pattern">
    <sch:p>Source: qfdd, section 5.1, PDF page 23, C76. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.1']]/v3:statusCode">
      <sch:assert id="QFDD-DK-1.2-C76" test="@code = 'completed'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23">QFDD-DK 1.2: @code must be completed. Source: qfdd 5.1, p. 23, C76.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C78-pattern">
    <sch:p>Source: qfdd, section 5.1, PDF page 23, C78. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.1']]">
      <sch:assert id="QFDD-DK-1.2-C78" test="count(v3:component) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23">QFDD-DK 1.2: component cardinality must be 1..*. Source: qfdd 5.1, p. 23, C78.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C79-pattern">
    <sch:p>Source: qfdd, section 5.1, PDF page 23, C79. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.1']]/v3:component">
      <sch:assert id="QFDD-DK-1.2-C79" test="count(v3:sequenceNumber) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23">QFDD-DK 1.2: sequenceNumber cardinality must be 1..1. Source: qfdd 5.1, p. 23, C79.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C80-85-pattern">
    <sch:p>Source: qfdd, section 5.1, PDF page 23, C80-85. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.1']]/v3:component">
      <sch:assert id="QFDD-DK-1.2-C80-85" test="count(v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.32.4.7', '2.16.840.1.113883.10.20.32.4.8', '2.16.840.1.113883.10.20.32.4.9', '2.16.840.1.113883.10.20.32.4.10', '2.16.840.1.113883.10.20.32.4.11')]) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23">QFDD-DK 1.2: observation[templateId/@root=('2.16.840.1.113883.10.20.32.4.7', '2.16.840.1.113883.10.20.32.4.8', '2.16.840.1.113883.10.20.32.4.9', '2.16.840.1.113883.10.20.32.4.10', '2.16.840.1.113883.10.20.32.4.11')] cardinality must be 1..1. Source: qfdd 5.1, p. 23, C80-85.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C86-pattern">
    <sch:p>Source: qfdd, section 5.2, PDF page 25, C86. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observationMedia[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.2']]">
      <sch:assert id="QFDD-DK-1.2-C86" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=25">QFDD-DK 1.2: @classCode must be OBS. Source: qfdd 5.2, p. 25, C86.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C87-pattern">
    <sch:p>Source: qfdd, section 5.2, PDF page 25, C87. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observationMedia[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.2']]">
      <sch:assert id="QFDD-DK-1.2-C87" test="@moodCode = 'DEF'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=25">QFDD-DK 1.2: @moodCode must be DEF. Source: qfdd 5.2, p. 25, C87.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C88-89-pattern">
    <sch:p>Source: qfdd, section 5.2, PDF page 25, C88-89. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observationMedia[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.2']]">
      <sch:assert id="QFDD-DK-1.2-C88-89" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=25">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.2'] cardinality must be 1..1. Source: qfdd 5.2, p. 25, C88-89.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C90-pattern">
    <sch:p>Source: qfdd, section 5.2, PDF page 25, C90. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observationMedia[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.2']]">
      <sch:assert id="QFDD-DK-1.2-C90" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=25">QFDD-DK 1.2: value cardinality must be 1..1. Source: qfdd 5.2, p. 25, C90.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C111-pattern">
    <sch:p>Source: qfdd, section 5.6, PDF page 29, C111. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.5']]">
      <sch:assert id="QFDD-DK-1.2-C111" test="@typeCode = 'REFV'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=29">QFDD-DK 1.2: @typeCode must be REFV. Source: qfdd 5.6, p. 29, C111.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C112-113-pattern">
    <sch:p>Source: qfdd, section 5.6, PDF page 29, C112-113. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.5']]">
      <sch:assert id="QFDD-DK-1.2-C112-113" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.5']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=29">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.5'] cardinality must be 1..1. Source: qfdd 5.6, p. 29, C112-113.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C114-pattern">
    <sch:p>Source: qfdd, section 5.6, PDF page 29, C114. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.5']]">
      <sch:assert id="QFDD-DK-1.2-C114" test="count(v3:observationRange) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=29">QFDD-DK 1.2: observationRange cardinality must be 1..1. Source: qfdd 5.6, p. 29, C114.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C115-pattern">
    <sch:p>Source: qfdd, section 5.6, PDF page 29, C115. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.5']]/v3:observationRange">
      <sch:assert id="QFDD-DK-1.2-C115" test="count(v3:text) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=29">QFDD-DK 1.2: text cardinality must be 0..1. Source: qfdd 5.6, p. 29, C115.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C116-pattern">
    <sch:p>Source: qfdd, section 5.6, PDF page 29, C116. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.5']]/v3:observationRange">
      <sch:assert id="QFDD-DK-1.2-C116" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=29">QFDD-DK 1.2: value cardinality must be 1..1. Source: qfdd 5.6, p. 29, C116.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C117-pattern">
    <sch:p>Source: qfdd, section 5.6, PDF page 29, C117. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.5']]/v3:observationRange/v3:value">
      <sch:assert id="QFDD-DK-1.2-C117" test="count(@xsi:type) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=29">QFDD-DK 1.2: @xsi:type cardinality must be 1..1. Source: qfdd 5.6, p. 29, C117.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C118-pattern">
    <sch:p>Source: qfdd, section 5.6, PDF page 29, C118. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.5']]/v3:observationRange/v3:value">
      <sch:assert id="QFDD-DK-1.2-C118" test="count(v3:low) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=29">QFDD-DK 1.2: low cardinality must be 1..1. Source: qfdd 5.6, p. 29, C118.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C119-pattern">
    <sch:p>Source: qfdd, section 5.6, PDF page 29, C119. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.5']]/v3:observationRange/v3:value">
      <sch:assert id="QFDD-DK-1.2-C119" test="count(v3:high) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=29">QFDD-DK 1.2: high cardinality must be 1..1. Source: qfdd 5.6, p. 29, C119.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C149-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, C149. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]">
      <sch:assert id="QFDD-DK-1.2-C149" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: @classCode must be OBS. Source: qfdd 5.10, p. 35, C149.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C150-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, C150. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]">
      <sch:assert id="QFDD-DK-1.2-C150" test="@moodCode = 'DEF'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: @moodCode must be DEF. Source: qfdd 5.10, p. 35, C150.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C151-152-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, C151-152. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]">
      <sch:assert id="QFDD-DK-1.2-C151-152" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.7'] cardinality must be 1..1. Source: qfdd 5.10, p. 35, C151-152.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C153-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, C153. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]">
      <sch:assert id="QFDD-DK-1.2-C153" test="count(v3:id) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: id cardinality must be 1..*. Source: qfdd 5.10, p. 35, C153.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C154-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, C154. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]">
      <sch:assert id="QFDD-DK-1.2-C154" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: code cardinality must be 1..1. Source: qfdd 5.10, p. 35, C154.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C155-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, C155. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-C155" test="count(@code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: @code cardinality must be 1..1. Source: qfdd 5.10, p. 35, C155.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C156-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, C156. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-C156" test="count(@codeSystem) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: @codeSystem cardinality must be 1..1. Source: qfdd 5.10, p. 35, C156.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C157-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, C157. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-C157" test="count(v3:originalText) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: originalText cardinality must be 1..1. Source: qfdd 5.10, p. 35, C157.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C158-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, C158. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]">
      <sch:assert id="QFDD-DK-1.2-C158" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: languageCode cardinality must be 0..1. Source: qfdd 5.10, p. 35, C158.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C168-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, C168. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]">
      <sch:assert id="QFDD-DK-1.2-C168" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: @classCode must be OBS. Source: qfdd 5.11, p. 39, C168.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C169-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, C169. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]">
      <sch:assert id="QFDD-DK-1.2-C169" test="@moodCode = 'DEF'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: @moodCode must be DEF. Source: qfdd 5.11, p. 39, C169.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C170-171-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, C170-171. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]">
      <sch:assert id="QFDD-DK-1.2-C170-171" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.8'] cardinality must be 1..1. Source: qfdd 5.11, p. 39, C170-171.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C172-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, C172. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]">
      <sch:assert id="QFDD-DK-1.2-C172" test="count(v3:id) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: id cardinality must be 1..*. Source: qfdd 5.11, p. 39, C172.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C173-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, C173. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]">
      <sch:assert id="QFDD-DK-1.2-C173" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: code cardinality must be 1..1. Source: qfdd 5.11, p. 39, C173.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C174-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, C174. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-C174" test="count(@code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: @code cardinality must be 1..1. Source: qfdd 5.11, p. 39, C174.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C175-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, C175. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-C175" test="count(@codeSystem) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: @codeSystem cardinality must be 1..1. Source: qfdd 5.11, p. 39, C175.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C176-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, C176. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-C176" test="count(v3:originalText) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: originalText cardinality must be 1..1. Source: qfdd 5.11, p. 39, C176.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C177-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, C177. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]">
      <sch:assert id="QFDD-DK-1.2-C177" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: languageCode cardinality must be 0..1. Source: qfdd 5.11, p. 39, C177.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C178-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, C178. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]">
      <sch:assert id="QFDD-DK-1.2-C178" test="count(v3:value) &gt;= 2" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: value cardinality must be 2..*. Source: qfdd 5.11, p. 39, C178.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C179-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, C179. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:value">
      <sch:assert id="QFDD-DK-1.2-C179" test="if (@xsi:type and matches(normalize-space(@xsi:type), '^[\i-[:]][\c-[:]]*(:[\i-[:]][\c-[:]]*)?$') and (not(contains(@xsi:type, ':')) or namespace-uri-for-prefix(substring-before(@xsi:type, ':'), .) != '')) then resolve-QName(@xsi:type, .) = (QName('urn:hl7-org:v3', 'CE')) else false()" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: xsi:type must identify a CDA datatype: CE. Source: qfdd 5.11, p. 39, C179.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C180-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, C180. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:value">
      <sch:assert id="QFDD-DK-1.2-C180" test="count(@code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: @code cardinality must be 1..1. Source: qfdd 5.11, p. 39, C180.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C181-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, C181. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:value">
      <sch:assert id="QFDD-DK-1.2-C181" test="count(@codeSystem) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: @codeSystem cardinality must be 1..1. Source: qfdd 5.11, p. 39, C181.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C182-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, C182. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:value">
      <sch:assert id="QFDD-DK-1.2-C182" test="count(@displayName) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: @displayName cardinality must be 1..1. Source: qfdd 5.11, p. 39, C182.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C197-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, C197. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]">
      <sch:assert id="QFDD-DK-1.2-C197" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: @classCode must be OBS. Source: qfdd 5.12, p. 44, C197.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C198-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, C198. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]">
      <sch:assert id="QFDD-DK-1.2-C198" test="@moodCode = 'DEF'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: @moodCode must be DEF. Source: qfdd 5.12, p. 44, C198.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C199-200-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, C199-200. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]">
      <sch:assert id="QFDD-DK-1.2-C199-200" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.9'] cardinality must be 1..1. Source: qfdd 5.12, p. 44, C199-200.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C201-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, C201. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]">
      <sch:assert id="QFDD-DK-1.2-C201" test="count(v3:id) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: id cardinality must be 1..*. Source: qfdd 5.12, p. 44, C201.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C202-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, C202. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]">
      <sch:assert id="QFDD-DK-1.2-C202" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: code cardinality must be 1..1. Source: qfdd 5.12, p. 44, C202.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C203-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, C203. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-C203" test="count(@code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: @code cardinality must be 1..1. Source: qfdd 5.12, p. 44, C203.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C204-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, C204. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-C204" test="count(@codeSystem) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: @codeSystem cardinality must be 1..1. Source: qfdd 5.12, p. 44, C204.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C205-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, C205. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-C205" test="count(v3:originalText) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: originalText cardinality must be 1..1. Source: qfdd 5.12, p. 44, C205.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C206-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, C206. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]">
      <sch:assert id="QFDD-DK-1.2-C206" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: languageCode cardinality must be 0..1. Source: qfdd 5.12, p. 44, C206.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C214-pattern">
    <sch:p>Source: qfdd, section 5.13, PDF page 45, C214. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.10']]">
      <sch:assert id="QFDD-DK-1.2-C214" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=45">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.7'] cardinality must be 1..1. Source: qfdd 5.13, p. 45, C214.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C215-pattern">
    <sch:p>Source: qfdd, section 5.13, PDF page 45, C215. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.10']]">
      <sch:assert id="QFDD-DK-1.2-C215" test="not(v3:referenceRange[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.5'])" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=45">QFDD-DK 1.2: Analog sliders must not use the interval reference-range template. Source: qfdd 5.13, p. 45, C215.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C216-217-pattern">
    <sch:p>Source: qfdd, section 5.13, PDF page 45, C216-217. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.10']]">
      <sch:assert id="QFDD-DK-1.2-C216-217" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.10']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=45">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.10'] cardinality must be 1..1. Source: qfdd 5.13, p. 45, C216-217.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C218-pattern">
    <sch:p>Source: qfdd, section 5.13, PDF page 45, C218. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.10']]">
      <sch:assert id="QFDD-DK-1.2-C218" test="count(v3:referenceRange) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=45">QFDD-DK 1.2: referenceRange cardinality must be 1..1. Source: qfdd 5.13, p. 45, C218.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C219-pattern">
    <sch:p>Source: qfdd, section 5.13, PDF page 45, C219. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.10']]/v3:referenceRange">
      <sch:assert id="QFDD-DK-1.2-C219" test="@typeCode = 'REFV'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=45">QFDD-DK 1.2: @typeCode must be REFV. Source: qfdd 5.13, p. 45, C219.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C220-pattern">
    <sch:p>Source: qfdd, section 5.13, PDF page 45, C220. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.10']]/v3:referenceRange">
      <sch:assert id="QFDD-DK-1.2-C220" test="count(v3:observationRange) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=45">QFDD-DK 1.2: observationRange cardinality must be 1..1. Source: qfdd 5.13, p. 45, C220.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C221-pattern">
    <sch:p>Source: qfdd, section 5.13, PDF page 45, C221. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.10']]/v3:referenceRange/v3:observationRange">
      <sch:assert id="QFDD-DK-1.2-C221" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=45">QFDD-DK 1.2: value cardinality must be 1..1. Source: qfdd 5.13, p. 45, C221.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C222-pattern">
    <sch:p>Source: qfdd, section 5.13, PDF page 45, C222. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.10']]/v3:referenceRange/v3:observationRange/v3:value">
      <sch:assert id="QFDD-DK-1.2-C222" test="if (@xsi:type and matches(normalize-space(@xsi:type), '^[\i-[:]][\c-[:]]*(:[\i-[:]][\c-[:]]*)?$') and (not(contains(@xsi:type, ':')) or namespace-uri-for-prefix(substring-before(@xsi:type, ':'), .) != '')) then resolve-QName(@xsi:type, .) = (QName('urn:hl7-org:v3', 'GLIST_PQ')) else false()" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=45">QFDD-DK 1.2: xsi:type must identify a CDA datatype: GLIST_PQ. Source: qfdd 5.13, p. 45, C222.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C223-pattern">
    <sch:p>Source: qfdd, section 5.13, PDF page 45, C223. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.10']]/v3:referenceRange/v3:observationRange/v3:value">
      <sch:assert id="QFDD-DK-1.2-C223" test="count(v3:head) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=45">QFDD-DK 1.2: head cardinality must be 1..1. Source: qfdd 5.13, p. 45, C223.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C224-pattern">
    <sch:p>Source: qfdd, section 5.13, PDF page 45, C224. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.10']]/v3:referenceRange/v3:observationRange/v3:value">
      <sch:assert id="QFDD-DK-1.2-C224" test="count(v3:increment) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=45">QFDD-DK 1.2: increment cardinality must be 1..1. Source: qfdd 5.13, p. 45, C224.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C225-pattern">
    <sch:p>Source: qfdd, section 5.13, PDF page 45, C225. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.10']]/v3:referenceRange/v3:observationRange/v3:value">
      <sch:assert id="QFDD-DK-1.2-C225" test="count(@denominator) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=45">QFDD-DK 1.2: @denominator cardinality must be 1..1. Source: qfdd 5.13, p. 45, C225.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C226-pattern">
    <sch:p>Source: qfdd, section 5.14, PDF page 47, C226. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.11']]">
      <sch:assert id="QFDD-DK-1.2-C226" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=47">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.8'] cardinality must be 1..1. Source: qfdd 5.14, p. 47, C226.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C227-228-pattern">
    <sch:p>Source: qfdd, section 5.14, PDF page 47, C227-228. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.11']]">
      <sch:assert id="QFDD-DK-1.2-C227-228" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.11']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=47">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.11'] cardinality must be 1..1. Source: qfdd 5.14, p. 47, C227-228.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C229-pattern">
    <sch:p>Source: qfdd, section 5.14, PDF page 47, C229. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.11']]">
      <sch:assert id="QFDD-DK-1.2-C229" test="exists(v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']) and (every $o in v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20'] satisfies ($o/v3:value/v3:high/@value = '1'))" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=47">QFDD-DK 1.2: Discrete sliders require the options template with high/@value=1. Source: qfdd 5.14, p. 47, C229.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C52-53-pattern">
    <sch:p>Source: qfdd, section 4.1; 4.3, PDF page 19, C52-53. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.1']]">
      <sch:assert id="QFDD-DK-1.2-C52-53" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.2.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=19">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.2.1'] cardinality must be 1..1. Source: qfdd 4.1; 4.3, p. 19, C52-53.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C55-pattern">
    <sch:p>Source: qfdd, section 4.1; 4.3, PDF page 19, C55. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.1']]">
      <sch:assert id="QFDD-DK-1.2-C55" test="count(v3:title) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=19">QFDD-DK 1.2: title cardinality must be 0..1. Source: qfdd 4.1; 4.3, p. 19, C55.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C56-pattern">
    <sch:p>Source: qfdd, section 4.1; 4.3, PDF page 19, C56. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.1']]">
      <sch:assert id="QFDD-DK-1.2-C56" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=19">QFDD-DK 1.2: text cardinality must be 1..1. Source: qfdd 4.1; 4.3, p. 19, C56.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C57-pattern">
    <sch:p>Source: qfdd, section 4.1; 4.3, PDF page 19, C57. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.1']]">
      <sch:assert id="QFDD-DK-1.2-C57" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=19">QFDD-DK 1.2: languageCode cardinality must be 0..1. Source: qfdd 4.1; 4.3, p. 19, C57.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C54-pattern">
    <sch:p>Source: qfdd, section 4.1; 4.3, PDF page 19, C54. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.1']][v3:entry]">
      <sch:assert id="QFDD-DK-1.2-C54" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=19">QFDD-DK 1.2: code cardinality must be 1..1. Source: qfdd 4.1; 4.3, p. 19, C54.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C54-CODE-pattern">
    <sch:p>Source: qfdd, section 4.1; 4.3, PDF page 19, C54-CODE. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.1']][v3:entry]/v3:code">
      <sch:assert id="QFDD-DK-1.2-C54-CODE" test="@code = '74468-0'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=19">QFDD-DK 1.2: @code must be 74468-0. Source: qfdd 4.1; 4.3, p. 19, C54-CODE.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C59-pattern">
    <sch:p>Source: qfdd, section 4.1; 4.3, PDF page 19, C59. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.1']]/v3:entry">
      <sch:assert id="QFDD-DK-1.2-C59" test="@typeCode = 'DRIV'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=19">QFDD-DK 1.2: @typeCode must be DRIV. Source: qfdd 4.1; 4.3, p. 19, C59.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C60-pattern">
    <sch:p>Source: qfdd, section 4.1; 4.3, PDF page 19, C60. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.1']]/v3:entry">
      <sch:assert id="QFDD-DK-1.2-C60" test="count(v3:organizer[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=19">QFDD-DK 1.2: organizer[templateId/@root='2.16.840.1.113883.10.20.32.4.1'] cardinality must be 1..1. Source: qfdd 4.1; 4.3, p. 19, C60.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C91-92-pattern">
    <sch:p>Source: qfdd, section 5.3, PDF page 26, C91-92. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:criterion[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.3']]">
      <sch:assert id="QFDD-DK-1.2-C91-92" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.3']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=26">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.3'] cardinality must be 1..1. Source: qfdd 5.3, p. 26, C91-92.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C93-pattern">
    <sch:p>Source: qfdd, section 5.3, PDF page 26, C93. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:criterion[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.3']]">
      <sch:assert id="QFDD-DK-1.2-C93" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=26">QFDD-DK 1.2: @classCode must be OBS. Source: qfdd 5.3, p. 26, C93.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C94-pattern">
    <sch:p>Source: qfdd, section 5.3, PDF page 26, C94. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:criterion[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.3']]">
      <sch:assert id="QFDD-DK-1.2-C94" test="@moodCode = 'EVN.CRT'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=26">QFDD-DK 1.2: @moodCode must be EVN.CRT. Source: qfdd 5.3, p. 26, C94.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C95-pattern">
    <sch:p>Source: qfdd, section 5.3, PDF page 26, C95. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:criterion[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.3']]">
      <sch:assert id="QFDD-DK-1.2-C95" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=26">QFDD-DK 1.2: code cardinality must be 1..1. Source: qfdd 5.3, p. 26, C95.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C96-pattern">
    <sch:p>Source: qfdd, section 5.3, PDF page 26, C96. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:criterion[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.3']]">
      <sch:assert id="QFDD-DK-1.2-C96" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=26">QFDD-DK 1.2: value cardinality must be 1..1. Source: qfdd 5.3, p. 26, C96.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C97-pattern">
    <sch:p>Source: qfdd, section 5.4, PDF page 27, C97. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:precondition[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.4']]">
      <sch:assert id="QFDD-DK-1.2-C97" test="@typeCode = 'PRCN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=27">QFDD-DK 1.2: @typeCode must be PRCN. Source: qfdd 5.4, p. 27, C97.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C98-99-pattern">
    <sch:p>Source: qfdd, section 5.4, PDF page 27, C98-99. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:precondition[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.4']]">
      <sch:assert id="QFDD-DK-1.2-C98-99" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.4']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=27">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.4'] cardinality must be 1..1. Source: qfdd 5.4, p. 27, C98-99.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C100-pattern">
    <sch:p>Source: qfdd, section 5.4, PDF page 27, C100. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:precondition[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.4']]">
      <sch:assert id="QFDD-DK-1.2-C100" test="count(v3:criterion[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.3']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=27">QFDD-DK 1.2: criterion[templateId/@root='2.16.840.1.113883.10.20.32.4.3'] cardinality must be 1..1. Source: qfdd 5.4, p. 27, C100.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C131-pattern">
    <sch:p>Source: qfdd, section 5.8, PDF page 31, C131. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.6']]">
      <sch:assert id="QFDD-DK-1.2-C131" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=31">QFDD-DK 1.2: @classCode must be OBS. Source: qfdd 5.8, p. 31, C131.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C132-pattern">
    <sch:p>Source: qfdd, section 5.8, PDF page 31, C132. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.6']]">
      <sch:assert id="QFDD-DK-1.2-C132" test="@moodCode = 'DEF'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=31">QFDD-DK 1.2: @moodCode must be DEF. Source: qfdd 5.8, p. 31, C132.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C133-134-pattern">
    <sch:p>Source: qfdd, section 5.8, PDF page 31, C133-134. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.6']]">
      <sch:assert id="QFDD-DK-1.2-C133-134" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.6']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=31">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.6'] cardinality must be 1..1. Source: qfdd 5.8, p. 31, C133-134.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C135-pattern">
    <sch:p>Source: qfdd, section 5.8, PDF page 31, C135. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.6']]">
      <sch:assert id="QFDD-DK-1.2-C135" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=31">QFDD-DK 1.2: code cardinality must be 1..1. Source: qfdd 5.8, p. 31, C135.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C135-CODE-pattern">
    <sch:p>Source: qfdd, section 5.8, PDF page 31, C135-CODE. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.6']]/v3:code">
      <sch:assert id="QFDD-DK-1.2-C135-CODE" test="@code = '74466-4'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=31">QFDD-DK 1.2: @code must be 74466-4. Source: qfdd 5.8, p. 31, C135-CODE.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C136-pattern">
    <sch:p>Source: qfdd, section 5.8, PDF page 31, C136. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.6']]">
      <sch:assert id="QFDD-DK-1.2-C136" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=31">QFDD-DK 1.2: value cardinality must be 1..1. Source: qfdd 5.8, p. 31, C136.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C137-pattern">
    <sch:p>Source: qfdd, section 5.8, PDF page 31, C137. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.6']]">
      <sch:assert id="QFDD-DK-1.2-C137" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=31">QFDD-DK 1.2: languageCode cardinality must be 0..1. Source: qfdd 5.8, p. 31, C137.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C230-pattern">
    <sch:p>Source: qfdd, section 6.1, PDF page 51, C230. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="sdtc:precondition[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.12']">
      <sch:assert id="QFDD-DK-1.2-C230" test="@typeCode = 'PRCN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=51">QFDD-DK 1.2: @typeCode must be PRCN. Source: qfdd 6.1, p. 51, C230.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C231-232-pattern">
    <sch:p>Source: qfdd, section 6.1, PDF page 51, C231-232. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="sdtc:precondition[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.12']">
      <sch:assert id="QFDD-DK-1.2-C231-232" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.12']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=51">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.12'] cardinality must be 1..1. Source: qfdd 6.1, p. 51, C231-232.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C233-pattern">
    <sch:p>Source: qfdd, section 6.1, PDF page 51, C233. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="sdtc:precondition[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.12']">
      <sch:assert id="QFDD-DK-1.2-C233" test="count(v3:conjunctionCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=51">QFDD-DK 1.2: conjunctionCode cardinality must be 0..1. Source: qfdd 6.1, p. 51, C233.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C234-241-pattern">
    <sch:p>Source: qfdd, section 6.1, PDF page 51, C234-241. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="sdtc:precondition[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.12']">
      <sch:assert id="QFDD-DK-1.2-C234-241" test="count(v3:criterion[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.3'] | v3:allTrue[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.13'] | v3:allFalse[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.14'] | v3:atLeastOneTrue[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.15'] | v3:atLeastOneFalse[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.16'] | v3:onlyOneTrue[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.17'] | v3:onlyOneFalse[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.18']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=51">QFDD-DK 1.2: criterion[templateId/@root='2.16.840.1.113883.10.20.32.4.3'] | allTrue[templateId/@root='2.16.840.1.113883.10.20.32.4.13'] | allFalse[templateId/@root='2.16.840.1.113883.10.20.32.4.14'] | atLeastOneTrue[templateId/@root='2.16.840.1.113883.10.20.32.4.15'] | atLeastOneFalse[templateId/@root='2.16.840.1.113883.10.20.32.4.16'] | onlyOneTrue[templateId/@root='2.16.840.1.113883.10.20.32.4.17'] | onlyOneFalse[templateId/@root='2.16.840.1.113883.10.20.32.4.18'] cardinality must be 1..1. Source: qfdd 6.1, p. 51, C234-241.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C243-244-pattern">
    <sch:p>Source: qfdd, section 6.2, PDF page 51, C243-244. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:allTrue[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.13']]">
      <sch:assert id="QFDD-DK-1.2-C243-244" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.13']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=51">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.13'] cardinality must be 1..1. Source: qfdd 6.2, p. 51, C243-244.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C245-pattern">
    <sch:p>Source: qfdd, section 6.2, PDF page 51, C245. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:allTrue[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.13']]">
      <sch:assert id="QFDD-DK-1.2-C245" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=51">QFDD-DK 1.2: id cardinality must be 1..1. Source: qfdd 6.2, p. 51, C245.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C246-pattern">
    <sch:p>Source: qfdd, section 6.2, PDF page 51, C246. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:allTrue[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.13']]">
      <sch:assert id="QFDD-DK-1.2-C246" test="count(sdtc:precondition[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.12']) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=51">QFDD-DK 1.2: sdtc:precondition[templateId/@root='2.16.840.1.113883.10.20.32.4.12'] cardinality must be 1..*. Source: qfdd 6.2, p. 51, C246.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C247-248-pattern">
    <sch:p>Source: qfdd, section 6.3, PDF page 51, C247-248. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:allFalse[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.14']]">
      <sch:assert id="QFDD-DK-1.2-C247-248" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.14']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=51">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.14'] cardinality must be 1..1. Source: qfdd 6.3, p. 51, C247-248.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C249-pattern">
    <sch:p>Source: qfdd, section 6.3, PDF page 51, C249. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:allFalse[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.14']]">
      <sch:assert id="QFDD-DK-1.2-C249" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=51">QFDD-DK 1.2: id cardinality must be 1..1. Source: qfdd 6.3, p. 51, C249.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C250-pattern">
    <sch:p>Source: qfdd, section 6.3, PDF page 51, C250. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:allFalse[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.14']]">
      <sch:assert id="QFDD-DK-1.2-C250" test="count(sdtc:precondition[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.12']) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=51">QFDD-DK 1.2: sdtc:precondition[templateId/@root='2.16.840.1.113883.10.20.32.4.12'] cardinality must be 1..*. Source: qfdd 6.3, p. 51, C250.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C251-252-pattern">
    <sch:p>Source: qfdd, section 6.4, PDF page 51, C251-252. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:atLeastOneTrue[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.15']]">
      <sch:assert id="QFDD-DK-1.2-C251-252" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.15']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=51">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.15'] cardinality must be 1..1. Source: qfdd 6.4, p. 51, C251-252.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C253-pattern">
    <sch:p>Source: qfdd, section 6.4, PDF page 51, C253. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:atLeastOneTrue[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.15']]">
      <sch:assert id="QFDD-DK-1.2-C253" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=51">QFDD-DK 1.2: id cardinality must be 1..1. Source: qfdd 6.4, p. 51, C253.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C254-pattern">
    <sch:p>Source: qfdd, section 6.4, PDF page 51, C254. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:atLeastOneTrue[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.15']]">
      <sch:assert id="QFDD-DK-1.2-C254" test="count(sdtc:precondition[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.12']) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=51">QFDD-DK 1.2: sdtc:precondition[templateId/@root='2.16.840.1.113883.10.20.32.4.12'] cardinality must be 1..*. Source: qfdd 6.4, p. 51, C254.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C255-256-pattern">
    <sch:p>Source: qfdd, section 6.5, PDF page 52, C255-256. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:atLeastOneFalse[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.16']]">
      <sch:assert id="QFDD-DK-1.2-C255-256" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.16']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=52">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.16'] cardinality must be 1..1. Source: qfdd 6.5, p. 52, C255-256.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C257-pattern">
    <sch:p>Source: qfdd, section 6.5, PDF page 52, C257. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:atLeastOneFalse[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.16']]">
      <sch:assert id="QFDD-DK-1.2-C257" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=52">QFDD-DK 1.2: id cardinality must be 1..1. Source: qfdd 6.5, p. 52, C257.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C258-pattern">
    <sch:p>Source: qfdd, section 6.5, PDF page 52, C258. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:atLeastOneFalse[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.16']]">
      <sch:assert id="QFDD-DK-1.2-C258" test="count(sdtc:precondition[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.12']) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=52">QFDD-DK 1.2: sdtc:precondition[templateId/@root='2.16.840.1.113883.10.20.32.4.12'] cardinality must be 1..*. Source: qfdd 6.5, p. 52, C258.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C259-260-pattern">
    <sch:p>Source: qfdd, section 6.6, PDF page 52, C259-260. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:onlyOneTrue[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.17']]">
      <sch:assert id="QFDD-DK-1.2-C259-260" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.17']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=52">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.17'] cardinality must be 1..1. Source: qfdd 6.6, p. 52, C259-260.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C261-pattern">
    <sch:p>Source: qfdd, section 6.6, PDF page 52, C261. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:onlyOneTrue[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.17']]">
      <sch:assert id="QFDD-DK-1.2-C261" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=52">QFDD-DK 1.2: id cardinality must be 1..1. Source: qfdd 6.6, p. 52, C261.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C262-pattern">
    <sch:p>Source: qfdd, section 6.6, PDF page 52, C262. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:onlyOneTrue[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.17']]">
      <sch:assert id="QFDD-DK-1.2-C262" test="count(sdtc:precondition[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.12']) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=52">QFDD-DK 1.2: sdtc:precondition[templateId/@root='2.16.840.1.113883.10.20.32.4.12'] cardinality must be 1..*. Source: qfdd 6.6, p. 52, C262.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C263-264-pattern">
    <sch:p>Source: qfdd, section 6.7, PDF page 52, C263-264. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:onlyOneFalse[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.18']]">
      <sch:assert id="QFDD-DK-1.2-C263-264" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.18']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=52">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.18'] cardinality must be 1..1. Source: qfdd 6.7, p. 52, C263-264.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C265-pattern">
    <sch:p>Source: qfdd, section 6.7, PDF page 52, C265. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:onlyOneFalse[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.18']]">
      <sch:assert id="QFDD-DK-1.2-C265" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=52">QFDD-DK 1.2: id cardinality must be 1..1. Source: qfdd 6.7, p. 52, C265.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-C266-pattern">
    <sch:p>Source: qfdd, section 6.7, PDF page 52, C266. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:onlyOneFalse[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.18']]">
      <sch:assert id="QFDD-DK-1.2-C266" test="count(sdtc:precondition[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.12']) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=52">QFDD-DK 1.2: sdtc:precondition[templateId/@root='2.16.840.1.113883.10.20.32.4.12'] cardinality must be 1..*. Source: qfdd 6.7, p. 52, C266.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C159-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, REL-C159. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]">
      <sch:assert id="QFDD-DK-1.2-REL-C159" test="count(v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: entryRelationship[observation/templateId/@root='2.16.840.1.113883.10.20.32.4.19'] cardinality must be 0..1. Source: qfdd 5.10, p. 35, REL-C159.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C160-161-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, REL-C160-161. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']">
      <sch:assert id="QFDD-DK-1.2-REL-C160-161" test="@typeCode = 'SUBJ'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: @typeCode must be SUBJ. Source: qfdd 5.10, p. 35, REL-C160-161.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C161-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, REL-C161. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']">
      <sch:assert id="QFDD-DK-1.2-REL-C161" test="count(v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: observation[templateId/@root='2.16.840.1.113883.10.20.32.4.19'] cardinality must be 1..1. Source: qfdd 5.10, p. 35, REL-C161.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C162-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, REL-C162. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]">
      <sch:assert id="QFDD-DK-1.2-REL-C162" test="count(v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.2']) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: entryRelationship[observationMedia/templateId/@root='2.16.840.1.113883.10.20.32.4.2'] cardinality must be 0..1. Source: qfdd 5.10, p. 35, REL-C162.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C163-164-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, REL-C163-164. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]/v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.2']">
      <sch:assert id="QFDD-DK-1.2-REL-C163-164" test="@typeCode = 'REFR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: @typeCode must be REFR. Source: qfdd 5.10, p. 35, REL-C163-164.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C164-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, REL-C164. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]/v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.2']">
      <sch:assert id="QFDD-DK-1.2-REL-C164" test="count(v3:observationMedia[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: observationMedia[templateId/@root='2.16.840.1.113883.10.20.32.4.2'] cardinality must be 1..1. Source: qfdd 5.10, p. 35, REL-C164.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C164A-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, REL-C164A. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]">
      <sch:assert id="QFDD-DK-1.2-REL-C164A" test="count(v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.6']) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: entryRelationship[observation/templateId/@root='2.16.840.1.113883.10.20.32.4.6'] cardinality must be 0..1. Source: qfdd 5.10, p. 35, REL-C164A.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C164B-165-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, REL-C164B-165. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.6']">
      <sch:assert id="QFDD-DK-1.2-REL-C164B-165" test="@typeCode = 'REFR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: @typeCode must be REFR. Source: qfdd 5.10, p. 35, REL-C164B-165.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C165-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, REL-C165. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.6']">
      <sch:assert id="QFDD-DK-1.2-REL-C165" test="count(v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.6']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: observation[templateId/@root='2.16.840.1.113883.10.20.32.4.6'] cardinality must be 1..1. Source: qfdd 5.10, p. 35, REL-C165.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-MEDIA-TEMPLATE-7-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, REL-MEDIA-TEMPLATE-7. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]/v3:entryRelationship/v3:observationMedia">
      <sch:assert id="QFDD-DK-1.2-REL-MEDIA-TEMPLATE-7" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.2'] cardinality must be 1..1. Source: qfdd 5.10, p. 35, REL-MEDIA-TEMPLATE-7.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C184-185-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, REL-C184-185. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']">
      <sch:assert id="QFDD-DK-1.2-REL-C184-185" test="@typeCode = 'SUBJ'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: @typeCode must be SUBJ. Source: qfdd 5.11, p. 39, REL-C184-185.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C185-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, REL-C185. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']">
      <sch:assert id="QFDD-DK-1.2-REL-C185" test="count(v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: observation[templateId/@root='2.16.840.1.113883.10.20.32.4.19'] cardinality must be 1..1. Source: qfdd 5.11, p. 39, REL-C185.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C184-186-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, REL-C184-186. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']">
      <sch:assert id="QFDD-DK-1.2-REL-C184-186" test="@typeCode = 'SUBJ'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: @typeCode must be SUBJ. Source: qfdd 5.11, p. 39, REL-C184-186.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C186-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, REL-C186. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']">
      <sch:assert id="QFDD-DK-1.2-REL-C186" test="count(v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: observation[templateId/@root='2.16.840.1.113883.10.20.32.4.20'] cardinality must be 1..1. Source: qfdd 5.11, p. 39, REL-C186.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C187-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, REL-C187. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]">
      <sch:assert id="QFDD-DK-1.2-REL-C187" test="count(v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.2']) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: entryRelationship[observationMedia/templateId/@root='2.16.840.1.113883.10.20.32.4.2'] cardinality must be 0..1. Source: qfdd 5.11, p. 39, REL-C187.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C188-189-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, REL-C188-189. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.2']">
      <sch:assert id="QFDD-DK-1.2-REL-C188-189" test="@typeCode = 'REFR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: @typeCode must be REFR. Source: qfdd 5.11, p. 39, REL-C188-189.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C189-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, REL-C189. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.2']">
      <sch:assert id="QFDD-DK-1.2-REL-C189" test="count(v3:observationMedia[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: observationMedia[templateId/@root='2.16.840.1.113883.10.20.32.4.2'] cardinality must be 1..1. Source: qfdd 5.11, p. 39, REL-C189.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C191-192-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, REL-C191-192. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.6']">
      <sch:assert id="QFDD-DK-1.2-REL-C191-192" test="@typeCode = 'REFR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: @typeCode must be REFR. Source: qfdd 5.11, p. 39, REL-C191-192.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C192-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, REL-C192. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.6']">
      <sch:assert id="QFDD-DK-1.2-REL-C192" test="count(v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.6']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: observation[templateId/@root='2.16.840.1.113883.10.20.32.4.6'] cardinality must be 1..1. Source: qfdd 5.11, p. 39, REL-C192.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C193-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, REL-C193. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]">
      <sch:assert id="QFDD-DK-1.2-REL-C193" test="count(v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.9']) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: entryRelationship[observation/templateId/@root='2.16.840.1.113883.10.20.32.4.9'] cardinality must be 0..1. Source: qfdd 5.11, p. 39, REL-C193.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C194-195-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, REL-C194-195. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.9']">
      <sch:assert id="QFDD-DK-1.2-REL-C194-195" test="@typeCode = 'REFR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: @typeCode must be REFR. Source: qfdd 5.11, p. 39, REL-C194-195.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C195-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, REL-C195. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.9']">
      <sch:assert id="QFDD-DK-1.2-REL-C195" test="count(v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.9']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: observation[templateId/@root='2.16.840.1.113883.10.20.32.4.9'] cardinality must be 1..1. Source: qfdd 5.11, p. 39, REL-C195.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-MEDIA-TEMPLATE-8-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, REL-MEDIA-TEMPLATE-8. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:entryRelationship/v3:observationMedia">
      <sch:assert id="QFDD-DK-1.2-REL-MEDIA-TEMPLATE-8" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.2'] cardinality must be 1..1. Source: qfdd 5.11, p. 39, REL-MEDIA-TEMPLATE-8.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C207-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, REL-C207. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]">
      <sch:assert id="QFDD-DK-1.2-REL-C207" test="count(v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: entryRelationship[observation/templateId/@root='2.16.840.1.113883.10.20.32.4.19'] cardinality must be 0..1. Source: qfdd 5.12, p. 44, REL-C207.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C208-209-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, REL-C208-209. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']">
      <sch:assert id="QFDD-DK-1.2-REL-C208-209" test="@typeCode = 'SUBJ'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: @typeCode must be SUBJ. Source: qfdd 5.12, p. 44, REL-C208-209.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C209-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, REL-C209. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']">
      <sch:assert id="QFDD-DK-1.2-REL-C209" test="count(v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: observation[templateId/@root='2.16.840.1.113883.10.20.32.4.19'] cardinality must be 1..1. Source: qfdd 5.12, p. 44, REL-C209.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C210-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, REL-C210. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]">
      <sch:assert id="QFDD-DK-1.2-REL-C210" test="count(v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.2']) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: entryRelationship[observationMedia/templateId/@root='2.16.840.1.113883.10.20.32.4.2'] cardinality must be 0..1. Source: qfdd 5.12, p. 44, REL-C210.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C211-212-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, REL-C211-212. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]/v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.2']">
      <sch:assert id="QFDD-DK-1.2-REL-C211-212" test="@typeCode = 'REFR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: @typeCode must be REFR. Source: qfdd 5.12, p. 44, REL-C211-212.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-C212-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, REL-C212. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]/v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.2']">
      <sch:assert id="QFDD-DK-1.2-REL-C212" test="count(v3:observationMedia[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: observationMedia[templateId/@root='2.16.840.1.113883.10.20.32.4.2'] cardinality must be 1..1. Source: qfdd 5.12, p. 44, REL-C212.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-REL-MEDIA-TEMPLATE-9-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, REL-MEDIA-TEMPLATE-9. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]/v3:entryRelationship/v3:observationMedia">
      <sch:assert id="QFDD-DK-1.2-REL-MEDIA-TEMPLATE-9" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.2'] cardinality must be 1..1. Source: qfdd 5.12, p. 44, REL-MEDIA-TEMPLATE-9.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-PRE-C77-pattern">
    <sch:p>Source: qfdd, section 5.1, PDF page 23, PRE-C77. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.1']]/v3:precondition">
      <sch:assert id="QFDD-DK-1.2-PRE-C77" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.4']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.4'] cardinality must be 1..1. Source: qfdd 5.1, p. 23, PRE-C77.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SDTC-C77-pattern">
    <sch:p>Source: qfdd, section 5.1, PDF page 23, SDTC-C77. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.1']]/sdtc:precondition">
      <sch:assert id="QFDD-DK-1.2-SDTC-C77" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.12']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.12'] cardinality must be 1..1. Source: qfdd 5.1, p. 23, SDTC-C77.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-PRE-C138-pattern">
    <sch:p>Source: qfdd, section 5.8, PDF page 31, PRE-C138. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.6']]/v3:precondition">
      <sch:assert id="QFDD-DK-1.2-PRE-C138" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.4']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=31">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.4'] cardinality must be 1..1. Source: qfdd 5.8, p. 31, PRE-C138.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SDTC-C138-pattern">
    <sch:p>Source: qfdd, section 5.8, PDF page 31, SDTC-C138. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.6']]/sdtc:precondition">
      <sch:assert id="QFDD-DK-1.2-SDTC-C138" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.12']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=31">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.12'] cardinality must be 1..1. Source: qfdd 5.8, p. 31, SDTC-C138.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-PRE-C166-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, PRE-C166. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]/v3:precondition">
      <sch:assert id="QFDD-DK-1.2-PRE-C166" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.4']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.4'] cardinality must be 1..1. Source: qfdd 5.10, p. 35, PRE-C166.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SDTC-C166-pattern">
    <sch:p>Source: qfdd, section 5.10, PDF page 35, SDTC-C166. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.7']]/sdtc:precondition">
      <sch:assert id="QFDD-DK-1.2-SDTC-C166" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.12']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=35">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.12'] cardinality must be 1..1. Source: qfdd 5.10, p. 35, SDTC-C166.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-PRE-C196-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, PRE-C196. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/v3:precondition">
      <sch:assert id="QFDD-DK-1.2-PRE-C196" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.4']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.4'] cardinality must be 1..1. Source: qfdd 5.11, p. 39, PRE-C196.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SDTC-C196-pattern">
    <sch:p>Source: qfdd, section 5.11, PDF page 39, SDTC-C196. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.8']]/sdtc:precondition">
      <sch:assert id="QFDD-DK-1.2-SDTC-C196" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.12']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=39">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.12'] cardinality must be 1..1. Source: qfdd 5.11, p. 39, SDTC-C196.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-PRE-C213-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, PRE-C213. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]/v3:precondition">
      <sch:assert id="QFDD-DK-1.2-PRE-C213" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.4']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.4'] cardinality must be 1..1. Source: qfdd 5.12, p. 44, PRE-C213.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QFDD-DK-1.2-SDTC-C213-pattern">
    <sch:p>Source: qfdd, section 5.12, PDF page 44, SDTC-C213. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.9']]/sdtc:precondition">
      <sch:assert id="QFDD-DK-1.2-SDTC-C213" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.12']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=44">QFDD-DK 1.2: templateId[@root='2.16.840.1.113883.10.20.32.4.12'] cardinality must be 1..1. Source: qfdd 5.12, p. 44, SDTC-C213.</sch:assert>
    </sch:rule>
  </sch:pattern>
<sch:pattern id="QFDD-DK-1.2-GROUPER-allTrue-classCode-pattern"><sch:p>Source: QFDD-DK 1.2, appendix A, PDF page 49: Grouper Attributes.</sch:p><sch:rule context="v3:allTrue"><sch:assert id="QFDD-DK-1.2-GROUPER-allTrue-classCode" flag="error" test="@classCode='GROUPER'" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=49">QFDD-DK 1.2: grouper @classCode must be GROUPER. Source: appendix A, p. 49, Grouper Attributes.</sch:assert></sch:rule></sch:pattern><sch:pattern id="QFDD-DK-1.2-GROUPER-allTrue-moodCode-pattern"><sch:p>Source: QFDD-DK 1.2, appendix A, PDF page 49: Grouper Attributes.</sch:p><sch:rule context="v3:allTrue"><sch:assert id="QFDD-DK-1.2-GROUPER-allTrue-moodCode" flag="error" test="@moodCode='EVN'" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=49">QFDD-DK 1.2: grouper @moodCode must be EVN. Source: appendix A, p. 49, Grouper Attributes.</sch:assert></sch:rule></sch:pattern><sch:pattern id="QFDD-DK-1.2-GROUPER-allFalse-classCode-pattern"><sch:p>Source: QFDD-DK 1.2, appendix A, PDF page 49: Grouper Attributes.</sch:p><sch:rule context="v3:allFalse"><sch:assert id="QFDD-DK-1.2-GROUPER-allFalse-classCode" flag="error" test="@classCode='GROUPER'" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=49">QFDD-DK 1.2: grouper @classCode must be GROUPER. Source: appendix A, p. 49, Grouper Attributes.</sch:assert></sch:rule></sch:pattern><sch:pattern id="QFDD-DK-1.2-GROUPER-allFalse-moodCode-pattern"><sch:p>Source: QFDD-DK 1.2, appendix A, PDF page 49: Grouper Attributes.</sch:p><sch:rule context="v3:allFalse"><sch:assert id="QFDD-DK-1.2-GROUPER-allFalse-moodCode" flag="error" test="@moodCode='EVN'" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=49">QFDD-DK 1.2: grouper @moodCode must be EVN. Source: appendix A, p. 49, Grouper Attributes.</sch:assert></sch:rule></sch:pattern><sch:pattern id="QFDD-DK-1.2-GROUPER-atLeastOneTrue-classCode-pattern"><sch:p>Source: QFDD-DK 1.2, appendix A, PDF page 49: Grouper Attributes.</sch:p><sch:rule context="v3:atLeastOneTrue"><sch:assert id="QFDD-DK-1.2-GROUPER-atLeastOneTrue-classCode" flag="error" test="@classCode='GROUPER'" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=49">QFDD-DK 1.2: grouper @classCode must be GROUPER. Source: appendix A, p. 49, Grouper Attributes.</sch:assert></sch:rule></sch:pattern><sch:pattern id="QFDD-DK-1.2-GROUPER-atLeastOneTrue-moodCode-pattern"><sch:p>Source: QFDD-DK 1.2, appendix A, PDF page 49: Grouper Attributes.</sch:p><sch:rule context="v3:atLeastOneTrue"><sch:assert id="QFDD-DK-1.2-GROUPER-atLeastOneTrue-moodCode" flag="error" test="@moodCode='EVN'" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=49">QFDD-DK 1.2: grouper @moodCode must be EVN. Source: appendix A, p. 49, Grouper Attributes.</sch:assert></sch:rule></sch:pattern><sch:pattern id="QFDD-DK-1.2-GROUPER-atLeastOneFalse-classCode-pattern"><sch:p>Source: QFDD-DK 1.2, appendix A, PDF page 49: Grouper Attributes.</sch:p><sch:rule context="v3:atLeastOneFalse"><sch:assert id="QFDD-DK-1.2-GROUPER-atLeastOneFalse-classCode" flag="error" test="@classCode='GROUPER'" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=49">QFDD-DK 1.2: grouper @classCode must be GROUPER. Source: appendix A, p. 49, Grouper Attributes.</sch:assert></sch:rule></sch:pattern><sch:pattern id="QFDD-DK-1.2-GROUPER-atLeastOneFalse-moodCode-pattern"><sch:p>Source: QFDD-DK 1.2, appendix A, PDF page 49: Grouper Attributes.</sch:p><sch:rule context="v3:atLeastOneFalse"><sch:assert id="QFDD-DK-1.2-GROUPER-atLeastOneFalse-moodCode" flag="error" test="@moodCode='EVN'" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=49">QFDD-DK 1.2: grouper @moodCode must be EVN. Source: appendix A, p. 49, Grouper Attributes.</sch:assert></sch:rule></sch:pattern><sch:pattern id="QFDD-DK-1.2-GROUPER-onlyOneTrue-classCode-pattern"><sch:p>Source: QFDD-DK 1.2, appendix A, PDF page 49: Grouper Attributes.</sch:p><sch:rule context="v3:onlyOneTrue"><sch:assert id="QFDD-DK-1.2-GROUPER-onlyOneTrue-classCode" flag="error" test="@classCode='GROUPER'" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=49">QFDD-DK 1.2: grouper @classCode must be GROUPER. Source: appendix A, p. 49, Grouper Attributes.</sch:assert></sch:rule></sch:pattern><sch:pattern id="QFDD-DK-1.2-GROUPER-onlyOneTrue-moodCode-pattern"><sch:p>Source: QFDD-DK 1.2, appendix A, PDF page 49: Grouper Attributes.</sch:p><sch:rule context="v3:onlyOneTrue"><sch:assert id="QFDD-DK-1.2-GROUPER-onlyOneTrue-moodCode" flag="error" test="@moodCode='EVN'" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=49">QFDD-DK 1.2: grouper @moodCode must be EVN. Source: appendix A, p. 49, Grouper Attributes.</sch:assert></sch:rule></sch:pattern><sch:pattern id="QFDD-DK-1.2-GROUPER-onlyOneFalse-classCode-pattern"><sch:p>Source: QFDD-DK 1.2, appendix A, PDF page 49: Grouper Attributes.</sch:p><sch:rule context="v3:onlyOneFalse"><sch:assert id="QFDD-DK-1.2-GROUPER-onlyOneFalse-classCode" flag="error" test="@classCode='GROUPER'" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=49">QFDD-DK 1.2: grouper @classCode must be GROUPER. Source: appendix A, p. 49, Grouper Attributes.</sch:assert></sch:rule></sch:pattern><sch:pattern id="QFDD-DK-1.2-GROUPER-onlyOneFalse-moodCode-pattern"><sch:p>Source: QFDD-DK 1.2, appendix A, PDF page 49: Grouper Attributes.</sch:p><sch:rule context="v3:onlyOneFalse"><sch:assert id="QFDD-DK-1.2-GROUPER-onlyOneFalse-moodCode" flag="error" test="@moodCode='EVN'" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=49">QFDD-DK 1.2: grouper @moodCode must be EVN. Source: appendix A, p. 49, Grouper Attributes.</sch:assert></sch:rule></sch:pattern></sch:schema>
