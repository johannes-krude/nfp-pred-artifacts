BUILDDIR=build
LATEX=lualatex --interaction=nonstopmode --halt-on-error --shell-escape %O %S
LATEXMK=latexmk -bibtex -pdf -pdflatex="$(LATEX)" -use-make -M -MP

TARGETS=$(patsubst %.tex,%.pdf,$(wildcard *.tex))
ifeq ($(shell git tag 2>/dev/null | fgrep revision-base),revision-base)
	TARGETS+= $(patsubst %.tex,%-revisiondiff.pdf,$(shell git ls-tree revision-base --name-only | egrep '\.tex$$'))
endif

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
	$(LATEXMK) -MF $@.d --outdir=$(@D) $<

$(BUILDDIR)/%.pdf: $(BUILDDIR)/%.tex
	@mkdir -p $(@D)
	$(LATEXMK) -MF $@.d --outdir=$(@D) $<

$(BUILDDIR)/%-cropped.pdf: %.pdf
	@mkdir -p $(@D)
	pdfcrop $< $@

$(BUILDDIR)/%.pdf: %.plot plot/defaults.plot $$(wildcard %*.dat)
	@mkdir -p $(@D)
	gnuplot plot/defaults.plot -e "set output '$@'" $<

$(BUILDDIR)/%.abstract: %.tex
	cat $< | fgrep -A 100 "\begin{abstract}" | fgrep -B 100 "\end{abstract}" | tee $@

$(BUILDDIR)/%.pdf.tar.bz2: $(BUILDDIR)/%.pdf
	cat $(BUILDDIR)/$*.pdf.d | egrep "^ " | sed "s/^ \+//; s/\\\\$$//" | egrep -v "^$|^/" | xargs tar -cjv --transform="s%^%$*/%" -f $@ Makefile

%-revisiondiff.pdf: $(BUILDDIR)/revisiondiff/%.pdf
	cp $< $@

$(BUILDDIR)/revisiondiff/%.tex: %.tex
	@mkdir -p $(@D)
	latexdiff-git --force --add-to-config PICTUREENV=tikzpicture --exclude-safecmd=ref,setlength --append-safecmd=ac,acp,acl,acs,mdata --no-links -r revision-base -d build/revisiondiff $<

$(BUILDDIR)/revisiondiff/plot/%: %
	@mkdir -p $(@D)
	cp $< $@

%-raw.pdf: %.pdf
	qpdf -qdf $< $@

%-pw.pdf: %-raw.pdf
	sed "s/^0.426667 w$$/3.000000 w/" $< > $@

.PHONY: clean
clean:
	rm -rf $(BUILDDIR) $(TARGETS)

include $(wildcard $(BUILDDIR)/*.d)
include $(wildcard $(BUILDDIR)/*/*.d)
