#!/usr/bin/perl -w
#
# kvasikode
#
# Felt:
# # fkvnob (denne berre for referanse)
# #"Lemma","POS","trans","tPOS","stamme1","stamme2","syntrans","syntransPOS","syntrans2","syntrans2POS","syntrans3","syntrans3POS","syneks","syneks2","syneks3"
# 
# # nobfkv
# #"Lemma;POS;trans;stamme1;stamme2;eks;syn1;syn2"
# 
# Les inn felta
# 
# Putt relevante felt inn i relevante stader i xml-strukturen
# 
#   <entry>
#     <lemma decl="POS">Lemma</lemma>
#     <mgr>
#       <trgr>
#         <trans decl="x">trans</trans>
#         <stem>stamme1</stem>
#         <stem>stamme2</stem>
#         <exgr>
#           <ex>eks</ex>
#           <extr></extr>
#         </exgr>
#       </trgr>
#     </mgr>
#     <syngr>
#       <syn>syn1</syn>
#       <syn>syn2</syn>
#     </syngr>
#  </entry>      

########################################################

use encoding 'utf-8';

# File and directory variables:
$SRCDIR = ".";

$CSVF = $SRCDIR . "/nobfkv.xml";
#$CSVF = $SRCDIR . "/test.csv";
$DICT = $SRCDIR . "/dictionary.xml";

open CSVF or die "Can't find file $CSVF: $!\n";
open DICT, ">$DICT" or die "Can't find file $DICT: $!\n";

print DICT "<dictionary >\n";

$line = <CSVF> ;

while ( $line = <CSVF> ) {
	chomp $line;
	($Lemma,
     $POS,
     $trans,
     $stamme1,
     $stamme2,
     $eks,
     $syn1)
	   = split /"?,"?/, $line ;
#    print "Lina er: $line\n";
#    print "Lemma er: $Lemma\n";
    $Lemma =~ s/"\W?(\w)/$1/; # rens $Lemma for " og ^L
    print DICT "\t<entry>\n";
    print DICT "\t  <lemma decl=\"$POS\">$Lemma</lemma>\n";
    print DICT "\t  <mgr>\n";
    print DICT "\t    <trgr>\n";
    print DICT "\t      <trans decl=\"$POS\">$trans</trans>\n";
    if ($stamme1 =~ /\w/) { print DICT "\t  <stem>$stamme1</stem>\n"; }
    if ($stamme2 =~ /\w/) { print DICT "\t  <stem>$stamme2</stem>\n"; }
    if ($eks =~ /\w/) { print DICT "\t        <exgr>\n          <ex>$eks</ex>\n          <extr></extr>\n        </exgr>\n";   }
    print DICT "\t    </trgr>\n";
    print DICT "\t  </mgr>\n";
    if ($syn1 =~ /\w/) { print DICT "\t      <syngr>\n          <syn>$syn1</syn>\n         </syngr>\n"; }
#    if ($syn2 =~ /\w/) { print DICT "\t        <syn>$syn2</syn>\n"; }
#    if ($syn1 =~ /\w/) { print DICT "\t      </syn>\n"; }
#    }
#    print DICT "\t    </trgr>\n";
    print DICT "\t</entry>\n";
}

print DICT "</dictionary>\n";
close DICT;
close CSVF;


# Note: Desse blir feil og skal fiksast:
# Dei blir merka som exgr, skal vers syneks
# "levoton paikka","louhikkonen",
# "tykköö","Hän oon minun tykkönä",
# "tykköö","Hän oon minun tykkönä",
# "himmee","Himmi sää oon umpu sää",
# "himmee","Himmi sää oon umpu sää",
# "tykönä","Hän oon minun tykköö",
# "tykönä","Hän oon minun tykköö",
# 
# "Nahka kun menee ",,
# "Tehe nyt sen valmhiiksi!",,
# "Tehe nyt sen valmhiiksi!",,
# "Ole vaiti!",,
# 
