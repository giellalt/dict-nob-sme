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

  <!-- get input files -->
  <!-- These paths have to be adjusted accordingly -->
  <xsl:param name="file" select="'../terms/law/rapl-ril_2011-01.xml'"/>
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
	      <e>
		<xsl:variable name="c_pos">
		  <xsl:variable name="cc11" select="normalize-space(Cell[11]/Data/text())"/>
		  <xsl:if test="$cc11 = ''">
		    <xsl:value-of select="'xxx'"/>
		  </xsl:if>
		  <xsl:if test="not($cc11 = '')">
		    <xsl:if test="contains($cc11, $scl)">
		      <xsl:call-template name="getPos">
			<xsl:with-param name="str" select="normalize-space(substring-before($cc11, $scl))"/>
		      </xsl:call-template>
		    </xsl:if>
		    <xsl:if test="not(contains($cc11, $scl))">
		      <xsl:call-template name="getPos">
			<xsl:with-param name="str" select="$cc11"/>
		      </xsl:call-template>
		    </xsl:if>
		  </xsl:if>
		</xsl:variable>
		<lg>
		  <l pos="{$c_pos}">
		    <xsl:value-of select="normalize-space(Cell[1]/Data/text())"/>
		  </l>
		</lg>
		<mg>
		  <tg>
		    <t pos="{$c_pos}" xml:lang="{$tlang}">
		      <xsl:if test="not(normalize-space(Cell[2]/Data/text()) = '')">
			<xsl:value-of select="normalize-space(Cell[2]/Data/text())"/>
		      </xsl:if>
		      <xsl:if test="normalize-space(Cell[2]/Data/text()) = ''">
			<xsl:value-of select="'xxx'"/>
		      </xsl:if>
		    </t>
		    <xsl:if test="not(normalize-space(Cell[3]/Data/text()) = '')">
		      <t pos="{$c_pos}" xml:lang="fin">
			<xsl:value-of select="normalize-space(Cell[3]/Data/text())"/>
		      </t>
		    </xsl:if>
		  </tg>
		</mg>
		<term_info>
		  <i type="{$labels/e/l[@l_pos = 16]}" value="{normalize-space(Cell[16]/Data/text())}"/>
		  <!-- <i type="{$labels/e/l[@l_pos = 4]}" count="{count(tokenize(normalize-space(Cell[4]/Data/text()), '___'))}"> -->
		  <i type="{$labels/e/l[@l_pos = 4]}">
		    <xsl:for-each select="tokenize(normalize-space(Cell[4]/Data/text()), '___')">
		      <si>
			<xsl:value-of select="normalize-space(.)"/>
		      </si>
		    </xsl:for-each>
		  </i>
		  <i type="{$labels/e/l[@l_pos = 5]}">
		    <xsl:call-template name="getAlignments">
		      <xsl:with-param name="data" select="Cell[5]/Data"/>
		    </xsl:call-template>
		  </i>
		  <i type="{$labels/e/l[@l_pos = 6]}">
		    <xsl:call-template name="getAlignments">
		      <xsl:with-param name="data" select="Cell[6]/Data"/>
		    </xsl:call-template>
		  </i>
		  <i type="{$labels/e/l[@l_pos = 7]}">
		    <xsl:copy-of copy-namespaces="no" select="Cell[7]/Data/node()"/>
		  </i>
		  <i type="{$labels/e/l[@l_pos = 8]}">
		    <xsl:copy-of copy-namespaces="no" select="Cell[8]/Data/node()"/>
		  </i>
		  <i type="{$labels/e/l[@l_pos = 9]}">
		    <!-- <xsl:copy-of copy-namespaces="no" select="Cell[9]/Data/node()"/> -->
		    <xsl:call-template name="getAlignments">
		      <xsl:with-param name="data" select="Cell[9]/Data"/>
		    </xsl:call-template>
		  </i>
		  <i type="{$labels/e/l[@l_pos = 10]}">
		    <!-- <xsl:copy-of copy-namespaces="no" select="Cell[10]/Data/node()"/> -->
		    <xsl:call-template name="getAlignments">
		      <xsl:with-param name="data" select="Cell[10]/Data"/>
		    </xsl:call-template>
		  </i>
		  <i type="{$labels/e/l[@l_pos = 11]}">
		    <xsl:copy-of copy-namespaces="no" select="Cell[11]/Data/node()"/>
		  </i>
		  <i type="{$labels/e/l[@l_pos = 12]}">
		    <xsl:copy-of copy-namespaces="no" select="Cell[12]/Data/node()"/>
		  </i>
		  <i type="{$labels/e/l[@l_pos = 13]}">
		    <xsl:copy-of copy-namespaces="no" select="lower-case(Cell[13]/Data/node())"/>
		  </i>
		  <i type="{$labels/e/l[@l_pos = 14]}">
		    <xsl:copy-of copy-namespaces="no" select="Cell[14]/Data/node()"/>
		  </i>
		  <i type="{$labels/e/l[@l_pos = 15]}">
		    <xsl:copy-of copy-namespaces="no" select="Cell[15]/Data/node()"/>
		  </i>
		</term_info>
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
  
  <xsl:template name="getPos">
    <xsl:param name="str"/>
    <xsl:value-of select="if ($str = 's') then 'n' else
			  if ($str = 'v') then 'v' else
			  if ($str = 'adj') then 'a' else
			  if ($str = 'adv') then 'adv' else
			  '_yyy_'"/>
    
  </xsl:template>

  <xsl:template name="getAlignments">
    <xsl:param name="data"/>
    <xsl:if test="(count($data/*) = 0) and not(normalize-space($data) = '')">
      <si_x0x>
	<xsl:value-of select="normalize-space($data)"/>
      </si_x0x>
    </xsl:if>
    <xsl:if test="(count($data/*) = 1)">
      <si_x1x>
	<xsl:copy-of copy-namespaces="no" select="normalize-space($data/*)"/>
      </si_x1x>
    </xsl:if>
    <xsl:if test="(count($data/*) &gt; 1)">
      <xsl:for-each select="$data/B">
	<xsl:variable name="nobix" select="normalize-space(.)"/>
	<xsl:variable name="smeix" select="normalize-space(following-sibling::Font[1]/text())"/>
	<xg>
	  <x>
	    <xsl:value-of select="normalize-space(replace($nobix, $cl, ''))"/>
	  </x>
	  <xt>
	    <xsl:variable name="tmp" select="normalize-space(replace($smeix, $cl, ''))"/>
	    <xsl:if test="ends-with($tmp, $dt)">
	      <xsl:value-of select="normalize-space(substring-before($tmp, $dt))"/>
	    </xsl:if>
	    <xsl:if test="not(ends-with($tmp, $dt))">
	      <xsl:value-of select="$tmp"/>
	    </xsl:if>
	  </xt>
	</xg>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>


</xsl:stylesheet>
