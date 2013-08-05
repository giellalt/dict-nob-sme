<?xml version="1.0"?>
<!--+
    | Transforms a csv file with two fields - "lemma","part-of-speech"- into a fitswe gtdict xml format
    | NB: An XSLT-2.0-processor is needed!
    | Usage: java -Xmx2024m net.sf.saxon.Transform -it main THIS_SCRIPT file="INPUT-FILE"
    | 
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:fn="fn"
		xmlns:local="nightbar"
		exclude-result-prefixes="xs fn local">
  
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

 <!-- Converts numbers in Scientific Notation e.g. 6.15595432E8 to decimal -->
    <xsl:function name="local:remove-scientific-notation"> 
        <xsl:param name="attr"/> 
        <xsl:choose> 
            <xsl:when test="matches($attr, '^\-?[\d\.,]*[Ee][+\-]*\d*$')"> 
                <xsl:value-of 
                    select="format-number(number($attr), '#0.#############')"> 
                </xsl:value-of> 
            </xsl:when> 
            <xsl:otherwise> 
                <xsl:value-of select="$attr"></xsl:value-of> 
            </xsl:otherwise> 
        </xsl:choose> 
    </xsl:function>

<xsl:function name="local:distinct-deep" as="node()*">
  <xsl:param name="nodes" as="node()*"/> 
 
  <xsl:sequence select=" 
    for $seq in (1 to count($nodes))
    return $nodes[$seq][not(local:is-node-in-sequence-deep-equal(
                          .,$nodes[position() &lt; $seq]))]
 "/>
   
</xsl:function>

<xsl:function name="local:is-node-in-sequence-deep-equal" as="xs:boolean">
  <xsl:param name="node" as="node()?"/> 
  <xsl:param name="seq" as="node()*"/> 
 
  <xsl:sequence select=" 
   some $nodeInSeq in $seq satisfies deep-equal($nodeInSeq,$node)
 "/>
   
</xsl:function>

  <xsl:variable name="e" select="'xml'"/>
  <xsl:variable name="outputDir" select="'_xml-out_'"/>

  <xsl:param name="inFile" select="'default.freq'"/>
  
  <xsl:template match="/" name="main">
    
    <xsl:choose>
      <xsl:when test="unparsed-text-available($inFile)">

	<xsl:variable name="file_name" select="substring-before($inFile, '.freq')"/>

	<xsl:variable name="source" select="unparsed-text($inFile)"/>
	<xsl:variable name="lines" select="tokenize($source, '&#xa;')" as="xs:string+"/>
	<xsl:variable name="output">
	  <r>
	    <!-- capture the patterns and their meanings -->
	    <xsl:for-each select="$lines">
	      <xsl:analyze-string select="." regex='^(\s*)(\d+)(.*)$' flags="s">
		<xsl:matching-substring>
		  <lemma abs_f="{regex-group(2)}" value="{normalize-space(regex-group(3))}"/>
		</xsl:matching-substring>
		<xsl:non-matching-substring>
		  <xxx><xsl:value-of select="." /></xxx>
		</xsl:non-matching-substring>
	      </xsl:analyze-string>
	    </xsl:for-each>
	  </r>
	</xsl:variable>

	<xsl:variable name="sum">
	  <xsl:value-of select="local:remove-scientific-notation(string(sum($output//lemma/@abs_f)))"/>
	</xsl:variable>
	
	<xsl:result-document href="{$outputDir}/{$inFile}.{$e}" format="{$e}">
	  <r sum="{$sum}">
	    <xsl:for-each select="$output//lemma">
	      <lemma>
		<xsl:copy-of select="./@abs_f"/>
		<xsl:attribute name="rel_f">
		  <xsl:value-of select="local:remove-scientific-notation(string(number(./@abs_f) div number($sum)))"/>
		</xsl:attribute>
		<xsl:copy-of select="./@value"/>
	      </lemma>
	    </xsl:for-each>
	  </r>
	</xsl:result-document>
	
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>Cannot locate : </xsl:text><xsl:value-of select="$inFile"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>

