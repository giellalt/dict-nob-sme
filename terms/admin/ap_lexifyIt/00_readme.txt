Steps:

1. extract entries with at least one t-element contaning an apertium-analysis
   of a compound ('+')
_six filter_sme-comps.xsl inFile=inData/fad_nobsme.20121130_merged_simp.xml 

2. compile an aligned nob2sme corpus of:
 a. input data
 b. apertium analyses
 c. gt analyses
_six align_ap-gt_pl.xsl 

3. extract gt-analyses based on the apertium-analyses from the corpus:
_six check_sme-comps.xsl

4. extract entries with correctly lemmatized sme-componds


