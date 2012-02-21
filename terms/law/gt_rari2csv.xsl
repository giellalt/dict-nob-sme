<?xml version="1.0"?>
<!--+
    | Usage: java net.sf.saxon.Transform -it main THIS_FILE PARAM_NAME=PARAM_VALUE*
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:local="nightbar"
		exclude-result-prefixes="xs local">

  <xsl:strip-space elements="*"/>
  
  <xsl:output method="xml" name="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>
  
  <xsl:output method="text" name="txt"
	      encoding="UTF-8"
	      omit-xml-declaration="yes"
	      indent="no"/>
  
  <xsl:function name="local:substring-before-if-contains" as="xs:string?">
    <xsl:param name="arg" as="xs:string?"/> 
    <xsl:param name="delim" as="xs:string"/> 
    
    <xsl:sequence select=" 
			  if (contains($arg,$delim))
			  then substring-before($arg,$delim)
			  else $arg
			  "/>
  </xsl:function>
  
  <xsl:function name="local:value-intersect" as="xs:anyAtomicType*">
    <xsl:param name="arg1" as="xs:anyAtomicType*"/> 
    <xsl:param name="arg2" as="xs:anyAtomicType*"/> 
    
    <xsl:sequence select=" 
			  distinct-values($arg1[.=$arg2])
			  "/>
  </xsl:function>

  <xsl:function name="local:value-except" as="xs:anyAtomicType*">
    <xsl:param name="arg1" as="xs:anyAtomicType*"/> 
    <xsl:param name="arg2" as="xs:anyAtomicType*"/> 
    
    <xsl:sequence select=" 
			  distinct-values($arg1[not(.=$arg2)])
			  "/>
  </xsl:function>
  
  <xsl:variable name="e" select="'csv'"/>
  <xsl:variable name="outputDir" select="'x_output_csv'"/>
  <xsl:variable name="debug" select="true()"/>
  <xsl:variable name="spc" select="'&#x20;'"/>
  <xsl:variable name="cl" select="':'"/>
  <xsl:variable name="dt" select="'.'"/>
  <xsl:variable name="scl" select="';'"/>
  <xsl:variable name="us" select="'_'"/>
  <xsl:variable name="qm" select="'&#34;'"/>
  <xsl:variable name="tab" select="'&#x9;'"/>
  <xsl:variable name="nl" select="'&#xa;'"/>
  <xsl:variable name="xxx" select="'textbf'"/>
  <xsl:variable name="cbl" select="'{'"/>
  <xsl:variable name="cbr" select="'}'"/>
  <xsl:variable name="bsl" select="'\'"/>
  <xsl:variable name="slang" select="'nob'"/>
  <xsl:variable name="tlang" select="'sme'"/>

  <xsl:variable name="headings">
    <head>Dárogillii (ohcansátni)</head>
    <head>Sámegillii (ohcansátni)</head>
    <head>Suomagillii</head>
    <head>Láhkaovdamearka</head>
    <head>(Vuosttáš láhkaovdamearkka) cealkkaovdamearka</head>
    <head>Eará cealkkaovdamearka</head>
    <head>Čilgehus sámegillii</head>
    <head>Čilgehus dárogillii</head>
    <head>Antonyma</head>
    <head>Sullásaš tearbma (V=vuolit tearbma, B=bajit tearbma)</head>
    <head>Sátneluohkká, sojahanmálle jna.</head>
    <head>Fágajoavkku siskkaldas kommentárat</head>
    <head>Mannan čoahkkimis geargan</head>
    <head>Fágajoavku (FJ) dahje jorgaleaddji ferte ođđaset gieđahallat</head>
    <head>Sámedikki giellastivrra áššis 50/05</head>
    <head>Listu</head>
  </xsl:variable>
  
  
  
  <!-- get input files -->
  <!-- These paths have to be adjusted accordingly -->
  <xsl:param name="file" select="'gt_rapl-ril.xml'"/>
  <xsl:variable name="file_name" select="substring-before((tokenize($file, '/'))[last()], '.xml')"/>

  <xsl:template match="/" name="main">
    <xsl:choose>
      <xsl:when test="doc-available($file)">
	<xsl:result-document href="{$outputDir}/{$file_name}.{$e}" format="txt">
	  
	  <xsl:for-each select="$headings/head">
	    <xsl:value-of select="normalize-space(.)"/>
	    <xsl:value-of select="if (position() = last()) then $nl else '&#x9;'"/>
	  </xsl:for-each>
	  
	  <xsl:for-each select="doc($file)/r/e">
	    
	    <xsl:if test="true()">
	      <xsl:message terminate="no">
		<xsl:value-of select="concat('.................', $nl)"/>
		<xsl:value-of select="concat('entry ', normalize-space(./lg/l), $nl)"/>
		<xsl:value-of select="'.................'"/>
	      </xsl:message>
	    </xsl:if>
	    
	    <xsl:value-of select="concat(normalize-space(./lg/l), '&#x9;',
				  normalize-space(./mg/tg/t[@xml:lang='sme']), '&#x9;',
				  normalize-space(./mg/tg/t[@xml:lang='fin']), '&#x9;',
				  normalize-space(./term_info/i[@type='Láhkaovdamearka']), '&#x9;')"/>

	    <xsl:for-each select="./term_info/i[@type='(Vuosttáš láhkaovdamearkka) cealkkaovdamearka']/xg">
	      <xsl:value-of select="normalize-space(concat(./x, '/', ./xt, ' '))"/>
	    </xsl:for-each>
	    
	    <xsl:value-of select="'&#x9;'"/>
	    
	    <xsl:for-each select="./term_info/i[@type='Eará cealkkaovdamearka']/xg">
	      <xsl:value-of select="normalize-space(concat(./x, '/', ./xt, ' '))"/>
	    </xsl:for-each>
	    
	    <xsl:value-of select="'&#x9;'"/>
	    
	    <xsl:value-of select="concat(normalize-space(./term_info/i[@type='Čilgehus sámegillii']), '&#x9;',
				  normalize-space(./term_info/i[@type='Čilgehus dárogillii']), '&#x9;',
				  normalize-space(./term_info/i[@type='Antonyma']), '&#x9;')"/>
	    
	    <xsl:for-each select="./term_info/i[@type='Sullásaš tearbma (V=vuolit tearbma, B=bajit tearbma)']/xg">
	      <xsl:value-of select="normalize-space(concat(./x, '/', ./xt, ' '))"/>
	    </xsl:for-each>

	    <xsl:if test="not(./term_info/i[@type='Sullásaš tearbma (V=vuolit tearbma, B=bajit tearbma)']/xg)">
	      <xsl:value-of select="normalize-space(./term_info/i[@type='Sullásaš tearbma (V=vuolit tearbma, B=bajit tearbma)'])"/>
	    </xsl:if>
	    
	    <xsl:value-of select="'&#x9;'"/>
	    
	    <xsl:value-of select="concat(normalize-space(./term_info/i[@type='Sátneluohkká, sojahanmálle jna.']), '&#x9;',
				  normalize-space(./term_info/i[@type='Fágajoavkku siskkaldas kommentárat']), '&#x9;',
				  normalize-space(./term_info/i[@type='Mannan čoahkkimis geargan']), '&#x9;',
				  normalize-space(./term_info/i[@type='Fágajoavku (FJ) dahje jorgaleaddji ferte ođđaset gieđahallat']), '&#x9;',
				  normalize-space(./term_info/i[@type='Sámedikki giellastivrra áššis 50/05']), '&#x9;',
				  normalize-space(./term_info/i[@type='Listu']/@value), '&#xa;')"/>
	    
	  </xsl:for-each>
	</xsl:result-document>
	
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>Cannot locate: </xsl:text><xsl:value-of select="$file"/><xsl:text>&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
