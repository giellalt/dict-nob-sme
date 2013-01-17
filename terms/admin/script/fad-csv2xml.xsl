<?xml version="1.0"?>
<!--+
    | 
    | compares two lists of words and outputs both the intersection set
    | and the set of items which are in the first but not in the second set
    | NB: The user has to adjust the paths to the input files accordingly
    | Usage: java net.sf.saxon.Transform -it main THIS_FILE
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

  <xsl:param name="slang" select="'nob'"/>
  <xsl:param name="tlang" select="'sme'"/>
  <xsl:param name="src" select="'fad'"/>
  <xsl:variable name="debug" select="true()"/>
  <xsl:variable name="of" select="'xml'"/>
  <xsl:variable name="e" select="$of"/>
  <xsl:variable name="nl" select="'&#xa;'"/>

  <!-- input file, extention of the output file -->
  <xsl:param name="inFile" select="'fad_nobsme_cand_ap-pl.20121130'"/>
  <xsl:param name="inDir" select="'_xxx_'"/>
  <xsl:param name="outDir" select="'_outData'"/>
  <xsl:variable name="current_file" select="(tokenize($inFile, '/'))[last()]"/>
  <xsl:variable name="current_dir" select="substring-before($inFile, $current_file)"/>
  <xsl:variable name="current_location" select="concat($inDir, substring-after($current_dir, $inDir))"/>
  <xsl:variable name="pattern_marked" select="'^\$.+$'"/>
  
  <xsl:template match="/" name="main">
    
    <xsl:choose>
      <xsl:when test="unparsed-text-available($inFile)">
	
        <!-- file -->
        <xsl:variable name="file" select="unparsed-text($inFile)"/>
        <xsl:variable name="file_lines" select="tokenize($file, $nl)" as="xs:string+"/>
	
	<xsl:message terminate="no">
	  <xsl:value-of select="concat('Processing file: ', $current_file, $nl)"/>
	  <xsl:value-of select="concat('Location: ', $current_dir, $nl)"/>
	</xsl:message>
	
	<xsl:result-document href="{$outDir}/{$current_file}_out.{$e}" format="{$of}">
	  <r xml:lang="{$slang}" src="{$src}">
	    <xsl:for-each select="$file_lines[matches(.,$pattern_marked)]">
	      <xsl:message terminate="no">
		<xsl:value-of select="concat('line ', position())"/>
	      </xsl:message>
	      <xsl:analyze-string select="."
				  regex="^(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)$"
				  flags="s">
		<xsl:matching-substring>
		  <xsl:variable name="l_nob" select="regex-group(6)"/>
		  <xsl:variable name="l_sme" select="regex-group(7)"/>
		  
		  <xsl:variable name="lemma_nob">
		    <xsl:analyze-string select="$l_nob"
					regex="^([^&lt;]+)(&lt;[^&lt;|&gt;]+&gt;)(.*)$">
		      <xsl:matching-substring>
			<l pos="{substring(substring-before(substring-after(regex-group(2), '&lt;'), '&gt;'), 1, 1)}">
			  <xsl:value-of select="regex-group(1)"/>
			</l>
		      </xsl:matching-substring>
		    </xsl:analyze-string>
		  </xsl:variable>
		  
		  <xsl:variable name="lemma_sme">
		    <xsl:analyze-string select="$l_sme"
					regex="^([^&lt;]+)(&lt;[^&lt;|&gt;]+&gt;)(.*)$">
		      <xsl:matching-substring>
			
			<xsl:variable name="pos">
			  <xsl:if test="(substring-before(substring-after(regex-group(2), '&lt;'), '&gt;')) = 'N'">
			    <xsl:value-of select="'prop'"/>
			  </xsl:if>
			  <xsl:if test="not((substring-before(substring-after(regex-group(2), '&lt;'), '&gt;')) = 'N')">
			    <xsl:value-of select="substring-before(substring-after(regex-group(2), '&lt;'), '&gt;')"/>
			  </xsl:if>
			</xsl:variable>

			<tg xml:lang="{$tlang}">
			  <t pos="{$pos}">
			    <xsl:if test="not(normalize-space(regex-group(3)) = '')">
			      <xsl:attribute name="rest">
				<xsl:value-of select="translate(translate(regex-group(3), '&lt;', ''), '&gt;', '/')"/>
			      </xsl:attribute>
			    </xsl:if>
			    <xsl:value-of select="regex-group(1)"/>
			  </t>
			</tg>
		      </xsl:matching-substring>
		    </xsl:analyze-string>
		  </xsl:variable>
		  
		  <e>
		    <lg>
		      <xsl:copy-of select="$lemma_nob"/>
		    </lg>
		    <mg>
		      <xsl:copy-of select="$lemma_sme"/>
		    </mg>
		  </e>
		  
		</xsl:matching-substring>
		<xsl:non-matching-substring>
		  <!--xsl:value-of select="concat('___', ., $nl)"/-->
		</xsl:non-matching-substring>
	      </xsl:analyze-string>
	    </xsl:for-each>
	  </r>
	</xsl:result-document>
	
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('Cannot locate file: ', $inFile, $nl)"/>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>
  
</xsl:stylesheet>
    
