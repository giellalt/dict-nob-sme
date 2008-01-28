#!/usr/bin/perl -w
#
# kvasikode
#
# smenob dtd
# <!ELEMENT r (e+) >
# <!ELEMENT e (lg,mg+)>
# <!ELEMENT lg (l,lc*)>
# <!ELEMENT l (#PCDATA)>
# <!ATTLIST l 
#       pos ( a | n | v | adv | po | pr | pron | i | pcle | num | cc | cs | npl | x ) #REQUIRED
# >      
# 
# <!ELEMENT lc (#PCDATA)>
# 
# <!ELEMENT mg (tg+)>
# <!ELEMENT tg (t+,xg*)>
# 
# <!ELEMENT t (#PCDATA)>
# <!ATTLIST t 
#       pos ( a | a5 | S | m | f | n | v | adv | p | pron | i | cc | cs | im | mpl | fpl | npl | x ) #REQUIRED
# >      >
# <!ELEMENT xg ((x,xt?)+)>
# <!ELEMENT x (#PCDATA)>
# <!ELEMENT xt (#PCDATA)>

# Quasicode

# For each <e>, for each <t> 
##  make the translation into lemma, 
##  make the lemma into translation,
##  keep the POS information on each of them
##  keep the example group, but switch <x> and <xt>

# A bit more specific

# For each element <e>, do the following
# For each node <t>, 
# Write <e>\n<lg>\n<l POS="
# Insert POS attr of source <t>
# Write ">
# Insert content of source <t>
# Write </l>\n</lg>\n<mg>\n<tg>\n<t POS="
# Insert POS attr of source <l>
# Write ">
# Insert content of source <l>
# Write </t>\n
# If there is <xg>
# Write <xg>\n\<x>
# Insert content of source <xt>
# Write </x>\n<xt>
# Insert content of source <x>
# Write </xt>\n</xg>n</mg>\n<\e>\n
# If there is no <xg>
# Write # </tg>\n</mg>\n<\e>\n

########################################################

