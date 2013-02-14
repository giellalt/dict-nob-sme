Some question from cip to the linguists concerning the newly
acquired FAD-data with both nob and sme as simplicia:

1. are all forms (both nob and sme) ok, i.e., can we just add those lemmata
to a regular dict?
2. are the rest-attribut still necessary or can be deleted?


For linguistic answers, see below "Linguistic answers"


(1) both nob and sme are simple lemmma:
src/fad_nobsme.20121130_merged_simp.xml
 ==> done (modulo the questions above)

3 non-analysed forms among sme::
cat src/done_fad_nobsme.20121130_nob-s_sme-s.xml |grep '<t '|tr '<' '>' | cut -d">" -f3|usme|grep '?'|l

vuođđo  vuođđo  +?
Direktoratet_for_naturforvaltning       Direktoratet_for_naturforvaltning       +?
ovttaoaivil     ovttaoaivil     +?

(2) nob simple but at least one sme complex:
src/fad_nobsme.20121130_merged_only-sme-comp.xml
 ==> done
 
TT:
src/done_fad_nobsme.20121130_nob-s_sme-c.xml
 
Note that 61 of these are not known by our usmeNorm:
cat src/done_fad_nobsme.20121130_nob-s_sme-c.xml |grep 't_gt '|tr '<' '>' | cut -d">" -f3|usmeNorm|grep '?'|wc -l      61

src/todo_fad_nobsme.20121130_nob-s_sme-c.xml 
     TT: nob ok.
     But the sme side is not ok.

ap_lexifyIt/nobsme_sme-comps_lex.xml
 ==> todo

(3) both nob and sme are complex:
src/fad_nobsme.20121130_merged_comp.xml
 ==> todo         

TT: src/todo_fad_nobsme.20121130_nob-c_sme-c.xml
    has been gone through on the nob side, but sme is not done.

3. what about that?

   <e>   
      <lg>  
         <l pos="n">kvalitet+reform</l>
      </lg> 
      <mg>  
         <tg xml:lang="sme">
            <t pos="prop" rest="Prop/Obj/">Kvalitetsreformen</t>
         </tg> 
      </mg> 
   </e>  

4. check OBT because of <tn pos="1">Omgangskolene | Omgangskolene{subst} | Omgang+skole{n}{m}</tn>:
<in_nob tc="16">Omgangskolene viste seg lite effektive for å gi ungdommene det         minimum av kunnskaper som loven krevde</in_nob>

5. check ap bygg+efor+skrift

6. betaling+sikkerhet

7. plenum+sekretariat

8. check ap kapasitet+bygg+ende

9. boazodoallobláđđi{Txt}: question - What kind of pos is "Txt"? 

Lesson learned: don't merge entries that have to be lexified!

Caveat: Lexifying =/= finding a gt_lemma pendant!!!

nob-sme pairs that can not be filtered because at least one part didn't get a proper lemma:
src>grep '<e' todo_fad_nobsme.20121130_nob-s_sme-c.xml | wc -l
      57
src>grep '<e' todo_fad_nobsme.20121130_nob-c_sme-c.xml | wc -l
     546

In forvaltningsordbok/second_run:
 - gt-pipeline output have been cleaned up for modal verbs and the like
 - all nob-sme lemma pairs from ap-pipeline run that have been lexified
   have been removed also from the gt-data
 - the remaining lines have been distributed onto four files of
   aprox. same size (I cut the name to the followings):

second_run>wc -l gt-pl.20121213_0*
    8939 gt-pl.20121213_01_non-ap
    8940 gt-pl.20121213_02_non-ap
    8940 gt-pl.20121213_03_non-ap
    8938 gt-pl.20121213_04_non-ap
   35757 total


further observations:
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
   <e>
      <lg>
         <l pos="n">barnevern+institusjon</l>
         <l_gt gt_pos="subst" c="2">barneverninstitusjon</l_gt>
         <l_gt gt_pos="subst" c="1">barnevernsinstitusjon</l_gt>
      </lg>
      <mg>
         <tg xml:lang="sme">
            <t pos="n">mánná+suodjalus+ásahus</t>
            <t_gt gt_pos="Org" c="1" cisl="3">mánáidsuodjalusásahus</t_gt>
            <t_gt gt_pos="Org" c="2" cisl="0">dearvvasvuođaásahus</t_gt>
            <t_gt gt_pos="Org" c="3" cisl="0">sosiálaásahus</t_gt>
         </tg>
      </mg>
    </e>
 ==> what to do? (remember also filmarbeid/er)

   <e note="???">
      <lg>   
         <l pos="n">familie+drev</l>
         <l_gt_zzz gt_pos="adj" c="1">familiedrevet</l_gt_zzz>
      </lg>  
      <mg>   
         <tg xml:lang="sme">
            <t pos="n">bearaš+doaibma</t>
            <t_gt gt_pos="N">bearašdoaibma</t_gt>
         </tg>  
      </mg>  
   </e>   

   <e note="mistakingly marked">
      <lg>
         <l pos="n">fest+spill</l>
         <l_test l_gt_c="2"/>
         <l_gt_zzz gt_pos="subst" c="1">festspillprofil</l_gt_zzz>
         <l_gt_zzz gt_pos="subst" c="2">festspillene</l_gt_zzz>
      </lg>
      <mg>
         <tg xml:lang="sme">
            <t pos="n">feasta+speallu+profiila</t>
            <t_gt gt_pos="N">feastaspealloprofiila</t_gt>
         </tg>
      </mg>
   </e>



Linguistic answers
==================

done_fad_nobsme.20121130_nob-s_sme-c.xml 
 - nob is checked and ok
 - sme ==> TODO

done_fad_nobsme.20121130_nob-s_sme-s.xml 
 - nob is checked and ok
 - sme ==> TODO

done_fad_nobsme.20121130_nob-c_sme-c.xml 
 - nob is checked and ok
 - sme ==> TODO

done_l-0_t-0.xml
 - nob  ==> DONE
 - sme ==> DONE

done_l-0_t-1.xml
 - nob  ==> DONE
 - sme ==> DONE

done_l-1_t-0.xml
 - nob  ==> TODO
 - sme ==> TODO


