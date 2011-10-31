Starting updating the nobsme for the web.

Issues:

Det vi bør gjere for nobsme ser ut til å vere:

- snu usage-VD på nytt
 ==> TODO
- snu resten av orda i smenob, men __separat__.
 ==> TODO
- deretter eventuelt legge til frå not-vd-nobsme til gjeldande nobsme manuelt
 ==> TODO
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

