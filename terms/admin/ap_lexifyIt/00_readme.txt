Steps:

1. extract entries with at least one t-element contaning an apertium-analysis
   of a compound ('+')
_six filter_sme-comps_todo.xsl inFile=inData/fad_nobsme.20121130_merged_simp.xml 

2. compile an aligned nob2sme corpus of:
 a. input data
 b. apertium analyses
 c. gt analyses
_six align_ap-gt_pl.xsl 

3. extract gt-analyses based on the apertium-analyses from the corpus:
_six check_sme-comps.xsl

4. extract entries with correctly lemmatized sme-componds
_six filter_sme-comps_done.xsl

nob-c_sme-c issue:

ap_lexifyIt>grep '<e' 00_coxx/fad_nobsme.20121130_nob-c_sme-c.xml | wc -l 
    8358
ap_lexifyIt>grep '<mg' 00_coxx/fad_nobsme.20121130_nob-c_sme-c.xml | wc -l 
    8358
ap_lexifyIt>grep '<tg' 00_coxx/fad_nobsme.20121130_nob-c_sme-c.xml | wc -l 
    8358
ap_lexifyIt>grep '<t ' 00_coxx/fad_nobsme.20121130_nob-c_sme-c.xml | wc -l 
    8358

