#!/bin/bash

createImageTable()
{
	cat <<-IMGTABLE
	\\begin{table}[H]
	\\begin{tabular}{ccc}
	\\toprule
	\\\\ \\includegraphics[width=1.8in]{${images[0]}} 
	& \\includegraphics[width=1.8in]{${images[1]}} 
	& \\includegraphics[width=1.8in]{${images[2]}} 
	\\\\ \\includegraphics[width=1.8in]{${images[3]}} 
	& \\includegraphics[width=1.8in]{${images[4]}} 
	& \\includegraphics[width=1.8in]{${images[5]}} 
	\\\\ \\includegraphics[width=1.8in]{${images[6]}} 
	\\\\ \\bottomrule
	\\end{tabular}
	\\caption{Part $part Step Responses}
  \\label{tab:part${part}Response}
	\\end{table}
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

outfile="$(pwd)/lab2Results.tex"
echo "" > $outfile

cd results/lab2results/

# get all of the parts
for part in {1..4}; do
	images=()
	# for each part get the expriments and generate the image table
	for num in {1..7}; do
		images+=("part${part}-${num}.jpg")
	done

	tableContents="$(cat "part${part}.tex")"

	echo "$(createImageTable)
$(createDataTable)" >> $outfile
done
