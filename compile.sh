#!/bin/sh
export BIBINPUTS=.
rm -rf build/*
latex --output-directory=build -interaction=nonstopmode paper.tex
bibtex build/paper
latex --output-directory=build -interaction=nonstopmode paper.tex
pdflatex --output-directory=build -interaction=nonstopmode paper.tex
mv build/paper.pdf .
