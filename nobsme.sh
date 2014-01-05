
# Dette skal bli ei makefil for å lage nobsme.fst, 
# ei fst-fil som tar nob og gjev ei sme-omsetjing.

# Førebels er det berre eit shellscript.

# Kommando for å lage nobsme.fst

# skriv
# sh nobsme.sh 
# dvs kall dette skriptet
# detetter gjer skriptet dette:

echo "LEXICON Root" > bin/nobsme.lexc

cat ../smi/geo/inc/prop_nobsme.xml sr*/*_nobsme.xml | \
tr '\n' '™' | sed 's/<e/£/g;'| tr '£' '\n'| \
sed 's/<re>[^>]*>//g;'|tr '<' '>'| cut -d">" -f6,16| \
tr ' ' '_'| sed 's/:/%/g;'|tr '>' ':'| \
grep -v '__'|sed 's/$/ # ;/g' >> bin/nobsme.lexc

xfst -e "read lexc < bin/nobsme.lexc"


# deretter gjer du dette i xfst:
# invert
# save bin/nobsme.fst

