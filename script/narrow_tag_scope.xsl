<?xml version="1.0"?>
<!--+
    | 
    | change the 2004-xml-spreadsheet XML files into a simpler xml format
    | Usage: java net.sf.saxon.Transform -it main STYLESHEET_NAME.xsl (inFile=INPUT_FILE_NAME.xml | inDir=INPUT_DIR)
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:local="nightbar"
                xmlns:misc="someURI"
                xmlns:File="java:java.io.File"
		xmlns:fmp="http://www.filemaker.com/fmpxmlresult"
		xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
		exclude-result-prefixes="xs local fmp ss File misc">

  <xsl:import href="/Users/cipriangerstenberger/local/xsl/file_checker.xsl"/>

  <xsl:strip-space elements="*"/>

  <xsl:output method="xml" name="xml"
              encoding="UTF-8"
              omit-xml-declaration="no"
              indent="yes"/>
  <xsl:output method="xml" name="html"
              encoding="UTF-8"
              omit-xml-declaration="yes"
              indent="yes"/>
  <xsl:output method="text" name="txt"
	      encoding="UTF-8"/>
  
  <!-- in -->
  <xsl:param name="inDir" select="'xxxdirxxx'"/>
  <xsl:param name="inFile" select="'xxxfilexxx.xml'"/>
  <xsl:param name="this" select="base-uri(document(''))"/>
  <xsl:variable name="this_name" select="(tokenize($this, '/'))[last()]"/>
  <xsl:variable name="file_name" select="substring-before((tokenize($inFile, '/'))[last()], '.xml')"/> 

 
  <!-- out -->
  <xsl:variable name="outDir" select="'outDir'"/>
  
  <xsl:variable name="oe" select="'xml'"/>
  <xsl:variable name="tb" select="'&#9;'"/>
  <xsl:variable name="nl" select="'&#xA;'"/>
  <xsl:variable name="debug" select="false()"/>  

  <xsl:template match="/" name="main">
    
    <xsl:if test="misc:file-exists(resolve-uri($inFile))">
      <xsl:call-template name="processFile">
    	<xsl:with-param name="file" select="document($inFile)"/>
    	<xsl:with-param name="name" select="$file_name"/>
	<xsl:with-param name="ie" select="'xml'"/>
	<xsl:with-param name="relPath" select="'./'"/>
      </xsl:call-template>
    </xsl:if>

    <xsl:if test="misc:file-exists(resolve-uri($inDir))">
      
      <xsl:message terminate="no">
	<xsl:value-of select="concat('Processing dir: ', $inDir)"/>
      </xsl:message>
      
      <xsl:for-each select="for $f in collection(concat($inDir, '?select=*.xml;recurse=yes;on-error=warning')) return $f">
	
	<xsl:variable name="current_file" select="substring-before((tokenize(document-uri(.), '/'))[last()], '.xml')"/>
	<xsl:variable name="current_dir" select="substring-before(document-uri(.), $current_file)"/>
	<xsl:variable name="current_location" select="concat($inDir, substring-after($current_dir, $inDir))"/>
	
	<xsl:call-template name="processFile">
	  <xsl:with-param name="file" select="."/>
	  <xsl:with-param name="name" select="$current_file"/>
	  <xsl:with-param name="ie" select="'xml'"/>
	  <xsl:with-param name="relPath" select="$current_location"/>
	</xsl:call-template>
      </xsl:for-each>
    </xsl:if>
    
    <xsl:if test="not(misc:file-exists(resolve-uri($inFile)))">
      <xsl:value-of select="concat($nl, 'No  file ', $inFile, ' found.', $nl)"/>
    </xsl:if>

    <xsl:if test="not(misc:file-exists(resolve-uri($inDir)))">
      <xsl:value-of select="concat($nl, 'No  dir ', $inDir, ' found.', $nl)"/>
    </xsl:if>

  </xsl:template>

  <!-- template to process file, once its existence has been determined -->
  <xsl:template name="processFile">
    <xsl:param name="file"/>
    <xsl:param name="name"/>
    <xsl:param name="ie"/>
    <xsl:param name="relPath"/>

    <xsl:message terminate="no">
      <xsl:value-of select="concat('Processing file: ', $relPath, $name, '.', $ie)"/>
    </xsl:message>      
    
    <!-- out -->
    <xsl:result-document href="{$outDir}/{$relPath}{$name}.{$oe}" format="{$oe}">
      <r id="nobsme" xml:lang="nob">  
	<xsl:for-each select="$file/r/e">
	  <xsl:message terminate="no">
	    <xsl:value-of select="concat('Processing file: ', ./lg/l, $nl)"/>
	  </xsl:message>      
	  
	  <e>
	    <xsl:copy-of copy-namespaces="no" select="./lg"/>
	    <xsl:for-each select="./mg">
	      <mg>
		<xsl:copy-of copy-namespaces="no" select="./@*"/>
		<xsl:for-each select="./tg">
		<tg>
		  <xsl:copy-of copy-namespaces="no" select="./@*"/>
		  <xsl:for-each select="./t">
		    <t>
		      <xsl:copy-of copy-namespaces="no" select="./@*"/>
		      <xsl:copy-of copy-namespaces="no" select="../../../@*"/>
		      <xsl:value-of select="normalize-space(.)"/>
		    </t>
		  </xsl:for-each>
		  <xsl:copy-of copy-namespaces="no" select="./xg"/>
		</tg>
		</xsl:for-each>
	      </mg>
	    </xsl:for-each>
	  </e>
	</xsl:for-each>
      </r>

    </xsl:result-document>

    <xsl:if test="$debug">
      <xsl:message terminate="no">
	<xsl:value-of select="concat('   Done!',' Output file  ',$name,' in: ', $outDir)"/>
      </xsl:message>
    </xsl:if>

  </xsl:template>
  
</xsl:stylesheet>

