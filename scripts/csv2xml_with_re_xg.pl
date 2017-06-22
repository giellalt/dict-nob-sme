#!/usr/bin/perl -w
use utf8 ;

# Simple script to convert csv to xml
# Input is expected to be of the format 
# lemma_POS_re_translation_example sentence_translation of example sentence
# The script does not have any if-so parts, so make sure
# your input has only one translation at each line

# Command:
# cat inputfile | perl csv2xml_with_re_xg.pl > output


print STDOUT "<r>\n";

while (<>) 
{
	chomp ;
	my ($lemma, $POS, $res, $trans, $ex, $tex) = split /_/ ;
	print STDOUT "   <e>\n";
	print STDOUT "      <lg>\n";
	print STDOUT "         <l pos=\"$POS\">$lemma</l>\n";
	print STDOUT "      </lg>\n";
	print STDOUT "      <mg>\n";
	print STDOUT "         <tg xml:lang=\"sme\">\n";
	print STDOUT "            <re>$res</re>\n";
	print STDOUT "            <t pos=\"$POS\">$trans</t>\n";
	print STDOUT "            <xg>\n";
	print STDOUT "               <x>$ex</x>\n";
	print STDOUT "               <xt>$tex</xt>\n";
	print STDOUT "            </xg>\n";
	print STDOUT "         </tg>\n";
	print STDOUT "      </mg>\n";
	print STDOUT "   </e>\n";
}

print STDOUT "</r>\n";




# Example input:
#opptatt_(ikke ledig)_várrejuvvon_Rommet er opptatt._Latnja lea várrejuvvon.

# Output
# <r>
#   <e>
#      <lg>
#         <l pos="A">opptatt</l>
#      </lg>
#      <mg>
#         <tg>
#            <re>(ikke ledig)</re>   <====== you can remove ( ) afterwards
#            <t pos="A">várrejuvvon</t>
#            <xg>
#               <x>Rommet er opptatt.</x>
#               <xt>Latnja lea várrejuvvon.</xt>
#            </xg>
#         </tg>
#      </mg>
#   </e>
# </r>


