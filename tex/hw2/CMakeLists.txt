cmake_minimum_required(VERSION 2.6)

include(UseLaTeX)

set(texDir "tex")
set(styDir "sty")

set(mainTexFile "main.tex")
set(subTexFiles "hw.tex")

#build the list of subtex files
set(inputTexFiles "")
foreach(subFile ${subTexFiles})
	set(inputTexFiles ${inputTexFile} "${texDir}/${subFile}")
endforeach(subFile)

ADD_LATEX_DOCUMENT (
	${mainTexFile}
	INPUTS ${inputTexFile}
	DEFAULT_PDF
)
