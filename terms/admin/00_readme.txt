Some question from cip to the linguists concerning the newly
acquired FAD-data with both nob and sme as simplicia:

1. are all forms (both nob and sme) ok, i.e., can we just add those lemmata
to a regular dict?
2. are the rest-attribut still necessary or can be deleted?

(1) both nob and sme are simple lemmma:
src/fad_nobsme.20121130_merged_simp.xml
 ==> done (modulo the questions above)

(2) nob simple but at least one sme complex:
src/fad_nobsme.20121130_merged_only-sme-comp.xml
 ==> done

ap_lexifyIt/nobsme_sme-comps_lex.xml
 ==> todo

(3) both nob and sme are complex:
src/fad_nobsme.20121130_merged_comp.xml
 ==> todo         

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

Postprocessing gt lemmata:
- nob
src>grep '<l_test' fad_nobsme.20121130_nob-c_sme-c.xml | wc -l 
     137
src>grep '<l_test' fad_nobsme.20121130_nob-c_sme-c.xml | sort | uniq -c | sort -nr 
  97          <l_test l_gt_c="2"/>
  23          <l_test l_gt_c="3"/>
   7          <l_test l_gt_c="5"/>
   5          <l_test l_gt_c="4"/>
   2          <l_test l_gt_c="7"/>
   1          <l_test l_gt_c="9"/>
   1          <l_test l_gt_c="6"/>
   1          <l_test l_gt_c="11"/>


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

 - sme
6691             <t_test t_gt-counter="1"/>
 978             <t_test t_gt-counter="2"/>
 348             <t_test t_gt-counter="0"/>
 224             <t_test t_gt-counter="3"/>
  64             <t_test t_gt-counter="4"/>
  20             <t_test t_gt-counter="5"/>
  13             <t_test t_gt-counter="6"/>
   7             <t_test t_gt-counter="7"/>
   4             <t_test t_gt-counter="10"/>
   2             <t_test t_gt-counter="9"/>
   2             <t_test t_gt-counter="11"/>
   1             <t_test t_gt-counter="8"/>
   1             <t_test t_gt-counter="35"/>
   1             <t_test t_gt-counter="30"/>
   1             <t_test t_gt-counter="14"/>
   1             <t_test t_gt-counter="12"/>


