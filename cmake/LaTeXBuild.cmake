cmake_minimum_required(VERSION 2.6)
cmake_policy(SET CMP0011 NEW) #acknowledge policy push/pop

function(SetupLaTexBuildEnv 
	mainTexFile # the main tex file
	inputList # the dirs to search for building pdf files (relative to this
	          #CMakeLists)
	subProjects # list of sub projects that this project depends on
	)

	# build the main file path
	set("${PROJECT_NAME}_mainTexFilePath"
		"${CMAKE_CURRENT_SOURCE_DIR}/${mainTexFile}" 
		CACHE INTERNAL "main tex file to compile from"
		)
	
	# build the TEXINPUTS environment variable
	#  - get the exported input paths for each sub project
	set("${PROJECT_NAME}_texInputs" 
		"${CMAKE_CURRENT_SOURCE_DIR}"
		)
	
	#build the include list for this project
	foreach(dir ${inputList})
		set("${PROJECT_NAME}_texInputs"
			"${${PROJECT_NAME}_texInputs}:${CMAKE_CURRENT_SOURCE_DIR}/${dir}"
			)
	endforeach(dir)

	#set the list of dependent projects
	set("${PROJECT_NAME}_dependProjects" 
		${subProjects}
		CACHE INTERNAL "list of dependent projects for this project"
		)

	#export our provided TEXINPUTS
	set("${PROJECT_NAME}_texInputs" "${${PROJECT_NAME}_texInputs}" 
		CACHE INTERNAL "TEXINPUTS provided by this project"
		)

	add_custom_command(
		OUTPUT "${CMAKE_BINARY_DIR}/${PROJECT_NAME}.pdf"
		COMMAND
			"TEXINPUTS=${OLDTEXINPUTS}:${${PROJECT_NAME}_texInputs}" # set the TEXINPUTS
			${PDFLATEX_COMPILER} # run pdflatex
				${PDF_COMPILER_OPTS}
				"${${PROJECT_NAME}_mainTexFilePath}"
		DEPENDS "${${PROJECT_NAME}_mainTexFilePath}"
		COMMENT "pdflates"
		)

	add_custom_target("build_${PROJECT_NAME}" 
		ALL 
		DEPENDS "${CMAKE_BINARY_DIR}/${PROJECT_NAME}.pdf"
		)

	set_target_properties("build_${PROJECT_NAME}"
		PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
		)

endfunction(SetupLaTexBuildEnv)
