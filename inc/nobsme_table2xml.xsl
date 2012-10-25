<?xml version="1.0"?>
<!--+
    | 
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="xs">

  <xsl:strip-space elements="*"/>

  <xsl:output method="text" name="txt"
	      encoding="UTF-8"
	      omit-xml-declaration="yes"
	      indent="no"/>

  <xsl:output method="xml" name="xml"
              encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>

  <xsl:variable name="tab" select="'&#x9;'"/>
  <xsl:variable name="spc" select="'&#x20;'"/>
  <xsl:variable name="nl" select="'&#xA;'"/>
  <xsl:variable name="cl" select="':'"/>
  <xsl:variable name="scl" select="';'"/>
  <xsl:variable name="us" select="'_'"/>
  <xsl:variable name="qm" select="'&#34;'"/>
  <xsl:variable name="cm" select="','"/>

  <!-- input file, extention of the output file -->
  <xsl:param name="inFile" select="'default'"/>
  <xsl:param name="of" select="'xml'"/>
  <xsl:param name="outDir" select="'out'"/>
  
  
  <xsl:template match="/" name="main">
    
    <xsl:choose>
      <xsl:when test="unparsed-text-available($inFile)">

	<!-- file -->
	<xsl:variable name="file" select="unparsed-text($inFile)"/>
	<xsl:variable name="file_lines" select="distinct-values(tokenize($file, $nl))" as="xs:string+"/>
	<xsl:variable name="dict" as="element()">
	  <r>
	    <xsl:for-each select="$file_lines">
	      <xsl:variable name="normLine" select="normalize-space(.)"/>
	      <xsl:analyze-string select="$normLine" regex="^([^\s|\t|{$us}]+)[\s|\t]+([^\s|\t|{$us}]+)[\s|\t]+(.*)$" flags="s">
		<xsl:matching-substring>
		  <xsl:variable name="lemma" select="regex-group(1)"/>
		  <xsl:variable name="pos" select="regex-group(2)"/>
		  <xsl:variable name="target" select="tokenize(regex-group(3), $scl)"/>
		  <xsl:variable name="rest" select="regex-group(4)"/>
		  <e>
		    <lg>
		      <l>
			<xsl:attribute name="pos">
			  <xsl:value-of select="normalize-space($pos)"/>
			</xsl:attribute>
			<xsl:value-of select="normalize-space($lemma)"/>
		      </l>
		    </lg>
		    <xsl:for-each select="$target">
		      <mg>
			<tg>
			  <xsl:for-each select="tokenize(., $cm)">
			    <t>
			      <xsl:attribute name="pos">
				<xsl:value-of select="normalize-space($pos)"/>
				<!--				<xsl:value-of select="'xxx'"/> -->
			      </xsl:attribute>
			      <xsl:value-of select="normalize-space(.)"/>
			    </t>
			  </xsl:for-each>
			</tg>
		      </mg>
		    </xsl:for-each>
		    <!-- 			  <features> -->
		    <!-- 			    <xsl:attribute name="count"> -->
		    <!-- 			      <xsl:value-of select="$count"/> -->
		    <!-- 			    </xsl:attribute> -->
		    <!-- 			    <xsl:value-of select="$features"/> -->
		    <!-- 			  </features> -->
		    <!-- 			  <rest val="{$rest}"/> -->
		  </e>
		</xsl:matching-substring>
		<xsl:non-matching-substring>
		  <xxx><xsl:value-of select="."/></xxx>
		</xsl:non-matching-substring>
	      </xsl:analyze-string>
	    </xsl:for-each>
	  </r>
	</xsl:variable>
	
	<!-- compute and output the intersection set: elements that are both in file 1 and in file 2 -->
	<xsl:result-document href="{$outDir}/{$inFile}.{$of}" format="{$of}">
	  <r>
	    <xsl:copy-of select="$dict/e"/>
	  </r>
	</xsl:result-document>

	<!-- compute and output the intersection set: elements that are both in file 1 and in file 2 -->
	<xsl:result-document href="{$outDir}/{$inFile}" format="txt">
	  <xsl:for-each select="$dict/xxx">
	    <xsl:value-of select="concat(., $nl)"/>
	  </xsl:for-each>
	</xsl:result-document>

      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="concat('Cannot locate file: ', $inFile, $nl)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
