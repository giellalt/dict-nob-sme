
# Dette skal bli ei makefil for å lage nobsme.fst, 
# ei fst-fil som tar nob og gjev ei sme-omsetjing.

# Førebels er det berre eit shellscript.
# Kommando for å lage nobsme.fst

# sh nobsme.sh

echo ""
echo "----------------------------------------------------"
echo "Shellscript to make a transducer of the dictionary."
echo ""
echo "It writes a lexc file to bin, containing the line	 "
echo "LEXICON Root										 "
echo "Thereafter, it picks lemma and first translation	 "
echo "of the dictionary, adds them to this lexc file,	 "
echo "and compiles a transducer bin/nobsme.fst		 "
echo ""
echo "Usage:"
echo "lookup bin/nobsme.fst"
echo ""
echo "(or if you have set up the alias: just write nobsme)"
echo "----------------------------------------------------"
echo ""




echo "LEXICON Root" > bin/nobsme.lexc

cat src/*_nobsme.xml   | \
grep -v '<r id='       | \
tr '\n' '™'            | \
sed 's/<e/£/g;'        | \
tr '£' '\n'            | \
sed 's/<re>[^>]*>//g;' | \
sed 's/xml:lang//g;'   | \
tr '<' '>'             | \
cut -d">" -f6,16       | \
tr ' ' '_'             | \
sed 's/:/%/g;'         | \
tr '>' ':'             | \
grep -v '__'           | \
sed 's/$/ # ;/g'       >> bin/nobsme.lexc


printf "read lexc < bin/nobsme.lexc \n\
invert net \n\
save stack bin/nobsme.fst \n\
quit \n" > tmpfile
xfst -utf8 < tmpfile
rm -f tmpfile

