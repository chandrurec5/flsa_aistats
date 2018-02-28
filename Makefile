slow:
	latexmk -pdf -enable-write18 flsa
fast:
	pdflatex flsa
final:
	latexmk -pdf -enable-write18 -pdflatex="pdflatex %O '\PassOptionsToPackage{disable}{todonotes}\input{%S}'" flsa
#	pdflatex '\PassOptionsToPackage{disable}{todonotes}\input{book}'
	[ -d ~/Dropbox/ ] && cp flsa.pdf ~/Dropbox/mypapers/aistats2018-flsa.pdf
clean:
	latexmk -C
	rm tikz/*
