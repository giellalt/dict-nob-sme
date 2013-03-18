


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


