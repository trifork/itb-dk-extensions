<?xml version='1.0' encoding='UTF-8'?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:title>QRD-DK 1.3.2: conformance extracted from MedCom specifications</sch:title>
  <sch:ns prefix="v3" uri="urn:hl7-org:v3"/>
  <sch:ns prefix="sdtc" uri="urn:hl7-org:sdtc"/>
  <sch:ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
  <sch:ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
  <sch:pattern id="QRD-DK-1.3.2-C1-pattern">
    <sch:p>Source: qrd, section 2.2, PDF page 13, C1. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-C1" test="count(v3:realmCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=13">QRD-DK 1.3.2: realmCode cardinality must be 1..1. Source: qrd 2.2, p. 13, C1.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C3-pattern">
    <sch:p>Source: qrd, section 2.2, PDF page 13, C3. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-C3" test="count(v3:typeId) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=13">QRD-DK 1.3.2: typeId cardinality must be 1..1. Source: qrd 2.2, p. 13, C3.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C9-pattern">
    <sch:p>Source: qrd, section 2.2, PDF page 13, C9. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-C9" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=13">QRD-DK 1.3.2: id cardinality must be 1..1. Source: qrd 2.2, p. 13, C9.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C11-pattern">
    <sch:p>Source: qrd, section 2.2, PDF page 13, C11. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-C11" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=13">QRD-DK 1.3.2: code cardinality must be 1..1. Source: qrd 2.2, p. 13, C11.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C14-pattern">
    <sch:p>Source: qrd, section 2.2, PDF page 13, C14. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-C14" test="count(v3:title) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=13">QRD-DK 1.3.2: title cardinality must be 1..1. Source: qrd 2.2, p. 13, C14.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C15-pattern">
    <sch:p>Source: qrd, section 2.2, PDF page 13, C15. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-C15" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=13">QRD-DK 1.3.2: effectiveTime cardinality must be 1..1. Source: qrd 2.2, p. 13, C15.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C16-pattern">
    <sch:p>Source: qrd, section 2.2, PDF page 13, C16. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-C16" test="count(v3:confidentialityCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=13">QRD-DK 1.3.2: confidentialityCode cardinality must be 1..1. Source: qrd 2.2, p. 13, C16.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C17-pattern">
    <sch:p>Source: qrd, section 2.2, PDF page 13, C17. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-C17" test="count(v3:languageCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=13">QRD-DK 1.3.2: languageCode cardinality must be 1..1. Source: qrd 2.2, p. 13, C17.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C4-pattern">
    <sch:p>Source: qrd, section 2.2, PDF page 13, C4. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:typeId">
      <sch:assert id="QRD-DK-1.3.2-C4" test="@root = '2.16.840.1.113883.1.3'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=13">QRD-DK 1.3.2: @root must be 2.16.840.1.113883.1.3. Source: qrd 2.2, p. 13, C4.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C5-pattern">
    <sch:p>Source: qrd, section 2.2, PDF page 13, C5. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:typeId">
      <sch:assert id="QRD-DK-1.3.2-C5" test="@extension = 'POCD_HD000040'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=13">QRD-DK 1.3.2: @extension must be POCD_HD000040. Source: qrd 2.2, p. 13, C5.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK4-pattern">
    <sch:p>Source: qrd, section 2.2, PDF page 13, DK4. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:confidentialityCode">
      <sch:assert id="QRD-DK-1.3.2-DK4" test="@code = 'N'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=13">QRD-DK 1.3.2: @code must be N. Source: qrd 2.2, p. 13, DK4.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK3-CODE-pattern">
    <sch:p>Source: qrd, section 2.2; sender test protocol 3.4, document code, PDF page 13, DK3-CODE. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:code">
      <sch:assert id="QRD-DK-1.3.2-DK3-CODE" test="@code = '74465-6'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=13">QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 2.2; sender test protocol 3.4, document code, p. 13, DK3-CODE.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK3-SYSTEM-pattern">
    <sch:p>Source: qrd, section 2.2; sender test protocol 3.4, document code, PDF page 13, DK3-SYSTEM. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:code">
      <sch:assert id="QRD-DK-1.3.2-DK3-SYSTEM" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=13">QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 2.2; sender test protocol 3.4, document code, p. 13, DK3-SYSTEM.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C18-pattern">
    <sch:p>Source: qrd, section 2.2.1, PDF page 15, C18. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-C18" test="count(v3:recordTarget) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=15">QRD-DK 1.3.2: recordTarget cardinality must be 1..1. Source: qrd 2.2.1, p. 15, C18.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C19-pattern">
    <sch:p>Source: qrd, section 2.2.1, PDF page 15, C19. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:recordTarget">
      <sch:assert id="QRD-DK-1.3.2-C19" test="count(v3:patientRole) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=15">QRD-DK 1.3.2: patientRole cardinality must be 1..1. Source: qrd 2.2.1, p. 15, C19.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK5-pattern">
    <sch:p>Source: qrd, section 2.2.1, PDF page 15, DK5. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole">
      <sch:assert id="QRD-DK-1.3.2-DK5" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=15">QRD-DK 1.3.2: id cardinality must be 1..1. Source: qrd 2.2.1, p. 15, DK5.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C21-pattern">
    <sch:p>Source: qrd, section 2.2.1, PDF page 15, C21. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole">
      <sch:assert id="QRD-DK-1.3.2-C21" test="count(v3:addr) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=15">QRD-DK 1.3.2: addr cardinality must be 1..1. Source: qrd 2.2.1, p. 15, C21.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C23-pattern">
    <sch:p>Source: qrd, section 2.2.1, PDF page 15, C23. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole">
      <sch:assert id="QRD-DK-1.3.2-C23" test="count(v3:patient) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=15">QRD-DK 1.3.2: patient cardinality must be 1..1. Source: qrd 2.2.1, p. 15, C23.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C22-pattern">
    <sch:p>Source: qrd, section 2.2.1, PDF page 15, C22. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole">
      <sch:assert id="QRD-DK-1.3.2-C22" test="count(v3:telecom) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=15">QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.1, p. 15, C22.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C24-pattern">
    <sch:p>Source: qrd, section 2.2.1, PDF page 15, C24. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:patient">
      <sch:assert id="QRD-DK-1.3.2-C24" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=15">QRD-DK 1.3.2: name cardinality must be 1..1. Source: qrd 2.2.1, p. 15, C24.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C25-GENDER-pattern">
    <sch:p>Source: qrd, section 2.2.1, PDF page 15, C25-GENDER. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:patient">
      <sch:assert id="QRD-DK-1.3.2-C25-GENDER" test="count(v3:administrativeGenderCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=15">QRD-DK 1.3.2: administrativeGenderCode cardinality must be 1..1. Source: qrd 2.2.1, p. 15, C25-GENDER.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C25-BIRTH-pattern">
    <sch:p>Source: qrd, section 2.2.1, PDF page 15, C25-BIRTH. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:patient">
      <sch:assert id="QRD-DK-1.3.2-C25-BIRTH" test="count(v3:birthTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=15">QRD-DK 1.3.2: birthTime cardinality must be 1..1. Source: qrd 2.2.1, p. 15, C25-BIRTH.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK6-8-pattern">
    <sch:p>Source: qrd, section 2.2.1, PDF page 15, CONF:27; CONF-DK:6-8. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:patient/v3:birthTime">
      <sch:assert id="QRD-DK-1.3.2-DK6-8" test="matches(string(@value), '^[0-9]{8}000000\+0000$') and concat(substring(@value,1,4), '-', substring(@value,5,2), '-', substring(@value,7,2)) castable as xs:date" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=15">QRD-DK 1.3.2: Birth time must contain a valid calendar date followed by 000000+0000. Source: qrd 2.2.1, p. 15, CONF:27; CONF-DK:6-8.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C29-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, C29. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-C29" test="count(v3:author) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: author cardinality must be 1..*. Source: qrd 2.2.2, p. 16, C29.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C30-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, C30. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author">
      <sch:assert id="QRD-DK-1.3.2-C30" test="count(v3:time) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: time cardinality must be 1..1. Source: qrd 2.2.2, p. 16, C30.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C31-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, C31. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author">
      <sch:assert id="QRD-DK-1.3.2-C31" test="count(v3:assignedAuthor) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: assignedAuthor cardinality must be 1..1. Source: qrd 2.2.2, p. 16, C31.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C32-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, C32. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <sch:assert id="QRD-DK-1.3.2-C32" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: id cardinality must be 1..1. Source: qrd 2.2.2, p. 16, C32.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C36-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, C36. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <sch:assert id="QRD-DK-1.3.2-C36" test="count(v3:addr) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: addr cardinality must be 1..*. Source: qrd 2.2.2, p. 16, C36.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C37-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, C37. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <sch:assert id="QRD-DK-1.3.2-C37" test="count(v3:telecom) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.2, p. 16, C37.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-AUTHOR-ORGANISATION-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, AUTHOR-ORGANISATION. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <sch:assert id="QRD-DK-1.3.2-AUTHOR-ORGANISATION" test="count(v3:representedOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: representedOrganization cardinality must be 1..1. Source: qrd 2.2.2, p. 16, AUTHOR-ORGANISATION.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C40-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, C40. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:assignedPerson">
      <sch:assert id="QRD-DK-1.3.2-C40" test="count(v3:name) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: name cardinality must be 1..*. Source: qrd 2.2.2, p. 16, C40.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK9-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, DK9. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <sch:assert id="QRD-DK-1.3.2-DK9" test="count(v3:assignedPerson) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: assignedPerson cardinality must be 1..1. Source: qrd 2.2.2, p. 16, DK9.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK30-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, CONF-DK:30-36 (identifier structure only). See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:id">
      <sch:assert id="QRD-DK-1.3.2-DK30" test="@root = ('1.2.208.176.1.2','1.2.208.176.1.1') and normalize-space(@extension) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: Author identity must use a CPR or SOR root and a nonempty extension. Source: qrd 2.2.2, p. 16, CONF-DK:30-36 (identifier structure only).</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK31-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, DK31. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:id[@root='1.2.208.176.1.2']">
      <sch:assert id="QRD-DK-1.3.2-DK31" test="@assigningAuthorityName = 'CPR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: @assigningAuthorityName must be CPR. Source: qrd 2.2.2, p. 16, DK31.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK34-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, DK34. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:id[@root='1.2.208.176.1.1']">
      <sch:assert id="QRD-DK-1.3.2-DK34" test="@assigningAuthorityName = 'SOR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: @assigningAuthorityName must be SOR. Source: qrd 2.2.2, p. 16, DK34.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C34-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, C34. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor[v3:id/@root='1.2.208.176.1.2']">
      <sch:assert id="QRD-DK-1.3.2-C34" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: code cardinality must be 1..1. Source: qrd 2.2.2, p. 16, C34.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK37-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, DK37. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor">
      <sch:assert id="QRD-DK-1.3.2-DK37" test="not(v3:id[@root='1.2.208.176.1.2']/@extension = /v3:ClinicalDocument/v3:recordTarget/v3:patientRole/v3:id[@root='1.2.208.176.1.2']/@extension) or (v3:code/@code='SELF' and v3:code/@codeSystem='2.16.840.1.113883.5.111' and v3:code/@codeSystemName='HL7 Role code' and v3:code/@displayName='self')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK38-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, DK38. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:code[@code='GUARD']">
      <sch:assert id="QRD-DK-1.3.2-DK38" test="@codeSystem='2.16.840.1.113883.5.111' and @codeSystemName='HL7 Role code' and @displayName='guardian'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: A declared guardian role must use the prescribed code system and labels; guardianship itself requires external verification. Source: qrd 2.2.2, p. 16, DK38.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK39-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, DK39. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:representedOrganization">
      <sch:assert id="QRD-DK-1.3.2-DK39" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: id cardinality must be 1..1. Source: qrd 2.2.2, p. 16, DK39.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK40-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, DK40. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:representedOrganization/v3:id">
      <sch:assert id="QRD-DK-1.3.2-DK40" test="@assigningAuthorityName = 'SOR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: @assigningAuthorityName must be SOR. Source: qrd 2.2.2, p. 16, DK40.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK41-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, DK41. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:representedOrganization/v3:id">
      <sch:assert id="QRD-DK-1.3.2-DK41" test="@root = '1.2.208.176.1.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: @root must be 1.2.208.176.1.1. Source: qrd 2.2.2, p. 16, DK41.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK42-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, DK42. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:representedOrganization/v3:id">
      <sch:assert id="QRD-DK-1.3.2-DK42" test="normalize-space(@extension) != ''" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: A SOR identifier is required; existence and organisational responsibility require external verification. Source: qrd 2.2.2, p. 16, DK42.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK43-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, DK43. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:representedOrganization">
      <sch:assert id="QRD-DK-1.3.2-DK43" test="count(v3:telecom) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.2, p. 16, DK43.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK44-pattern">
    <sch:p>Source: qrd, section 2.2.2, PDF page 16, DK44. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:author/v3:assignedAuthor/v3:representedOrganization">
      <sch:assert id="QRD-DK-1.3.2-DK44" test="count(v3:addr) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16">QRD-DK 1.3.2: addr cardinality must be 1..*. Source: qrd 2.2.2, p. 16, DK44.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C60-pattern">
    <sch:p>Source: qrd, section 2.2.5, PDF page 22, C60. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-C60" test="count(v3:custodian) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=22">QRD-DK 1.3.2: custodian cardinality must be 1..1. Source: qrd 2.2.5, p. 22, C60.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C61-pattern">
    <sch:p>Source: qrd, section 2.2.5, PDF page 22, C61. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:custodian">
      <sch:assert id="QRD-DK-1.3.2-C61" test="count(v3:assignedCustodian) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=22">QRD-DK 1.3.2: assignedCustodian cardinality must be 1..1. Source: qrd 2.2.5, p. 22, C61.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C62-pattern">
    <sch:p>Source: qrd, section 2.2.5, PDF page 22, C62. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian">
      <sch:assert id="QRD-DK-1.3.2-C62" test="count(v3:representedCustodianOrganization) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=22">QRD-DK 1.3.2: representedCustodianOrganization cardinality must be 1..1. Source: qrd 2.2.5, p. 22, C62.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C63-pattern">
    <sch:p>Source: qrd, section 2.2.5, PDF page 22, C63. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <sch:assert id="QRD-DK-1.3.2-C63" test="count(v3:id) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=22">QRD-DK 1.3.2: id cardinality must be 1..*. Source: qrd 2.2.5, p. 22, C63.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C64-pattern">
    <sch:p>Source: qrd, section 2.2.5, PDF page 22, C64. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <sch:assert id="QRD-DK-1.3.2-C64" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=22">QRD-DK 1.3.2: name cardinality must be 1..1. Source: qrd 2.2.5, p. 22, C64.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C65-pattern">
    <sch:p>Source: qrd, section 2.2.5, PDF page 22, C65. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <sch:assert id="QRD-DK-1.3.2-C65" test="count(v3:telecom) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=22">QRD-DK 1.3.2: telecom cardinality must be 1..1. Source: qrd 2.2.5, p. 22, C65.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C67-pattern">
    <sch:p>Source: qrd, section 2.2.5, PDF page 22, C67. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization">
      <sch:assert id="QRD-DK-1.3.2-C67" test="count(v3:addr) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=22">QRD-DK 1.3.2: addr cardinality must be 1..1. Source: qrd 2.2.5, p. 22, C67.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C66-pattern">
    <sch:p>Source: qrd, section 2.2.5, PDF page 22, C66. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:custodian/v3:assignedCustodian/v3:representedCustodianOrganization/v3:telecom">
      <sch:assert id="QRD-DK-1.3.2-C66" test="count(@use) = 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=22">QRD-DK 1.3.2: @use cardinality must be 1..1. Source: qrd 2.2.5, p. 22, C66.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C114-pattern">
    <sch:p>Source: qrd, section 3.1, PDF page 30, C114. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-C114" test="count(v3:component) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=30">QRD-DK 1.3.2: component cardinality must be 1..1. Source: qrd 3.1, p. 30, C114.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C115-pattern">
    <sch:p>Source: qrd, section 3.1, PDF page 30, C115. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:component">
      <sch:assert id="QRD-DK-1.3.2-C115" test="count(v3:structuredBody) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=30">QRD-DK 1.3.2: structuredBody cardinality must be 1..1. Source: qrd 3.1, p. 30, C115.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C116-pattern">
    <sch:p>Source: qrd, section 3.1, PDF page 30, C116. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:component/v3:structuredBody">
      <sch:assert id="QRD-DK-1.3.2-C116" test="count(v3:component) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=30">QRD-DK 1.3.2: component cardinality must be 1..*. Source: qrd 3.1, p. 30, C116.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C117-pattern">
    <sch:p>Source: qrd, section 3.1, PDF page 30, C117. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:component/v3:structuredBody/v3:component">
      <sch:assert id="QRD-DK-1.3.2-C117" test="count(v3:section) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=30">QRD-DK 1.3.2: section cardinality must be 1..1. Source: qrd 3.1, p. 30, C117.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C112-113-pattern">
    <sch:p>Source: qrd, section 3.1, PDF page 30, C112-113. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-C112-113" test="count(v3:templateId[@root='1.2.208.184.13.1.1.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=30">QRD-DK 1.3.2: templateId[@root='1.2.208.184.13.1.1.1'] cardinality must be 1..1. Source: qrd 3.1, p. 30, C112-113.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-COPY-C61-62-pattern">
    <sch:p>Source: qfdd, section 4.2 (QFDD imported by QRD 1.6.1), PDF page 20, COPY-C61-62. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']]">
      <sch:assert id="QRD-DK-1.3.2-COPY-C61-62" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.32.2.2'] cardinality must be 1..1. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C61-62.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-COPY-C63-pattern">
    <sch:p>Source: qfdd, section 4.2 (QFDD imported by QRD 1.6.1), PDF page 20, COPY-C63. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']]">
      <sch:assert id="QRD-DK-1.3.2-COPY-C63" test="count(v3:title) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20">QRD-DK 1.3.2: title cardinality must be 0..1. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C63.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-COPY-C64-pattern">
    <sch:p>Source: qfdd, section 4.2 (QFDD imported by QRD 1.6.1), PDF page 20, COPY-C64. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']]">
      <sch:assert id="QRD-DK-1.3.2-COPY-C64" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20">QRD-DK 1.3.2: text cardinality must be 1..1. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C64.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-COPY-C65-pattern">
    <sch:p>Source: qfdd, section 4.2 (QFDD imported by QRD 1.6.1), PDF page 20, COPY-C65. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']]">
      <sch:assert id="QRD-DK-1.3.2-COPY-C65" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20">QRD-DK 1.3.2: languageCode cardinality must be 0..1. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C65.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-COPY-C66-pattern">
    <sch:p>Source: qfdd, section 4.2 (QFDD imported by QRD 1.6.1), PDF page 20, COPY-C66. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']]">
      <sch:assert id="QRD-DK-1.3.2-COPY-C66" test="count(v3:entry) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20">QRD-DK 1.3.2: entry cardinality must be 1..*. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C66.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-COPY-C67-pattern">
    <sch:p>Source: qfdd, section 4.2 (QFDD imported by QRD 1.6.1), PDF page 20, COPY-C67. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']]/v3:entry">
      <sch:assert id="QRD-DK-1.3.2-COPY-C67" test="@typeCode = 'DRIV'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20">QRD-DK 1.3.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-COPY-C68-pattern">
    <sch:p>Source: qfdd, section 4.2 (QFDD imported by QRD 1.6.1), PDF page 20, COPY-C68. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.2']]/v3:entry">
      <sch:assert id="QRD-DK-1.3.2-COPY-C68" test="count(v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.21']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20">QRD-DK 1.3.2: observation[templateId/@root='2.16.840.1.113883.10.20.32.4.21'] cardinality must be 1..1. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C68.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C101-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C101. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C101" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QRD-DK 1.3.2: @classCode must be OBS. Source: qfdd 5.5, p. 28, SHARED-C101.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C102-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C102. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C102" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QRD-DK 1.3.2: @moodCode must be EVN. Source: qfdd 5.5, p. 28, SHARED-C102.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C103-104-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C103-104. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C103-104" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.32.4.19'] cardinality must be 1..1. Source: qfdd 5.5, p. 28, SHARED-C103-104.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C105-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C105. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C105" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QRD-DK 1.3.2: code cardinality must be 1..1. Source: qfdd 5.5, p. 28, SHARED-C105.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C106-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C106. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C106" test="@code = '48767-8'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QRD-DK 1.3.2: @code must be 48767-8. Source: qfdd 5.5, p. 28, SHARED-C106.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C107-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C107. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C107" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qfdd 5.5, p. 28, SHARED-C107.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C108-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C108. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C108" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QRD-DK 1.3.2: value cardinality must be 1..1. Source: qfdd 5.5, p. 28, SHARED-C108.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C109-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C109. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]/v3:value">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C109" test="if (@xsi:type and matches(normalize-space(@xsi:type), '^[\i-[:]][\c-[:]]*(:[\i-[:]][\c-[:]]*)?$') and (not(contains(@xsi:type, ':')) or namespace-uri-for-prefix(substring-before(@xsi:type, ':'), .) != '')) then resolve-QName(@xsi:type, .) = (QName('urn:hl7-org:v3', 'ST')) else false()" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QRD-DK 1.3.2: xsi:type must identify a CDA datatype: ST. Source: qfdd 5.5, p. 28, SHARED-C109.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C110-pattern">
    <sch:p>Source: qfdd, section 5.5, PDF page 28, SHARED-C110. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.19']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C110" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=28">QRD-DK 1.3.2: languageCode cardinality must be 0..1. Source: qfdd 5.5, p. 28, SHARED-C110.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C120-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C120. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C120" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QRD-DK 1.3.2: @classCode must be OBS. Source: qfdd 5.7, p. 30, SHARED-C120.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C121-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C121. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C121" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QRD-DK 1.3.2: @moodCode must be EVN. Source: qfdd 5.7, p. 30, SHARED-C121.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C122-123-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C122-123. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C122-123" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.32.4.20'] cardinality must be 1..1. Source: qfdd 5.7, p. 30, SHARED-C122-123.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C124-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C124. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C124" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QRD-DK 1.3.2: code cardinality must be 1..1. Source: qfdd 5.7, p. 30, SHARED-C124.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C125-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C125. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C125" test="@code = '74467-2'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QRD-DK 1.3.2: @code must be 74467-2. Source: qfdd 5.7, p. 30, SHARED-C125.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C126-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C126. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C126" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qfdd 5.7, p. 30, SHARED-C126.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C127-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C127. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C127" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QRD-DK 1.3.2: value cardinality must be 1..1. Source: qfdd 5.7, p. 30, SHARED-C127.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C128-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C128. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]/v3:value">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C128" test="if (@xsi:type and matches(normalize-space(@xsi:type), '^[\i-[:]][\c-[:]]*(:[\i-[:]][\c-[:]]*)?$') and (not(contains(@xsi:type, ':')) or namespace-uri-for-prefix(substring-before(@xsi:type, ':'), .) != '')) then resolve-QName(@xsi:type, .) = (QName('urn:hl7-org:v3', 'IVL_INT')) else false()" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QRD-DK 1.3.2: xsi:type must identify a CDA datatype: IVL_INT. Source: qfdd 5.7, p. 30, SHARED-C128.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C129-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C129. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]/v3:value">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C129" test="count(v3:low) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QRD-DK 1.3.2: low cardinality must be 1..1. Source: qfdd 5.7, p. 30, SHARED-C129.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C130-pattern">
    <sch:p>Source: qfdd, section 5.7, PDF page 30, SHARED-C130. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.20']]/v3:value">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C130" test="count(v3:high) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">QRD-DK 1.3.2: high cardinality must be 1..1. Source: qfdd 5.7, p. 30, SHARED-C130.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C139-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C139. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C139" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QRD-DK 1.3.2: @classCode must be OBS. Source: qfdd 5.9, p. 33, SHARED-C139.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C140-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C140. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C140" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QRD-DK 1.3.2: @moodCode must be EVN. Source: qfdd 5.9, p. 33, SHARED-C140.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C141-142-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C141-142. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C141-142" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.32.4.21'] cardinality must be 1..1. Source: qfdd 5.9, p. 33, SHARED-C141-142.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C143-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C143. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C143" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QRD-DK 1.3.2: code cardinality must be 1..1. Source: qfdd 5.9, p. 33, SHARED-C143.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C144-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C144. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C144" test="@code = 'COPY'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QRD-DK 1.3.2: @code must be COPY. Source: qfdd 5.9, p. 33, SHARED-C144.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C145-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C145. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C145" test="@codeSystem = '2.16.840.1.113883.5.4'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C146-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C146. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C146" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QRD-DK 1.3.2: value cardinality must be 1..1. Source: qfdd 5.9, p. 33, SHARED-C146.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C147-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C147. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]/v3:value">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C147" test="if (@xsi:type and matches(normalize-space(@xsi:type), '^[\i-[:]][\c-[:]]*(:[\i-[:]][\c-[:]]*)?$') and (not(contains(@xsi:type, ':')) or namespace-uri-for-prefix(substring-before(@xsi:type, ':'), .) != '')) then resolve-QName(@xsi:type, .) = (QName('urn:hl7-org:v3', 'ST')) else false()" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QRD-DK 1.3.2: xsi:type must identify a CDA datatype: ST. Source: qfdd 5.9, p. 33, SHARED-C147.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-SHARED-C148-pattern">
    <sch:p>Source: qfdd, section 5.9, PDF page 33, SHARED-C148. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.32.4.21']]">
      <sch:assert id="QRD-DK-1.3.2-SHARED-C148" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33">QRD-DK 1.3.2: languageCode cardinality must be 0..1. Source: qfdd 5.9, p. 33, SHARED-C148.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C128-pattern">
    <sch:p>Source: qrd, section 5.1, PDF page 35, C128. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.1']]">
      <sch:assert id="QRD-DK-1.3.2-C128" test="@classCode = 'BATTERY'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35">QRD-DK 1.3.2: @classCode must be BATTERY. Source: qrd 5.1, p. 35, C128.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C129-pattern">
    <sch:p>Source: qrd, section 5.1, PDF page 35, C129. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.1']]">
      <sch:assert id="QRD-DK-1.3.2-C129" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35">QRD-DK 1.3.2: @moodCode must be EVN. Source: qrd 5.1, p. 35, C129.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C130-131-pattern">
    <sch:p>Source: qrd, section 5.1, PDF page 35, C130-131. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.1']]">
      <sch:assert id="QRD-DK-1.3.2-C130-131" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.33.4.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.4.1'] cardinality must be 1..1. Source: qrd 5.1, p. 35, C130-131.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C132-pattern">
    <sch:p>Source: qrd, section 5.1, PDF page 35, C132. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.1']]">
      <sch:assert id="QRD-DK-1.3.2-C132" test="count(v3:id) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35">QRD-DK 1.3.2: id cardinality must be 1..*. Source: qrd 5.1, p. 35, C132.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C133-pattern">
    <sch:p>Source: qrd, section 5.1, PDF page 35, C133. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.1']]">
      <sch:assert id="QRD-DK-1.3.2-C133" test="count(v3:code) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35">QRD-DK 1.3.2: code cardinality must be 0..1. Source: qrd 5.1, p. 35, C133.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C134-pattern">
    <sch:p>Source: qrd, section 5.1, PDF page 35, C134. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.1']]">
      <sch:assert id="QRD-DK-1.3.2-C134" test="count(v3:statusCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35">QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.1, p. 35, C134.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C135-pattern">
    <sch:p>Source: qrd, section 5.1, PDF page 35, C135. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.1']]/v3:statusCode">
      <sch:assert id="QRD-DK-1.3.2-C135" test="@code = 'completed'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35">QRD-DK 1.3.2: @code must be completed. Source: qrd 5.1, p. 35, C135.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C136-pattern">
    <sch:p>Source: qrd, section 5.1, PDF page 35, C136. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.1']]">
      <sch:assert id="QRD-DK-1.3.2-C136" test="count(v3:component) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35">QRD-DK 1.3.2: component cardinality must be 1..*. Source: qrd 5.1, p. 35, C136.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C137-pattern">
    <sch:p>Source: qrd, section 5.1, PDF page 35, C137. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.1']]/v3:component">
      <sch:assert id="QRD-DK-1.3.2-C137" test="count(v3:sequenceNumber) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35">QRD-DK 1.3.2: sequenceNumber cardinality must be 1..1. Source: qrd 5.1, p. 35, C137.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C138-143-pattern">
    <sch:p>Source: qrd, section 5.1, PDF page 35, C138-143. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:organizer[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.1']]/v3:component">
      <sch:assert id="QRD-DK-1.3.2-C138-143" test="count(v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4', '2.16.840.1.113883.10.20.33.4.5', '2.16.840.1.113883.10.20.33.4.6', '2.16.840.1.113883.10.20.33.4.7', '2.16.840.1.113883.10.20.33.4.8')]) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35">QRD-DK 1.3.2: observation[templateId/@root=('2.16.840.1.113883.10.20.33.4.4', '2.16.840.1.113883.10.20.33.4.5', '2.16.840.1.113883.10.20.33.4.6', '2.16.840.1.113883.10.20.33.4.7', '2.16.840.1.113883.10.20.33.4.8')] cardinality must be 1..1. Source: qrd 5.1, p. 35, C138-143.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C144-pattern">
    <sch:p>Source: qrd, section 5.2, PDF page 37, C144. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observationMedia[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.2']]">
      <sch:assert id="QRD-DK-1.3.2-C144" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=37">QRD-DK 1.3.2: @classCode must be OBS. Source: qrd 5.2, p. 37, C144.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C145-pattern">
    <sch:p>Source: qrd, section 5.2, PDF page 37, C145. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observationMedia[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.2']]">
      <sch:assert id="QRD-DK-1.3.2-C145" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=37">QRD-DK 1.3.2: @moodCode must be EVN. Source: qrd 5.2, p. 37, C145.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C146-147-pattern">
    <sch:p>Source: qrd, section 5.2, PDF page 37, C146-147. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observationMedia[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.2']]">
      <sch:assert id="QRD-DK-1.3.2-C146-147" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.33.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=37">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.4.2'] cardinality must be 1..1. Source: qrd 5.2, p. 37, C146-147.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C148-pattern">
    <sch:p>Source: qrd, section 5.2, PDF page 37, C148. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observationMedia[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.2']]">
      <sch:assert id="QRD-DK-1.3.2-C148" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=37">QRD-DK 1.3.2: value cardinality must be 1..1. Source: qrd 5.2, p. 37, C148.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C149-pattern">
    <sch:p>Source: qrd, section 5.3, PDF page 38, C149. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.3']]">
      <sch:assert id="QRD-DK-1.3.2-C149" test="@typeCode = 'REFV'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=38">QRD-DK 1.3.2: @typeCode must be REFV. Source: qrd 5.3, p. 38, C149.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C150-151-pattern">
    <sch:p>Source: qrd, section 5.3, PDF page 38, C150-151. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.3']]">
      <sch:assert id="QRD-DK-1.3.2-C150-151" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.33.4.3']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=38">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.4.3'] cardinality must be 1..1. Source: qrd 5.3, p. 38, C150-151.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C152-pattern">
    <sch:p>Source: qrd, section 5.3, PDF page 38, C152. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.3']]">
      <sch:assert id="QRD-DK-1.3.2-C152" test="count(v3:observationRange) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=38">QRD-DK 1.3.2: observationRange cardinality must be 1..1. Source: qrd 5.3, p. 38, C152.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C153-pattern">
    <sch:p>Source: qrd, section 5.3, PDF page 38, C153. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.3']]/v3:observationRange">
      <sch:assert id="QRD-DK-1.3.2-C153" test="count(v3:text) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=38">QRD-DK 1.3.2: text cardinality must be 0..1. Source: qrd 5.3, p. 38, C153.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C154-pattern">
    <sch:p>Source: qrd, section 5.3, PDF page 38, C154. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.3']]/v3:observationRange">
      <sch:assert id="QRD-DK-1.3.2-C154" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=38">QRD-DK 1.3.2: value cardinality must be 1..1. Source: qrd 5.3, p. 38, C154.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C155-pattern">
    <sch:p>Source: qrd, section 5.3, PDF page 38, C155. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.3']]/v3:observationRange/v3:value">
      <sch:assert id="QRD-DK-1.3.2-C155" test="count(@xsi:type) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=38">QRD-DK 1.3.2: @xsi:type cardinality must be 1..1. Source: qrd 5.3, p. 38, C155.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C156-pattern">
    <sch:p>Source: qrd, section 5.3, PDF page 38, C156. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.3']]/v3:observationRange/v3:value">
      <sch:assert id="QRD-DK-1.3.2-C156" test="count(v3:low) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=38">QRD-DK 1.3.2: low cardinality must be 1..1. Source: qrd 5.3, p. 38, C156.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C157-pattern">
    <sch:p>Source: qrd, section 5.3, PDF page 38, C157. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:referenceRange[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.3']]/v3:observationRange/v3:value">
      <sch:assert id="QRD-DK-1.3.2-C157" test="count(v3:high) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=38">QRD-DK 1.3.2: high cardinality must be 1..1. Source: qrd 5.3, p. 38, C157.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C158-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 39, C158. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]">
      <sch:assert id="QRD-DK-1.3.2-C158" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39">QRD-DK 1.3.2: @classCode must be OBS. Source: qrd 5.4, p. 39, C158.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C159-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 39, C159. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]">
      <sch:assert id="QRD-DK-1.3.2-C159" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39">QRD-DK 1.3.2: @moodCode must be EVN. Source: qrd 5.4, p. 39, C159.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C160-161-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 39, C160-161. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]">
      <sch:assert id="QRD-DK-1.3.2-C160-161" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.4.4'] cardinality must be 1..1. Source: qrd 5.4, p. 39, C160-161.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C162-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 39, C162. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]">
      <sch:assert id="QRD-DK-1.3.2-C162" test="count(v3:id) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39">QRD-DK 1.3.2: id cardinality must be 1..*. Source: qrd 5.4, p. 39, C162.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C163-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 39, C163. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]">
      <sch:assert id="QRD-DK-1.3.2-C163" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39">QRD-DK 1.3.2: code cardinality must be 1..1. Source: qrd 5.4, p. 39, C163.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C164-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 39, C164. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-C164" test="count(@code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39">QRD-DK 1.3.2: @code cardinality must be 1..1. Source: qrd 5.4, p. 39, C164.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C165-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 39, C165. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-C165" test="count(@codeSystem) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39">QRD-DK 1.3.2: @codeSystem cardinality must be 1..1. Source: qrd 5.4, p. 39, C165.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C166-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 39, C166. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-C166" test="count(v3:originalText) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39">QRD-DK 1.3.2: originalText cardinality must be 1..1. Source: qrd 5.4, p. 39, C166.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C167-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 39, C167. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]">
      <sch:assert id="QRD-DK-1.3.2-C167" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39">QRD-DK 1.3.2: languageCode cardinality must be 0..1. Source: qrd 5.4, p. 39, C167.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C168-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 39, C168. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]">
      <sch:assert id="QRD-DK-1.3.2-C168" test="count(v3:statusCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39">QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.4, p. 39, C168.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C169-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 39, C169. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]/v3:statusCode">
      <sch:assert id="QRD-DK-1.3.2-C169" test="@code = 'completed'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39">QRD-DK 1.3.2: @code must be completed. Source: qrd 5.4, p. 39, C169.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C170-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 39, C170. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]">
      <sch:assert id="QRD-DK-1.3.2-C170" test="count(v3:value) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39">QRD-DK 1.3.2: value cardinality must be 0..1. Source: qrd 5.4, p. 39, C170.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C171-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 39, C171. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]/v3:value">
      <sch:assert id="QRD-DK-1.3.2-C171" test="if (@xsi:type and matches(normalize-space(@xsi:type), '^[\i-[:]][\c-[:]]*(:[\i-[:]][\c-[:]]*)?$') and (not(contains(@xsi:type, ':')) or namespace-uri-for-prefix(substring-before(@xsi:type, ':'), .) != '')) then resolve-QName(@xsi:type, .) = (QName('urn:hl7-org:v3', 'INT'), QName('urn:hl7-org:v3', 'REAL'), QName('urn:hl7-org:v3', 'TS')) else false()" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39">QRD-DK 1.3.2: xsi:type must identify a CDA datatype: INT REAL TS. Source: qrd 5.4, p. 39, C171.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK25-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 39, DK25. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]">
      <sch:assert id="QRD-DK-1.3.2-DK25" test="count(v3:reference) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39">QRD-DK 1.3.2: reference cardinality must be 1..1. Source: qrd 5.4, p. 39, DK25.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C179-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, C179. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]">
      <sch:assert id="QRD-DK-1.3.2-C179" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: @classCode must be OBS. Source: qrd 5.5, p. 41, C179.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C180-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, C180. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]">
      <sch:assert id="QRD-DK-1.3.2-C180" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: @moodCode must be EVN. Source: qrd 5.5, p. 41, C180.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C181-182-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, C181-182. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]">
      <sch:assert id="QRD-DK-1.3.2-C181-182" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.4.5'] cardinality must be 1..1. Source: qrd 5.5, p. 41, C181-182.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C183-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, C183. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]">
      <sch:assert id="QRD-DK-1.3.2-C183" test="count(v3:id) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: id cardinality must be 1..*. Source: qrd 5.5, p. 41, C183.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C184-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, C184. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]">
      <sch:assert id="QRD-DK-1.3.2-C184" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: code cardinality must be 1..1. Source: qrd 5.5, p. 41, C184.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C185-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, C185. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-C185" test="count(@code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: @code cardinality must be 1..1. Source: qrd 5.5, p. 41, C185.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C186-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, C186. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-C186" test="count(@codeSystem) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: @codeSystem cardinality must be 1..1. Source: qrd 5.5, p. 41, C186.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C187-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, C187. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-C187" test="count(v3:originalText) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: originalText cardinality must be 1..1. Source: qrd 5.5, p. 41, C187.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C188-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, C188. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]">
      <sch:assert id="QRD-DK-1.3.2-C188" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: languageCode cardinality must be 0..1. Source: qrd 5.5, p. 41, C188.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C189-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, C189. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]">
      <sch:assert id="QRD-DK-1.3.2-C189" test="count(v3:statusCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.5, p. 41, C189.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C190-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, C190. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:statusCode">
      <sch:assert id="QRD-DK-1.3.2-C190" test="@code = 'completed'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: @code must be completed. Source: qrd 5.5, p. 41, C190.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C192-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, C192. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:value">
      <sch:assert id="QRD-DK-1.3.2-C192" test="if (@xsi:type and matches(normalize-space(@xsi:type), '^[\i-[:]][\c-[:]]*(:[\i-[:]][\c-[:]]*)?$') and (not(contains(@xsi:type, ':')) or namespace-uri-for-prefix(substring-before(@xsi:type, ':'), .) != '')) then resolve-QName(@xsi:type, .) = (QName('urn:hl7-org:v3', 'CE')) else false()" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: xsi:type must identify a CDA datatype: CE. Source: qrd 5.5, p. 41, C192.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK26-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, DK26. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]">
      <sch:assert id="QRD-DK-1.3.2-DK26" test="count(v3:reference) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: reference cardinality must be 1..1. Source: qrd 5.5, p. 41, DK26.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C193-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, C193. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:value">
      <sch:assert id="QRD-DK-1.3.2-C193" test="count(@code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: @code cardinality must be 1..1. Source: qrd 5.5, p. 41, C193.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C194-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, C194. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:value">
      <sch:assert id="QRD-DK-1.3.2-C194" test="count(@codeSystem) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: @codeSystem cardinality must be 1..1. Source: qrd 5.5, p. 41, C194.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C195-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 41, C195. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:value">
      <sch:assert id="QRD-DK-1.3.2-C195" test="count(@displayName) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">QRD-DK 1.3.2: @displayName cardinality must be 1..1. Source: qrd 5.5, p. 41, C195.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C204-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 44, C204. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]">
      <sch:assert id="QRD-DK-1.3.2-C204" test="@classCode = 'OBS'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44">QRD-DK 1.3.2: @classCode must be OBS. Source: qrd 5.6, p. 44, C204.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C205-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 44, C205. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]">
      <sch:assert id="QRD-DK-1.3.2-C205" test="@moodCode = 'EVN'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44">QRD-DK 1.3.2: @moodCode must be EVN. Source: qrd 5.6, p. 44, C205.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C206-207-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 44, C206-207. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]">
      <sch:assert id="QRD-DK-1.3.2-C206-207" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.4.6'] cardinality must be 1..1. Source: qrd 5.6, p. 44, C206-207.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C208-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 44, C208. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]">
      <sch:assert id="QRD-DK-1.3.2-C208" test="count(v3:id) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44">QRD-DK 1.3.2: id cardinality must be 1..*. Source: qrd 5.6, p. 44, C208.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C209-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 44, C209. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]">
      <sch:assert id="QRD-DK-1.3.2-C209" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44">QRD-DK 1.3.2: code cardinality must be 1..1. Source: qrd 5.6, p. 44, C209.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C210-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 44, C210. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-C210" test="count(@code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44">QRD-DK 1.3.2: @code cardinality must be 1..1. Source: qrd 5.6, p. 44, C210.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C211-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 44, C211. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-C211" test="count(@codeSystem) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44">QRD-DK 1.3.2: @codeSystem cardinality must be 1..1. Source: qrd 5.6, p. 44, C211.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C212-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 44, C212. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-C212" test="count(v3:originalText) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44">QRD-DK 1.3.2: originalText cardinality must be 1..1. Source: qrd 5.6, p. 44, C212.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C213-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 44, C213. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]">
      <sch:assert id="QRD-DK-1.3.2-C213" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44">QRD-DK 1.3.2: languageCode cardinality must be 0..1. Source: qrd 5.6, p. 44, C213.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C214-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 44, C214. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]">
      <sch:assert id="QRD-DK-1.3.2-C214" test="count(v3:statusCode) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44">QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.6, p. 44, C214.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C215-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 44, C215. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]/v3:statusCode">
      <sch:assert id="QRD-DK-1.3.2-C215" test="@code = 'completed'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44">QRD-DK 1.3.2: @code must be completed. Source: qrd 5.6, p. 44, C215.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C216-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 44, C216. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]">
      <sch:assert id="QRD-DK-1.3.2-C216" test="count(v3:value) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44">QRD-DK 1.3.2: value cardinality must be 0..1. Source: qrd 5.6, p. 44, C216.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C217-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 44, C217. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]/v3:value">
      <sch:assert id="QRD-DK-1.3.2-C217" test="if (@xsi:type and matches(normalize-space(@xsi:type), '^[\i-[:]][\c-[:]]*(:[\i-[:]][\c-[:]]*)?$') and (not(contains(@xsi:type, ':')) or namespace-uri-for-prefix(substring-before(@xsi:type, ':'), .) != '')) then resolve-QName(@xsi:type, .) = (QName('urn:hl7-org:v3', 'ST')) else false()" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44">QRD-DK 1.3.2: xsi:type must identify a CDA datatype: ST. Source: qrd 5.6, p. 44, C217.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK27-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 44, DK27. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]">
      <sch:assert id="QRD-DK-1.3.2-DK27" test="count(v3:reference) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44">QRD-DK 1.3.2: reference cardinality must be 1..1. Source: qrd 5.6, p. 44, DK27.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C224-pattern">
    <sch:p>Source: qrd, section 5.7, PDF page 46, C224. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.7']]">
      <sch:assert id="QRD-DK-1.3.2-C224" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=46">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.4.4'] cardinality must be 1..1. Source: qrd 5.7, p. 46, C224.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C225-pattern">
    <sch:p>Source: qrd, section 5.7, PDF page 46, C225. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.7']]">
      <sch:assert id="QRD-DK-1.3.2-C225" test="not(v3:referenceRange[v3:templateId/@root='2.16.840.1.113883.10.20.33.4.3'])" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=46">QRD-DK 1.3.2: Analog sliders must not use the interval reference-range template. Source: qrd 5.7, p. 46, C225.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C226-227-pattern">
    <sch:p>Source: qrd, section 5.7, PDF page 46, C226-227. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.7']]">
      <sch:assert id="QRD-DK-1.3.2-C226-227" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.33.4.7']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=46">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.4.7'] cardinality must be 1..1. Source: qrd 5.7, p. 46, C226-227.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C228-pattern">
    <sch:p>Source: qrd, section 5.7, PDF page 46, C228. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.7']]">
      <sch:assert id="QRD-DK-1.3.2-C228" test="count(v3:referenceRange) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=46">QRD-DK 1.3.2: referenceRange cardinality must be 1..1. Source: qrd 5.7, p. 46, C228.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C229-pattern">
    <sch:p>Source: qrd, section 5.7, PDF page 46, C229. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.7']]/v3:referenceRange">
      <sch:assert id="QRD-DK-1.3.2-C229" test="@typeCode = 'REFV'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=46">QRD-DK 1.3.2: @typeCode must be REFV. Source: qrd 5.7, p. 46, C229.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C230-pattern">
    <sch:p>Source: qrd, section 5.7, PDF page 46, C230. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.7']]/v3:referenceRange">
      <sch:assert id="QRD-DK-1.3.2-C230" test="count(v3:observationRange) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=46">QRD-DK 1.3.2: observationRange cardinality must be 1..1. Source: qrd 5.7, p. 46, C230.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C231-pattern">
    <sch:p>Source: qrd, section 5.7, PDF page 46, C231. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.7']]/v3:referenceRange/v3:observationRange">
      <sch:assert id="QRD-DK-1.3.2-C231" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=46">QRD-DK 1.3.2: value cardinality must be 1..1. Source: qrd 5.7, p. 46, C231.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C232-pattern">
    <sch:p>Source: qrd, section 5.7, PDF page 46, C232. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.7']]/v3:referenceRange/v3:observationRange/v3:value">
      <sch:assert id="QRD-DK-1.3.2-C232" test="if (@xsi:type and matches(normalize-space(@xsi:type), '^[\i-[:]][\c-[:]]*(:[\i-[:]][\c-[:]]*)?$') and (not(contains(@xsi:type, ':')) or namespace-uri-for-prefix(substring-before(@xsi:type, ':'), .) != '')) then resolve-QName(@xsi:type, .) = (QName('urn:hl7-org:v3', 'GLIST_PQ')) else false()" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=46">QRD-DK 1.3.2: xsi:type must identify a CDA datatype: GLIST_PQ. Source: qrd 5.7, p. 46, C232.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C233-pattern">
    <sch:p>Source: qrd, section 5.7, PDF page 46, C233. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.7']]/v3:referenceRange/v3:observationRange/v3:value">
      <sch:assert id="QRD-DK-1.3.2-C233" test="count(v3:head) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=46">QRD-DK 1.3.2: head cardinality must be 1..1. Source: qrd 5.7, p. 46, C233.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C234-pattern">
    <sch:p>Source: qrd, section 5.7, PDF page 46, C234. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.7']]/v3:referenceRange/v3:observationRange/v3:value">
      <sch:assert id="QRD-DK-1.3.2-C234" test="count(v3:increment) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=46">QRD-DK 1.3.2: increment cardinality must be 1..1. Source: qrd 5.7, p. 46, C234.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C235-pattern">
    <sch:p>Source: qrd, section 5.7, PDF page 46, C235. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.7']]/v3:referenceRange/v3:observationRange/v3:value">
      <sch:assert id="QRD-DK-1.3.2-C235" test="count(@denominator) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=46">QRD-DK 1.3.2: @denominator cardinality must be 1..1. Source: qrd 5.7, p. 46, C235.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C236-pattern">
    <sch:p>Source: qrd, section 5.8, PDF page 48, C236. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.8']]">
      <sch:assert id="QRD-DK-1.3.2-C236" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=48">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.4.5'] cardinality must be 1..1. Source: qrd 5.8, p. 48, C236.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C237-238-pattern">
    <sch:p>Source: qrd, section 5.8, PDF page 48, C237-238. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.8']]">
      <sch:assert id="QRD-DK-1.3.2-C237-238" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.33.4.8']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=48">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.4.8'] cardinality must be 1..1. Source: qrd 5.8, p. 48, C237-238.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C239-pattern">
    <sch:p>Source: qrd, section 5.8, PDF page 48, C239. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.8']]">
      <sch:assert id="QRD-DK-1.3.2-C239" test="count(v3:value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=48">QRD-DK 1.3.2: value cardinality must be 1..1. Source: qrd 5.8, p. 48, C239.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C240-pattern">
    <sch:p>Source: qrd, section 5.8, PDF page 48, C240. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.8']]">
      <sch:assert id="QRD-DK-1.3.2-C240" test="exists(v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']) and (every $o in v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20'] satisfies ($o/v3:value/v3:high/@value = '1'))" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=48">QRD-DK 1.3.2: Discrete sliders require the options template with high/@value=1. Source: qrd 5.8, p. 48, C240.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C45-pattern">
    <sch:p>Source: qrd, section 2.2.3, PDF page 20, C45. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-C45" test="count(v3:dataEnterer) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=20">QRD-DK 1.3.2: dataEnterer cardinality must be 0..1. Source: qrd 2.2.3, p. 20, C45.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C46-pattern">
    <sch:p>Source: qrd, section 2.2.3, PDF page 20, C46. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:dataEnterer">
      <sch:assert id="QRD-DK-1.3.2-C46" test="count(v3:assignedEntity) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=20">QRD-DK 1.3.2: assignedEntity cardinality must be 1..1. Source: qrd 2.2.3, p. 20, C46.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C47-pattern">
    <sch:p>Source: qrd, section 2.2.3, PDF page 20, C47. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:dataEnterer/v3:assignedEntity">
      <sch:assert id="QRD-DK-1.3.2-C47" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=20">QRD-DK 1.3.2: id cardinality must be 1..1. Source: qrd 2.2.3, p. 20, C47.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C48-pattern">
    <sch:p>Source: qrd, section 2.2.3, PDF page 20, C48. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:dataEnterer/v3:assignedEntity">
      <sch:assert id="QRD-DK-1.3.2-C48" test="count(v3:addr) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=20">QRD-DK 1.3.2: addr cardinality must be 1..1. Source: qrd 2.2.3, p. 20, C48.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C49-pattern">
    <sch:p>Source: qrd, section 2.2.3, PDF page 20, C49. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:dataEnterer/v3:assignedEntity">
      <sch:assert id="QRD-DK-1.3.2-C49" test="count(v3:telecom) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=20">QRD-DK 1.3.2: telecom cardinality must be 1..1. Source: qrd 2.2.3, p. 20, C49.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C50-pattern">
    <sch:p>Source: qrd, section 2.2.3, PDF page 20, C50. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:dataEnterer/v3:assignedEntity">
      <sch:assert id="QRD-DK-1.3.2-C50" test="count(v3:assignedPerson) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=20">QRD-DK 1.3.2: assignedPerson cardinality must be 1..1. Source: qrd 2.2.3, p. 20, C50.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C51-pattern">
    <sch:p>Source: qrd, section 2.2.3, PDF page 20, C51. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:dataEnterer/v3:assignedEntity/v3:assignedPerson">
      <sch:assert id="QRD-DK-1.3.2-C51" test="count(v3:name) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=20">QRD-DK 1.3.2: name cardinality must be 1..1. Source: qrd 2.2.3, p. 20, C51.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C52-pattern">
    <sch:p>Source: qrd, section 2.2.3, PDF page 20, C52. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:dataEnterer/v3:assignedEntity">
      <sch:assert id="QRD-DK-1.3.2-C52" test="count(v3:code) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=20">QRD-DK 1.3.2: code cardinality must be 0..1. Source: qrd 2.2.3, p. 20, C52.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-NO-INFORMANT-pattern">
    <sch:p>Source: qrd, section 2.2.4, PDF page 21, NO-INFORMANT. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-NO-INFORMANT" test="not(v3:informant)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=21">QRD-DK 1.3.2: informant is not used in this profile. Source: qrd 2.2.4, p. 21, NO-INFORMANT.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-NO-LEGALAUTHENTICATOR-pattern">
    <sch:p>Source: qrd, section 2.2.7, PDF page 24, NO-LEGALAUTHENTICATOR. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-NO-LEGALAUTHENTICATOR" test="not(v3:legalAuthenticator)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=24">QRD-DK 1.3.2: legalAuthenticator is not used in this profile. Source: qrd 2.2.7, p. 24, NO-LEGALAUTHENTICATOR.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-NO-AUTHENTICATOR-pattern">
    <sch:p>Source: qrd, section 2.2.8, PDF page 25, NO-AUTHENTICATOR. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-NO-AUTHENTICATOR" test="not(v3:authenticator)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=25">QRD-DK 1.3.2: authenticator is not used in this profile. Source: qrd 2.2.8, p. 25, NO-AUTHENTICATOR.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C69-pattern">
    <sch:p>Source: qrd, section 2.2.6, PDF page 23, C69. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:informationRecipient">
      <sch:assert id="QRD-DK-1.3.2-C69" test="count(v3:intendedRecipient) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=23">QRD-DK 1.3.2: intendedRecipient cardinality must be 1..1. Source: qrd 2.2.6, p. 23, C69.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C70-pattern">
    <sch:p>Source: qrd, section 2.2.6, PDF page 23, C70. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:informationRecipient/v3:intendedRecipient">
      <sch:assert id="QRD-DK-1.3.2-C70" test="count(v3:id) &gt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=23">QRD-DK 1.3.2: id cardinality must be 1..*. Source: qrd 2.2.6, p. 23, C70.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C71-pattern">
    <sch:p>Source: qrd, section 2.2.6, PDF page 23, C71. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:informationRecipient/v3:intendedRecipient">
      <sch:assert id="QRD-DK-1.3.2-C71" test="count(v3:informationRecipient) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=23">QRD-DK 1.3.2: informationRecipient cardinality must be 0..1. Source: qrd 2.2.6, p. 23, C71.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C72-pattern">
    <sch:p>Source: qrd, section 2.2.6, PDF page 23, C72. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:informationRecipient/v3:intendedRecipient/v3:informationRecipient">
      <sch:assert id="QRD-DK-1.3.2-C72" test="count(v3:name) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=23">QRD-DK 1.3.2: name cardinality must be 1..*. Source: qrd 2.2.6, p. 23, C72.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C73-pattern">
    <sch:p>Source: qrd, section 2.2.6, PDF page 23, C73. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:informationRecipient/v3:intendedRecipient">
      <sch:assert id="QRD-DK-1.3.2-C73" test="count(v3:receivedOrganization) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=23">QRD-DK 1.3.2: receivedOrganization cardinality must be 0..1. Source: qrd 2.2.6, p. 23, C73.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C74-pattern">
    <sch:p>Source: qrd, section 2.2.6, PDF page 23, C74. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:informationRecipient/v3:intendedRecipient/v3:receivedOrganization">
      <sch:assert id="QRD-DK-1.3.2-C74" test="count(v3:name) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=23">QRD-DK 1.3.2: name cardinality must be 1..*. Source: qrd 2.2.6, p. 23, C74.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C99-pattern">
    <sch:p>Source: qrd, section 2.2.9, PDF page 26, C99. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:participant">
      <sch:assert id="QRD-DK-1.3.2-C99" test="count(v3:time) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=26">QRD-DK 1.3.2: time cardinality must be 0..1. Source: qrd 2.2.9, p. 26, C99.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C100-pattern">
    <sch:p>Source: qrd, section 2.2.9, PDF page 26, C100. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:participant">
      <sch:assert id="QRD-DK-1.3.2-C100" test="v3:associatedEntity/v3:associatedPerson or v3:associatedEntity/v3:scopingOrganization" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=26">QRD-DK 1.3.2: Participant requires an associated person or scoping organisation. Source: qrd 2.2.9, p. 26, C100.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C101-pattern">
    <sch:p>Source: qrd, section 2.2.9, PDF page 26, C101. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:participant[@typeCode='IND']/v3:associatedEntity">
      <sch:assert id="QRD-DK-1.3.2-C101" test="@classCode=('PRS','NOK','CAREGIVER','AGNT','GUAR','ECON')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=26">QRD-DK 1.3.2: IND participant role must belong to the six-code value set in table 5. Source: qrd 2.2.9, p. 26, C101.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C103-pattern">
    <sch:p>Source: qrd, section 2.2.10, PDF page 27, C103. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:inFulfillmentOf">
      <sch:assert id="QRD-DK-1.3.2-C103" test="count(v3:order) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=27">QRD-DK 1.3.2: order cardinality must be 1..1. Source: qrd 2.2.10, p. 27, C103.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C104-pattern">
    <sch:p>Source: qrd, section 2.2.10, PDF page 27, C104. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:inFulfillmentOf/v3:order">
      <sch:assert id="QRD-DK-1.3.2-C104" test="count(v3:id) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=27">QRD-DK 1.3.2: id cardinality must be 1..*. Source: qrd 2.2.10, p. 27, C104.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK11-pattern">
    <sch:p>Source: qrd, section 2.2.11, PDF page 28, DK11. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument">
      <sch:assert id="QRD-DK-1.3.2-DK11" test="count(v3:documentationOf) = 2" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28">QRD-DK 1.3.2: documentationOf cardinality must be 2..2. Source: qrd 2.2.11, p. 28, DK11.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK11-SERVICE-pattern">
    <sch:p>Source: qrd, section 2.2.11, PDF page 28, DK11-SERVICE. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf">
      <sch:assert id="QRD-DK-1.3.2-DK11-SERVICE" test="count(v3:serviceEvent) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28">QRD-DK 1.3.2: serviceEvent cardinality must be 1..1. Source: qrd 2.2.11, p. 28, DK11-SERVICE.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK12-pattern">
    <sch:p>Source: qrd, section 2.2.11, PDF page 28, DK12. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf[1]/v3:serviceEvent">
      <sch:assert id="QRD-DK-1.3.2-DK12" test="count(v3:templateId[@root='1.2.208.184.10.1.10']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28">QRD-DK 1.3.2: templateId[@root='1.2.208.184.10.1.10'] cardinality must be 1..1. Source: qrd 2.2.11, p. 28, DK12.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK13-ID-pattern">
    <sch:p>Source: qrd, section 2.2.11, PDF page 28, DK13-ID. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf[1]/v3:serviceEvent">
      <sch:assert id="QRD-DK-1.3.2-DK13-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28">QRD-DK 1.3.2: id cardinality must be 1..1. Source: qrd 2.2.11, p. 28, DK13-ID.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK13-pattern">
    <sch:p>Source: qrd, section 2.2.11, PDF page 28, DK13. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf[1]/v3:serviceEvent/v3:id">
      <sch:assert id="QRD-DK-1.3.2-DK13" test="@assigningAuthorityName = 'MedCom'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28">QRD-DK 1.3.2: @assigningAuthorityName must be MedCom. Source: qrd 2.2.11, p. 28, DK13.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK14-pattern">
    <sch:p>Source: qrd, section 2.2.11, PDF page 28, DK14. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf[1]/v3:serviceEvent/v3:id">
      <sch:assert id="QRD-DK-1.3.2-DK14" test="@extension = 'qrd-v1.3'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28">QRD-DK 1.3.2: @extension must be qrd-v1.3. Source: qrd 2.2.11, p. 28, DK14.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK15-pattern">
    <sch:p>Source: qrd, section 2.2.11, PDF page 28, DK15. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf[1]/v3:serviceEvent/v3:id">
      <sch:assert id="QRD-DK-1.3.2-DK15" test="@root = '1.2.208.184.100.10'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28">QRD-DK 1.3.2: @root must be 1.2.208.184.100.10. Source: qrd 2.2.11, p. 28, DK15.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK16-TIME-pattern">
    <sch:p>Source: qrd, section 2.2.11, PDF page 28, DK16-TIME. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf[2]/v3:serviceEvent">
      <sch:assert id="QRD-DK-1.3.2-DK16-TIME" test="count(v3:effectiveTime) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28">QRD-DK 1.3.2: effectiveTime cardinality must be 1..1. Source: qrd 2.2.11, p. 28, DK16-TIME.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK16-LOW-pattern">
    <sch:p>Source: qrd, section 2.2.11, PDF page 28, DK16-LOW. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf[2]/v3:serviceEvent/v3:effectiveTime">
      <sch:assert id="QRD-DK-1.3.2-DK16-LOW" test="count(v3:low) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28">QRD-DK 1.3.2: low cardinality must be 1..1. Source: qrd 2.2.11, p. 28, DK16-LOW.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK16-pattern">
    <sch:p>Source: qrd, section 2.2.11, PDF page 28, DK16. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf[2]/v3:serviceEvent/v3:effectiveTime/v3:low">
      <sch:assert id="QRD-DK-1.3.2-DK16" test="count(@value) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28">QRD-DK 1.3.2: @value cardinality must be 1..1. Source: qrd 2.2.11, p. 28, DK16.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK17-HIGH-pattern">
    <sch:p>Source: qrd, section 2.2.11, PDF page 28, DK17-HIGH. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf[2]/v3:serviceEvent/v3:effectiveTime">
      <sch:assert id="QRD-DK-1.3.2-DK17-HIGH" test="count(v3:high) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28">QRD-DK 1.3.2: high cardinality must be 1..1. Source: qrd 2.2.11, p. 28, DK17-HIGH.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK17-pattern">
    <sch:p>Source: qrd, section 2.2.11, PDF page 28, DK17. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:ClinicalDocument/v3:documentationOf[2]/v3:serviceEvent/v3:effectiveTime/v3:high">
      <sch:assert id="QRD-DK-1.3.2-DK17" test="(@value and not(@nullFlavor)) or (not(@value) and normalize-space(@nullFlavor) != '')" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28">QRD-DK 1.3.2: Answer end time requires a value or a nonempty nullFlavor (vocabulary validation is delegated to the CDA schema), exclusively. Source: qrd 2.2.11, p. 28, DK17.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C119-120-pattern">
    <sch:p>Source: qrd, section 4.1, PDF page 32, C119-120. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.33.2.1']]">
      <sch:assert id="QRD-DK-1.3.2-C119-120" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.33.2.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.2.1'] cardinality must be 1..1. Source: qrd 4.1, p. 32, C119-120.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C122-pattern">
    <sch:p>Source: qrd, section 4.1, PDF page 32, C122. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.33.2.1']]">
      <sch:assert id="QRD-DK-1.3.2-C122" test="count(v3:title) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32">QRD-DK 1.3.2: title cardinality must be 0..1. Source: qrd 4.1, p. 32, C122.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C123-pattern">
    <sch:p>Source: qrd, section 4.1, PDF page 32, C123. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.33.2.1']]">
      <sch:assert id="QRD-DK-1.3.2-C123" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32">QRD-DK 1.3.2: text cardinality must be 1..1. Source: qrd 4.1, p. 32, C123.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C124-pattern">
    <sch:p>Source: qrd, section 4.1, PDF page 32, C124. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.33.2.1']]">
      <sch:assert id="QRD-DK-1.3.2-C124" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32">QRD-DK 1.3.2: languageCode cardinality must be 0..1. Source: qrd 4.1, p. 32, C124.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C125-pattern">
    <sch:p>Source: qrd, section 4.1, PDF page 32, C125. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.33.2.1']]">
      <sch:assert id="QRD-DK-1.3.2-C125" test="count(v3:entry) &gt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32">QRD-DK 1.3.2: entry cardinality must be 1..*. Source: qrd 4.1, p. 32, C125.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C126-pattern">
    <sch:p>Source: qrd, section 4.1, PDF page 32, C126. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.33.2.1']]/v3:entry">
      <sch:assert id="QRD-DK-1.3.2-C126" test="@typeCode = 'DRIV'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32">QRD-DK 1.3.2: @typeCode must be DRIV. Source: qrd 4.1, p. 32, C126.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C127-pattern">
    <sch:p>Source: qrd, section 4.1, PDF page 32, C127. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.33.2.1']]/v3:entry">
      <sch:assert id="QRD-DK-1.3.2-C127" test="count(v3:organizer[v3:templateId/@root='2.16.840.1.113883.10.20.33.4.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32">QRD-DK 1.3.2: organizer[templateId/@root='2.16.840.1.113883.10.20.33.4.1'] cardinality must be 1..1. Source: qrd 4.1, p. 32, C127.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C121-pattern">
    <sch:p>Source: qrd, section 4.1, PDF page 32, C121. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.33.2.1']]">
      <sch:assert id="QRD-DK-1.3.2-C121" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32">QRD-DK 1.3.2: code cardinality must be 1..1. Source: qrd 4.1, p. 32, C121.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-C121-CODE-pattern">
    <sch:p>Source: qrd, section 4.1, PDF page 32, C121-CODE. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.33.2.1']]/v3:code">
      <sch:assert id="QRD-DK-1.3.2-C121-CODE" test="@code = '74465-6'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32">QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK20-21-pattern">
    <sch:p>Source: qrd, section 4.2, PDF page 33, DK20-21. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.1']]">
      <sch:assert id="QRD-DK-1.3.2-DK20-21" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.32.2.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=33">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.32.2.1'] cardinality must be 1..1. Source: qrd 4.2, p. 33, DK20-21.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK22-pattern">
    <sch:p>Source: qrd, section 4.2, PDF page 33, DK22. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.1']]">
      <sch:assert id="QRD-DK-1.3.2-DK22" test="count(v3:title) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=33">QRD-DK 1.3.2: title cardinality must be 0..1. Source: qrd 4.2, p. 33, DK22.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK23-pattern">
    <sch:p>Source: qrd, section 4.2, PDF page 33, DK23. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.1']]">
      <sch:assert id="QRD-DK-1.3.2-DK23" test="count(v3:text) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=33">QRD-DK 1.3.2: text cardinality must be 1..1. Source: qrd 4.2, p. 33, DK23.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-DK24-pattern">
    <sch:p>Source: qrd, section 4.2, PDF page 33, DK24. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.1']]">
      <sch:assert id="QRD-DK-1.3.2-DK24" test="count(v3:languageCode) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=33">QRD-DK 1.3.2: languageCode cardinality must be 0..1. Source: qrd 4.2, p. 33, DK24.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-INFO-NO-ENTRY-pattern">
    <sch:p>Source: qrd, section 4.2, PDF page 33, 4.2 prose. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:section[v3:templateId[@root='2.16.840.1.113883.10.20.32.2.1']]">
      <sch:assert id="QRD-DK-1.3.2-INFO-NO-ENTRY" test="not(v3:entry)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=33">QRD-DK 1.3.2: Information-only sections contain no entries. Source: qrd 4.2, p. 33, 4.2 prose.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REFERENCE-TYPE-pattern">
    <sch:p>Source: qrd, section 5.9; 5.9.1, PDF page 50, REFERENCE-TYPE. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4', '2.16.840.1.113883.10.20.33.4.5', '2.16.840.1.113883.10.20.33.4.6', '2.16.840.1.113883.10.20.33.4.7', '2.16.840.1.113883.10.20.33.4.8')]/v3:reference">
      <sch:assert id="QRD-DK-1.3.2-REFERENCE-TYPE" test="@typeCode = 'REFR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50">QRD-DK 1.3.2: @typeCode must be REFR. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-TYPE.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REFERENCE-TEMPLATE-pattern">
    <sch:p>Source: qrd, section 5.9; 5.9.1, PDF page 50, REFERENCE-TEMPLATE. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4', '2.16.840.1.113883.10.20.33.4.5', '2.16.840.1.113883.10.20.33.4.6', '2.16.840.1.113883.10.20.33.4.7', '2.16.840.1.113883.10.20.33.4.8')]/v3:reference">
      <sch:assert id="QRD-DK-1.3.2-REFERENCE-TEMPLATE" test="count(v3:templateId[@root='1.2.208.184.6.1']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50">QRD-DK 1.3.2: templateId[@root='1.2.208.184.6.1'] cardinality must be 1..1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-TEMPLATE.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REFERENCE-DOCUMENT-pattern">
    <sch:p>Source: qrd, section 5.9; 5.9.1, PDF page 50, REFERENCE-DOCUMENT. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4', '2.16.840.1.113883.10.20.33.4.5', '2.16.840.1.113883.10.20.33.4.6', '2.16.840.1.113883.10.20.33.4.7', '2.16.840.1.113883.10.20.33.4.8')]/v3:reference">
      <sch:assert id="QRD-DK-1.3.2-REFERENCE-DOCUMENT" test="count(v3:externalDocument) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50">QRD-DK 1.3.2: externalDocument cardinality must be 1..1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-DOCUMENT.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REFERENCE-CLASS-pattern">
    <sch:p>Source: qrd, section 5.9; 5.9.1, PDF page 50, REFERENCE-CLASS. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4', '2.16.840.1.113883.10.20.33.4.5', '2.16.840.1.113883.10.20.33.4.6', '2.16.840.1.113883.10.20.33.4.7', '2.16.840.1.113883.10.20.33.4.8')]/v3:reference/v3:externalDocument">
      <sch:assert id="QRD-DK-1.3.2-REFERENCE-CLASS" test="@classCode = 'DOC'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50">QRD-DK 1.3.2: @classCode must be DOC. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-CLASS.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REFERENCE-ID-pattern">
    <sch:p>Source: qrd, section 5.9; 5.9.1, PDF page 50, REFERENCE-ID. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4', '2.16.840.1.113883.10.20.33.4.5', '2.16.840.1.113883.10.20.33.4.6', '2.16.840.1.113883.10.20.33.4.7', '2.16.840.1.113883.10.20.33.4.8')]/v3:reference/v3:externalDocument">
      <sch:assert id="QRD-DK-1.3.2-REFERENCE-ID" test="count(v3:id) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50">QRD-DK 1.3.2: id cardinality must be 1..1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-ID.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REFERENCE-ROOT-pattern">
    <sch:p>Source: qrd, section 5.9; 5.9.1, PDF page 50, REFERENCE-ROOT. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4', '2.16.840.1.113883.10.20.33.4.5', '2.16.840.1.113883.10.20.33.4.6', '2.16.840.1.113883.10.20.33.4.7', '2.16.840.1.113883.10.20.33.4.8')]/v3:reference/v3:externalDocument/v3:id">
      <sch:assert id="QRD-DK-1.3.2-REFERENCE-ROOT" test="@root = '2.16.840.1.113883.4.873'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50">QRD-DK 1.3.2: @root must be 2.16.840.1.113883.4.873. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-ROOT.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REFERENCE-UUID-pattern">
    <sch:p>Source: qrd, section 5.9; 5.9.1, PDF page 50, 5.9.1. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4', '2.16.840.1.113883.10.20.33.4.5', '2.16.840.1.113883.10.20.33.4.6', '2.16.840.1.113883.10.20.33.4.7', '2.16.840.1.113883.10.20.33.4.8')]/v3:reference/v3:externalDocument/v3:id">
      <sch:assert id="QRD-DK-1.3.2-REFERENCE-UUID" test="matches(string(@extension), &quot;^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89aAbB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$&quot;)" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50">QRD-DK 1.3.2: QFDD reference extension must be a version 4 UUID. Source: qrd 5.9; 5.9.1, p. 50, 5.9.1.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REFERENCE-CODE-pattern">
    <sch:p>Source: qrd, section 5.9; 5.9.1, PDF page 50, REFERENCE-CODE. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4', '2.16.840.1.113883.10.20.33.4.5', '2.16.840.1.113883.10.20.33.4.6', '2.16.840.1.113883.10.20.33.4.7', '2.16.840.1.113883.10.20.33.4.8')]/v3:reference/v3:externalDocument">
      <sch:assert id="QRD-DK-1.3.2-REFERENCE-CODE" test="count(v3:code) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50">QRD-DK 1.3.2: code cardinality must be 1..1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-CODE.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REFERENCE-LOINC-pattern">
    <sch:p>Source: qrd, section 5.9; 5.9.1, PDF page 50, REFERENCE-LOINC. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4', '2.16.840.1.113883.10.20.33.4.5', '2.16.840.1.113883.10.20.33.4.6', '2.16.840.1.113883.10.20.33.4.7', '2.16.840.1.113883.10.20.33.4.8')]/v3:reference/v3:externalDocument/v3:code">
      <sch:assert id="QRD-DK-1.3.2-REFERENCE-LOINC" test="@code = '74468-0'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50">QRD-DK 1.3.2: @code must be 74468-0. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-LOINC.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REFERENCE-SYSTEM-pattern">
    <sch:p>Source: qrd, section 5.9; 5.9.1, PDF page 50, REFERENCE-SYSTEM. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4', '2.16.840.1.113883.10.20.33.4.5', '2.16.840.1.113883.10.20.33.4.6', '2.16.840.1.113883.10.20.33.4.7', '2.16.840.1.113883.10.20.33.4.8')]/v3:reference/v3:externalDocument/v3:code">
      <sch:assert id="QRD-DK-1.3.2-REFERENCE-SYSTEM" test="@codeSystem = '2.16.840.1.113883.6.1'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50">QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REFERENCE-NAME-pattern">
    <sch:p>Source: qrd, section 5.9; 5.9.1, PDF page 50, REFERENCE-NAME. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4', '2.16.840.1.113883.10.20.33.4.5', '2.16.840.1.113883.10.20.33.4.6', '2.16.840.1.113883.10.20.33.4.7', '2.16.840.1.113883.10.20.33.4.8')]/v3:reference/v3:externalDocument/v3:code">
      <sch:assert id="QRD-DK-1.3.2-REFERENCE-NAME" test="@displayName = 'Questionnaire Form Definition Document'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50">QRD-DK 1.3.2: @displayName must be Questionnaire Form Definition Document. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-NAME.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C172-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 40, REL-C172. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]">
      <sch:assert id="QRD-DK-1.3.2-REL-C172" test="count(v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=40">QRD-DK 1.3.2: entryRelationship[observation/templateId/@root='2.16.840.1.113883.10.20.32.4.19'] cardinality must be 0..1. Source: qrd 5.4, p. 40, REL-C172.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C173-174-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 40, REL-C173-174. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']">
      <sch:assert id="QRD-DK-1.3.2-REL-C173-174" test="@typeCode = 'SUBJ'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=40">QRD-DK 1.3.2: @typeCode must be SUBJ. Source: qrd 5.4, p. 40, REL-C173-174.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C174-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 40, REL-C174. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']">
      <sch:assert id="QRD-DK-1.3.2-REL-C174" test="count(v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=40">QRD-DK 1.3.2: observation[templateId/@root='2.16.840.1.113883.10.20.32.4.19'] cardinality must be 1..1. Source: qrd 5.4, p. 40, REL-C174.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C175-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 40, REL-C175. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]">
      <sch:assert id="QRD-DK-1.3.2-REL-C175" test="count(v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.33.4.2']) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=40">QRD-DK 1.3.2: entryRelationship[observationMedia/templateId/@root='2.16.840.1.113883.10.20.33.4.2'] cardinality must be 0..1. Source: qrd 5.4, p. 40, REL-C175.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C176-177-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 40, REL-C176-177. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]/v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.33.4.2']">
      <sch:assert id="QRD-DK-1.3.2-REL-C176-177" test="@typeCode = 'REFR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=40">QRD-DK 1.3.2: @typeCode must be REFR. Source: qrd 5.4, p. 40, REL-C176-177.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C177-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 40, REL-C177. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]/v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.33.4.2']">
      <sch:assert id="QRD-DK-1.3.2-REL-C177" test="count(v3:observationMedia[v3:templateId/@root='2.16.840.1.113883.10.20.33.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=40">QRD-DK 1.3.2: observationMedia[templateId/@root='2.16.840.1.113883.10.20.33.4.2'] cardinality must be 1..1. Source: qrd 5.4, p. 40, REL-C177.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-MEDIA-TEMPLATE-4-pattern">
    <sch:p>Source: qrd, section 5.4, PDF page 40, REL-MEDIA-TEMPLATE-4. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.4']]/v3:entryRelationship/v3:observationMedia">
      <sch:assert id="QRD-DK-1.3.2-REL-MEDIA-TEMPLATE-4" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.33.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=40">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.4.2'] cardinality must be 1..1. Source: qrd 5.4, p. 40, REL-MEDIA-TEMPLATE-4.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C197-198-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 42, REL-C197-198. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']">
      <sch:assert id="QRD-DK-1.3.2-REL-C197-198" test="@typeCode = 'SUBJ'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=42">QRD-DK 1.3.2: @typeCode must be SUBJ. Source: qrd 5.5, p. 42, REL-C197-198.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C198-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 42, REL-C198. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']">
      <sch:assert id="QRD-DK-1.3.2-REL-C198" test="count(v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=42">QRD-DK 1.3.2: observation[templateId/@root='2.16.840.1.113883.10.20.32.4.19'] cardinality must be 1..1. Source: qrd 5.5, p. 42, REL-C198.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C197-199-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 42, REL-C197-199. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']">
      <sch:assert id="QRD-DK-1.3.2-REL-C197-199" test="@typeCode = 'SUBJ'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=42">QRD-DK 1.3.2: @typeCode must be SUBJ. Source: qrd 5.5, p. 42, REL-C197-199.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C199-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 42, REL-C199. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']">
      <sch:assert id="QRD-DK-1.3.2-REL-C199" test="count(v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=42">QRD-DK 1.3.2: observation[templateId/@root='2.16.840.1.113883.10.20.32.4.20'] cardinality must be 1..1. Source: qrd 5.5, p. 42, REL-C199.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C200-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 42, REL-C200. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]">
      <sch:assert id="QRD-DK-1.3.2-REL-C200" test="count(v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.33.4.2']) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=42">QRD-DK 1.3.2: entryRelationship[observationMedia/templateId/@root='2.16.840.1.113883.10.20.33.4.2'] cardinality must be 0..1. Source: qrd 5.5, p. 42, REL-C200.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C201-202-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 42, REL-C201-202. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.33.4.2']">
      <sch:assert id="QRD-DK-1.3.2-REL-C201-202" test="@typeCode = 'REFR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=42">QRD-DK 1.3.2: @typeCode must be REFR. Source: qrd 5.5, p. 42, REL-C201-202.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C202-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 42, REL-C202. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.33.4.2']">
      <sch:assert id="QRD-DK-1.3.2-REL-C202" test="count(v3:observationMedia[v3:templateId/@root='2.16.840.1.113883.10.20.33.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=42">QRD-DK 1.3.2: observationMedia[templateId/@root='2.16.840.1.113883.10.20.33.4.2'] cardinality must be 1..1. Source: qrd 5.5, p. 42, REL-C202.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C201-203-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 42, REL-C201-203. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.33.4.6']">
      <sch:assert id="QRD-DK-1.3.2-REL-C201-203" test="@typeCode = 'REFR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=42">QRD-DK 1.3.2: @typeCode must be REFR. Source: qrd 5.5, p. 42, REL-C201-203.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C203-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 42, REL-C203. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.33.4.6']">
      <sch:assert id="QRD-DK-1.3.2-REL-C203" test="count(v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.33.4.6']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=42">QRD-DK 1.3.2: observation[templateId/@root='2.16.840.1.113883.10.20.33.4.6'] cardinality must be 1..1. Source: qrd 5.5, p. 42, REL-C203.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-MEDIA-TEMPLATE-5-pattern">
    <sch:p>Source: qrd, section 5.5, PDF page 42, REL-MEDIA-TEMPLATE-5. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.5']]/v3:entryRelationship/v3:observationMedia">
      <sch:assert id="QRD-DK-1.3.2-REL-MEDIA-TEMPLATE-5" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.33.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=42">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.4.2'] cardinality must be 1..1. Source: qrd 5.5, p. 42, REL-MEDIA-TEMPLATE-5.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C218-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 45, REL-C218. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]">
      <sch:assert id="QRD-DK-1.3.2-REL-C218" test="count(v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']) &lt;= 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=45">QRD-DK 1.3.2: entryRelationship[observation/templateId/@root='2.16.840.1.113883.10.20.32.4.19'] cardinality must be 0..1. Source: qrd 5.6, p. 45, REL-C218.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C219-220-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 45, REL-C219-220. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']">
      <sch:assert id="QRD-DK-1.3.2-REL-C219-220" test="@typeCode = 'SUBJ'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=45">QRD-DK 1.3.2: @typeCode must be SUBJ. Source: qrd 5.6, p. 45, REL-C219-220.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C220-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 45, REL-C220. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]/v3:entryRelationship[v3:observation/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']">
      <sch:assert id="QRD-DK-1.3.2-REL-C220" test="count(v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.19']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=45">QRD-DK 1.3.2: observation[templateId/@root='2.16.840.1.113883.10.20.32.4.19'] cardinality must be 1..1. Source: qrd 5.6, p. 45, REL-C220.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C221-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 45, REL-C221. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]">
      <sch:assert id="QRD-DK-1.3.2-REL-C221" test="count(v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.33.4.2']) &lt;= 1" flag="warning" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=45">QRD-DK 1.3.2: entryRelationship[observationMedia/templateId/@root='2.16.840.1.113883.10.20.33.4.2'] cardinality must be 0..1. Source: qrd 5.6, p. 45, REL-C221.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C222-223-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 45, REL-C222-223. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]/v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.33.4.2']">
      <sch:assert id="QRD-DK-1.3.2-REL-C222-223" test="@typeCode = 'REFR'" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=45">QRD-DK 1.3.2: @typeCode must be REFR. Source: qrd 5.6, p. 45, REL-C222-223.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-C223-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 45, REL-C223. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]/v3:entryRelationship[v3:observationMedia/v3:templateId/@root='2.16.840.1.113883.10.20.33.4.2']">
      <sch:assert id="QRD-DK-1.3.2-REL-C223" test="count(v3:observationMedia[v3:templateId/@root='2.16.840.1.113883.10.20.33.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=45">QRD-DK 1.3.2: observationMedia[templateId/@root='2.16.840.1.113883.10.20.33.4.2'] cardinality must be 1..1. Source: qrd 5.6, p. 45, REL-C223.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="QRD-DK-1.3.2-REL-MEDIA-TEMPLATE-6-pattern">
    <sch:p>Source: qrd, section 5.6, PDF page 45, REL-MEDIA-TEMPLATE-6. See docs/pro-conformance.md for interpretation and limitations.</sch:p>
    <sch:rule context="v3:observation[v3:templateId[@root='2.16.840.1.113883.10.20.33.4.6']]/v3:entryRelationship/v3:observationMedia">
      <sch:assert id="QRD-DK-1.3.2-REL-MEDIA-TEMPLATE-6" test="count(v3:templateId[@root='2.16.840.1.113883.10.20.33.4.2']) = 1" flag="error" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=45">QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.4.2'] cardinality must be 1..1. Source: qrd 5.6, p. 45, REL-MEDIA-TEMPLATE-6.</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
