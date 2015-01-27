#!/bin/sh

doc_name="paper"
export BIBINPUTS=.

if [ $1 = "c" ]
then
    # continuous compilation
    echo "# Waiting for changes in source files... (in *.tex and sections/*.tex)"
    while true; do 
        inotifywait -e modify *.tex sections/*.tex
        pdflatex --output-directory=build -interaction=nonstopmode $doc_name.tex
        mv build/$doc_name.pdf .
    done
else
    # full build
    rm -rf build/*
    latex --output-directory=build -interaction=nonstopmode $doc_name.tex
    bibtex build/$doc_name
    latex --output-directory=build -interaction=nonstopmode $doc_name.tex
    pdflatex --output-directory=build -interaction=nonstopmode $doc_name.tex
    mv build/$doc_name.pdf .
fi
