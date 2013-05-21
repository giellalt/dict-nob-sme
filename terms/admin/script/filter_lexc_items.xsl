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

  <xsl:variable name="debug" select="true()"/>
  <xsl:variable name="of" select="'txt'"/>
  <xsl:variable name="e" select="$of"/>
  <xsl:variable name="nl" select="'&#xa;'"/>
  <xsl:variable name="tb" select="'&#9;'"/>

  <!-- input files: 1.lexc=base forms; 2.lexc=continuation classes; fad_usmeNorm_double_lemma=list of 
       lemmata marked for deletion -->
  <xsl:param name="inFile" select="'1.lexc'"/>
  <xsl:param name="fcFile" select="'2.lexc'"/>
  <xsl:param name="filterFile" select="'fad_dobbel_lemma2'"/>

  <xsl:param name="inDir" select="'_xxx_'"/>
  <xsl:param name="outDir" select="'_out-filtered_'"/>
  <xsl:variable name="current_file" select="(tokenize($inFile, '/'))[last()]"/>
  <xsl:variable name="current_dir" select="substring-before($inFile, $current_file)"/>
  <xsl:variable name="current_location" select="concat($inDir, substring-after($current_dir, $inDir))"/>
  <xsl:variable name="current_fc_file" select="(tokenize($fcFile, '/'))[last()]"/>  

  <xsl:template match="/" name="main">
    
    <xsl:choose>
      <xsl:when test="unparsed-text-available($inFile)">
	
        <!-- file -->
        <xsl:variable name="file" select="unparsed-text($inFile)"/>
        <xsl:variable name="file_lines" select="tokenize($file, $nl)" as="xs:string+"/>
        <xsl:variable name="fifi" select="unparsed-text($filterFile)"/>
        <xsl:variable name="fifili" select="tokenize($fifi, $nl)" as="xs:string+"/>
        <xsl:variable name="fc_file" select="unparsed-text($fcFile)"/>
        <xsl:variable name="fc_file_lines" select="tokenize($fc_file, $nl)" as="xs:string+"/>
	
	<xsl:variable name="to_filter">
	  <away_with>
	    <xsl:for-each select="$fifili">
	      <item>
		<xsl:value-of select="."/>
	      </item>
	    </xsl:for-each>
	  </away_with>
	</xsl:variable>

	<xsl:message terminate="no">
	  <xsl:value-of select="concat('Processing file: ', $current_file)"/>
	  <xsl:value-of select="concat('Location: ', $current_dir, $nl)"/>
	</xsl:message>


	<xsl:variable name="out_stuff">
	  <xsl:for-each select="$file_lines">
	    
	    <xsl:variable name="c_line" select="."/>
	    <xsl:variable name="c_pos" select="position()"/>
	    
	    <xsl:if test="not(. = $to_filter/away_with/*)">
	      <xsl:message terminate="no">
		<xsl:value-of select="concat('line ', position())"/>
	      </xsl:message>
	      <lemma>
		<xsl:value-of select="concat(., '_', $c_pos)"/>
	      </lemma>
	    </xsl:if>
	  </xsl:for-each>
	</xsl:variable>
	
	<xsl:result-document href="{$outDir}/{$current_file}.{$e}" format="{$of}">
	  <xsl:for-each select="$out_stuff/*">
	    <xsl:value-of select="concat(substring-before(., '_'), $nl)"/>
	  </xsl:for-each>
	</xsl:result-document>

	<xsl:result-document href="{$outDir}/{$current_fc_file}.{$e}" format="{$of}">
	  <xsl:for-each select="$out_stuff/*">
	    <xsl:variable name="cPos" select="number(substring-after(., '_'))"/>
	    <xsl:value-of select="concat($fc_file_lines[$cPos], $nl)"/>
	  </xsl:for-each>
	</xsl:result-document>

      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('Cannot locate file: ', $inFile, $nl)"/>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>
  
</xsl:stylesheet>
    
