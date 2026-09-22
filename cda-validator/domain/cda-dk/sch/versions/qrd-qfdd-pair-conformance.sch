<?xml version='1.0' encoding='UTF-8'?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:title>QRD/QFDD paired-document checks from the QRD sender test protocol, section 3.4</sch:title>
  <sch:ns prefix="v3" uri="urn:hl7-org:v3"/>
  <sch:ns prefix="pro" uri="urn:dk:medcom:pro:validation"/>
  <sch:ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
  <sch:pattern id="PRO-PAIR-INPUT-pattern">
    <sch:rule context="/">
      <sch:assert id="PRO-PAIR-INPUT" flag="error" test="count(pro:documents)=1 and count(pro:documents/pro:qfdd/v3:ClinicalDocument)=1 and count(pro:documents/pro:qrd/v3:ClinicalDocument)=1" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/DK-QRD_Testprotokol_Afsendelse.docx">Supply one QFDD and one QRD in the pro:documents envelope. Source: DK-QRD_Testprotokol_Afsendelse.docx (2024-10-11), section 3.4; QRD-DK 1.3.2 section 5.9.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-QUESTION-ID-pattern">
    <sch:rule context="pro:qrd/v3:ClinicalDocument//v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4','2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.6','2.16.840.1.113883.10.20.33.4.7','2.16.840.1.113883.10.20.33.4.8')]">
      <sch:let name="answer" value="."/>
      <sch:let name="definition" value="/pro:documents/pro:qfdd/v3:ClinicalDocument//v3:observation[some $id in v3:id satisfies (some $other in $answer/v3:id satisfies ($id/@root = $other/@root and string($id/@extension) = string($other/@extension)))]"/>
      <sch:assert id="PRO-PAIR-QUESTION-ID" flag="error" test="count($definition)=1" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/DK-QRD_Testprotokol_Afsendelse.docx">Each response id must identify exactly one question in the supplied QFDD. Source: DK-QRD_Testprotokol_Afsendelse.docx (2024-10-11), section 3.4; QRD-DK 1.3.2 section 5.9.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-QUESTION-CODE-pattern">
    <sch:rule context="pro:qrd/v3:ClinicalDocument//v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4','2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.6','2.16.840.1.113883.10.20.33.4.7','2.16.840.1.113883.10.20.33.4.8')]">
      <sch:let name="answer" value="."/>
      <sch:let name="definition" value="/pro:documents/pro:qfdd/v3:ClinicalDocument//v3:observation[some $id in v3:id satisfies (some $other in $answer/v3:id satisfies ($id/@root = $other/@root and string($id/@extension) = string($other/@extension)))]"/>
      <sch:assert id="PRO-PAIR-QUESTION-CODE" flag="error" test="count($definition)!=1 or (v3:code/@code=$definition/v3:code/@code and v3:code/@codeSystem=$definition/v3:code/@codeSystem)" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/DK-QRD_Testprotokol_Afsendelse.docx">Response question code and code system must match the QFDD question. Source: DK-QRD_Testprotokol_Afsendelse.docx (2024-10-11), section 3.4; QRD-DK 1.3.2 section 5.9.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-ANSWER-OPTION-pattern">
    <sch:rule context="pro:qrd/v3:ClinicalDocument//v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4','2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.6','2.16.840.1.113883.10.20.33.4.7','2.16.840.1.113883.10.20.33.4.8')][v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.8')]">
      <sch:let name="answer" value="."/>
      <sch:let name="definition" value="/pro:documents/pro:qfdd/v3:ClinicalDocument//v3:observation[some $id in v3:id satisfies (some $other in $answer/v3:id satisfies ($id/@root = $other/@root and string($id/@extension) = string($other/@extension)))]"/>
      <sch:assert id="PRO-PAIR-ANSWER-OPTION" flag="error" test="count($definition)!=1 or (every $v in v3:value satisfies (some $option in $definition/v3:value satisfies ($v/@code=$option/@code and $v/@codeSystem=$option/@codeSystem and $v/@displayName=$option/@displayName)))" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/DK-QRD_Testprotokol_Afsendelse.docx">Each selected coded answer must match an option in the QFDD. Source: DK-QRD_Testprotokol_Afsendelse.docx (2024-10-11), section 3.4; QRD-DK 1.3.2 section 5.9.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-OPTION-LIMITS-pattern">
    <sch:rule context="pro:qrd/v3:ClinicalDocument//v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4','2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.6','2.16.840.1.113883.10.20.33.4.7','2.16.840.1.113883.10.20.33.4.8')][v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.8')]">
      <sch:let name="answer" value="."/>
      <sch:let name="definition" value="/pro:documents/pro:qfdd/v3:ClinicalDocument//v3:observation[some $id in v3:id satisfies (some $other in $answer/v3:id satisfies ($id/@root = $other/@root and string($id/@extension) = string($other/@extension)))]"/>
      <sch:assert id="PRO-PAIR-OPTION-LIMITS" flag="error" test="count($definition)!=1 or (count(v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']/v3:value)=count($definition/v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']/v3:value) and (every $v in v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']/v3:value satisfies (some $d in $definition/v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']/v3:value satisfies ($v/v3:low/@value=$d/v3:low/@value and $v/v3:high/@value=$d/v3:high/@value))))" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/DK-QRD_Testprotokol_Afsendelse.docx">Copied minimum and maximum choice counts must match the QFDD. Source: DK-QRD_Testprotokol_Afsendelse.docx (2024-10-11), section 3.4; QRD-DK 1.3.2 section 5.9.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-ANSWER-COUNT-pattern">
    <sch:rule context="pro:qrd/v3:ClinicalDocument//v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4','2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.6','2.16.840.1.113883.10.20.33.4.7','2.16.840.1.113883.10.20.33.4.8')][v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.8')]">
      <sch:let name="answer" value="."/>
      <sch:let name="definition" value="/pro:documents/pro:qfdd/v3:ClinicalDocument//v3:observation[some $id in v3:id satisfies (some $other in $answer/v3:id satisfies ($id/@root = $other/@root and string($id/@extension) = string($other/@extension)))]"/>
      <sch:assert id="PRO-PAIR-ANSWER-COUNT" flag="error" test="count($definition)!=1 or not(v3:value) or (every $limits in $definition/v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']/v3:value satisfies (if ($limits/v3:low/@value castable as xs:integer and $limits/v3:high/@value castable as xs:integer) then (count(v3:value) &gt;= xs:integer($limits/v3:low/@value) and count(v3:value) &lt;= xs:integer($limits/v3:high/@value)) else false()))" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/DK-QRD_Testprotokol_Afsendelse.docx">For an answered choice question, the selection count must fall within the QFDD limits. Source: DK-QRD_Testprotokol_Afsendelse.docx (2024-10-11), section 3.4; QRD-DK 1.3.2 section 5.9.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-QFDD-REFERENCE-pattern">
    <sch:rule context="pro:qrd/v3:ClinicalDocument//v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4','2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.6','2.16.840.1.113883.10.20.33.4.7','2.16.840.1.113883.10.20.33.4.8')]">
      <sch:let name="answer" value="."/>
      <sch:let name="definition" value="/pro:documents/pro:qfdd/v3:ClinicalDocument//v3:observation[some $id in v3:id satisfies (some $other in $answer/v3:id satisfies ($id/@root = $other/@root and string($id/@extension) = string($other/@extension)))]"/>
      <sch:assert id="PRO-PAIR-QFDD-REFERENCE" flag="error" test="every $id in v3:reference/v3:externalDocument/v3:id satisfies ($id/@extension=/pro:documents/pro:qfdd/v3:ClinicalDocument/v3:id/@extension)" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/DK-QRD_Testprotokol_Afsendelse.docx">Response references must identify the supplied QFDD document. Source: DK-QRD_Testprotokol_Afsendelse.docx (2024-10-11), section 3.4; QRD-DK 1.3.2 section 5.9.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-MEDIA-pattern">
    <sch:rule context="pro:qrd/v3:ClinicalDocument//v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4','2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.6','2.16.840.1.113883.10.20.33.4.7','2.16.840.1.113883.10.20.33.4.8')]">
      <sch:let name="answer" value="."/>
      <sch:let name="definition" value="/pro:documents/pro:qfdd/v3:ClinicalDocument//v3:observation[some $id in v3:id satisfies (some $other in $answer/v3:id satisfies ($id/@root = $other/@root and string($id/@extension) = string($other/@extension)))]"/>
      <sch:assert id="PRO-PAIR-MEDIA" flag="error" test="count($definition)!=1 or (every $v in v3:entryRelationship/v3:observationMedia/v3:value satisfies (some $d in $definition/v3:entryRelationship/v3:observationMedia/v3:value satisfies ($v/@mediaType=$d/@mediaType and replace(string($v),'\s','')=replace(string($d),'\s','') and string($v/v3:reference/@value)=string($d/v3:reference/@value))))" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/DK-QRD_Testprotokol_Afsendelse.docx">Media carried into the response must match the QFDD media content and type. Source: DK-QRD_Testprotokol_Afsendelse.docx (2024-10-11), section 3.4; QRD-DK 1.3.2 section 5.9.</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
