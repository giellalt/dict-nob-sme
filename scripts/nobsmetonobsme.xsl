<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output omit-xml-declaration="yes" indent="yes"/>

  <!-- If the e element contains @src='fad', then skip: -->
  <xsl:template match="e[contains(@src,'fad')]"/>
  <xsl:template match="e[not(./@src='fad') and not(.//t[not(contains(@src,'fad'))])]"/>


  <xsl:template match="e[not(./@src='fad') and .//t[not(contains(@src,'fad'))]]">
  <e>
  	<!-- always print lemma group -->
    <xsl:apply-templates select="lg"/>
    <!-- print mg if it does not contain a t/@src='fad' -->
    <xsl:apply-templates select="mg[.//t[not(contains(@src,'fad'))]]"/>
  </e>
  </xsl:template>

<!-- Skip t elements not containing @src=fad, and not contained wihtin
       an e with @src=fad -->
  <xsl:template match="t[contains(@src,'fad')]"/>

  <!-- Copy anything not matched by the above -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>