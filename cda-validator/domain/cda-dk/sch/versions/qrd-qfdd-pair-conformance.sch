<?xml version='1.0' encoding='UTF-8'?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:v3="urn:hl7-org:v3" xmlns:sdtc="urn:hl7-org:sdtc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:qf="urn:dk:medcom:pro:functions" queryBinding="xslt2">
  <sch:title>QRD/QFDD paired-document checks from the QRD sender test protocol, section 3.4</sch:title>
  <sch:ns prefix="v3" uri="urn:hl7-org:v3"/>
  <sch:ns prefix="pro" uri="urn:dk:medcom:pro:validation"/>
  <sch:ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
  <sch:ns prefix="sdtc" uri="urn:hl7-org:sdtc"/>
  <sch:ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
  <sch:ns prefix="qf" uri="urn:dk:medcom:pro:functions"/>

  <!-- Shared functions for the dependency checks. $qrd and $qfdd are the two v3:ClinicalDocument roots.
       Precondition state is three-valued: 1 = holds, 0 = does not hold, -1 = cannot be evaluated. -->
  <xsl:function name="qf:answers" as="element()*">
    <xsl:param name="qrd" as="element()?"/>
    <xsl:sequence select="$qrd//v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4','2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.6','2.16.840.1.113883.10.20.33.4.7','2.16.840.1.113883.10.20.33.4.8')]"/>
  </xsl:function>
  <xsl:function name="qf:same-id" as="xs:boolean">
    <xsl:param name="a" as="element()"/>
    <xsl:param name="b" as="element()"/>
    <xsl:sequence select="some $i in $a/v3:id satisfies (some $j in $b/v3:id satisfies ($i/@root = $j/@root and string($i/@extension) = string($j/@extension)))"/>
  </xsl:function>
  <xsl:function name="qf:definition" as="element()*">
    <xsl:param name="answer" as="element()"/>
    <xsl:param name="qfdd" as="element()?"/>
    <xsl:sequence select="$qfdd//v3:observation[qf:same-id(., $answer)]"/>
  </xsl:function>
  <xsl:function name="qf:question-answers" as="element()*">
    <xsl:param name="question" as="element()"/>
    <xsl:param name="qrd" as="element()?"/>
    <xsl:sequence select="qf:answers($qrd)[qf:same-id(., $question)]"/>
  </xsl:function>
  <xsl:function name="qf:expected-templates" as="xs:string*">
    <xsl:param name="question" as="element()"/>
    <!-- A slider response always includes its base pattern (QRD 5.7: numeric, 5.8: multiple choice),
         so the slider template alone decides, whether or not the QFDD also lists the base template. -->
    <xsl:sequence select="distinct-values((
                           if ($question/v3:templateId/@root=('2.16.840.1.113883.10.20.32.4.7','2.16.840.1.113883.10.20.32.4.10')) then '2.16.840.1.113883.10.20.33.4.4' else (),
                           if ($question/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.10') then '2.16.840.1.113883.10.20.33.4.7' else (),
                           if ($question/v3:templateId/@root=('2.16.840.1.113883.10.20.32.4.8','2.16.840.1.113883.10.20.32.4.11')) then '2.16.840.1.113883.10.20.33.4.5' else (),
                           if ($question/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.11') then '2.16.840.1.113883.10.20.33.4.8' else (),
                           if ($question/v3:templateId/@root='2.16.840.1.113883.10.20.32.4.9') then '2.16.840.1.113883.10.20.33.4.6' else ()))"/>
  </xsl:function>
  <xsl:function name="qf:same-node" as="xs:boolean">
    <xsl:param name="a" as="element()"/>
    <xsl:param name="b" as="element()"/>
    <xsl:sequence select="node-name($a) = node-name($b)
                          and count($a/@*) = count($b/@*)
                          and (every $x in $a/@* satisfies string($x) = string($b/@*[node-name(.) = node-name($x)]))
                          and count($a/*) = count($b/*)
                          and (every $i in 1 to count($a/*) satisfies qf:same-node($a/*[$i], $b/*[$i]))"/>
  </xsl:function>
  <xsl:function name="qf:same-ranges" as="xs:boolean">
    <xsl:param name="a" as="element()*"/>
    <xsl:param name="b" as="element()*"/>
    <xsl:sequence select="count($a) = count($b) and (every $i in 1 to count($a) satisfies qf:same-node($a[$i], $b[$i]))"/>
  </xsl:function>
  <xsl:function name="qf:criterion" as="xs:integer">
    <xsl:param name="criterion" as="element()"/>
    <xsl:param name="qrd" as="element()?"/>
    <xsl:param name="qfdd" as="element()?"/>
    <xsl:variable name="value" select="$criterion/*[local-name()='value'][1]"/>
    <xsl:variable name="type" select="if ($value/@xsi:type) then local-name-from-QName(resolve-QName($value/@xsi:type, $value)) else ''"/>
    <xsl:variable name="code" select="$criterion/*[local-name()='code']/@code"/>
    <xsl:variable name="answers" select="qf:answers($qrd)[v3:code/@code = $code]"/>
    <xsl:sequence select="
      if (count($criterion/*[local-name()='value']) ne 1 or not($code) or empty($qfdd//v3:observation[v3:code/@code = $code])) then -1
      else if ($type = ('CE','CD','CV')) then
        (if (some $a in $answers satisfies (some $v in $a/v3:value satisfies ($v/@code = $value/@code and (not($value/@codeSystem) or $value/@codeSystem = $v/@codeSystem)))) then 1 else 0)
      else if ($type = 'IVL_INT'
               and (every $b in ($value/*[local-name()=('low','high')]) satisfies ($b/@value castable as xs:decimal and not($b/@inclusive = 'false')))) then
        (if (some $a in $answers satisfies (some $v in $a/v3:value satisfies
              ($v/@value castable as xs:decimal
               and (not($value/*[local-name()='low']/@value) or xs:decimal($v/@value) ge xs:decimal($value/*[local-name()='low']/@value))
               and (not($value/*[local-name()='high']/@value) or xs:decimal($v/@value) le xs:decimal($value/*[local-name()='high']/@value))))) then 1 else 0)
      else -1"/>
  </xsl:function>
  <xsl:function name="qf:grouper" as="xs:integer">
    <xsl:param name="grouper" as="element()"/>
    <xsl:param name="qrd" as="element()?"/>
    <xsl:param name="qfdd" as="element()?"/>
    <xsl:variable name="states" select="for $c in $grouper/*[local-name()='precondition'] return qf:precondition($c, $qrd, $qfdd)"/>
    <xsl:variable name="kind" select="$grouper/*[local-name()='templateId']/@root"/>
    <xsl:sequence select="
      if (empty($states) or $states = -1) then -1
      else if ($kind = '2.16.840.1.113883.10.20.32.4.13') then (if (every $s in $states satisfies $s = 1) then 1 else 0)
      else if ($kind = '2.16.840.1.113883.10.20.32.4.14') then (if (every $s in $states satisfies $s = 0) then 1 else 0)
      else if ($kind = '2.16.840.1.113883.10.20.32.4.15') then (if ($states = 1) then 1 else 0)
      else if ($kind = '2.16.840.1.113883.10.20.32.4.16') then (if ($states = 0) then 1 else 0)
      else if ($kind = '2.16.840.1.113883.10.20.32.4.17') then (if (count($states[. = 1]) = 1) then 1 else 0)
      else if ($kind = '2.16.840.1.113883.10.20.32.4.18') then (if (count($states[. = 0]) = 1) then 1 else 0)
      else -1"/>
  </xsl:function>
  <xsl:function name="qf:precondition" as="xs:integer">
    <xsl:param name="precondition" as="element()"/>
    <xsl:param name="qrd" as="element()?"/>
    <xsl:param name="qfdd" as="element()?"/>
    <xsl:variable name="state" as="xs:integer" select="
      if ($precondition/*[local-name()='criterion']) then qf:criterion($precondition/*[local-name()='criterion'][1], $qrd, $qfdd)
      else if ($precondition/*[*[local-name()='templateId']/@root = ('2.16.840.1.113883.10.20.32.4.13','2.16.840.1.113883.10.20.32.4.14','2.16.840.1.113883.10.20.32.4.15','2.16.840.1.113883.10.20.32.4.16','2.16.840.1.113883.10.20.32.4.17','2.16.840.1.113883.10.20.32.4.18')]) then
        qf:grouper($precondition/*[*[local-name()='templateId']/@root = ('2.16.840.1.113883.10.20.32.4.13','2.16.840.1.113883.10.20.32.4.14','2.16.840.1.113883.10.20.32.4.15','2.16.840.1.113883.10.20.32.4.16','2.16.840.1.113883.10.20.32.4.17','2.16.840.1.113883.10.20.32.4.18')][1], $qrd, $qfdd)
      else -1"/>
    <xsl:sequence select="if ($state = -1 or not($precondition/@negationInd = 'true')) then $state else 1 - $state"/>
  </xsl:function>
  <xsl:function name="qf:applies" as="xs:integer">
    <xsl:param name="question" as="element()"/>
    <xsl:param name="qrd" as="element()?"/>
    <xsl:param name="qfdd" as="element()?"/>
    <xsl:variable name="states" select="(for $p in $question/v3:precondition return (if ($p/*[local-name()='criterion']) then qf:criterion($p/*[local-name()='criterion'][1], $qrd, $qfdd) else -1),
                                         for $p in $question/sdtc:precondition return qf:precondition($p, $qrd, $qfdd))"/>
    <xsl:sequence select="if ($states = 0) then 0 else if ($states = -1) then -1 else 1"/>
  </xsl:function>
  <xsl:function name="qf:zone" as="xs:string">
    <xsl:param name="value" as="xs:string?"/>
    <!-- The zone a TS value states (+hh:mm), or the empty string when it states none. -->
    <xsl:variable name="zone" as="xs:string*">
      <xsl:analyze-string select="normalize-space($value)" regex="^\d{{4,14}}([+-]\d{{2}})(\d{{2}})?$">
        <xsl:matching-substring>
          <xsl:sequence select="concat(regex-group(1), ':', (regex-group(2)[. ne ''], '00')[1])"/>
        </xsl:matching-substring>
      </xsl:analyze-string>
    </xsl:variable>
    <xsl:sequence select="($zone, '')[1]"/>
  </xsl:function>
  <xsl:function name="qf:ts" as="xs:dateTime?">
    <xsl:param name="value" as="xs:string"/>
    <xsl:param name="zone" as="xs:string"/>
    <!-- HL7 TS (YYYYMMDD[hhmm[ss]][+/-zzzz]) as a dateTime; the empty sequence when it is not one.
         A value without a zone is local time (HL7 C-CDA effectiveTime guidance), here taken to be in $zone. -->
    <xsl:variable name="parts" as="xs:string*">
      <xsl:analyze-string select="normalize-space($value)" regex="^(\d{{4}})(\d{{2}})(\d{{2}})(\d{{2}})?(\d{{2}})?(\d{{2}})?([+-]\d{{2}})?(\d{{2}})?$">
        <xsl:matching-substring>
          <xsl:sequence select="concat(regex-group(1), '-', regex-group(2), '-', regex-group(3), 'T',
                                       (regex-group(4)[. ne ''], '00')[1], ':', (regex-group(5)[. ne ''], '00')[1], ':', (regex-group(6)[. ne ''], '00')[1],
                                       if (regex-group(7) ne '') then concat(regex-group(7), ':', (regex-group(8)[. ne ''], '00')[1]) else $zone)"/>
        </xsl:matching-substring>
      </xsl:analyze-string>
    </xsl:variable>
    <xsl:sequence select="if (exists($parts) and $parts[1] castable as xs:dateTime) then xs:dateTime($parts[1]) else ()"/>
  </xsl:function>
  <xsl:function name="qf:in-range" as="xs:boolean">
    <xsl:param name="answer" as="element()"/>
    <xsl:param name="range" as="element()"/>
    <xsl:variable name="timestamp" select="matches(normalize-space($range/@xsi:type), '(^|:)IVL_TS$')"/>
    <xsl:variable name="low" select="$range/v3:low/@value"/>
    <xsl:variable name="high" select="$range/v3:high/@value"/>
    <!-- Values without a zone are read in the first zone that the answer or the interval states, else UTC. -->
    <xsl:variable name="zone" select="((for $v in ($answer/@value, $low, $high) return qf:zone($v))[. ne ''], 'Z')[1]"/>
    <xsl:sequence select="
      if ($timestamp) then
        (exists(qf:ts($answer/@value, $zone))
         and (empty($low) or empty(qf:ts($low, $zone)) or qf:ts($answer/@value, $zone) ge qf:ts($low, $zone))
         and (empty($high) or empty(qf:ts($high, $zone)) or qf:ts($answer/@value, $zone) le qf:ts($high, $zone)))
      else
        ($answer/@value castable as xs:decimal
         and (empty($low) or not($low castable as xs:decimal) or xs:decimal($answer/@value) ge xs:decimal($low))
         and (empty($high) or not($high castable as xs:decimal) or xs:decimal($answer/@value) le xs:decimal($high)))"/>
  </xsl:function>
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
      <sch:assert id="PRO-PAIR-OPTION-LIMITS" flag="error" test="count($definition)!=1 or (count(v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']/v3:value)=count($definition/v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']/v3:value) and (every $v in v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']/v3:value satisfies (some $d in $definition/v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']/v3:value satisfies (count($v/v3:low/@value)=count($d/v3:low/@value) and string($v/v3:low/@value)=string($d/v3:low/@value) and count($v/v3:high/@value)=count($d/v3:high/@value) and string($v/v3:high/@value)=string($d/v3:high/@value)))))" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/DK-QRD_Testprotokol_Afsendelse.docx">Copied minimum and maximum choice counts must match the QFDD. Source: DK-QRD_Testprotokol_Afsendelse.docx (2024-10-11), section 3.4; QRD-DK 1.3.2 section 5.9.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-ANSWER-COUNT-pattern">
    <sch:rule context="pro:qrd/v3:ClinicalDocument//v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4','2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.6','2.16.840.1.113883.10.20.33.4.7','2.16.840.1.113883.10.20.33.4.8')][v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.8')]">
      <sch:let name="answer" value="."/>
      <sch:let name="definition" value="/pro:documents/pro:qfdd/v3:ClinicalDocument//v3:observation[some $id in v3:id satisfies (some $other in $answer/v3:id satisfies ($id/@root = $other/@root and string($id/@extension) = string($other/@extension)))]"/>
      <sch:assert id="PRO-PAIR-ANSWER-COUNT" flag="error" test="count($definition)!=1 or not(v3:value) or (every $limits in $definition/v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']/v3:value satisfies ((not($limits/v3:low/@value) or ($limits/v3:low/@value castable as xs:integer and count(v3:value) &gt;= xs:integer($limits/v3:low/@value))) and (not($limits/v3:high/@value) or ($limits/v3:high/@value castable as xs:integer and count(v3:value) &lt;= xs:integer($limits/v3:high/@value)))))" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/DK-QRD_Testprotokol_Afsendelse.docx">For an answered choice question, the selection count must fall within the QFDD limits. Source: DK-QRD_Testprotokol_Afsendelse.docx (2024-10-11), section 3.4; QRD-DK 1.3.2 section 5.9.</sch:assert>
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
  <sch:pattern id="PRO-PAIR-ANSWER-TYPE-pattern">
    <sch:rule context="pro:qrd/v3:ClinicalDocument//v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4','2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.6','2.16.840.1.113883.10.20.33.4.7','2.16.840.1.113883.10.20.33.4.8')]">
      <sch:let name="definition" value="qf:definition(., /pro:documents/pro:qfdd/v3:ClinicalDocument)"/>
      <sch:let name="expected" value="if (count($definition)=1) then qf:expected-templates($definition) else ()"/>
      <sch:assert id="PRO-PAIR-ANSWER-TYPE" flag="error" test="empty($expected) or ((every $t in $expected satisfies $t = v3:templateId/@root) and (every $t in v3:templateId/@root[. = ('2.16.840.1.113883.10.20.33.4.4','2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.6','2.16.840.1.113883.10.20.33.4.7','2.16.840.1.113883.10.20.33.4.8')] satisfies $t = $expected))" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41">The response pattern must correspond to the QFDD question pattern: numeric to Numeric, multiple choice to Multiple Choice, text to Text, analog slider to Numeric plus Analog Slider, discrete slider to Multiple Choice plus Discrete Slider response. Source: QRD-DK 1.3.2 sections 5.4-5.8; QFDD-DK 1.2 sections 5.9-5.14.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-ANSWER-DUPLICATE-pattern">
    <sch:rule context="pro:qrd/v3:ClinicalDocument//v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4','2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.6','2.16.840.1.113883.10.20.33.4.7','2.16.840.1.113883.10.20.33.4.8')]">
      <sch:let name="answer" value="."/>
      <sch:assert id="PRO-PAIR-ANSWER-DUPLICATE" flag="error" test="count(qf:answers(/pro:documents/pro:qrd/v3:ClinicalDocument)[qf:same-id(., $answer)]) = 1" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50">A question may be answered only once; several responses carry the same question id. Interpretation of QRD-DK 1.3.2 section 5.9 (one response per question) and the Test Protocol 3.4; see docs/pro-conformance.md.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-REFERENCE-RANGE-pattern">
    <sch:rule context="pro:qrd/v3:ClinicalDocument//v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4','2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.6','2.16.840.1.113883.10.20.33.4.7','2.16.840.1.113883.10.20.33.4.8')]">
      <sch:let name="definition" value="qf:definition(., /pro:documents/pro:qfdd/v3:ClinicalDocument)"/>
      <sch:assert id="PRO-PAIR-REFERENCE-RANGE" flag="error" test="count($definition)!=1 or qf:same-ranges(v3:referenceRange/v3:observationRange/v3:value, $definition/v3:referenceRange/v3:observationRange/v3:value)" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=38">The response reference range must be a copy of the reference range of the QFDD question. Source: QRD-DK 1.3.2 section 5.3.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-ANSWER-RANGE-pattern">
    <sch:rule context="pro:qrd/v3:ClinicalDocument//v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.33.4.7']">
      <sch:let name="definition" value="qf:definition(., /pro:documents/pro:qfdd/v3:ClinicalDocument)[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.10']"/>
      <sch:let name="scale" value="$definition/v3:referenceRange/v3:observationRange/v3:value[ends-with(normalize-space(@xsi:type), 'GLIST_PQ')]"/>
      <sch:assert id="PRO-PAIR-ANSWER-RANGE" flag="error" test="count($scale)!=1 or not($scale/v3:head/@value castable as xs:decimal and $scale/v3:increment/@value castable as xs:decimal and $scale/@denominator castable as xs:decimal) or (every $v in v3:value/@value satisfies ($v castable as xs:decimal and xs:decimal($v) ge min((xs:decimal($scale/v3:head/@value), xs:decimal($scale/@denominator))) and xs:decimal($v) le max((xs:decimal($scale/v3:head/@value), xs:decimal($scale/@denominator))) and (xs:decimal($scale/v3:increment/@value) le 0 or ((xs:decimal($v) - xs:decimal($scale/v3:head/@value)) mod xs:decimal($scale/v3:increment/@value)) = 0)))" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=45">An analog slider answer must lie on the QFDD scale: from head to denominator in steps of increment. Source: QFDD-DK 1.2 section 5.13; QRD-DK 1.3.2 section 5.7.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-ANSWER-MISSING-pattern">
    <sch:rule context="pro:qfdd/v3:ClinicalDocument//v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.8'][v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']/v3:value/v3:low/@value castable as xs:integer]">
      <sch:let name="minimum" value="max(for $l in v3:entryRelationship/v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.32.4.20']/v3:value/v3:low/@value[. castable as xs:integer] return xs:integer($l))"/>
      <sch:let name="applies" value="qf:applies(., /pro:documents/pro:qrd/v3:ClinicalDocument, /pro:documents/pro:qfdd/v3:ClinicalDocument)"/>
      <sch:assert id="PRO-PAIR-ANSWER-MISSING" flag="error" test="$minimum lt 1 or $applies ne 1 or (some $a in qf:question-answers(., /pro:documents/pro:qrd/v3:ClinicalDocument) satisfies count($a/v3:value) ge $minimum)" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30">Question <sch:value-of select="v3:code/@code"/> requires at least <sch:value-of select="$minimum"/> selected option(s) but has no sufficient answer. Source: QFDD-DK 1.2 section 5.7; QRD-DK 1.3.2 section 5.5.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-PRECONDITION-pattern">
    <sch:rule context="pro:qrd/v3:ClinicalDocument//v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.33.4.4','2.16.840.1.113883.10.20.33.4.5','2.16.840.1.113883.10.20.33.4.6','2.16.840.1.113883.10.20.33.4.7','2.16.840.1.113883.10.20.33.4.8')][v3:value]">
      <sch:let name="definition" value="qf:definition(., /pro:documents/pro:qfdd/v3:ClinicalDocument)"/>
      <sch:assert id="PRO-PAIR-PRECONDITION" flag="error" test="count($definition)!=1 or qf:applies($definition, /pro:documents/pro:qrd/v3:ClinicalDocument, /pro:documents/pro:qfdd/v3:ClinicalDocument) ne 0" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=27">This question is answered although its preconditions are not met, so it should not have been asked. Source: QFDD-DK 1.2 sections 5.3, 5.4 and 6.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-PRECONDITION-UNEVALUATED-pattern">
    <sch:rule context="pro:qfdd/v3:ClinicalDocument//v3:observation[v3:templateId/@root=('2.16.840.1.113883.10.20.32.4.7','2.16.840.1.113883.10.20.32.4.8','2.16.840.1.113883.10.20.32.4.9','2.16.840.1.113883.10.20.32.4.10','2.16.840.1.113883.10.20.32.4.11')][v3:precondition or sdtc:precondition]">
      <sch:assert id="PRO-PAIR-PRECONDITION-UNEVALUATED" flag="warning" test="qf:applies(., /pro:documents/pro:qrd/v3:ClinicalDocument, /pro:documents/pro:qfdd/v3:ClinicalDocument) ne -1" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=51">The preconditions of question <sch:value-of select="v3:code/@code"/> cannot be evaluated (unsupported criterion value type, unknown referenced question or unrecognised grouper), so the dependent answer checks were not performed. Source: QFDD-DK 1.2 sections 5.3, 5.4 and 6.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-QFDD-VERSION-pattern">
    <sch:rule context="pro:qrd/v3:ClinicalDocument//v3:reference/v3:externalDocument[v3:versionNumber]">
      <sch:assert id="PRO-PAIR-QFDD-VERSION" flag="error" test="not(v3:id/@extension = /pro:documents/pro:qfdd/v3:ClinicalDocument/v3:id/@extension) or v3:versionNumber/@value = /pro:documents/pro:qfdd/v3:ClinicalDocument/v3:versionNumber/@value" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50">A stated QFDD version must equal the version of the supplied QFDD. Source: QRD-DK 1.3.2 section 5.9.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="PRO-PAIR-NUMERIC-RANGE-pattern">
    <sch:rule context="pro:qrd/v3:ClinicalDocument//v3:observation[v3:templateId/@root='2.16.840.1.113883.10.20.33.4.4']">
      <sch:let name="definition" value="qf:definition(., /pro:documents/pro:qfdd/v3:ClinicalDocument)"/>
      <sch:let name="range" value="$definition[count(.)=1]/v3:referenceRange/v3:observationRange/v3:value[matches(normalize-space(@xsi:type), '(^|:)IVL_(INT|REAL|TS)$')]"/>
      <sch:assert id="PRO-PAIR-NUMERIC-RANGE" flag="error" test="count($range)!=1 or (every $v in v3:value satisfies qf:in-range($v, $range))" see="https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=38">A numeric answer must lie within the interval (IVL_INT, IVL_REAL or IVL_TS) that the QFDD reference range defines. Source: QFDD-DK 1.2 section 5.5/5.9 (reference range); QRD-DK 1.3.2 sections 5.3 and 5.4.</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
