Starting updating the nobsme for the web.

Issues:

Det vi bør gjere for nobsme ser ut til å vere:

- snu usage-VD på nytt
 ==> DONE
- snu resten av orda i smenob, men __separat__.
 ==> DONE
- check the files in reverted_new/src_vd with those in the src and
  unify whatever it is worth to unify (__Cip and/or Trond__)
 ==> DONE
- deretter eventuelt legge til frå not-vd-nobsme til gjeldande nobsme manuelt
 ==> DONE (på et annet måte: både vd- og non-vd-entrier ble snudd og lagt til;
                             vd-merkelappen kommer til å være på t-elementet;
                             for tiden er på e-elementet men cip skal endre det snart)
     - the script is now tested and ready for use: waiting for
	1. Marja to finish the cleanup in the p_, po_ and pr_-files 
	2. Trond to answer the <re>-related questions:
	    2.a Where to put re-info? 
            2.b This has been transferred from smenob:
	        Belongs re now to the l-value or to the t-value?
	    2.c Do we really need the re-info both in the mg-element and in the tg-element?

Last answer from Trond: 
Spörsmålet var:
Under <l> eller under <mg>

Svaret er framleis: Under <mg>.

__Men__ vi vil at dei ulike ordbökene skal vere mest mogleg lik. Som bm minnar oss på har vi faktisk dokumentasjon for dette, 
http://giellatekno.uit.no/doc/dicts/dictionarywork.html

Der går det fram at <re> ligg under <tg>.

No er tg = mg (dvs. kvar mg har ei dotter), så lingvistisk sett er desse to konvensjonane identisk.

Men prosesseringsmessig vil vi ikkje ha variasjon. Ergo følgjer vi dokumentasjonen, og har <re> under <tg>.



Observation on <re> issue:
 In such an entry as
   <e usage="vd">
      <lg>
         <l pos="x">strekke seg etter noe</l>
      </lg>
      <mg>
         <tg xml:lang="sme">
            <re>en gang</re>
            <t pos="v">faŋádit</t>
         </tg>
      </mg>
   </e>
 the <re> is not of much use if you don't put also 
 the non-restricted/complementarily restricted entry (in this specific case
 "flere ganger", "to ganger", etc.)

Nota bene:
grep '<e ' * | wc -l
   10442
src>!678
grep '<e>' * | wc -l
   11243
Dette betyr at det finns mer non-vd entrier enn vd!
 
- deretter arbeide med nobsme frå eit norsk perspektiv. Tidsplan for det kjem vi attende til
 ==> TODO

Some observations by browsing through the files

1. Example: Is it alway appropriate to take the example from
   the smenob and just turn it around?

   <e>
      <lg>
         <l pos="a" decl="2">kjedelig</l>
      </lg>
      <mg xml:lang="sme">
         <tg>
            <t context="dilli" pos="a">ahkit</t>
            <xg>
               <x>Jeg kjeder meg.</x>
               <xt>Mus lea ahkit.</xt>
            </xg>
         </tg>
      </mg>
   </e>
   <e>
      <lg>
         <l pos="a" decl="2">utrivelig</l>
      </lg>
      <mg xml:lang="sme">
         <tg>
            <t context="dilli" pos="a">ahkit</t>
            <xg>
               <x>Jeg kjeder meg.</x>
               <xt>Mus lea ahkit.</xt>
            </xg>
         </tg>
      </mg>
   </e>

2. Example: <l>spredt</l> vs. <x>spredt</x> exactly the same string (not to comment on
the content of xt) : from a user perspective, weird.
   <e>
      <lg>
         <l pos="a" decl="2">spredt</l>
      </lg>
      <mg xml:lang="sme">
         <tg>
            <t context="viesut" pos="a">bieđggus</t>
            <xg>
               <x>spredt</x>
               <xt>biđgosis, biđgosii</xt>
            </xg>
         </tg>
      </mg>
   </e>

3. phrase_nobsme.xml should be checked properly!

=======

Testing before merging the new_entries2add and src:
in both dirs, there a lots of doubled entries.

What are the reasons for this state?
1. sme entries with different e-flags: vd vs. non-vd

 ==> question to Trond (and Marja): Have you done something about those entries?
                                    Do you want to do something about that?

Some TODO-issue based on the last check:
 - unify the p_nobsme and po_nobsme file with the current pr_nobsme file (__Marja__)
 - transfer the '<re>'-elements into the re-elements (__Ciprian__)
 ==> DONE
 - transfer the vd-flags from the e-element to the t-element; these flags belong to the sme-word (entry)
 ==> DONE

