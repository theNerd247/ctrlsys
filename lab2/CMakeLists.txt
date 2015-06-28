cmake_minimum_required(VERSION 2.6)
cmake_policy(SET CMP0011 NEW) #acknowledge policy push/pop

include(LaTeXBuild)

project("lab2")

set(mainTexFile "main.tex")

set(srcDir "src")
set(graphDir "graph")
set(texDir "tex")
set(styDir "sty")
set(imgDir "img")
set(otherIncludes 
	"${srcDir}"
	"${graphDir}"
	)

set(subProjects "")

set(texinputs 
	"${texDir}"
	"${styDir}"
	"${imgDir}"
	"${otherIncludes}")

SetupLaTexBuildEnv (
	"${mainTexFile}" # the main tex file
	"${texinputs}" # all the standalone TEXINPUTS for this project
	"${subProjects}"
	)
