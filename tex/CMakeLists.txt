cmake_minimum_required(VERSION 2.6)
cmake_policy(SET CMP0011 NEW) #acknowledge policy push/pop

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(LaTeXBuild)
include(FindLATEX)

project("Homework")

set(PDF_COMPILER_OPTS "")

# list of projects to build
set(projects "hw2")

set(OLDTEXINPUTS $ENV{TEXINPUTS})

#build the project infos
foreach(proj "${projects}")
	add_subdirectory(${proj})
endforeach(proj)

foreach(projectName "${projects}")
endforeach(projectName)
