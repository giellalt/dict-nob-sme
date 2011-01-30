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
  <xsl:output method="xml"
	      omit-xml-declaration="no"
	      indent="yes"/>

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
  
  <xsl:variable name="e" select="'xml'"/>
  <xsl:variable name="outputDir" select="'output_kt2gt'"/>
  <xsl:variable name="debug" select="true()"/>


  <xsl:variable name="spc" select="'&#x20;'"/>
  <xsl:variable name="cl" select="':'"/>
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

  <!-- get input files -->
  <!-- These paths have to be adjusted accordingly -->
  <xsl:param name="file" select="'my_rapl-ril_2011-01.xml'"/>
  <xsl:variable name="file_name" select="substring-before((tokenize($file, '/'))[last()], '.xml')"/>


  
  <xsl:template match="/" name="main">
    
    <xsl:choose>
      <xsl:when test="doc-available($file)">

	<xsl:variable name="file_out" as="element()">
	  <r xml:lang="{$slang}">

	    <xsl:variable name="labels">
	      <e>
		<xsl:for-each select="doc($file)/Workbook/Worksheet/Table/Row[1]/Cell">
		  <l l_pos="{position()}">
		    <xsl:value-of select="normalize-space(./Data/text())"/>
		  </l>
		  <xsl:if test="false()">
		    <xsl:message terminate="no">
		      <xsl:value-of select="concat('.................', $nl)"/>
		      <xsl:value-of select="concat('label ', position(), ' ___ ', normalize-space(./Data/text()), $nl)"/>
		      <xsl:value-of select="'.................'"/>
		    </xsl:message>
		  </xsl:if>
		</xsl:for-each>
	      </e>
	    </xsl:variable>

	    <xsl:for-each select="doc($file)/Workbook/Worksheet/Table/Row[position() &gt; 1]">
	      <xsl:if test="$debug">
		<xsl:message terminate="no">
		  <xsl:value-of select="concat('-----------------------------------------', $nl)"/>
		  <xsl:value-of select="concat('nob entry: ', ./Cell[1]/Data[1] , $nl)"/>
		  <xsl:value-of select="'-----------------------------------------'"/>
		</xsl:message>
	      </xsl:if>
	      <e e_pos="{position()}" c_count="{count(Cell) - 1}">
		<xsl:for-each select="./Cell[position() &lt; 17]">
		  <xsl:variable name="cp" select="position()"/>
		  <c content="{$labels/e/l[@l_pos = $cp]}" c_pos="{position()}" kids="{count(./*)}">
		    <xsl:if test="(count(./*) > 0) and not(normalize-space(.) = '')">
		      <xsl:copy-of copy-namespaces="no" select="./node()"/>
		    </xsl:if>
		  </c>
		</xsl:for-each>
	      </e>
	    </xsl:for-each>
	  </r>
	</xsl:variable>
	
	<xsl:result-document href="{$outputDir}/gt_{$file_name}.{$e}">
	  <xsl:copy-of select="$file_out"/>
	</xsl:result-document>
	
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>Cannot locate: </xsl:text><xsl:value-of select="$file"/><xsl:text>&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
