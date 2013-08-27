<?xml version="1.0"?>
<!--+
    | Usage: java -Xmx2048m net.sf.saxon.Transform -it main THIS_FILE inDir=DIR
    | 
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		xmlns:local="nightbar"
		exclude-result-prefixes="xs xhtml local">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" name="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>

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

  <xsl:param name="l_ggg_freqFile" select="'00_infreqs/short_nowac-1.1.lemmas.freq.xml'"/>
  <xsl:param name="l_fad_freqFile" select="'00_infreqs/fad_nob_lemma.freq.xml'"/>
  <xsl:param name="t_ggg_freqFile" select="'00_infreqs/20130819_sme_lemma.freq.xml'"/>
  <xsl:param name="t_fad_freqFile" select="'00_infreqs/fad_sme_lemma.freq.xml'"/>

  <!--xsl:param name="inDir" select="'00_indata/src_gt-only'"/-->
  <!--xsl:param name="inDir" select="'00_indata/src_gt-fad_merged'"/-->
  <xsl:param name="inDir" select="'00_indata/src_fad-only'"/>
  <xsl:param name="outDir" select="'_out_'"/>
  <xsl:variable name="of" select="'xml'"/>
  <xsl:variable name="e" select="$of"/>
  <xsl:variable name="debug" select="false()"/>
  <xsl:variable name="nl" select="'&#xa;'"/>

  <xsl:template match="/" name="main">

    <xsl:variable name="l_ggg_ff" select="document($l_ggg_freqFile)"/>
    <xsl:variable name="l_fad_ff" select="document($l_fad_freqFile)"/>
    <xsl:variable name="t_ggg_ff" select="document($t_ggg_freqFile)"/>
    <xsl:variable name="t_fad_ff" select="document($t_fad_freqFile)"/>
    
    <xsl:for-each select="for $f in collection(concat($inDir,'?recurse=no;select=*.xml;on-error=warning')) return $f">
      
      <xsl:variable name="current_file" select="(tokenize(document-uri(.), '/'))[last()]"/>
      <xsl:variable name="current_dir" select="substring-before(document-uri(.), $current_file)"/>
      <xsl:variable name="current_location" select="concat($inDir, substring-after($current_dir, $inDir))"/>
      <xsl:variable name="file_name" select="substring-before($current_file, '.xml')"/>      

      <xsl:if test="true()">
	<xsl:message terminate="no">
	  <xsl:value-of select="concat('-----------------------------------------', $nl)"/>
	  <xsl:value-of select="concat('processing file ', $current_file, $nl)"/>
	  <xsl:value-of select="'-----------------------------------------'"/>
	</xsl:message>
      </xsl:if>

      <xsl:result-document href="{$outDir}/{$inDir}/{$file_name}.{$of}" format="{$of}">
	<r>
	  <xsl:for-each select=".//e">
	    <e>
	      <xsl:copy-of select="./@*"/>
	      <xsl:variable name="l_current_lemma" select="./lg/l"/>
	      <xsl:variable name="l_current_pos">
		<xsl:if test="./lg/l/@pos='N'">
		  <xsl:value-of select="'subst'"/>
		</xsl:if>
		<xsl:if test="./lg/l/@pos='A'">
		  <xsl:value-of select="'adj'"/>
		</xsl:if>
		<xsl:if test="./lg/l/@pos='V'">
		  <xsl:value-of select="'verb'"/>
		</xsl:if>
	      </xsl:variable>
	      
	      <xsl:variable name="l_g_freq">
		<xsl:copy-of select="$l_ggg_ff/r/lemma[normalize-space(substring-before(@value, ' ')) = $l_current_lemma]
				     [starts-with(substring-after(@value, ' '), $l_current_pos)][1]"/>
	      </xsl:variable>

              <xsl:variable name="l_f_freq">
                <xsl:copy-of select="$l_fad_ff/r/lemma[normalize-space(substring-before(@value, ' :')) = $l_current_lemma]
                                     [starts-with(substring-after(@value, ' :'), $l_current_pos)][1]"/>
              </xsl:variable>
	      
	      <xsl:if test="$debug">
		<test>
		  <xsl:copy-of select="$l_g_freq"/>
		  <xsl:copy-of select="$l_f_freq"/>
		</test>
	      </xsl:if>

	      <xsl:variable name="l_gf">
		<xsl:if test="not($l_g_freq/lemma/@rel_f)">
		  <xsl:value-of select="'0'"/>
		</xsl:if>
		<xsl:if test="$l_g_freq/lemma/@rel_f">
		  <xsl:value-of select="$l_g_freq/lemma/@rel_f"/>
		</xsl:if>
	      </xsl:variable>
	      
	      <xsl:variable name="l_ff">
		<xsl:if test="not($l_f_freq/lemma/@rel_f)">
		  <xsl:value-of select="'0'"/>
		</xsl:if>
		<xsl:if test="$l_f_freq/lemma/@rel_f">
		  <xsl:value-of select="$l_f_freq/lemma/@rel_f"/>
		</xsl:if>
	      </xsl:variable>

	      <lg>
		<l>
		  <xsl:copy-of select="./lg/l/@*"/>
		  <xsl:attribute name="gf" select="$l_gf"/>
                  <xsl:attribute name="ff" select="$l_ff"/>

                  <!--xsl:attribute name="gf-ff" select="substring(string($l_gf - $l_ff), 1, 10)"/-->

                  <!--xsl:attribute name="gf-ff" select="substring(local:remove-scientific-notation(string(number($l_gf) - number($l_ff))), 1, 10)"/-->

                  <xsl:attribute name="gf-ff">
		    <xsl:variable name="tmp" select="local:remove-scientific-notation(string(number($l_gf) - number($l_ff)))"/>
		    <xsl:if test="starts-with($tmp, '-')">
		      <xsl:value-of select="substring($tmp, 1, 11)"/>
		    </xsl:if>
		    <xsl:if test="not(starts-with($tmp, '-'))">
		      <xsl:value-of select="substring($tmp, 1, 10)"/>
		    </xsl:if>
		  </xsl:attribute>


		  <xsl:copy-of select="normalize-space(./lg/l)"/>		  
		</l>
		<xsl:copy-of select="./lg/*[not(local-name() = 'l')]"/>
	      </lg>

	      <xsl:for-each select="./mg">
		<mg>
		  <xsl:copy-of select="./@*"/>
		  <xsl:for-each select="./tg">
		    <tg>
		      <xsl:copy-of select="./@*"/>
		      <xsl:copy-of select="./re"/>
		      <xsl:for-each select="./*[starts-with(local-name(), 't')]">
			<xsl:copy-of copy-namespaces="no" select=".[not(local-name() = 't')]"/>
			<xsl:if test="local-name() = 't'">
			  <t>
			    
			    <xsl:variable name="t_current_lemma" select="normalize-space(.)"/>
			    <xsl:variable name="t_current_pos"  select="normalize-space(./@pos)"/>
			    
			    <xsl:variable name="t_g_freq">
			      <xsl:copy-of select="$t_ggg_ff/r/lemma[normalize-space(substring-before(@value, ' :')) = $t_current_lemma]
						   [starts-with(substring-after(@value, ' :'), $t_current_pos)][1]"/>
			    </xsl:variable>
			    
			    <xsl:variable name="t_f_freq">
			      <xsl:copy-of select="$t_fad_ff/r/lemma[normalize-space(substring-before(@value, ' :')) = $t_current_lemma]
						   [starts-with(substring-after(@value, ' :'), $t_current_pos)][1]"/>
			    </xsl:variable>
			    
			    
			    <xsl:variable name="t_gf">
			      <xsl:if test="not($t_g_freq/lemma/@rel_f)">
				<xsl:value-of select="'0'"/>
			      </xsl:if>
			      <xsl:if test="$t_g_freq/lemma/@rel_f">
				<xsl:value-of select="$t_g_freq/lemma/@rel_f"/>
			      </xsl:if>
			    </xsl:variable>
			    
			    <xsl:variable name="t_ff">
			      <xsl:if test="not($t_f_freq/lemma/@rel_f)">
				<xsl:value-of select="'0'"/>
			      </xsl:if>
			      <xsl:if test="$t_f_freq/lemma/@rel_f">
				<xsl:value-of select="$t_f_freq/lemma/@rel_f"/>
			      </xsl:if>
			    </xsl:variable>
			    
			    <xsl:copy-of select="./@*"/>
			    <xsl:attribute name="gf" select="$t_gf"/>
			    <xsl:attribute name="ff" select="$t_ff"/>
			    
			    <!--xsl:attribute name="gf-ff" select="substring(string($t_gf - $t_ff), 1, 10)"/-->
			    
			    <!--xsl:attribute name="gf-ff" select="substring(local:remove-scientific-notation(string(number($t_gf) - number($t_ff))), 1, 10)"/-->

			    <xsl:attribute name="gf-ff">
			      <xsl:variable name="tmp" select="local:remove-scientific-notation(string(number($t_gf) - number($t_ff)))"/>
			      <xsl:if test="starts-with($tmp, '-')">
				<xsl:value-of select="substring($tmp, 1, 11)"/>
			      </xsl:if>
			      <xsl:if test="not(starts-with($tmp, '-'))">
				<xsl:value-of select="substring($tmp, 1, 10)"/>
			      </xsl:if>
			    </xsl:attribute>
			    


			    <xsl:value-of select="."/>

			    <xsl:if test="$debug">
			      <test>
				<xsl:copy-of select="$t_g_freq"/>
				<xsl:copy-of select="$t_f_freq"/>
			      </test>
			    </xsl:if>

			  </t>
			</xsl:if>
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
    </xsl:for-each>
  </xsl:template>
  
  </xsl:stylesheet>
