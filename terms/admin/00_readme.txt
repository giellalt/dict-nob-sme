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
6867          <l_test l_gt-counter="1"/>
 889          <l_test l_gt-counter="2"/>
 207          <l_test l_gt-counter="3"/>
 191          <l_test l_gt-counter="0"/>
  92          <l_test l_gt-counter="4"/>
  35          <l_test l_gt-counter="5"/>
  22          <l_test l_gt-counter="6"/>
  14          <l_test l_gt-counter="7"/>
   8          <l_test l_gt-counter="9"/>
   8          <l_test l_gt-counter="10"/>
   5          <l_test l_gt-counter="8"/>
   5          <l_test l_gt-counter="12"/>
   5          <l_test l_gt-counter="11"/>
   3          <l_test l_gt-counter="13"/>
   2          <l_test l_gt-counter="16"/>
   2          <l_test l_gt-counter="14"/>
   1          <l_test l_gt-counter="31"/>
   1          <l_test l_gt-counter="22"/>
   1          <l_test l_gt-counter="21"/>

