cmake_minimum_required(VERSION 2.6)
#acknowledge policy push/pop
cmake_policy(SET CMP0011 NEW) 

include(LaTeXBuild)

project("lab3")

set(mainTexFile "main.tex")

set(texDir "tex")
set(styDir "sty")
set(imgDir "img")

set(includeList 
	"${texDir}"
	"${styDir}"
	"${imgDir}"
	"src"
	"src/results/imgs"
	"src/results/data"
	)

set(styleFiles 
	"sty/lab.sty"
	"src/imgResults.sty"
	)

SetupLaTexBuildEnv (
	# the main tex file
	"${mainTexFile}" 
	# the file search paths this project provides
	"${includeList}" 
	# the style files this project provides
	"${styleFiles}"
	# projects this project depends on
	"${subProjects}"
	)
