DONE: Starting updating the nobsme for the web.
DONE: 
DONE: Issues:
DONE: 
DONE: Det vi bør gjere for nobsme ser ut til å vere:
DONE: 
DONE: - snu usage-VD på nytt
DONE:  ==> DONE (for the very last time)
DONE: 
DONE: - implement routines to sync sme2nob with nob2sme
DONE:  ==> TODO
DONE: 
DONE: Notes on <re>:
DONE: 
DONE: 	2. Trond to answer the <re>-related questions:
DONE: 	    2.a Where to put re-info? 
DONE:             2.b This has been transferred from smenob:
DONE: 	        Belongs re now to the l-value or to the t-value?
DONE: 	    2.c Do we really need the re-info both in the mg-element and in the tg-element?
DONE: 
DONE: Last answer from Trond: 
DONE: Spörsmålet var:
DONE: Under <l> eller under <mg>
DONE: 
DONE: Svaret er framleis: Under <mg>.
DONE: 
DONE: __Men__ vi vil at dei ulike ordbökene skal vere mest mogleg lik. 
DONE: Som bm minnar oss på har vi faktisk dokumentasjon for dette, 
DONE: http://giellatekno.uit.no/doc/dicts/dictionarywork.html
DONE: 
DONE: Der går det fram at <re> ligg under <tg>.
DONE: 
DONE: No er tg = mg (dvs. kvar mg har ei dotter), så lingvistisk sett 
DONE: er desse to konvensjonane identisk.
DONE: 
DONE: Men prosesseringsmessig vil vi ikkje ha variasjon. 
DONE: Ergo følgjer vi dokumentasjonen, og har <re> under <tg>.
DONE: 
DONE: 
DONE: 
DONE: Observation on <re> issue:
DONE:  In such an entry as
DONE:    <e usage="vd">
DONE:       <lg>
DONE:          <l pos="x">strekke seg etter noe</l>
DONE:       </lg>
DONE:       <mg>
DONE:          <tg xml:lang="sme">
DONE:             <re>en gang</re>
DONE:             <t pos="v">faŋádit</t>
DONE:          </tg>
DONE:       </mg>
DONE:    </e>
DONE:  the <re> is not of much use if you don't put also 
DONE:  the non-restricted/complementarily restricted entry (in this specific case
DONE:  "flere ganger", "to ganger", etc.)
DONE: 
DONE: - deretter arbeide med nobsme frå eit norsk perspektiv. 
DONE:   Tidsplan for det kjem vi attende til
DONE:  ==> TODO
DONE: 
DONE: Some observations by browsing through the files
DONE: 
DONE: 1. Example: Is it alway appropriate to take the example from
DONE:    the smenob and just turn it around?
DONE: 
DONE:    <e>
DONE:       <lg>
DONE:          <l pos="a" decl="2">kjedelig</l>
DONE:       </lg>
DONE:       <mg xml:lang="sme">
DONE:          <tg>
DONE:             <t context="dilli" pos="a">ahkit</t>
DONE:             <xg>
DONE:                <x>Jeg kjeder meg.</x>
DONE:                <xt>Mus lea ahkit.</xt>
DONE:             </xg>
DONE:          </tg>
DONE:       </mg>
DONE:    </e>
DONE:    <e>
DONE:       <lg>
DONE:          <l pos="a" decl="2">utrivelig</l>
DONE:       </lg>
DONE:       <mg xml:lang="sme">
DONE:          <tg>
DONE:             <t context="dilli" pos="a">ahkit</t>
DONE:             <xg>
DONE:                <x>Jeg kjeder meg.</x>
DONE:                <xt>Mus lea ahkit.</xt>
DONE:             </xg>
DONE:          </tg>
DONE:       </mg>
DONE:    </e>
DONE: 
DONE: 2. Example: <l>spredt</l> vs. <x>spredt</x> exactly the same string (not to comment on
DONE: the content of xt) : from a user perspective, weird.
DONE:    <e>
DONE:       <lg>
DONE:          <l pos="a" decl="2">spredt</l>
DONE:       </lg>
DONE:       <mg xml:lang="sme">
DONE:          <tg>
DONE:             <t context="viesut" pos="a">bieđggus</t>
DONE:             <xg>
DONE:                <x>spredt</x>
DONE:                <xt>biđgosis, biđgosii</xt>
DONE:             </xg>
DONE:          </tg>
DONE:       </mg>
DONE:    </e>
DONE: 
DONE: 3. phrase_nobsme.xml should be checked properly!
DONE: 
DONE: =======
DONE: 
DONE: Testing before merging the new_entries2add and src:
DONE: in both dirs, there a lots of doubled entries.
DONE: 
DONE: What are the reasons for this state?
DONE: 1. sme entries with different e-flags: vd vs. non-vd
DONE: 
DONE:  ==> question to Trond (and Marja): Have you done something about those entries?
DONE:                                     Do you want to do something about that?
DONE: 
DONE: Some TODO-issue based on the last check:
DONE:  - unify the p_nobsme and po_nobsme file with the current pr_nobsme file (__Marja__)
DONE:  - transfer the '<re>'-elements into the re-elements (__Ciprian__)
DONE:  ==> DONE
DONE:  - transfer the vd-flags from the e-element to the t-element; these flags belong to the sme-word (entry)
DONE:  ==> DONE
DONE: 
DONE: Cip's next todo issues:
DONE:  - check new_entries2add file for formal/contentwise usefulness
DONE:  ==> DONE
DONE:  - merge entries into the src files 
DONE:  ==> DONE
DONE: 
DONE: NB: The tag 'merged' has been replaced by the tag 'mg_c'!
DONE: 
DONE: 
DONE: =====
DONE: 
DONE: Missing:
DONE: 
DONE: cat $GTBIG/st/nob/nowac/nowac-1-1.1.lemmas.freq | sed 's/^ *//g;' \
DONE:     | cut -d" " -f2 | cut -f1 | grep -v '[A-ZÆØÅ0-9$.,:;/_-]' | grep '[a-z]' \
DONE:     | lookup $GTHOME/words/dicts/nobsme/bin/nobdict.fst | grep '?' | cut -f1 \
DONE:     > $GTHOME/words/dicts/nobsme/inc/nylangliste
DONE: 
DONE: =======
DONE: 
DONE: Checking source data after the manual unification:
DONE: 
DONE: src>grep '/>' * | wc -l 
DONE:      204
DONE: src>grep '><' * | wc -l 
DONE:       48
DONE: 
DONE: N_nobsme.xml:         <l pos="N"></l>
DONE: N_nobsme.xml:            <re></re>
DONE: N_nobsme.xml:            <re></re>
DONE: N_nobsme.xml:            <re></re>
DONE: 
DONE: 
DONE: 
DONE: N_nobsme.xml:               <x/>
DONE: N_nobsme.xml:               <xt/>
DONE: N_nobsme.xml:         <tg xml:lang="sme"/>
DONE: N_nobsme.xml:               <x/>
DONE: N_nobsme.xml:               <xt/>
DONE: 
DONE: Observation:
DONE: the mg_c attributes on the e-element are still there, I tought
DONE: Marja wanted to delete them in order to mark the entries that
DONE: have been done.
DONE: 
DONE: ================
DONE: 
DONE: global check of patterns:
DONE: 
DONE: 1. doubled entry or not?
DONE:          <l pos="V">være uheldig</l>
DONE:          <l pos="V">være uheldig å</l>
DONE: 
DONE: 
DONE: 4. what to do with such pair?
DONE:          <l pos="V">vri</l>
DONE:          <l pos="V">vri seg</l>
DONE: 
DONE: => Different transitivity.
DONE: 
DONE: 5. and with that?
DONE:          <l pos="V">vokse</l>
DONE:          <l pos="V">vokse opp</l>
DONE: 
DONE: => These must await a solution for particle verbs.
DONE: 
DONE: 
DONE: cip-TODO:
DONE:  - systematic check of any separator in the l-element such as ',', '/', etc.
DONE:   ==> DONE
DONE: 
DONE:    - ','
DONE: src>grep '<l ' *.xml | grep ','
DONE: N_nobsme.xml:         <l pos="N">trestokk til å henge, ta av og ordne kaffekjelen over ilden med</l>
DONE: N_nobsme.xml:         <l pos="N">frodig, ruvende person</l>
DONE: N_nobsme.xml:         <l pos="N">vilt dyr, også hund og katt</l>
DONE: 
DONE:    - '/'
DONE: src>grep 'i/av hva slags' *.xml
DONE: Pron_static_nobsme.xml:         <l pos="Pron">i/av hva slags</l>
DONE: 
DONE:    - '()'
DONE: grep -h '<l ' *_nobsme.xml | cut -d '>' -f2 | cut -d '<' -f1 | grep '('
DONE: og (heller) ikke
DONE: slik (har)
DONE: en sånn her (har)
DONE: en slik en (har)
DONE: slike (har)
DONE: .......
DONE: 
DONE:    - '.'
DONE: 50.
DONE: 60.
DONE: 70.
DONE: f.eks.
DONE: St. Hans
DONE: avd.
DONE: på ... navn
DONE: nærmere mot ... siden
DONE: 
DONE:    - '?' (check also t-elements)
DONE: nobsme>grep '<t ' src/*xml | grep '?' 
DONE: src/Pr_nobsme.xml:            <t type="expl" freq="0">???</t>
DONE: 
DONE:    - '-'
DONE: berg-folk</l ==> why not just 'bergfolk'?
DONE: te-kjøkken</l ==> dito
DONE: dusj-krakk</l ==> dito
DONE: 
DONE:    - tv vs. TV
DONE: barne-tv</l
DONE: TV-program</l
DONE: tv-program</l
DONE: 
DONE:    - doublings or not?
DONE: liten jord- eller snøskavl som henger utover</l
DONE: jord- eller snøskavl som henger utover</l
DONE: 
DONE: => both should be under "snøskavl" and "jordskavl", respectively
DONE: 
DONE: 
DONE:    - why not eighter all-letter strings or all-digit strings? 
DONE: tjue-tretti</l
DONE: 14-19000</l
DONE: 14-19</l
DONE: 2-3000</l
DONE: tolv-tretten</l
DONE: 
DONE: => Because it reflects actual usage.
DONE:    But arabic numbers should be excluded.
DONE: 
DONE: 
DONE:  - unify other-mwe with the specific mwe-data
DONE:       ==> TODO (this is not relevant for Enare presentation)
DONE: 
DONE:  - manual unification/checking of the data in src_gt-fad_merged
DONE:     ==> DONE (berit merete/marja)
DONE: 
DONE:  - delete frequencies from 
DONE:    - src_gt-only  ==> DONE (cip)
DONE:    - src_gt-fad_merged ==> DONE (cip)
DONE:    - src_fad-only ==> TODO (cip)
DONE: 
DONE: 
DONE: Notes on mg (valable also for smj, sms, etc):
DONE: 1. compounds, special meaning ==> structure?
DONE: 
DONE:    <e>
DONE:       <lg>
DONE:          <l pos="A">gulbrun</l>
DONE:       </lg>
DONE:       <mg>
DONE:          <tg xml:lang="sme">
DONE:             <t pos="A" usage="vd">ruškat</t>
DONE:             <t pos="A" usage="vd">fiskesruškat</t>
DONE:          </tg>
DONE:       </mg>
DONE:    </e>
DONE:    <e>
DONE:       <lg>
DONE:          <l pos="A">rødbrun</l>
DONE:       </lg>
DONE:       <mg>
DONE:          <tg xml:lang="sme">
DONE:             <t pos="A" usage="vd">ruksesruškat</t>
DONE:          </tg>
DONE:       </mg>
DONE:    </e>
DONE: 
DONE: ============
DONE: 
DONE: compare and in needed merge fad_only with gt_only after Lenes lemma adding action
DONE: 
DONE: Ex. uskikkelig was only in fad_only data
DONE: 
DONE: src_gt-only>g uskikkelig *
DONE: A_nobsme.xml:         <l pos="A">uskikkelig</l>
DONE: 
DONE: =============
DONE: 
DONE: cleanup data b4 merging:
DONE:  - delete e interim tags from gt-fad-merged
DONE:    <e mg_all="2" mg_fad="1">
DONE: 
DONE:  - normalize re-info (scope?)
DONE: src_gt-fad_merged>g '<re' *|c
DONE:     1752
DONE: src_gt-fad_merged>g 're=' *|c
DONE:       71
DONE: src_gt-only>g '<re' *|c
DONE:      353
DONE: src_gt-only>g 're=' *|c
DONE:       82
DONE: src_fad-only>g '<re' *|c
DONE:      237
DONE: src_fad-only>g 're=' *|c
DONE:        0
DONE: src>g '<re' *|c
DONE:      258
DONE: src>g 're=' *|c
DONE:       45
DONE: 
DONE:  - finish merging (Berit Merete) => DONE
