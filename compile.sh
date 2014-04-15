#!/bin/sh
export BIBINPUTS=.

if [ $1 = "c" ]
then
    # continuous compilation
    echo "# Waiting for changes in source files... (in *.tex and  sections/*.tex)"
    while true; do 
        inotifywait -e modify *.tex sections/*.tex
        pdflatex --output-directory=build -interaction=nonstopmode paper.tex
        mv build/paper.pdf .
    done
else
    # full build
    rm -rf build/*
    latex --output-directory=build -interaction=nonstopmode paper.tex
    bibtex build/paper
    latex --output-directory=build -interaction=nonstopmode paper.tex
    pdflatex --output-directory=build -interaction=nonstopmode paper.tex
    mv build/paper.pdf .
fi
