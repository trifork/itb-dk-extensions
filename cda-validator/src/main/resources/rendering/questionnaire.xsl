<?xml version="1.0" encoding="UTF-8"?>
<!--
  Structured view of a QRD (questionnaire response) or QFDD (form definition).

  The general CDA stylesheet shows the header and the narrative only. A questionnaire's actual content
  lives in its entries, so this stylesheet lists them: for a QRD each answer, for a QFDD each question
  with its options, limits, ranges and preconditions. It writes an HTML fragment and nothing for any
  other kind of document. All document text is output with xsl:value-of, never as markup.

  Template ids: QFDD-DK 1.2 (2.16.840.1.113883.10.20.32.*) and QRD-DK 1.3.2 (...10.20.33.*).
-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:hl7="urn:hl7-org:v3"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                exclude-result-prefixes="xs hl7 xsi">

  <xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes"/>

  <xsl:variable name="q" select="'2.16.840.1.113883.10.20.32.4.'"/>
  <xsl:variable name="r" select="'2.16.840.1.113883.10.20.33.4.'"/>
  <xsl:variable name="doc" select="/hl7:ClinicalDocument"/>
  <xsl:variable name="isQrd" select="$doc/hl7:templateId/@root = '1.2.208.184.13.1' or $doc/hl7:code/@code = '74465-6'"/>
  <xsl:variable name="isQfdd" select="$doc/hl7:templateId/@root = '1.2.208.184.12.1' or $doc/hl7:code/@code = '74468-0'"/>

  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="$isQrd">
        <div class="qv">
          <h2>Questionnaire response: structured answers</h2>
          <p class="qv-note">Listed from the structured entries of the document, independently of its narrative.</p>
          <xsl:variable name="refs" select="distinct-values($doc//hl7:reference/hl7:externalDocument/hl7:id/@extension)"/>
          <p class="qv-note">Answers the questionnaire form definition:
            <xsl:choose>
              <xsl:when test="exists($refs)"><xsl:value-of select="string-join($refs, ', ')"/></xsl:when>
              <xsl:otherwise>(no QFDD reference)</xsl:otherwise>
            </xsl:choose>
          </p>
          <xsl:apply-templates select="$doc//hl7:section[hl7:entry/hl7:organizer]" mode="qrd"/>
        </div>
      </xsl:when>
      <xsl:when test="$isQfdd">
        <div class="qv">
          <h2>Questionnaire form definition: structured questions</h2>
          <p class="qv-note">Listed from the structured entries of the document, independently of its narrative.</p>
          <xsl:apply-templates select="$doc//hl7:section[hl7:entry/hl7:organizer]" mode="qfdd"/>
        </div>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- ===================== QRD ===================== -->

  <xsl:template match="hl7:section" mode="qrd">
    <h3><xsl:value-of select="(hl7:title, 'Questionnaire section')[1]"/></h3>
    <xsl:for-each select="hl7:entry/hl7:organizer">
      <table class="qv-table">
        <thead>
          <tr><th>Question</th><th>Answer</th><th>Question limits</th></tr>
        </thead>
        <tbody>
          <xsl:apply-templates select="hl7:component/hl7:observation[hl7:templateId/@root = (for $n in 4 to 8 return concat($r, $n))]" mode="answer">
            <xsl:with-param name="depth" select="0"/>
          </xsl:apply-templates>
        </tbody>
      </table>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="hl7:observation" mode="answer">
    <xsl:param name="depth"/>
    <tr class="qv-depth-{$depth}">
      <td>
        <xsl:call-template name="question-label"/>
      </td>
      <td>
        <xsl:choose>
          <xsl:when test="hl7:value">
            <xsl:for-each select="hl7:value">
              <div><xsl:call-template name="value-text"/></div>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise><span class="qv-none">not answered</span></xsl:otherwise>
        </xsl:choose>
      </td>
      <td>
        <xsl:call-template name="limits"/>
        <xsl:call-template name="range"/>
      </td>
    </tr>
    <xsl:apply-templates select="hl7:entryRelationship/hl7:observation[hl7:templateId/@root = (for $n in 4 to 8 return concat($r, $n))]" mode="answer">
      <xsl:with-param name="depth" select="$depth + 1"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- ===================== QFDD ===================== -->

  <xsl:template match="hl7:section" mode="qfdd">
    <h3><xsl:value-of select="(hl7:title, 'Question section')[1]"/></h3>
    <xsl:for-each select="hl7:entry/hl7:organizer">
      <table class="qv-table">
        <thead>
          <tr><th>Question</th><th>Type</th><th>Options and limits</th><th>Asked only if</th></tr>
        </thead>
        <tbody>
          <xsl:apply-templates select="hl7:component/hl7:observation[@moodCode = 'DEF']" mode="question">
            <xsl:with-param name="depth" select="0"/>
          </xsl:apply-templates>
        </tbody>
      </table>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="hl7:observation" mode="question">
    <xsl:param name="depth"/>
    <xsl:if test="hl7:templateId/@root = (for $n in 7 to 11 return concat($q, $n))">
      <tr class="qv-depth-{$depth}">
        <td><xsl:call-template name="question-label"/></td>
        <td><xsl:call-template name="question-type"/></td>
        <td>
          <xsl:for-each select="hl7:value">
            <div><xsl:call-template name="value-text"/></div>
          </xsl:for-each>
          <xsl:call-template name="limits"/>
          <xsl:call-template name="range"/>
          <xsl:for-each select="hl7:entryRelationship/hl7:observation[hl7:templateId/@root = concat($q, '19')]/hl7:value">
            <div class="qv-note">Help: <xsl:value-of select="."/></div>
          </xsl:for-each>
        </td>
        <td>
          <xsl:variable name="conditions" select="hl7:precondition | *[local-name() = 'precondition']"/>
          <xsl:choose>
            <xsl:when test="exists($conditions)">
              <xsl:for-each select="$conditions">
                <xsl:call-template name="condition"/>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise><span class="qv-none">always</span></xsl:otherwise>
          </xsl:choose>
        </td>
      </tr>
      <xsl:apply-templates select="hl7:entryRelationship/hl7:observation[@moodCode = 'DEF']" mode="question">
        <xsl:with-param name="depth" select="$depth + 1"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:template>

  <xsl:template name="question-type">
    <xsl:variable name="t" select="hl7:templateId/@root"/>
    <xsl:choose>
      <xsl:when test="$t = concat($q, '10')">analog slider</xsl:when>
      <xsl:when test="$t = concat($q, '11')">discrete slider</xsl:when>
      <xsl:when test="$t = concat($q, '8')">multiple choice</xsl:when>
      <xsl:when test="$t = concat($q, '9')">text</xsl:when>
      <xsl:when test="$t = concat($q, '7')">numeric</xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- A precondition, a criterion or a logical grouper, in either the HL7 or the sdtc namespace. -->
  <xsl:template name="condition">
    <xsl:variable name="criterion" select="*[local-name() = 'criterion']"/>
    <xsl:variable name="grouper" select="*[*[local-name() = 'templateId']/@root = (for $n in 13 to 18 return concat($q, $n))]"/>
    <xsl:variable name="negated" select="@negationInd = 'true'"/>
    <xsl:choose>
      <xsl:when test="exists($criterion)">
        <div>
          <xsl:if test="$negated">not </xsl:if>
          <xsl:value-of select="$criterion/*[local-name() = 'code']/@code"/>
          <xsl:text> = </xsl:text>
          <xsl:for-each select="$criterion/*[local-name() = 'value']">
            <xsl:choose>
              <xsl:when test="@code"><xsl:value-of select="@code"/></xsl:when>
              <xsl:when test="*[local-name() = ('low', 'high')]">
                <xsl:value-of select="concat(*[local-name() = 'low']/@value, ' to ', *[local-name() = 'high']/@value)"/>
              </xsl:when>
              <xsl:otherwise><xsl:value-of select="(@value, .)[1]"/></xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </div>
      </xsl:when>
      <xsl:when test="exists($grouper)">
        <xsl:variable name="kind" select="$grouper[1]/*[local-name() = 'templateId']/@root"/>
        <div>
          <xsl:if test="$negated">not </xsl:if>
          <xsl:choose>
            <xsl:when test="$kind = concat($q, '13')">all of:</xsl:when>
            <xsl:when test="$kind = concat($q, '14')">none of:</xsl:when>
            <xsl:when test="$kind = concat($q, '15')">at least one of:</xsl:when>
            <xsl:when test="$kind = concat($q, '16')">at least one not of:</xsl:when>
            <xsl:when test="$kind = concat($q, '17')">exactly one of:</xsl:when>
            <xsl:otherwise>exactly one not of:</xsl:otherwise>
          </xsl:choose>
          <ul>
            <xsl:for-each select="$grouper[1]/*[local-name() = 'precondition']">
              <li><xsl:call-template name="condition"/></li>
            </xsl:for-each>
          </ul>
        </div>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- ===================== shared ===================== -->

  <xsl:template name="question-label">
    <strong><xsl:value-of select="hl7:code/@code"/></strong>
    <xsl:if test="hl7:code/hl7:originalText">
      <xsl:text> </xsl:text>
      <xsl:value-of select="normalize-space(hl7:code/hl7:originalText)"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="value-text">
    <xsl:choose>
      <xsl:when test="@code">
        <xsl:value-of select="(@displayName, @code)[1]"/>
        <xsl:if test="@displayName"><xsl:text> (</xsl:text><xsl:value-of select="@code"/><xsl:text>)</xsl:text></xsl:if>
      </xsl:when>
      <xsl:when test="@value"><xsl:value-of select="@value"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="normalize-space(.)"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="limits">
    <xsl:for-each select="hl7:entryRelationship/hl7:observation[hl7:templateId/@root = concat($q, '20')]/hl7:value">
      <div class="qv-note">
        <xsl:text>options: at least </xsl:text><xsl:value-of select="(hl7:low/@value, '0')[1]"/>
        <xsl:choose>
          <xsl:when test="hl7:high/@value"><xsl:text>, at most </xsl:text><xsl:value-of select="hl7:high/@value"/></xsl:when>
          <xsl:otherwise><xsl:text>, no maximum</xsl:text></xsl:otherwise>
        </xsl:choose>
      </div>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="range">
    <xsl:for-each select="hl7:referenceRange/hl7:observationRange/hl7:value">
      <div class="qv-note">
        <xsl:choose>
          <xsl:when test="@denominator">
            <xsl:value-of select="concat('scale: ', hl7:head/@value, ' to ', @denominator, ' in steps of ', hl7:increment/@value)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat('range: ', hl7:low/@value, ' to ', hl7:high/@value)"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
