cmake_minimum_required(VERSION 2.6)
cmake_policy(SET CMP0011 NEW) #acknowledge policy push/pop

include(LaTeXBuild)

project("cheatsheet")

set(mainTexFile "main.tex")

set(texDir "tex")
set(styDir "sty")
set(imgDir "img")
set(otherIncludes "")

set(subProjects "")
set(styleFiles "")

set(texinputs 
	"${texDir}"
	"${styDir}"
	"${imgDir}"
	"${otherIncludes}")

SetupLaTexBuildEnv (
	"${mainTexFile}" # the main tex file
	"${texinputs}" # all the standalone TEXINPUTS for this project
	"${styleFiles}"
	"${subProjects}"
	)
