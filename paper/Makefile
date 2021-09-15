TARGETS=paper-nfp-pred.pdf
BUILDDIR=build
LATEX=lualatex --interaction=nonstopmode --halt-on-error --shell-escape %O %S
LATEXMK=latexmk -bibtex -pdf -pdflatex="$(LATEX)" -use-make -M -MP

.SECONDARY:
.SUFFIXES:

.SECONDEXPANSION:

.PHONY: all
all: $(TARGETS)

.PHONY: plots
plots: $(patsubst %.plot,$(BUILDDIR)/%.pdf, $(wildcard plot/*.plot))

%.pdf: $(BUILDDIR)/%.pdf
	cp $< $@

$(BUILDDIR)/%.pdf: %.tex
	@mkdir -p $(@D)
	$(LATEXMK) -MF $@.d --outdir=$(BUILDDIR) $<

$(BUILDDIR)/%-cropped.pdf: %.pdf
	@mkdir -p $(@D)
	pdfcrop $< $@

$(BUILDDIR)/%.pdf: %.plot plot/defaults.plot $$(wildcard %*.dat)
	@mkdir -p $(@D)
	gnuplot plot/defaults.plot -e "set output '$@'" $<

$(BUILDDIR)/%.abstract: %.tex
	cat $< | fgrep -A 100 "\begin{abstract}" | fgrep -B 100 "\end{abstract}" | tee $@

$(BUILDDIR)/%.pdf.tar.bz2: $(BUILDDIR)/%.pdf
	cat $(BUILDDIR)/$*.pdf.d | egrep "^ " | sed "s/^ \+//; s/\\\\$$//" | egrep -v "^$|^/" | xargs tar -cjvf $@

%-raw.pdf: %.pdf
	qpdf -qdf $< $@

%-pw.pdf: %-raw.pdf
	sed "s/^0.426667 w$$/3.000000 w/" $< > $@

.PHONY: clean
clean:
	rm -rf $(BUILDDIR) $(TARGETS)

include $(wildcard $(BUILDDIR)/*.d)
include $(wildcard $(BUILDDIR)/*/*.d)
