tmp dir for fad statistics:

all_freq2xml.xsl ==> script for transforming freq files into xml adding rel freq to each lemma
20130124_sme_lemma.freq.xml ==> output of the all_freq2xml-script on the filtered sme-data
short_nowac-1.1.lemmas.freq.xml ==> output of the all_freq2xml-script on the filtered nob-data

 - rel and abs freqs for general nob/sme data ==> DONE
 - rel and abs freqs for FAD data ==> DONE
 - rel and abs freqs for domain within FAD (news, law, admin, etc.? - waiting
   for Trond's decision) ==> TODO


Evaluation: What does each frequency patter mean?
nob: gf ==> (cleaned) nowac
     ff ==> (cleaned) FAD
sme: gf ==> (cleaned) main/words/lists/sme/20130124_sme_lemma.freq
     ff ==> (cleaned) FAD

For individual lemmata:
1. gf="0" ff="0"

2. gf="T" ff="0"

3. gf="0" ff="T" ==> sme: This is weird!

FAD-data should have been a part of all GT_data!
Cheching GT_data (= cleaned main/words/lists/sme/20130124_sme_lemma.freq):
482 nuorta N
22 nuorta N

   <e>
      <lg>
         <l pos="A" gf="0.000006030102381861363" ff="0.00000274677608601804">østlig</l>
      </lg>
      <mg>
         <tg xml:lang="sme">
            <t pos="A" gf="0" ff="0.0000005457109">nuorta</t>
         </tg>
      </mg>
   </e>





4. gf="T" ff="T"

For nob-sme pairs:


=====================
Still TODO:
1. in fad-only:

src_fad-only>grep '<e' N_nobsme.xml | grep 'mg_c' | wc -l 
     175
src_fad-only>grep '<e' N_nobsme.xml | grep 'mg_c' | sort | uniq -c | sort -nr 
  78    <e src="fad" mg_c="2">
  41    <e src="fad" mg_c="3">
  21    <e src="fad" mg_c="4">
  19    <e src="fad" mg_c="5">
   6    <e src="fad" mg_c="7">
   4    <e src="fad" mg_c="8">
   4    <e src="fad" mg_c="6">
   1    <e src="fad" mg_c="9">
   1    <e src="fad" mg_c="10">

2012.08.22:
manual unification progress in src_fad-only ==> 175-175=0

2. in gt-fad_merged:

src_gt-fad_merged>grep '<e ' *xml | wc -l 
    1868
src_gt-fad_merged>grep '<e ' A_nobsme.xml | wc -l 
     212
src_gt-fad_merged>grep '<e ' V_nobsme.xml | wc -l 
     380
src_gt-fad_merged>grep '<e ' N_nobsme.xml | wc -l 
    1276

2012.08.22:
manual unification progress in src_gt-fad-merged ==> 1868-1868=0

