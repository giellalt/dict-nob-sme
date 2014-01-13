<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output omit-xml-declaration="yes" indent="yes"/>

  <xsl:template match="e[not(./@src='fad') and not(.//t[(contains(@src,'fad'))])]"/>

  <!-- If the e element contains @src='fad', then copy everything: -->
  <xsl:template match="e[contains(@src,'fad')]">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- If fad src further down, process it in more detail: -->
  <xsl:template match="e[not(./@src='fad') and .//t[contains(@src,'fad')]]">
  <e>
    <!-- always print lemma group -->
    <xsl:apply-templates select="lg"/>
    <!-- print tg if it contains a t/@src='fad' -->
    <xsl:apply-templates select="mg[.//t[contains(@src,'fad')]]"/>
  </e>
  </xsl:template>

  <!-- Skip t elements not containing @src=fad, and not contained wihtin
       an e with @src=fad -->
  <xsl:template match="t[not(contains(@src,'fad'))]
                        [not(ancestor::e[@src='fad'])]"/>

  <!-- Copy anything not matched by the above -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
