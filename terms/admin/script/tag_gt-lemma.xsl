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
  <xsl:param name="inFile" select="'xfilex'"/>
  <xsl:param name="this" select="base-uri(document(''))"/>
  <xsl:variable name="this_name" select="(tokenize($this, '/'))[last()]"/>
  <xsl:variable name="file_name" select="substring-before((tokenize($inFile, '/'))[last()], '.xml')"/> 

 
  <!-- out -->
  <xsl:variable name="outDir" select="'___outDir___'"/>
  
  <xsl:variable name="oe" select="'xml'"/>
  <xsl:variable name="tb" select="'&#9;'"/>
  <xsl:variable name="nl" select="'&#xA;'"/>
  <xsl:variable name="debug" select="false()"/>  

  <xsl:template match="/" name="main">
    
    <xsl:if test="misc:file-exists(resolve-uri($inFile))">
      <xsl:call-template name="processFile">
    	<xsl:with-param name="file" select="document($inFile)"/>
    	<xsl:with-param name="name" select="$file_name"/>
      </xsl:call-template>
    </xsl:if>

    <xsl:if test="misc:file-exists(resolve-uri($inDir))">
      
      <xsl:message terminate="no">
	<xsl:value-of select="concat('Processing dir: ', $inDir)"/>
      </xsl:message>
      
      <xsl:for-each select="for $f in collection(concat($inDir, '?select=*.xml;recurse=no;on-error=warning')) return $f">
	
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
      <r>
	<xsl:for-each select="$file//e">
	  <xsl:message terminate="no">
	    <xsl:value-of select="concat('Processing e: ', ./lg/l, $nl)"/>
	  </xsl:message> 
	  <!-- here to go -->
	  <e>
	    <xsl:copy-of select="./@*"/>
	    <lg>
	      <xsl:copy-of select="./lg/l"/>
	      <xsl:variable name="lgtc" select="count(./lg/l_gt)"/>
	      <!--l_test l_gt_c="{$lgtc}"/-->
	      <xsl:if test="$lgtc = 1">
		<xsl:copy-of select="./lg/l_gt"/>
	      </xsl:if>
	      <xsl:variable name="fix1" select="translate(./lg/l, '+', '')"/>
	      <xsl:variable name="fix2" select="translate(./lg/l, '+', 's')"/>
	      <!--xsl:message terminate="no">
		<xsl:value-of select="concat('xxxxxxxxxxxxxxxxxxxxxxxxxx ', ./lg/l, ' === ', $fix1)"/>
	      </xsl:message-->      
	      <xsl:if test="$lgtc &gt; 1">

		<xsl:variable name="same_lemma">
		  <l_gt>
		    <xsl:copy-of select="./lg/l_gt[. = $fix1]/@*"/>
		    <xsl:value-of select="./lg/l_gt[. = $fix1]"/>
		  </l_gt>
		</xsl:variable>
		<xsl:if test="not($same_lemma = '')">
		  <xsl:copy-of select="$same_lemma"/>
		</xsl:if>
		
		<xsl:variable name="s_lemma">
		  <l_gt>
		    <xsl:copy-of select="./lg/l_gt[. = $fix2]/@*"/>
		    <xsl:value-of select="./lg/l_gt[. = $fix2]"/>
		  </l_gt>
		</xsl:variable>

		<xsl:if test="not($s_lemma = '')">
		  <xsl:copy-of select="$s_lemma"/>
		</xsl:if>

		<xsl:if test="$same_lemma = '' and $s_lemma = ''">
		  <xsl:for-each select="./lg/l_gt">
		    <l_gt_zzz>
		      <xsl:copy-of select="./@*"/>
		      <xsl:value-of select="."/>
		    </l_gt_zzz>
		  </xsl:for-each>
		</xsl:if>
	      </xsl:if>
	    </lg>
	    <mg>
	      <tg>
		<xsl:copy-of select="./mg/tg/@*"/>
		<xsl:copy-of select="./mg/tg/t"/>
		<xsl:variable name="tgtc" select="count(./mg/tg/t_gt)"/>
		<!--t_test t_gt-c="{$tgtc}"/-->
		<xsl:if test="$tgtc = 1">
		  <xsl:copy-of select="./mg/tg/t_gt"/>
		</xsl:if>
		<xsl:if test="$tgtc &gt; 1">
		  <!--xsl:if test="./mg/tg/t">
		  </xsl:if-->
		  <xsl:copy-of select="./mg/tg/t_gt"/>
		</xsl:if>
	      </tg>
	    </mg>
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

