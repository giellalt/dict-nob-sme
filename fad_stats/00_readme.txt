tmp dir for fad statistics:

all_freq2xml.xsl ==> script for transforming freq files into xml adding rel freq to each lemma
20130124_sme_lemma.freq.xml ==> output of the all_freq2xml-script on the filtered sme-data
short_nowac-1.1.lemmas.freq.xml ==> output of the all_freq2xml-script on the filtered nob-data

 - rel and abs freqs  and their difference for general and FAD data to
   - src_fad-only ==> DONE
   - src_gt-only ==> DONE
   - src_gt-fad_merged: e_A_nobsme.xml, e_N_nobsme.xml and e_V_nobsme.xml ==> DONE

   - src_gt-fad_merged: 21_*_nobsme.xml and rest_*_nobsme.xml
     ==> TODO (waiting for manual unification of mg-elements)    

Evaluation: What does each frequency patter mean?
nob: gf ==> (cleaned) nowac
     ff ==> (cleaned) FAD
sme: gf ==> (cleaned) main/words/lists/sme/20130124_sme_lemma.freq
     ff ==> (cleaned) FAD

For individual lemmata:
1. gf="0" ff="0"

2. gf="T" ff="0"

3. gf="0" ff="T" ==> sme: This is weird!

4. gf="T" ff="T"

For nob-sme pairs:


=====================
Still TODO:
in gt-fad_merged:

21_N_nobsme.xml ==>     630

src_gt-fad_merged>grep '<e' 21_A_nobsme.xml | wc -l 
     135
src_gt-fad_merged>grep '<e' 21_V_nobsme.xml | wc -l 
     179

src_gt-fad_merged>grep '<e' rest_* | cut -d ':' -f1 | sort | uniq -c | sort -nr
 433 rest_N_nobsme.xml
 201 rest_V_nobsme.xml
  77 rest_A_nobsme.xml
