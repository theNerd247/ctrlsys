#!/bin/bash

createImageTable()
{
	IFS=";"
	imgsText="\\subsection{Part ${part} Results}"
	for i in ${images[@]}; do
		imgsText="$imgsText
\\begin{figure}[H]
	\\includegraphics[width=4in]{$i}
\\end{figure}"
	done

	cat <<-IMGTABLE
	${imgsText}
		IMGTABLE
}

# template for results table
createDataTable()
{
cat <<TABLE1
\\begin{table}[H]
	\\begin{tabularx}{\\textwidth}{XXXXXXXXXX}
		\\toprule
		\\\\ \$K_p\$ & \$K_i\$ & \$K_d\$ & \$T_r\$ & \$T_p\$ & \$T_s\$ & \$\\%OS\$ & \$e_{ss}\$ 
		& Stable System? & Damping Classification
		\\\\ \\midrule
		$tableContents
		\\\\ \\bottomrule
	\\end{tabularx}
	\\caption{Part ${part} PID Results}
	\\label{tab:pid${part}SimResults}
\\end{table}
TABLE1
}

outfile="$(pwd)/imgResults.tex"
echo "" > $outfile

baseDir=results

# get all of the parts
for part in {1..4}; do
	images=()

	IFS=;
	images=$(find ${baseDir}/imgs/pt${part}/* -printf "pt${part}/%f\n" | sort -n -t "-" -k2 | sed -e ':a;N;$!ba;s/\n/;/g')
	tableContents=$(cat ${baseDir}/data/pt${part}.tex)

	echo "$(createImageTable) 
$(createDataTable)" >> ${outfile}

done
