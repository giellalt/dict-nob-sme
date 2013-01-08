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
  <xsl:variable name="pp" select="'|'"/>
  <xsl:variable name="pct" select="'!#%()+/-,....:..;=?–––—‘’“”„†•…‰€−'&apos;&quot;&lt;&gt;&amp;'"/>
  
  
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
    
    <xsl:result-document href="{$outputDir}/aligned_in-ut_data.{$e}">
      <nob2sme>
	<xsl:for-each select="$lns_in_nob">
	  <xsl:variable name="position" select="position()"/>
	  <!-- filtering nob/sme punctuation from the input data-->
	  <xsl:variable name="clin" select="normalize-space(.)"/>
	  <xsl:variable name="lin">
	    <xsl:variable name="wcl">
	      <xsl:for-each select="tokenize($clin, ' ')">
		<xsl:if test="not(contains($pct, .))">
		  <xsl:value-of select="concat(., ' ')"/>
		</xsl:if>
	      </xsl:for-each>
	    </xsl:variable>
	    <xsl:value-of select="normalize-space($wcl)"/>
	  </xsl:variable>
	  
	  <xsl:variable name="clis" select="normalize-space($lns_in_sme[$position])"/>
	  <xsl:variable name="lis">
	    <xsl:variable name="wcl">
	      <xsl:for-each select="tokenize($clis, ' ')">
		<xsl:if test="not(contains($pct, .))">
		  <xsl:value-of select="concat(., ' ')"/>
		</xsl:if>
	      </xsl:for-each>
	    </xsl:variable>
	    <xsl:value-of select="normalize-space($wcl)"/>
	  </xsl:variable>
	  
	  <xsl:variable name="luan" select="normalize-space(translate(translate($lns_ut_ap_nob[$position], '&lt;', '{'), '&gt;', '}'))"/>
	  <xsl:variable name="luas" select="normalize-space(translate(translate($lns_ut_ap_sme[$position], '&lt;', '{'), '&gt;', '}'))"/>
	  
	  <xsl:variable name="lugn" select="normalize-space(translate(translate($lns_ut_gt_nob[$position], '&lt;', '{'), '&gt;', '}'))"/>
	  <xsl:variable name="lugs" select="normalize-space(translate(translate($lns_ut_gt_sme[$position], '&lt;', '{'), '&gt;', '}'))"/>

	  <xsl:message terminate="no">
	    <xsl:value-of select="concat('Processing line ', $position)"/>
	  </xsl:message>
	  <l pos="{$position}">
	    <nob>
	      <in_nob>
		<xsl:attribute name="tc">
		  <xsl:value-of select="count(tokenize($lin, ' '))"/>
		</xsl:attribute>
		<xsl:copy-of select="$lin"/>
	      </in_nob>
	      <ut_gt_nob>
		<xsl:attribute name="tc">
		  <xsl:value-of select="count(tokenize($lugn, ' '))"/>
		</xsl:attribute>
		<xsl:copy-of select="$lugn"/>
	      </ut_gt_nob>
	      <ut_ap_nob>
		<xsl:attribute name="tc">
		  <xsl:value-of select="count(tokenize($luan, ' '))"/>
		</xsl:attribute>
		<xsl:copy-of select="$luan"/>
	      </ut_ap_nob>
	      <aligned_nob>
		<xsl:for-each select="tokenize($luan, ' ')">
		  <xsl:variable name="cp" select="position()"/>
		  <tn pos="{$cp}">
		    <xsl:value-of select="concat((tokenize($lin, ' '))[$cp], ' ', $pp, ' ', (tokenize($lugn, ' '))[$cp], ' ', $pp, ' ', .)"/>
		  </tn>
		</xsl:for-each>
	      </aligned_nob>
	    </nob>
	    <sme>
	      <in_sme>
		<xsl:attribute name="tc">
		  <xsl:value-of select="count(tokenize($lis, ' '))"/>
		</xsl:attribute>
		<xsl:copy-of select="$lis"/>
	      </in_sme>
	      <ut_gt_sme>
		<xsl:attribute name="tc">
		  <xsl:value-of select="count(tokenize($lugs, ' '))"/>
		</xsl:attribute>
		<xsl:copy-of select="$lugs"/>
	      </ut_gt_sme>
	      <ut_ap_sme>
		<xsl:attribute name="tc">
		  <xsl:value-of select="count(tokenize($luas, ' '))"/>
		</xsl:attribute>
		<xsl:copy-of select="$luas"/>
	      </ut_ap_sme>
	      <aligned_sme>
		<xsl:for-each select="tokenize($luas, ' ')">
		  <xsl:variable name="cp" select="position()"/>
		  <ts pos="{$cp}">
		    <xsl:value-of select="concat((tokenize($lis, ' '))[$cp], ' ', $pp, ' ', (tokenize($lugs, ' '))[$cp], ' ', $pp, ' ', .)"/>
		  </ts>
		</xsl:for-each>
	      </aligned_sme>
	    </sme>
	  </l>
	</xsl:for-each>
      </nob2sme>
    </xsl:result-document>
  </xsl:template>
  
</xsl:stylesheet>

