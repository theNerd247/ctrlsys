labproj 
-------
Skeleton directory for labreports. 

Directory Structure
===================
* tex/: where all tex files should go
	* main.tex: the main tex file that is compiled 
	* labreport.sty: the latex styling document for a labreport. 	
	* .tex: other sections of a labreport 
* Makefile: builds the entire labreport. This runs the Makefile in the data directory.
* figures/: place all images here.
* data/: all of your stuff relating to data and its analysis should go here
	* graphs/: the results from gnuplot graphs (images, .tex, .eps, etc.)
	* tables/: the data files for you project (.csv, .dat, etc.).
	* graph.gp: the main gnuplot file.
	* main.m: the main octave/matlab file to process your data
	* Makefile: makefile to run data analysis and generate graphs

Make Lab Report
===============
Inside of the parent directory run:  

	$ make

If you wish to just build the pdf without re-running data analysis then run:  

	$ make pdf

Or you can do:  

	$ make data

To just run data analysis.
