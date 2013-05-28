
Fila oppdatert etter møte 18.3.2013:
TODO:
=====

sme:
1. Sjekk alle 285 sme som ikkje blir analysert av usmeNorm
2. Sjekke lemma-varianter (c="1", c="2") i nob-c_sme-c-fila, slette uriktig variant og beholde riktig variant. (151)
3. Sjekke at POS for sme og nob stemmer overens
4. Lage lister over sme-lemma som skal leksikaliseres
5. Sjå på heilheita

nob:
1. Ordne opp i nob-lemma: Bøygde former for grunnformer (58?) - done 
2. Liste over nob-lemma som skal leksikaliseres (3239?) - undervegs
3. Sjekke lemma-varianter (c="1", c="2") i nob-c_sme-c-fila, slette uriktig variant og beholde riktig variant. (61) - done
4. Sjå på heilheita



Notatar langs livets landeveg:
==============================
Lesson learned: don't merge entries that have to be lexified!

In forvaltningsordbok/second_run:
 - gt-pipeline output have been cleaned up for modal verbs and the like
 - all nob-sme lemma pairs from ap-pipeline run that have been lexified
   have been removed also from the gt-data
 - the remaining lines have been distributed onto four files of
   aprox. same size (I cut the name to the followings):


Illustrasjon, kommandoar:
=========================

non-analysed forms among sme:
cat src/done*.xml |grep '<t '|tr '<' '>' | cut -d">" -f3|usmeNorm|grep '?'|wc -l
     285


Sjekke at POS for sme og nob stemmer overens:
 - vær obs på forholdet mellom V i nob og V i sme
==============
src>grep '<t ' done_fad_nobsme.20121130_nob-s_sme-c.xml | cut -d '>' -f1 | sort | uniq -c 
   5             <t pos="A"
1829             <t pos="N"
   3             <t pos="N" type="NomAg"
   2             <t pos="UNKNOWN"
 132             <t pos="V"
src>grep '<l ' done_fad_nobsme.20121130_nob-s_sme-c.xml | cut -d '>' -f1 | sort | uniq -c 
   3          <l pos="A"
1933          <l pos="N"
  35          <l pos="V"
===============
Dette er en bedre kommando siden type kan være så mangt:
src$ grep '<t ' done_fad_nobsme.20121130_nob-s_sme-c.xml | egrep -o '<t pos=...'| sort | uniq -c
   3 <t pos="A"
1928 <t pos="N"
  30 <t pos="V"
src$ grep '<l ' done_fad_nobsme.20121130_nob-s_sme-c.xml | egrep -o '<l pos=...'| sort | uniq -c
   3 <l pos="A"
1928 <l pos="N"
  30 <l pos="V"

cat done_fad_nobsme.20121130_nob-s_sme-s.xml |sed 's/<e>/€/' |tr '\n' '£'|tr '€' '\n'|grep '"N".*"V"'|cut -d'>' -f8|cut -d"<" -f1|sed 's/$/+V+Der\/NomAct+N+Sg+Nom/'|dsmeNorm |cut -f2| sort -u| grep '+' |l

done_fad_nobsme.20121130_nob-c_sme-c.xml:
Etter opprydding i nob-c_sme-c:
 - pass på at det finnes lemma varianter i både nob og sme som skal
 sjekkes og bare én skal står igjen (Trond, hva gjorde du med
 nob-variantene når du sjekket nob?)

 - i nob (l-elementet) finnes 61 slike par
 - i sme (t-elementet) finnes 151 med 2, derav 13 med 3 og derav 3 med
    4 varianter

Bare det riktige skal bli igjen!

=======================
src>grep '<l' done_fad_nobsme.20121130_nob-c_sme-c.xml | grep 'c="1"' | wc -l
      61
src>grep '<l' done_fad_nobsme.20121130_nob-c_sme-c.xml | grep 'c="2"' | wc -l
      61
src>grep '<t' done_fad_nobsme.20121130_nob-c_sme-c.xml | grep 'c="1"' | wc -l
     151
src>grep '<t' done_fad_nobsme.20121130_nob-c_sme-c.xml | grep 'c="2"' | wc -l
     151
src>grep '<t' done_fad_nobsme.20121130_nob-c_sme-c.xml | grep 'c="3"' | wc -l
      13
src>grep '<t' done_fad_nobsme.20121130_nob-c_sme-c.xml | grep 'c="4"' | wc -l
       3
