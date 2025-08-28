LATEX=pdflatex -interaction=nonstopmode  
SRC_EN=abstract_en.tex
SRC_FR=abstract_fr.tex
PDF_EN=abstract_en.pdf
PDF_FR=abstract_fr.pdf

all: $(PDF_EN) $(PDF_FR)

$(PDF_EN): $(SRC_EN)
	$(LATEX) $(SRC_EN)

$(PDF_FR): $(SRC_FR)
	$(LATEX) $(SRC_FR)

clean:
	rm -f *.aux *.log *.out *.toc *.lof *.lot

distclean: clean
	rm -f $(PDF_EN) $(PDF_FR)

# Auto-recompile when sources change (requires `entr`)
watch:
	ls *.tex | entr make