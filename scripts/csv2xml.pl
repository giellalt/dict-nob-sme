#!/usr/bin/perl -w
use utf8 ;

# Simple script to convert csv to xml
# Input is expected to be of the format 
# lemma<tab>POS<tab>translation or
# lemma<tab>POS<tab>translation<tab>translation etc.
# The script does not have any if-so parts, so make sure
# your input has an equal number of translations (e.g. always 1)
# To get 2 or 3: use the lines with 2 and 3 instead.

# Command:
# cat inputfile | perl csv2xml.pl > output


print STDOUT "<r>\n";

while (<>) 
{
	chomp ;
	my ($lemma, $POS, $trans) = split /\t/ ;
#	my ($lemma, $POS, $trans, $trans2) = split /\t/ ;
#	my ($lemma, $POS, $trans, $trans2, $trans3) = split /\t/ ;
	print STDOUT "   <e>\n";
	print STDOUT "      <lg>\n";
	print STDOUT "         <l pos=\"$POS\">$lemma</l>\n";
	print STDOUT "      </lg>\n";
	print STDOUT "      <mg>\n";
	print STDOUT "         <tg>\n";
	print STDOUT "            <t pos=\"$POS\">$trans</t>\n";
#	print STDOUT "            <t pos=\"$POS\">$trans2</t>\n";
#	print STDOUT "            <t pos=\"$POS\">$trans3</t>\n";
	print STDOUT "         </tg>\n";
	print STDOUT "      </mg>\n";
	print STDOUT "   </e>\n";
}

print STDOUT "</r>\n";




# Example input:
# null	N	nolla

# Output
# <r>
#    <e>
#       <lg>
#          <l pos="N">null</l>
#       </lg>
#       <mg>
#          <tg>
#             <t pos="N">nolla</t>
#          </tg>
#       </mg>
#    </e>
# </r>


