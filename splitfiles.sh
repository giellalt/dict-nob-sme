#!/bin/sh

sourcedir="src"
nobsmedir="../nobsme"
faddir="../fad"
scriptdir="../script"

cd "$sourcedir"

for i in *.xml; do
	[ ! -f $file ] && continue
	xsltproc -o "$nobsmedir/$i" $scriptdir/nobsmetonobsme.xsl $i 
	xsltproc -o "$faddir/$i" $scriptdir/nobsmetofad.xsl $i 
done