=======================

   <e>
      <lg>
         <l pos="n">barnevern+institusjon</l>
         <l_gt gt_pos="subst" c="1">barneverninstitusjon</l_gt>
         <l_gt gt_pos="subst" c="2">barnevernsinstitusjon</l_gt>
      </lg>
      <mg>
         <tg xml:lang="sme">
            <t pos="n">suodjalit+ásahus</t>
            <t_gt gt_pos="Org" c="1" cisl="0">mánáidsuodjalanásahus</t_gt>
            <t_gt gt_pos="" c="2" cisl="0">mánná+suodjalit+ásahus</t_gt>
         </tg>
      </mg>
   </e>


OVERSIKT OVER done-filene 9. april:

done-filene er virkelig DONE - 9 april 2013

5581 ord må leksikaliseres, baklengssortert liste over ordene finnes her:
$GTHOME/words/dicts/nobsme/terms/admin/src/ap_leksikalisering

Lista er laget på følgende måte:
plassering: $GTHOME/words/dicts/nobsme/terms/admin/src/
src$ cat done_* | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > smelist
src$ cat smelist | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > smelemma
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 smelist smelemma | wc -l
    5581
src$ comm -23 smelist smelemma > ap_done_leksikalisering
src$ cat ap_done_leksikalisering | rev| sort | rev > ap_leksikalisering




__done_fad_nobsme.20121130_nob-c_sme-c.xml__

Hvor mange entry er det i fila?
src$ cat done_fad_nobsme.20121130_nob-c_sme-c.xml | grep '<e>' | wc -l
    7813
    
    
POS OK:
src$ grep '<l ' done_fad_nobsme.20121130_nob-c_sme-c.xml | egrep -o '<l pos=...'| sort | uniq -c
   1 <l pos="A"
7812 <l pos="N"
src$ grep '<t ' done_fad_nobsme.20121130_nob-c_sme-c.xml | egrep -o '<t pos=...'| sort | uniq -c
   1 <t pos="A"
7812 <t pos="N"

Det finnes 0 tilfeller av minimum 2 ulike sme-varianter i t-elementet:
src$ grep '<t' done_fad_nobsme.20121130_nob-c_sme-c.xml | grep 'c="1"' | wc -l
      0
      
Jeg har lagt til en ny attributt, alternative_string, som betyr at i korpuset finnes også denne alternative varianten som ikke er normativ.

usmeNorm OK
4362 ord er ikke leksikalisert
src$ cat done_fad_nobsme.20121130_nob-c_sme-c.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > smelistcc
src$ cat smelistcc | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       0
src$ cat smelistcc | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > smelemmacc
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 smelistcc smelemmacc | wc -l
    4355 


__done_fad_nobsme.20121130_nob-s_sme-s.xml__

Hvor mange entry er det i fila?
src$ cat done_fad_nobsme.20121130_nob-s_sme-s.xml | grep '<e>' | wc -l
    4940

POS OK: sme-fila inneholder noen flere t-pos N-element siden der er flere tg som har to eller flere t-element.
src$ grep '<l ' done_fad_nobsme.20121130_nob-s_sme-s.xml | egrep -o '<l pos=...'| sort | uniq -c
 610 <l pos="A"
   1 <l pos="Ad
2915 <l pos="N"
1414 <l pos="V"
src$ grep '<t ' done_fad_nobsme.20121130_nob-s_sme-s.xml | egrep -o '<t pos=...'| sort | uniq -c
 610 <t pos="A"
   1 <t pos="Ad
2930 <t pos="N"
1414 <t pos="V"

usmeNorm OK
187 ord er ikke leksikalisert
src$ cat done_fad_nobsme.20121130_nob-s_sme-s.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > smelistss
src$ cat smelistss | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       0
src$ cat smelistss | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > smelemmass
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 smelistss smelemmass | wc -l
     187


__done_fad_nobsme.20121130_nob-s_sme-c.xml____LEKSIKALISERING GJENSTÅR.


Hvor mange entry er det i fila?
src$ cat done_fad_nobsme.20121130_nob-s_sme-c.xml | grep '<e>' | wc -l
    1961


POS OK:
src$ grep '<l ' done_fad_nobsme.20121130_nob-s_sme-c.xml | egrep -o '<l pos=...'| sort | uniq -c
   3 <l pos="A"
1928 <l pos="N"
  30 <l pos="V"
src$ grep '<t ' done_fad_nobsme.20121130_nob-s_sme-c.xml | egrep -o '<t pos=...'| sort | uniq -c
   3 <t pos="A"
1928 <t pos="N"
  30 <t pos="V"


