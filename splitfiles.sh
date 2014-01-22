#!/bin/sh

sourcedir="src"
nobsmedir="../gen_for_satni-org/nobsme"
faddir="../gen_for_satni-org/fad"
scriptdir="../script"

cd "$sourcedir"

for i in *.xml; do
	[ ! -f $file ] && continue
	xsltproc -o "$nobsmedir/$i" $scriptdir/nobsmetonobsme.xsl $i 
	xsltproc -o "$faddir/$i" $scriptdir/nobsmetofad.xsl $i 
done