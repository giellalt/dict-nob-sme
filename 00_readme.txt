Starting updating the nobsme for the web.

Issues:

Det vi bør gjere for nobsme ser ut til å vere:

- snu usage-VD på nytt
 ==> DONE (for the very last time)

- implement routines to sync sme2nob with nob2sme
 ==> TODO

Notes on <re>:

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


 - unify other-mwe with the specific mwe-data
      ==> TODO (this is not relevant for Enare presentation)

 - manual unification/checking of the data in src_gt-fad_merged
    ==> DONE (berit merete/marja)

 - delete frequencies from 
   - src_gt-only  ==> DONE (cip)
   - src_gt-fad_merged ==> DONE (cip)
   - src_fad-only ==> TODO (cip)


Notes on mg (valable also for smj, sms, etc):
1. compounds, special meaning ==> structure?

   <e>
      <lg>
         <l pos="A">gulbrun</l>
      </lg>
      <mg>
         <tg xml:lang="sme">
            <t pos="A" usage="vd">ruškat</t>
            <t pos="A" usage="vd">fiskesruškat</t>
         </tg>
      </mg>
   </e>
   <e>
      <lg>
         <l pos="A">rødbrun</l>
      </lg>
      <mg>
         <tg xml:lang="sme">
            <t pos="A" usage="vd">ruksesruškat</t>
         </tg>
      </mg>
   </e>

============

compare and in needed merge fad_only with gt_only after Lenes lemma adding action

Ex. uskikkelig was only in fad_only data

src_gt-only>g uskikkelig *
A_nobsme.xml:         <l pos="A">uskikkelig</l>


