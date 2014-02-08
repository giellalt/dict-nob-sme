
# Dette skal bli ei makefil for å lage nobsme.fst, 
# ei fst-fil som tar nob og gjev ei sme-omsetjing.

# Førebels er det berre eit shellscript.
# Kommando for å lage nobsme.fst

# sh nobsme.sh

echo 
echo "Etter at dette scriptet er ferdig står du i xfst med promten"
echo "xfst[1]"
echo 
echo "Gjör då dette:"
echo "invert"
echo "save bin/nobsme.fst"
echo "quit"
echo ""
echo "LEXICON Root" > bin/smenob.lexc

cat  src/*_smenob.xml | \

echo "LEXICON Root" > bin/nobsme.lexc

cat src/*_nobsme.xml | \
tr '\n' '™' | sed 's/<e/£/g;'| tr '£' '\n'| \
sed 's/<re>[^>]*>//g;'|tr '<' '>'| cut -d">" -f6,16| \
tr ' ' '_'| sed 's/:/%/g;'|tr '>' ':'| \
grep -v '__'|sed 's/$/ # ;/g' >> bin/nobsme.lexc

xfst -e "read lexc < bin/nobsme.lexc"


# deretter gjer du dette i xfst:
# invert
# save bin/nobsme.fst

