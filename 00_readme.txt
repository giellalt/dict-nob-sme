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

Nota bene:
grep '<e ' * | wc -l
   10442
src>!678
grep '<e>' * | wc -l
   11243
Dette betyr at det finns mer non-vd entrier som vd!
 
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




