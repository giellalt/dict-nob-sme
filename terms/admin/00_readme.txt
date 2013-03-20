


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
1. Ordne opp i nob-lemma: Bøygde former for grunnformer (58?)
2. Liste over nob-lemma som skal leksikaliseres (3239?)
3. Sjekke lemma-varianter (c="1", c="2") i nob-c_sme-c-fila, slette uriktig variant og beholde riktig variant. (61)
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
            <t_gt gt_pos="" c="2" cisl="0">| mánná+suodjalit+ásahus</t_gt>
         </tg>
      </mg>
   </e>


OVERSIKT OVER done-filene 19.mars:

__done_fad_nobsme.20121130_nob-c_sme-c.xml__

Hvor mange entry er det i fila?
src$ cat done_fad_nobsme.20121130_nob-c_sme-c.xml | grep '<e>' | wc -l
    7814

POS ikke ok:
nob-del inneholder N og A
sme-del inneholder både N og A, men har t-element enn nob har l-element:
src$ grep '<l ' done_fad_nobsme.20121130_nob-c_sme-c.xml | egrep -o '<l pos=...'| sort | uniq -c
   1 <l pos="A"
7811 <l pos="N"
src$ grep '<t ' done_fad_nobsme.20121130_nob-c_sme-c.xml | egrep -o '<t pos=...'| sort | uniq -c
   1 <t pos="A"
7960 <t pos="N"

Det finnes 137 tilfeller av minimum 2 ulike sme-varianter i t-elementet:
src$ grep '<t' done_fad_nobsme.20121130_nob-c_sme-c.xml | grep 'c="1"' | wc -l
     137

usmeNorm ikke OK
273 ord blir ikke analysert
4460 ord er ikke leksikalisert
src$ cat done_fad_nobsme.20121130_nob-c_sme-c.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > smelistcc
src$ cat smelistcc | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
     123
src$ cat smelistcc | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > smelemmacc
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 smelistcc smelemmacc | wc -l
    4460



__done_fad_nobsme.20121130_nob-s_sme-c.xml__

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


usmeNorm ikke OK
1 ord blir ikke analysert
857 ord er ikke leksikalisert
src$ cat done_fad_nobsme.20121130_nob-s_sme-c.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > smelistsc
src$ cat smelistsc | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       1
src$ cat smelistsc | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > smelemmasc
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 smelistsc smelemmasc | wc -l
     857


__done_fad_nobsme.20121130_nob-s_sme-s.xml__

Hvor mange entry er det i fila?
src$ cat done_fad_nobsme.20121130_nob-s_sme-s.xml | grep '<e>' | wc -l
    5049

POS ikke ok:
nob-filen inneholder flere N enn sme-fila
sme-fila inneholder flere A og V enn nob-fila:
src$ grep '<l ' done_fad_nobsme.20121130_nob-s_sme-s.xml | egrep -o '<l pos=...'| sort | uniq -c
 628 <l pos="A"
3032 <l pos="N"
1389 <l pos="V"
src$ grep '<t ' done_fad_nobsme.20121130_nob-s_sme-s.xml | egrep -o '<t pos=...'| sort | uniq -c
 680 <t pos="A"
   1 <t pos="Ad
2548 <t pos="N"
1820 <t pos="V"


usmeNorm ikke OK
1 ord blir ikke analysert
16 ord er ikke leksikalisert
src$ cat done_fad_nobsme.20121130_nob-s_sme-s.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > smelistss
src$ cat smelistss | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       1
src$ cat smelistss | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > smelemmass
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 smelistss smelemmass | wc -l
      16




__done_l-1_t-0.xml__LEKSIKALISERING GJENSTÅR.

Hvor mange entry er det i fila?
src$ cat done_l-1_t-0.xml | grep '<e>' | wc -l
     325

POS OK:
sme har 3 <t pos flere enn nob, grunnen er at det er flere t-element under et lemma, se nedenfor
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
195 ord er ikke leksikalisert
Har laget en fil med oversikt over lemmaer som skal leksikaliseres: leksikaliseret_done_l-1_t-0
src$ cat done_l-1_t-0.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > smelist10
src$ cat smelist10 | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       1
src$ cat smelist10 | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > smelemma10
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 smelist10 smelemma10 | wc -l
     195
     
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
123 ord er ikke leksikalisert.
Har laget en fil med oversikt over lemmaer som skal leksikaliseres: leksikalisering_done_l-0_t-1
src$ cat done_l-0_t-1.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > smelist01
src>cat smelist01 | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       0
src$ cat smelist01 | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > smelemma01
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src>comm -23 smelist01 smelemma01 | wc -l
     123

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