usmeNorm OK, leksikalisering gjenstår.
801 ord er ikke leksikalisert. Har laget en fil med oversikt over lemmaer som skal leksikaliseres: leksikalisering_done_fad_nobsme.20121130_nob-s_sme-c.xml
src$ cat done_fad_nobsme.20121130_nob-s_sme-c.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > smelistsc
src$ cat smelistsc | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       0
src$ cat smelistsc | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > smelemmasc
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 smelistsc smelemmasc | wc -l
     801


__done_l-1_t-0.xml__LEKSIKALISERING GJENSTÅR.

Hvor mange entry er det i fila?
src$ cat done_l-1_t-0.xml | grep '<e>' | wc -l
     325

POS OK:
sme har 3 <t pos flere enn nob har lemma, grunnen er at det er flere t-element under et lemma, se nedenfor
src$ grep '<l ' done_l-1_t-0.xml | egrep -o '<l pos=...'| sort | uniq -c
 325 <l pos="N"
src$ grep '<t ' done_l-1_t-0.xml | egrep -o '<t pos=...'| sort | uniq -c
 328 <t pos="N"

         <tg xml:lang="sme">
            <t pos="N">terminologiijaráhkadeapmi</t>
            <t pos="N">terminologiijaovddideapmi</t>
         </tg>

         <tg xml:lang="sme">
            <t pos="N">bargomárkanovdáneapmi</t>
            <t pos="N">bargomárkanovddideapmi</t>
         </tg>

         <tg xml:lang="sme">
            <t pos="N" type="G3">roahcanášši</t>
            <t pos="N" type="G3">veahkaváldinášši</t>
         </tg>

usmeNorm OK, leksikalisering gjenstår.
1 ord blir ikke analysert, fordi ordet Finnmárkku báhppa er en mwe.
188 ord er ikke leksikalisert
Har laget en fil med oversikt over lemmaer som skal leksikaliseres: leksikalisering_done_l-0_t-1
src$ cat done_l-1_t-0.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > smelist10
src$ cat smelist10 | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       1
src$ cat smelist10 | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > smelemma10
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 smelist10 smelemma10 | wc -l
     188
     
***

__done_l-0_t-1.xml__ LEKSIKALISERING GJENSTÅR.

Hvor mange entry er det i fila?
src$ cat done_l-0_t-1.xml | grep '<e>' | wc -l
     173

POS OK:
Pos i nob og sme stemmer overens:
src$ grep '<l ' done_l-0_t-1.xml | egrep -o '<l pos=...'| sort | uniq -c
 173 <l pos="N"
src$ grep '<t ' done_l-0_t-1.xml | egrep -o '<t pos=...'| sort | uniq -c
 173 <t pos="N"

usmeNorm OK, leksikalisering gjenstår.
alle ordene blir analysert.
119 ord er ikke leksikalisert.
Har laget en fil med oversikt over lemmaer som skal leksikaliseres: leksikalisering_done_l-0_t-1
src$ cat done_l-0_t-1.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > smelist01
src>cat smelist01 | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       0
src$ cat smelist01 | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > smelemma01
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src>comm -23 smelist01 smelemma01 | wc -l
     119

__done_l-0_t-0.xml__ HELT OK

Hvor mange entry er det i fila?
src$ cat done_l-0_t-0.xml | grep '<e>' | wc -l
      14

POS OK:
Pos i nob og sme stemmer overens:
src$ grep '<l ' done_l-0_t-0.xml | egrep -o '<l pos=...'| sort | uniq -c
  14 <l pos="N"
src$ grep '<t ' done_l-0_t-0.xml | egrep -o '<t pos=...'| sort | uniq -c
  14 <t pos="N"


usmeNorm OK:
alle ordene blir analysert
alle ordene er leksikalisert
src$ cat done_l-0_t-0.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > smelist00
src$ cat smelist00 | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       0
src$ cat smelist00 | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > smelemma00
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 smelist00 smelemma00 | wc -l
       0

============================
pos synchronization check: grep for 'crash':

src>grep '<e' done_fad_nobsme.20121130_nob-s_sme-s.xml | sort | uniq -c | sort -nr 
4520    <e>
 422    <e crash="N_V">
  69    <e crash="N_A">
  17    <e crash="A_V">
  10    <e crash="V_A">
   9    <e crash="A_N">
   1    <e crash="A_Adv">

============================
gt-pipeline-filene:

__A_gt-pl.20121213_all_candidates.xml__

Hvor mange entry er det i fila?
src>grep '<e' A_gt-pl.20121213_all_candidates.xml | wc -l
     708

POS:
src$ grep '<l ' A_gt-pl.20121213_all_candidates.xml | egrep -o '<l pos=...'| sort | uniq -c
 708 <l pos="A"
 
