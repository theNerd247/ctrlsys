##############################
# @file Makefile for <+lab+> 
##############################
#
#-- PROJECT {{{ ---------------------------------------------------------
SHELL=/bin/sh
PROJECT=Homework
VERSION=1
#-- END PROJECT }}} -----------------------------------------------------
#-- DIRS {{{ ------------------------------------------------------------
PREFIX=$(PWD)
CLEAN=
TEXDIR=$(PREFIX)/tex/hw2
DATADIR=$(PREFIX)/data
PDFOUTDIR=$(PREFIX)/out
FIGUREDIR=$(PREFIX)/figures
#-- END DIRS }}} --------------------------------------------------------
#-- FLAGS {{{ -----------------------------------------------------------
ENV_TEXINPUTS=TEXINPUTS="$$TEXINPUTS:.:$(FIGUREDIR):$(DATADIR):$(DATADIR)/graphs"
ENV_TEXFORMATS=TEXFORMATS="$$TEXFORMATS:$(DATADIR)/graphs"
PDFENV=$(ENV_TEXINPUTS) $(ENV_TEXFORMATS)
PDFOPTS=-output-directory $(PDFOUTDIR)
#-shell-escape 
#-- END FLAGS }}} -------------------------------------------------------
#-- TARGETS {{{ -----------------------------------------------------------
TEXMAIN=main
PDFTEXTARGET=$(TEXDIR)/$(TEXMAIN).tex
PDFTARGET=$(PREFIX)/$(PROJECT).pdf
#-- END TARGETS }}} -------------------------------------------------------

.PHONY: all setup clean data pdf

all: pdf

data:
	$(MAKE) -C $(DATADIR)

setup: 
	mkdir -p $(PDFOUTDIR)

pdf: setup
	cd $(TEXDIR);\
	export $(PDFENV);\
	pdflatex $(PDFOPTS) $(PDFTEXTARGET)
	mv $(PDFOUTDIR)/$(TEXMAIN).pdf $(PDFTARGET)