Cip's next todo issues:
 - check new_entries2add file for formal/contentwise usefulness
 ==> DONE
 - merge entries into the src files 
 ==> DONE

NB: The tag 'merged' has been replaced by the tag 'mg_c'!


=====

Missing:

cat $GTBIG/st/nob/nowac/nowac-1-1.1.lemmas.freq | sed 's/^ *//g;' \
    | cut -d" " -f2 | cut -f1 | grep -v '[A-ZÆØÅ0-9$.,:;/_-]' | grep '[a-z]' \
    | lookup $GTHOME/words/dicts/nobsme/bin/nobdict.fst | grep '?' | cut -f1 \
    > $GTHOME/words/dicts/nobsme/inc/nylangliste

=======

Checking source data after the manual unification:

src>grep '/>' * | wc -l 
     204
src>grep '><' * | wc -l 
      48

N_nobsme.xml:         <l pos="N"></l>
N_nobsme.xml:            <re></re>
N_nobsme.xml:            <re></re>
N_nobsme.xml:            <re></re>



N_nobsme.xml:               <x/>
N_nobsme.xml:               <xt/>
N_nobsme.xml:         <tg xml:lang="sme"/>
N_nobsme.xml:               <x/>
N_nobsme.xml:               <xt/>

Observation:
the mg_c attributes on the e-element are still there, I tought
Marja wanted to delete them in order to mark the entries that
have been done.

================

global check of patterns:

1. doubled entry or not?
         <l pos="V">være uheldig</l>
         <l pos="V">være uheldig å</l>


4. what to do with such pair?
         <l pos="V">vri</l>
         <l pos="V">vri seg</l>

=> Different transitivity.

5. and with that?
         <l pos="V">vokse</l>
         <l pos="V">vokse opp</l>

=> These must await a solution for particle verbs.


cip-TODO:
 - systematic check of any separator in the l-element such as ',', '/', etc.
  ==> DONE

   - ','
src>grep '<l ' *.xml | grep ','
N_nobsme.xml:         <l pos="N">trestokk til å henge, ta av og ordne kaffekjelen over ilden med</l>
N_nobsme.xml:         <l pos="N">frodig, ruvende person</l>
N_nobsme.xml:         <l pos="N">vilt dyr, også hund og katt</l>

   - '/'
src>grep 'i/av hva slags' *.xml
Pron_static_nobsme.xml:         <l pos="Pron">i/av hva slags</l>

   - '()'
grep -h '<l ' *_nobsme.xml | cut -d '>' -f2 | cut -d '<' -f1 | grep '('
og (heller) ikke
slik (har)
en sånn her (har)
en slik en (har)
slike (har)
.......

   - '.'
50.
60.
70.
f.eks.
St. Hans
avd.
på ... navn
nærmere mot ... siden

   - '?' (check also t-elements)
