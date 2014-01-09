<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output omit-xml-declaration="yes" indent="yes"/>

	<xsl:template match="e">
		<xsl:choose>
			<xsl:when test="@src">
				FAD
				<xsl:value-of select="normalize-space(.)"/>
			</xsl:when>
			<xsl:otherwise>
				<!--xsl:copy-of copy-namespaces="no" select="./node()"/-->
    </xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>