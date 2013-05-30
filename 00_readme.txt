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

global check of doublings after the many corrections done by Trond:

   2          <l pos="V">være</l>
   2          <l pos="CS">som</l>
   2          <l pos="CS">for at han eller hun ikke</l>
   2          <l pos="Adv">og (heller) ikke</l>
   2          <l pos="Adv">ikke</l>
   2          <l pos="A">østligere</l>
   2          <l pos="A">vestligere</l>
   2          <l pos="A">sørligere</l>
   2          <l pos="A">nordligere</l>
   2          <l pos="A">midterste</l>
   2          <l pos="A">dypere</l>

 ==> please take care of them!