src$ grep '<t ' A_gt-pl.20121213_all_candidates.xml | egrep -o '<t pos=...'| sort | uniq -c
 707 <t pos="A"
   1 <t pos="N"

usmeNorm:
alle ordene blir analysert
10 ord er ikke leksikalisert
src$ cat A_gt-pl.20121213_all_candidates.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > A_list
src$ cat A_list | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       0
src$ cat A_list | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > A_lemma
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 A_list A_lemma | wc -l
      10 

__A_gt-pl.20121213_all_qm_candidates.xml__

Hvor mange entry er det i fila?
src>grep '<e' A_gt-pl.20121213_all_qm_candidates.xml | wc -l 
      12

POS:
src$ grep '<l ' A_gt-pl.20121213_all_qm_candidates.xml | egrep -o '<l pos=...'| sort | uniq -c
  12 <l pos="A"
 
src$ grep '<t ' A_gt-pl.20121213_all_qm_candidates.xml | egrep -o '<t pos=...'| sort | uniq -c
  12 <t pos="A"

usmeNorm:
alle ordene blir analysert
2 ord er ikke leksikalisert
src$ cat A_gt-pl.20121213_all_qm_candidates.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > A_qm_list
src$ cat A_qm_list |usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       0
src$ cat A_qm_list |usmeNorm |cut -f2 | cut -d '+' -f1 | sort -u > A_qm_lemma
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 A_qm_list A_qm_lemma  | wc -l
       2


__N_gt-pl.20121213_all_candidates.xml__
Hvor mange entry er det i fila?
src$ grep '<e' N_gt-pl.20121213_all_candidates.xml | wc -l
    5826

src$ grep '<l ' N_gt-pl.20121213_all_candidates.xml | egrep -o '<l pos=...'| sort | uniq -c
5826 <l pos="N"
src$ grep '<t ' N_gt-pl.20121213_all_candidates.xml | egrep -o '<t pos=...'| sort | uniq -c
5826 <t pos="N"

usmeNorm:
3 ord blir ikke analysert
2861 ord er ikke leksikalisert
src$ cat N_gt-pl.20121213_all_candidates.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > N_list
src$ cat N_list | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       3
src$ cat N_list | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > N_lemma
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 N_list N_lemma | wc -l
    2861


__N_gt-pl.20121213_all_qm_candidates.xml__
Hvor mange entry er det i fila?
src$ grep '<e' N_gt-pl.20121213_all_qm_candidates.xml | wc -l 
     121

POS OK:
src$ grep '<l ' N_gt-pl.20121213_all_qm_candidates.xml | egrep -o '<l pos=...'| sort | uniq -c
   1 <l pos="A"
 120 <l pos="N"
src$ grep '<t ' N_gt-pl.20121213_all_qm_candidates.xml | egrep -o '<t pos=...'| sort | uniq -c
   1 <t pos="A"
 121 <t pos="N"

usmeNorm:
alle ordene blir analysert
46 ord er ikke leksikalisert
src$ cat N_gt-pl.20121213_all_qm_candidates.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > N_qm_list
src$ cat N_qm_list | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       0
src$ cat N_qm_list | usmeNorm |  cut -f2 | cut -d '+' -f1 | sort -u > N_qm_lemma
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 N_qm_list N_qm_lemma | wc -l
      46



__V_gt-pl.20121213_all_candidates.xml__
Hvor mange entry er det i fila?
src$ grep '<e' V_gt-pl.20121213_all_candidates.xml | wc -l
     412

POS OK:
src$ grep '<l ' V_gt-pl.20121213_all_candidates.xml | egrep -o '<l pos=...'| sort | uniq -c
 412 <l pos="V"
src$ grep '<t ' V_gt-pl.20121213_all_candidates.xml | egrep -o '<t pos=...'| sort | uniq -c
 412 <t pos="V"


usmeNorm OK:
src$ cat V_gt-pl.20121213_all_candidates.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > V_list
src$ cat V_list | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       0
src$ cat V_list | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > V_lemma
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 V_list V_lemma | wc -l
       0

__V_gt-pl.20121213_all_qm_candidates.xml__
Hvor mange entry er det i fila?
src$ grep '<e' V_gt-pl.20121213_all_qm_candidates.xml | wc -l 
      18

POS OK:
src$ grep '<l ' V_gt-pl.20121213_all_qm_candidates.xml | egrep -o '<l pos=...'| sort | uniq -c
  18 <l pos="V"
src$ grep '<t ' V_gt-pl.20121213_all_qm_candidates.xml | egrep -o '<t pos=...'| sort | uniq -c
  18 <t pos="V"
  
