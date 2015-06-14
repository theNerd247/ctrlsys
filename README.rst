ctrlsys
-------
Control Systems Class stuff (Mostly homework).

Directory Structure
===================

pdf/
  PDF files (instructions, homework, solutions, etc.)

tex/
  Latex projects for writing homework.

<project_name>
  All files related to a given project

<project_name>/src/
  The source code for the project (if any)

<project_name>/tex/
  Latex files for the specific project.

<project_name>/img/
  The images, TikZ files, etc. for the given project

tex/<project_name>/sty/
  Sty files for the latex project

Building
========

Use the following steps to build the project called <project_name>.

::

  mkdir build
  cd build
  cmake ..
  cd <project_name>
  make

The output for the pdf will be produced in build/<project_name>
