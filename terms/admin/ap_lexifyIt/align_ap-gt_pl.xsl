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
  <xsl:output method="xml"
              encoding="UTF-8"
              omit-xml-declaration="no"
              indent="yes"/>
  

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
  <xsl:variable name="outputDir" select="'xml-out'"/>

  <xsl:param name="in_nob" select="'data.nob'"/>
  <xsl:param name="in_sme" select="'data.sme'"/>
  <xsl:param name="ut_ap_nob" select="'data.ap.tagged.clean.nob'"/>
  <xsl:param name="ut_ap_sme" select="'data.ap.tagged.clean.sme'"/>
  <xsl:param name="ut_gt_nob" select="'data.gt.tagged.clean.nob'"/>
  <xsl:param name="ut_gt_sme" select="'data.gt.tagged.clean.sme'"/>
  
  <xsl:template match="/" name="main">
    <xsl:variable name="src_in_nob" select="unparsed-text($in_nob)"/>
    <xsl:variable name="src_in_sme" select="unparsed-text($in_sme)"/>
    <xsl:variable name="src_ut_ap_nob" select="unparsed-text($ut_ap_nob)"/>
    <xsl:variable name="src_ut_ap_sme" select="unparsed-text($ut_ap_sme)"/>
    <xsl:variable name="src_ut_gt_nob" select="unparsed-text($ut_gt_nob)"/>
    <xsl:variable name="src_ut_gt_sme" select="unparsed-text($ut_gt_sme)"/>
    
    <xsl:variable name="lns_in_nob" select="tokenize($src_in_nob, '&#xa;')" as="xs:string+"/>
    <xsl:variable name="lns_in_sme" select="tokenize($src_in_sme, '&#xa;')" as="xs:string+"/>
    <xsl:variable name="lns_ut_ap_nob" select="tokenize($src_ut_ap_nob, '&#xa;')" as="xs:string+"/>
    <xsl:variable name="lns_ut_ap_sme" select="tokenize($src_ut_ap_sme, '&#xa;')" as="xs:string+"/>
    <xsl:variable name="lns_ut_gt_nob" select="tokenize($src_ut_gt_nob, '&#xa;')" as="xs:string+"/>
    <xsl:variable name="lns_ut_gt_sme" select="tokenize($src_ut_gt_sme, '&#xa;')" as="xs:string+"/>
    
    <xsl:result-document href="{$outputDir}/aligned_in-ot_data.{$e}">
      <nob2sme>
	<xsl:for-each select="$lns_in_nob">
	  <xsl:variable name="position" select="position()"/>
	  <xsl:variable name="current_line" select="normalize-space(.)"/>
	  <xsl:message terminate="no">
	    <xsl:value-of select="concat('Processing line ', $position)"/>
	  </xsl:message>
	  <l pos="{$position}">
	    <nob>
	      <in_nob>
		<xsl:attribute name="tc">
		  <xsl:value-of select="count(tokenize(normalize-space(.), ' '))"/>
		</xsl:attribute>
		<xsl:copy-of select="normalize-space(.)"/>
	      </in_nob>
	      <ot_nob>
		<xsl:attribute name="tc">
		  <xsl:value-of select="count(tokenize(normalize-space($lns_ot_nob[$position]), ' '))"/>
		</xsl:attribute>
		<xsl:copy-of select="normalize-space($lns_ot_nob[$position])"/>
	      </ot_nob>
	      <nob_aligned>
		<xsl:for-each select="tokenize(normalize-space($lns_ot_nob[$position]), ' ')">
		  <xsl:variable name="cp" select="position()"/>
		  <l pos="{$cp}">
		    <in_nob_w>
		      <xsl:value-of select="(tokenize($current_line, ' '))[$cp]"/>
		    </in_nob_w>
		    <ot_nob_w>
		      <xsl:value-of select="."/>
		    </ot_nob_w>
		  </l>
		</xsl:for-each>
	      </nob_aligned>
	    </nob>
	    <sme>
	      <in_sme>
		<xsl:attribute name="tc">
		  <xsl:value-of select="count(tokenize(normalize-space($lns_in_sme[$position]), ' '))"/>
		</xsl:attribute>
		<xsl:copy-of select="normalize-space($lns_in_sme[$position])"/>
	      </in_sme>
	      <ot_sme>
		<xsl:attribute name="tc">
		  <xsl:value-of select="count(tokenize(normalize-space($lns_ot_sme[$position]), ' '))"/>
		</xsl:attribute>
		<xsl:copy-of select="normalize-space($lns_ot_sme[$position])"/>
	      </ot_sme>
	      <sme_aligned>
		<xsl:for-each select="tokenize(normalize-space($lns_ot_sme[$position]), ' ')">
		  <xsl:variable name="cp" select="position()"/>
		  <l pos="{$cp}">
		    <in_sme_w>
		      <xsl:value-of select="(tokenize(normalize-space($lns_in_sme[$position]), ' '))[$cp]"/>
		    </in_sme_w>
		    <ot_sme_w>
		      <xsl:value-of select="."/>
		    </ot_sme_w>
		  </l>
		</xsl:for-each>
	      </sme_aligned>
	    </sme>
	  </l>
	</xsl:for-each>
      </nob2sme>
    </xsl:result-document>
  </xsl:template>
  
</xsl:stylesheet>