usmeNorm OK:
src$ cat V_gt-pl.20121213_all_qm_candidates.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > V_qm_list
src$ cat V_qm_list | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       0
src$ cat V_qm_list | usmeNorm |  cut -f2 | cut -d '+' -f1 | sort -u > V_qm_lemma
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 V_qm_list V_qm_lemma | wc -l
       0


The _qm_-flag in the file name means "questionmarked"!

============================

@cip: before deleting the doubled entries according to the file fad_usmeNorm_double_lemma
I checked both lexc files for internal doubled entries.
Following lines have been detected and for each pair the second line in each lexc-file
deleted:

1683:pasieantasihkarvuohta
1692:pasieantasihkarvuohta
1683:pasieanta#sihkarvuoh'ta LUONDU ;
1692:pasieanta#sihkarvuoh'ta LUONDU ;

3150:oahppogalledeapmi
3151:oahppogalledeapmi
3150:oahppo#galled EAPMI ;
3151:oahppo#galled EAPMI ;

1687:máksinsihkarvuohta
1693:máksinsihkarvuohta
1687:máksin#sihkarvuoh'ta LUONDU ;
1693:máksin#sihkarvuoh'ta LUONDU ;

429:guovttegielatvuođapedagogihkka
432:guovttegielatvuođapedagogihkka
429:guovttegielatvuođa#pedagogihkka GOAHTI-A ;
432:guovttegielatvuođa#pedagogihkka GOAHTI-A ;

3369:guovllusuodjaleapmi
3371:guovllusuodjaleapmi
3369:guovllu#suodjal EAPMI ;
3371:guovllu#suodjal EAPMI ;

6198:dokumeantahivvodat
6199:dokumeantahivvodat
6198:dokumeanta#hivvodah'k JOHTOLAT ;
6199:dokumeanta#hivvodah'k JOHTOLAT ;

3331:bušeahttalasiheapmi
3332:bušeahttalasiheapmi
3331:bušeahtta#lasih EAPMI ;
3332:bušeahtta#lasih EAPMI ;

4066:asttuáiggeulbmil
4067:asttuáiggeulbmil
4066:asttuáigge#ulbmil GAHPIRLONG ;
4067:asttuáigge#ulbmil GAHPIRLONG ;

src>sort 1.lexc | uniq -c | sort -nr | less
   1 šállošanágga
   1 šákšabivdu
   1 šákšabivddus

src>sort 2.lexc | uniq -c | sort -nr | less
   2 kultur#kalean'dar MALIS ;
   1 šállošan#ágga GOAHTI-A ;
   1 šákša#biv'dus MALISLONG ;

 
... but:

src>grep kulturkalean 1.lexc 
kulturkaleanddar
kulturkaleandar

 ==> ergo: no deletion of this apparently doubled continuation class!

==============

Tests before the unification step in the fad-data:

src>grep -h '<l pos' *.xml | sort | uniq -c | sort -nr | wc -l 
   15371
src>grep -h '<l pos' *.xml | sort | uniq -c | sort -nr | grep "^ *1 " | wc -l 
   11099
src>grep -h '<l pos' *.xml | sort | uniq -c | sort -nr | grep -v "^ *1 " | wc -l 
    4272

  15          <l pos="V">svekke</l>
  13          <l pos="V">redusere</l>
  12          <l pos="N">endring</l>
  11          <l pos="V">snakke</l>
  11          <l pos="V">registrere</l>
  11          <l pos="N">mangfold</l>
  10          <l pos="N">utgangspunkt</l>
  10          <l pos="N">utdanning</l>
  10          <l pos="N">part</l>
  10          <l pos="N">oversikt</l>
  10          <l pos="N">kulturuttrykk</l>
  10          <l pos="N">forvaltningsoppgave</l>
  10          <l pos="N">eiendomsrett</l>

Attributtlista er redusert til:
<l>
@pos
@alternative_string
@type
</l>

<t>
@pos
@alternative_string
@type
@nr
</t>

======================

fad-data unification results:
unify_all>grep '<e' united_entries_of_fad.xml | sort | uniq -c | sort -nr 
11532    <e>
2539    <e mg_c="2">
 785    <e mg_c="3">
 275    <e mg_c="4">
 116    <e mg_c="5">
  44    <e mg_c="6">
  29    <e mg_c="7">
  13    <e mg_c="8">
   8    <e mg_c="9">
   4    <e mg_c="10">
   1    <e mg_c="15">
   1    <e mg_c="13">
   1    <e mg_c="11">



