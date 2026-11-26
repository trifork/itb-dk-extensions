<?xml version="1.0" encoding="UTF-8"?>
<!--
  Structured view of the entries of any CDA document that is not a questionnaire.

  The general CDA stylesheet shows the header and the narrative only. Most profiles keep their
  actual data in structured entries too (measurements, results, goals, appointments, registrations).
  This stylesheet lists them generically, so it needs no knowledge of a particular profile: every
  section with entries gets a table with one row per act (observation, organizer, procedure,
  medication, encounter, act, supply), nested through component and entryRelationship, showing its
  code, its values formatted by their data type, its time, status and the people and devices
  involved. Questionnaires (QRD, QFDD) have their own view in questionnaire.xsl.

  It writes an HTML fragment, nothing for a document without entries. All document text is output
  with xsl:value-of, never as markup; there are no links, so nothing in a document is made active.
  Entries are shown as encoded: codes are not translated and nothing is derived or validated.
-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:hl7="urn:hl7-org:v3"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                exclude-result-prefixes="xs hl7 xsi">

  <xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes"/>

  <!-- Nesting deeper than this is not drawn; it keeps a hostile document from exhausting the stack. -->
  <xsl:variable name="max-depth" select="12"/>

  <xsl:template match="/">
    <xsl:variable name="sections" select="/hl7:ClinicalDocument//hl7:section[hl7:entry]"/>
    <xsl:if test="exists($sections)">
      <div class="qv">
        <h2>Structured entries</h2>
        <p class="qv-note">Listed from the structured entries of the document, independently of its narrative, as they are encoded. Codes are shown with the name the document gives them.</p>
        <xsl:apply-templates select="$sections" mode="section"/>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="hl7:section" mode="section">
    <h3>
      <xsl:value-of select="(normalize-space(hl7:title)[. != ''], hl7:code/@displayName, hl7:code/@code,
                             concat('Section: ', (hl7:entry/*/hl7:code/@displayName)[1]), 'Section')[1]"/>
    </h3>
    <table class="qv-table">
      <thead>
        <tr><th>Entry</th><th>Value</th><th>Time</th><th>Details</th></tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="hl7:entry/(hl7:observation | hl7:organizer | hl7:procedure | hl7:substanceAdministration | hl7:encounter | hl7:act | hl7:supply | hl7:observationMedia | hl7:regionOfInterest)" mode="act">
          <xsl:with-param name="depth" select="0"/>
        </xsl:apply-templates>
      </tbody>
    </table>
  </xsl:template>

  <!-- ===================== one act per row ===================== -->

  <xsl:template match="hl7:observation | hl7:organizer | hl7:procedure | hl7:substanceAdministration | hl7:encounter | hl7:act | hl7:supply | hl7:observationMedia | hl7:regionOfInterest" mode="act">
    <xsl:param name="depth"/>
    <tr class="qv-depth-{min(($depth, 5))}">
      <td>
        <strong>
          <xsl:choose>
            <xsl:when test="self::hl7:observation">Observation</xsl:when>
            <xsl:when test="self::hl7:organizer">Group</xsl:when>
            <xsl:when test="self::hl7:procedure">Procedure</xsl:when>
            <xsl:when test="self::hl7:substanceAdministration">Medication</xsl:when>
            <xsl:when test="self::hl7:encounter">Encounter</xsl:when>
            <xsl:when test="self::hl7:act">Act</xsl:when>
            <xsl:when test="self::hl7:supply">Supply</xsl:when>
            <xsl:when test="self::hl7:observationMedia">Media</xsl:when>
            <xsl:otherwise>Region</xsl:otherwise>
          </xsl:choose>
        </strong>
        <xsl:if test="@moodCode and @moodCode != 'EVN'">
          <span class="qv-note"> (<xsl:call-template name="mood"/>)</span>
        </xsl:if>
        <xsl:if test="parent::hl7:entryRelationship/@typeCode">
          <span class="qv-note"><xsl:text> </xsl:text><xsl:call-template name="relationship"/></span>
        </xsl:if>
        <xsl:for-each select="hl7:code">
          <div><xsl:call-template name="data"/></div>
          <xsl:for-each select="hl7:translation">
            <div class="qv-note">also: <xsl:call-template name="data"/></div>
          </xsl:for-each>
        </xsl:for-each>
        <xsl:for-each select="hl7:id">
          <div class="qv-note">id: <xsl:call-template name="data"/></div>
        </xsl:for-each>
      </td>
      <td>
        <xsl:for-each select="hl7:value">
          <div><xsl:call-template name="data"/></div>
        </xsl:for-each>
        <xsl:for-each select="hl7:text[normalize-space(.) != '']">
          <div class="qv-note"><xsl:value-of select="normalize-space(.)"/></div>
        </xsl:for-each>
      </td>
      <td>
        <xsl:for-each select="(hl7:effectiveTime | hl7:time)[not(@nullFlavor and not(@value or *))]">
          <div><xsl:call-template name="time"/></div>
        </xsl:for-each>
      </td>
      <td>
        <xsl:call-template name="details"/>
      </td>
    </tr>
    <xsl:choose>
      <xsl:when test="$depth &lt; $max-depth">
        <xsl:apply-templates select="(hl7:component | hl7:entryRelationship)/(hl7:observation | hl7:organizer | hl7:procedure | hl7:substanceAdministration | hl7:encounter | hl7:act | hl7:supply | hl7:observationMedia | hl7:regionOfInterest)" mode="act">
          <xsl:with-param name="depth" select="$depth + 1"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="(hl7:component | hl7:entryRelationship)/*">
        <tr><td colspan="4" class="qv-none">Further nested entries are not shown.</td></tr>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="mood">
    <xsl:choose>
      <xsl:when test="@moodCode = 'APT'">appointment</xsl:when>
      <xsl:when test="@moodCode = 'ARQ'">appointment request</xsl:when>
      <xsl:when test="@moodCode = 'INT'">intent</xsl:when>
      <xsl:when test="@moodCode = 'RQO'">request</xsl:when>
      <xsl:when test="@moodCode = 'PRP'">proposal</xsl:when>
      <xsl:when test="@moodCode = 'PRMS'">promise</xsl:when>
      <xsl:when test="@moodCode = 'GOL'">goal</xsl:when>
      <xsl:when test="@moodCode = 'DEF'">definition</xsl:when>
      <xsl:when test="@moodCode = 'CRT'">criterion</xsl:when>
      <xsl:when test="@moodCode = 'RMD'">reminder</xsl:when>
      <xsl:otherwise><xsl:value-of select="@moodCode"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="relationship">
    <xsl:variable name="t" select="parent::hl7:entryRelationship/@typeCode"/>
    <xsl:text>[</xsl:text>
    <xsl:choose>
      <xsl:when test="$t = 'COMP'">component of parent</xsl:when>
      <xsl:when test="$t = 'SUBJ'">subject</xsl:when>
      <xsl:when test="$t = 'RSON'">reason</xsl:when>
      <xsl:when test="$t = 'REFR'">refers to</xsl:when>
      <xsl:when test="$t = 'CAUS'">cause</xsl:when>
      <xsl:when test="$t = 'MFST'">manifestation</xsl:when>
      <xsl:when test="$t = 'SPRT'">supports</xsl:when>
      <xsl:when test="$t = 'XCRPT'">excerpt</xsl:when>
      <xsl:when test="$t = 'GEVL'">evaluates</xsl:when>
      <xsl:when test="$t = 'SAS'">starts after start of</xsl:when>
      <xsl:when test="$t = 'FLFS'">fulfills</xsl:when>
      <xsl:when test="$t = 'OUTC'">outcome</xsl:when>
      <xsl:when test="$t = 'REFV'">reference value</xsl:when>
      <xsl:otherwise><xsl:value-of select="$t"/></xsl:otherwise>
    </xsl:choose>
    <xsl:text>]</xsl:text>
  </xsl:template>

  <!-- ===================== details column ===================== -->

  <xsl:template name="details">
    <xsl:if test="hl7:statusCode/@code">
      <div class="qv-note">status: <xsl:value-of select="hl7:statusCode/@code"/></div>
    </xsl:if>
    <xsl:if test="@negationInd = 'true'">
      <div class="qv-note">negated: this did not happen or does not apply</div>
    </xsl:if>
    <xsl:if test="hl7:sequenceNumber/@value">
      <div class="qv-note">sequence: <xsl:value-of select="hl7:sequenceNumber/@value"/></div>
    </xsl:if>
    <xsl:for-each select="hl7:priorityCode | hl7:interpretationCode | hl7:methodCode | hl7:targetSiteCode | hl7:approachSiteCode | hl7:routeCode | hl7:doseQuantity | hl7:rateQuantity | hl7:quantity | hl7:repeatNumber | hl7:independentInd | hl7:reasonCode | hl7:confidentialityCode">
      <div class="qv-note">
        <xsl:value-of select="lower-case(replace(replace(local-name(), 'Code$', ''), '([A-Z])', ' $1'))"/>
        <xsl:text>: </xsl:text>
        <xsl:call-template name="data"/>
      </div>
    </xsl:for-each>
    <xsl:for-each select="hl7:referenceRange/hl7:observationRange">
      <div class="qv-note">
        <xsl:text>reference range: </xsl:text>
        <xsl:for-each select="hl7:value"><xsl:call-template name="data"/></xsl:for-each>
        <xsl:if test="normalize-space(hl7:text) != ''"><xsl:text> </xsl:text><xsl:value-of select="normalize-space(hl7:text)"/></xsl:if>
        <xsl:for-each select="hl7:interpretationCode">
          <xsl:text> (</xsl:text><xsl:call-template name="data"/><xsl:text>)</xsl:text>
        </xsl:for-each>
      </div>
    </xsl:for-each>
    <xsl:for-each select="hl7:consumable/hl7:manufacturedProduct | hl7:product/hl7:manufacturedProduct">
      <div class="qv-note">
        <xsl:text>product: </xsl:text>
        <xsl:call-template name="product"/>
      </div>
    </xsl:for-each>
    <xsl:for-each select="hl7:author | hl7:performer | hl7:participant | hl7:informant | hl7:location | hl7:responsibleParty | hl7:specimen | hl7:subject">
      <div class="qv-note"><xsl:call-template name="party"/></div>
    </xsl:for-each>
    <xsl:for-each select="hl7:reference[hl7:externalAct or hl7:externalObservation or hl7:externalProcedure or hl7:externalDocument]/*/hl7:id">
      <div class="qv-note">refers to: <xsl:call-template name="data"/></div>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="product">
    <xsl:variable name="material" select="hl7:manufacturedMaterial | hl7:manufacturedLabeledDrug"/>
    <xsl:for-each select="$material/hl7:code">
      <xsl:call-template name="data"/>
    </xsl:for-each>
    <xsl:if test="normalize-space($material/hl7:name) != ''">
      <xsl:text> </xsl:text><xsl:value-of select="normalize-space($material/hl7:name)"/>
    </xsl:if>
    <xsl:if test="normalize-space(hl7:manufacturerOrganization/hl7:name) != ''">
      <xsl:text>, manufacturer </xsl:text><xsl:value-of select="normalize-space(hl7:manufacturerOrganization/hl7:name)"/>
    </xsl:if>
  </xsl:template>

  <!-- A participant, author, performer, informant, location ... with its role, identifiers, names and devices. -->
  <xsl:template name="party">
    <xsl:variable name="role" select="*[hl7:id or hl7:code or hl7:addr or hl7:telecom or hl7:assignedPerson or hl7:playingEntity or hl7:playingDevice or hl7:assignedAuthoringDevice or hl7:associatedPerson or hl7:relatedPerson or hl7:representedOrganization or hl7:scopingEntity][1]"/>
    <xsl:value-of select="local-name()"/>
    <xsl:if test="@typeCode"><xsl:text> (</xsl:text><xsl:value-of select="@typeCode"/><xsl:text>)</xsl:text></xsl:if>
    <xsl:text>: </xsl:text>
    <xsl:variable name="parts" as="xs:string*">
      <xsl:for-each select="hl7:time[@value or hl7:low/@value]">
        <xsl:variable name="when"><xsl:call-template name="time"/></xsl:variable>
        <xsl:sequence select="concat('at ', $when)"/>
      </xsl:for-each>
      <xsl:for-each select="hl7:functionCode | $role/hl7:code">
        <xsl:variable name="c"><xsl:call-template name="data"/></xsl:variable>
        <xsl:sequence select="string($c)"/>
      </xsl:for-each>
      <xsl:for-each select="$role/hl7:id">
        <xsl:variable name="i"><xsl:call-template name="data"/></xsl:variable>
        <xsl:sequence select="concat('id ', $i)"/>
      </xsl:for-each>
      <xsl:for-each select="$role//*[self::hl7:assignedPerson or self::hl7:playingEntity or self::hl7:associatedPerson or self::hl7:relatedPerson or self::hl7:representedOrganization or self::hl7:scopingEntity or self::hl7:wholeOrganization or self::hl7:playingDevice or self::hl7:assignedAuthoringDevice]">
        <xsl:variable name="n">
          <xsl:for-each select="hl7:name"><xsl:value-of select="normalize-space(string-join(for $part in (if (*) then * else .) return normalize-space($part), ' '))"/></xsl:for-each>
          <xsl:if test="normalize-space(hl7:manufacturerModelName) != ''"><xsl:text> model </xsl:text><xsl:value-of select="normalize-space(hl7:manufacturerModelName)"/></xsl:if>
          <xsl:if test="normalize-space(hl7:softwareName) != ''"><xsl:text> software </xsl:text><xsl:value-of select="normalize-space(hl7:softwareName)"/></xsl:if>
          <xsl:if test="normalize-space(hl7:desc) != ''"><xsl:text> </xsl:text><xsl:value-of select="normalize-space(hl7:desc)"/></xsl:if>
        </xsl:variable>
        <xsl:if test="normalize-space($n) != ''"><xsl:sequence select="normalize-space($n)"/></xsl:if>
      </xsl:for-each>
      <xsl:for-each select="$role/hl7:telecom[@value]">
        <xsl:sequence select="string(@value)"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:value-of select="if (exists($parts)) then string-join($parts, '; ') else '(no further information)'"/>
  </xsl:template>

  <!-- ===================== times ===================== -->

  <!-- effectiveTime or time: a point, an interval or a recurrence. -->
  <xsl:template name="time">
    <xsl:variable name="t" select="replace(string(@xsi:type), '^.*:', '')"/>
    <xsl:choose>
      <xsl:when test="@nullFlavor"><span class="qv-none">no time (<xsl:value-of select="@nullFlavor"/>)</span></xsl:when>
      <xsl:when test="@value"><xsl:call-template name="timestamp"><xsl:with-param name="v" select="@value"/></xsl:call-template></xsl:when>
      <xsl:when test="$t = 'PIVL_TS' or hl7:period">
        <xsl:text>every </xsl:text><xsl:value-of select="concat(hl7:period/@value, ' ', hl7:period/@unit)"/>
        <xsl:if test="hl7:phase"><xsl:text> starting </xsl:text><xsl:for-each select="hl7:phase"><xsl:call-template name="interval"/></xsl:for-each></xsl:if>
      </xsl:when>
      <xsl:when test="hl7:comp">
        <xsl:for-each select="hl7:comp">
          <xsl:if test="position() &gt; 1"><xsl:text>; </xsl:text></xsl:if>
          <xsl:call-template name="time"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise><xsl:call-template name="interval"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="interval">
    <xsl:variable name="unit" select="string(hl7:width/@unit)"/>
    <xsl:choose>
      <xsl:when test="hl7:low or hl7:high">
        <xsl:for-each select="hl7:low[@value]"><xsl:call-template name="timestamp"><xsl:with-param name="v" select="@value"/></xsl:call-template></xsl:for-each>
        <xsl:if test="hl7:low[@nullFlavor]"><xsl:text>unknown start</xsl:text></xsl:if>
        <xsl:text> – </xsl:text>
        <xsl:for-each select="hl7:high[@value]"><xsl:call-template name="timestamp"><xsl:with-param name="v" select="@value"/></xsl:call-template></xsl:for-each>
        <xsl:if test="hl7:high[@nullFlavor]"><xsl:text>unknown end</xsl:text></xsl:if>
      </xsl:when>
      <xsl:when test="hl7:center[@value]">
        <xsl:text>around </xsl:text><xsl:call-template name="timestamp"><xsl:with-param name="v" select="hl7:center/@value"/></xsl:call-template>
      </xsl:when>
      <xsl:when test="hl7:width[@value]"><xsl:value-of select="concat('duration ', hl7:width/@value, ' ', $unit)"/></xsl:when>
      <xsl:otherwise><span class="qv-none">no time</span></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- HL7 TS (yyyy[MM[dd[HH[mm[ss[.f]]]]]][+|-zzzz]) as "yyyy-MM-dd HH:mm:ss +zz:zz", keeping its precision. -->
  <xsl:template name="timestamp">
    <xsl:param name="v"/>
    <xsl:variable name="re" select="'^(\d{4})(\d{2})?(\d{2})?(\d{2})?(\d{2})?(\d{2})?(?:\.\d+)?([+-]\d{2})?(\d{2})?$'"/>
    <xsl:choose>
      <xsl:when test="matches($v, $re)">
        <xsl:analyze-string select="$v" regex="{$re}">
          <xsl:matching-substring>
            <xsl:value-of select="regex-group(1)"/>
            <xsl:if test="regex-group(2) != ''"><xsl:value-of select="concat('-', regex-group(2))"/></xsl:if>
            <xsl:if test="regex-group(3) != ''"><xsl:value-of select="concat('-', regex-group(3))"/></xsl:if>
            <xsl:if test="regex-group(4) != ''"><xsl:value-of select="concat(' ', regex-group(4))"/></xsl:if>
            <xsl:if test="regex-group(5) != ''"><xsl:value-of select="concat(':', regex-group(5))"/></xsl:if>
            <xsl:if test="regex-group(6) != ''"><xsl:value-of select="concat(':', regex-group(6))"/></xsl:if>
            <xsl:if test="regex-group(7) != ''">
              <xsl:value-of select="concat(' ', regex-group(7), ':', (regex-group(8)[. != ''], '00')[1])"/>
            </xsl:if>
          </xsl:matching-substring>
        </xsl:analyze-string>
      </xsl:when>
      <xsl:otherwise><xsl:value-of select="$v"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ===================== values, by data type ===================== -->

  <!-- Context: a value, code, id, doseQuantity ... Writes it readably according to its xsi:type. -->
  <xsl:template name="data">
    <xsl:variable name="t" select="replace(string(@xsi:type), '^.*:', '')"/>
    <xsl:choose>
      <xsl:when test="@nullFlavor and not(@code or @value or normalize-space(.) != '')">
        <span class="qv-none">not provided (<xsl:value-of select="@nullFlavor"/>)</span>
      </xsl:when>
      <xsl:when test="starts-with($t, 'IVL_') and not($t = 'IVL_TS')">
        <xsl:call-template name="quantity-interval"/>
      </xsl:when>
      <xsl:when test="$t = 'IVL_TS'"><xsl:call-template name="interval"/></xsl:when>
      <xsl:when test="starts-with($t, 'TS')">
        <xsl:call-template name="timestamp"><xsl:with-param name="v" select="string(@value)"/></xsl:call-template>
      </xsl:when>
      <xsl:when test="$t = 'II' or self::hl7:id or self::hl7:setId"><xsl:call-template name="identifier"/></xsl:when>
      <xsl:when test="$t = ('PN', 'EN', 'ON', 'TN')"><xsl:call-template name="plain-name"/></xsl:when>
      <xsl:when test="$t = 'AD'"><xsl:call-template name="address"/></xsl:when>
      <xsl:when test="$t = 'TEL'">
        <xsl:value-of select="@value"/>
        <xsl:if test="@use"><xsl:value-of select="concat(' (', @use, ')')"/></xsl:if>
      </xsl:when>
      <xsl:when test="$t = 'ED'">
        <xsl:choose>
          <xsl:when test="@mediaType and not(starts-with(@mediaType, 'text/'))">
            <xsl:value-of select="concat('embedded ', @mediaType, ' (not shown)')"/>
          </xsl:when>
          <xsl:otherwise><xsl:value-of select="normalize-space(.)"/></xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="@code"><xsl:call-template name="coded"/></xsl:when>
      <xsl:when test="@value and @unit"><xsl:value-of select="concat(@value, ' ', @unit)"/></xsl:when>
      <xsl:when test="@value"><xsl:value-of select="@value"/></xsl:when>
      <xsl:when test="hl7:low or hl7:high or hl7:center"><xsl:call-template name="quantity-interval"/></xsl:when>
      <xsl:when test="normalize-space(.) != ''"><xsl:value-of select="normalize-space(.)"/></xsl:when>
      <xsl:when test="hl7:originalText"><xsl:value-of select="normalize-space(hl7:originalText)"/></xsl:when>
      <xsl:otherwise><span class="qv-none">empty</span></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- CD, CE, CV: "name (code, code system)" with the document's own text when it has no name. -->
  <xsl:template name="coded">
    <xsl:variable name="name" select="(@displayName, normalize-space(hl7:originalText)[. != ''])[1]"/>
    <xsl:variable name="system"
                  select="(@codeSystemName,
                           if (@codeSystem = '2.16.840.1.113883.6.1') then 'LOINC'
                           else if (@codeSystem = '2.16.840.1.113883.6.96') then 'SNOMED CT'
                           else if (@codeSystem = '2.16.840.1.113883.6.8') then 'UCUM'
                           else if (@codeSystem = '1.2.208.176.2.1') then 'NPU'
                           else @codeSystem)[. != ''][1]"/>
    <xsl:value-of select="($name, @code)[1]"/>
    <xsl:text> (</xsl:text>
    <xsl:value-of select="@code"/>
    <xsl:if test="$system"><xsl:value-of select="concat(', ', $system)"/></xsl:if>
    <xsl:text>)</xsl:text>
  </xsl:template>

  <xsl:template name="identifier">
    <xsl:choose>
      <xsl:when test="@nullFlavor"><span class="qv-none">no identifier (<xsl:value-of select="@nullFlavor"/>)</span></xsl:when>
      <xsl:otherwise>
        <xsl:if test="@assigningAuthorityName"><xsl:value-of select="concat(@assigningAuthorityName, ' ')"/></xsl:if>
        <xsl:value-of select="@root"/>
        <xsl:if test="@extension"><xsl:value-of select="concat(' / ', @extension)"/></xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- A structured name (prefix, given, family, suffix) or a plain one, in document order. -->
  <xsl:template name="plain-name">
    <xsl:value-of select="normalize-space(string-join(for $part in (if (*) then * else .) return normalize-space($part), ' '))"/>
  </xsl:template>

  <xsl:template name="address">
    <xsl:value-of select="string-join(for $part in * return normalize-space($part)[. != ''], ', ')"/>
    <xsl:if test="@use"><xsl:value-of select="concat(' (', @use, ')')"/></xsl:if>
  </xsl:template>

  <!-- IVL_PQ, IVL_INT, IVL_REAL: "low – high unit", or one open end ("below 5 mmol/L"). The unit
       may sit on the interval itself or on its bounds; a bound with only a nullFlavor is open. -->
  <xsl:template name="quantity-interval">
    <xsl:variable name="unit" select="(@unit, hl7:low/@unit, hl7:high/@unit, hl7:center/@unit, hl7:width/@unit)[1]"/>
    <xsl:variable name="low" select="hl7:low/@value"/>
    <xsl:variable name="high" select="hl7:high/@value"/>
    <xsl:choose>
      <xsl:when test="exists($low) and exists($high)"><xsl:value-of select="concat($low, ' – ', $high)"/></xsl:when>
      <xsl:when test="exists($high)">
        <xsl:value-of select="concat(if (hl7:high/@inclusive = 'false') then 'below ' else 'at most ', $high)"/>
      </xsl:when>
      <xsl:when test="exists($low)">
        <xsl:value-of select="concat(if (hl7:low/@inclusive = 'false') then 'above ' else 'at least ', $low)"/>
      </xsl:when>
      <xsl:when test="hl7:center/@value"><xsl:value-of select="concat('around ', hl7:center/@value)"/></xsl:when>
      <xsl:when test="hl7:width/@value"><xsl:value-of select="concat('width ', hl7:width/@value)"/></xsl:when>
      <xsl:otherwise><span class="qv-none">not provided</span></xsl:otherwise>
    </xsl:choose>
    <xsl:if test="$unit and (exists($low) or exists($high) or hl7:center/@value or hl7:width/@value)">
      <xsl:value-of select="concat(' ', $unit)"/>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
