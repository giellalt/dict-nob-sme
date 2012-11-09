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
		xmlns:functx="http://www.functx.com"
		exclude-result-prefixes="xs functx">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>

<xsl:function name="functx:is-node-in-sequence-deep-equal" as="xs:boolean" 
              xmlns:functx="http://www.functx.com" >
  <xsl:param name="node" as="node()?"/> 
  <xsl:param name="seq" as="node()*"/> 
 
  <xsl:sequence select=" 
   some $nodeInSeq in $seq satisfies deep-equal($nodeInSeq,$node)
 "/>
   
</xsl:function>

<xsl:function name="functx:distinct-deep" as="node()*" 
              xmlns:functx="http://www.functx.com" >
  <xsl:param name="nodes" as="node()*"/> 
 
  <xsl:sequence select=" 
    for $seq in (1 to count($nodes))
    return $nodes[$seq][not(functx:is-node-in-sequence-deep-equal(
                          .,$nodes[position() &lt; $seq]))]
 "/>
   
</xsl:function>

  <xsl:variable name="e" select="'xml'"/>
  <xsl:variable name="outputDir" select="'out-dir'"/>
  
  <!-- get input files -->
  <!-- These paths have to be adjusted accordingly -->
  <xsl:param name="file01" select="'gogo01'"/>
  <xsl:param name="file02" select="'gogo02'"/>

  <xsl:variable name="nl" select="'&#xa;'"/>


  <xsl:template match="r">
    <r>
      <xsl:copy-of select="./@*"/>
      <xsl:apply-templates/>
    </r>
  </xsl:template>

  <xsl:template match="e">
    
    <xsl:variable name="current_position" select="position()"/>
    <xsl:variable name="current_lemma" select="normalize-space(./lg/l/text())"/>
    <xsl:variable name="lemma_freq" select="count(../e[$current_lemma = normalize-space(./lg/l/text())])"/>
    <xsl:variable name="follow_lemma" select="count(following-sibling::e[normalize-space(./lg/l/text()) = $current_lemma])"/>

    <xsl:if test="true()">
      <xsl:message terminate="no">
	<xsl:value-of select="concat('.................', $nl)"/>
	<xsl:value-of select="concat('entry ', $current_position, ' ___ ', $current_lemma, $nl)"/>
	<xsl:value-of select="'.................'"/>
      </xsl:message>
    </xsl:if>
    
    <xsl:if test="$lemma_freq = 1">
      <e>
	<xsl:copy-of select="./@*"/>
      
<!-- 	<xsl:attribute name="e_pos"> -->
<!-- 	  <xsl:value-of select="$current_position"/> -->
<!-- 	</xsl:attribute> -->
	
<!-- 	<xsl:attribute name="single_counter"> -->
<!-- 	  <xsl:value-of select="$lemma_freq"/> -->
<!-- 	</xsl:attribute> -->
	<xsl:copy-of select="./node()"/>
      </e>
    </xsl:if>
      
    <xsl:if test="($lemma_freq &gt; 1) and ($follow_lemma = 0)">
      <e>
	<xsl:copy-of select="./@*"/>
      
<!-- 	<xsl:attribute name="e_pos"> -->
<!-- 	  <xsl:value-of select="$current_position"/> -->
<!-- 	</xsl:attribute> -->
	
	<xsl:attribute name="lc">
	  <xsl:value-of select="$lemma_freq"/>
	</xsl:attribute>

	<xsl:attribute name="flc">
	  <xsl:value-of select="$follow_lemma"/>
	</xsl:attribute>

	<xsl:copy-of select="./lg"/>
	<xsl:copy-of select="functx:distinct-deep(../e[$current_lemma = normalize-space(./lg/l/text())]/mg)"/>
      </e>
    </xsl:if>
    </xsl:template>
    
  <xsl:template match="node()|@*">
    <xsl:apply-templates/>
  </xsl:template>
  
</xsl:stylesheet>
