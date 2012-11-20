<?xml version="1.0"?>
<!--+
    | 
    | Script to merged entries with the samme lemma as following:
    | 1. if two or more meaning groups are exactly the same the are reduced to one
    | 2. if two or more meaning groups differ in the least feature (different attribute names, values, etc.)
    |    each of them is added to the unified entry
    | 3. the unified lemma gets the attribute "merged" with a numerical value showing how many entries have been 
    |    unified with the purpose of easing the linguists' manual cleanup 
    |
    | Usage: java -Xmx2048m -Dfile.encoding=UTF8 net.sf.saxon.Transform XML-INPUT XSL-THIS_FILE > XML-OUTPUT
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
	<xsl:copy-of select="./@*[not(./local-name() = 'merged')]"/>
	<xsl:variable name="mgs" select="count(./mg)"/>
	<xsl:if test="not($mgs = 1)">
	  <xsl:attribute name="mg_counter">
	    <xsl:value-of select="$mgs"/>
	  </xsl:attribute>
	</xsl:if>
	<!-- <xsl:attribute name="e_pos"> -->
	<!--   <xsl:value-of select="$current_position"/> -->
	<!-- </xsl:attribute> -->
	<!-- <xsl:attribute name="single_counter"> -->
	<!--   <xsl:value-of select="$lemma_freq"/> -->
	<!-- </xsl:attribute> -->
	<xsl:copy-of select="./node()"/>
      </e>
    </xsl:if>
      
    <xsl:if test="($lemma_freq &gt; 1) and ($follow_lemma = 0)">
      <e>
	<xsl:copy-of select="./@*[not(./local-name() = 'merged')]"/>
	<xsl:variable name="mgs" select="count(functx:distinct-deep(../e[$current_lemma = normalize-space(./lg/l/text())]/mg))"/>
	
	<!-- <xsl:attribute name="e_pos"> -->
	<!--   <xsl:value-of select="$current_position"/> -->
	<!-- </xsl:attribute> -->
	
	<xsl:if test="not($mgs = 1)">
	  <xsl:attribute name="mg_counter">
	    <xsl:value-of select="$mgs"/>
	  </xsl:attribute>
	</xsl:if>
	
	<!-- <xsl:attribute name="flc"> -->
	<!--   <xsl:value-of select="$follow_lemma"/> -->
	<!-- </xsl:attribute> -->
	
	<xsl:copy-of select="./lg"/>
	<xsl:copy-of select="functx:distinct-deep(../e[$current_lemma = normalize-space(./lg/l/text())]/mg)"/>
      </e>
    </xsl:if>
    </xsl:template>
    
  <xsl:template match="node()|@*">
    <xsl:apply-templates/>
  </xsl:template>
  
</xsl:stylesheet>
