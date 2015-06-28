#!/bin/bash

outfile="lab2ImgResults.tex"

for f in $(ls); do
	part=$(echo $f | sed -e 's/part\([0-9]\)-[0-9].jpg/\1/')
	num=$(echo $f | sed -e 's/part[0-9]-\([0-9]\).jpg/\1/')

	echo "	
	\\begin{figure}[H]
		\\includegraphics[width=\\textwidth]{$f}
		\\caption{PID Response for Control Loop $part-$num}
	\\end{figure}"  >> $outfile
done