nobsme>grep '<t ' src/*xml | grep '?' 
src/Pr_nobsme.xml:            <t type="expl" freq="0">???</t>

   - '-'
berg-folk</l ==> why not just 'bergfolk'?
te-kjøkken</l ==> dito
dusj-krakk</l ==> dito

   - tv vs. TV
barne-tv</l
TV-program</l
tv-program</l

   - doublings or not?
liten jord- eller snøskavl som henger utover</l
jord- eller snøskavl som henger utover</l

=> both should be under "snøskavl" and "jordskavl", respectively


   - why not eighter all-letter strings or all-digit strings? 
tjue-tretti</l
14-19000</l
14-19</l
2-3000</l
tolv-tretten</l

=> Because it reflects actual usage.
   But arabic numbers should be excluded.

 
 

Simple check of doublings ignoring pos and other information:
src>grep -h '<l ' *_nobsme.xml | cut -d '>' -f2 | cut -d '<' -f1 | sort | uniq -c | sort -nr | grep -v '1' | wc -l 
     279
here the top N of them
   3 velkommen
   3 sånn her
   3 så
   3 rett
   3 nær
   3 hva slags
   3 før
   3 for
   3 ende
   3 det der borte
   3 de to
   3 de fleste
   3 bak
   2 øverst
   2 ønske
   2 ære
   2 årlig
   2 ytre
   2 vår egen
   2 vår
   2 voksenopplæringslov
   2 vogge
   2 vis
   2 virkelig
   2 vifte
   2 vi to

... og hva er "i veien med dem"?

src>grep 'i veien' *.xml | grep '<l ' 
Adv_nobsme.xml:         <l pos="Adv">i veien</l>
phrase_nobsme.xml:         <l pos="phrase">i veien</l>

Oversikt over N, A og V i nobsme/src:

__N_nobsme.xml__
Hvor mange entry er det i fila?
src$ cat N_nobsme.xml | grep 'l pos' | wc -l
    8450

Hvor mange translations er det i fila?
src$ cat N_nobsme.xml | grep 't pos' | wc -l
   10065

POS:
NOB-lemma:
src$ grep '<l ' N_nobsme.xml | egrep -o '<l pos=...'| sort | uniq -c
   1 <l pos="De
8449 <l pos="N"
SME-translation:
src$ grep '<t ' N_nobsme.xml | egrep -o '<t pos=...'| sort | uniq -c
   7 <t pos="A"
   3 <t pos="Ad
10048 <t pos="N"
   3 <t pos="Po
   2 <t pos="Pr
   2 <t pos="ph


usmeNorm OK:
src$ cat N_nobsme.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > N_list
src$ cat N_list | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       0
src$ cat N_list | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > N_lemma
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 N_list N_lemma | wc -l
       0


__V_nobsme.xml__
Hvor mange entry er det i fila?
src$ cat V_nobsme.xml | grep 'l pos' | wc -l
    2362

Hvor mange translations er det i fila?
src$ cat V_nobsme.xml | grep 't pos' | wc -l
    3342

POS OK:
NOB-lemma:
src$ grep '<l ' V_nobsme.xml | egrep -o '<l pos=...'| sort | uniq -c
2362 <l pos="V"
SME-translation:
src$ grep '<t ' V_nobsme.xml | egrep -o '<t pos=...'| sort | uniq -c
3341 <t pos="V"
   1 <t pos="i"

usmeNorm OK:
src$ cat V_nobsme.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > V_list
src$ cat V_list | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       1
src$ cat V_list | usmeNorm | grep '?' | lesssávvat lihku    sávvat lihku    +?
src$ cat V_list | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > V_lemma
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 V_list V_lemma | wc -l
       0


__A_nobsme.xml__
Hvor mange entry er det i fila?
src$ cat A_nobsme.xml | grep 'l pos' | wc -l
    1030

Hvor mange translations er det i fila?
src$ cat A_nobsme.xml | grep 't pos' | wc -l
    1417

POS:
NOB-lemma:
src$ grep '<l ' A_nobsme.xml | egrep -o '<l pos=...'| sort | uniq -c
src$ grep '<l ' A_nobsme.xml | egrep -o '<l pos=...'| sort | uniq -c
1030 <l pos="A"
SME-translation:
src$ grep '<t ' A_nobsme.xml | egrep -o '<t pos=...'| sort | uniq -c
1372 <t pos="A"
  17 <t pos="Ad
  11 <t pos="N"
  14 <t pos="Po
   2 <t pos="Pr
   1 <t pos="ph
   
usmeNorm OK:
src$ cat A_nobsme.xml | grep '<t pos' | tr '>' '<' | cut -d '<' -f3 | sort -u > A_list
src$ cat A_list | usmeNorm | grep '?' | wc -l
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
       0
src$ cat A_list | usmeNorm | cut -f2 | cut -d '+' -f1 | sort -u > A_lemma
0%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>100%
src$ comm -23 A_list A_lemma | wc -l
      25
src$ comm -23 A_list A_lemma | rev|sort|rev|l
Lista inneholder 18 dynamisk sammensatte ordenstall, 6 ord som brukes som førsteledd i sammensetninger + namuhan veara. Alle disse får analyse i Neahttadigisánit.

goansta-
oarje-
gávpe-
sálte-
boasttu-
bođu-
namuhan veara
golbmaloginubbi
guokteloginubbi
guoktelogičihččet
guoktelogiovccát
guoktelogigávccát
golbmalogát
vihttalogát
guhttalogát
čiežalogát
njealljelogát
ovccilogát
gávccilogát
guokteloginjealját
guoktelogigoalmmát
guoktelogiviđát
guoktelogiguđát
golbmalogivuosttaš
guoktelogivuosttaš


Deadlines missing:

1. Når er filene i nobsme/src ferdig til unifikasjon med FAD-dataen?
   ==> nob-lemmaen TODO: (spørsmål til Trond)
   
   ==> sme-lemmaen DONE (10.6.13 er filene ferdig til unifisering)

2. Når er filene i nobsme/terms/admin/src_interim ferdig til unifikasjon med nobsme/src-dataen?
   ==> unifikasjon av sme-mgs TODO: (spørsmål til Berit Merete)


cip-TODO:
 - extract proper nouns from the FAD-data
 - unify other-mwe with the specific mwe-data


