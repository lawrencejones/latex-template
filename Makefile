DOCUMENTS := \
	report.pdf

TEX_FILES:=$(shell find . -name "*.tex" -type f)
RESOURCE_FILES:=$(shell find ./res -type f)

all: $(DOCUMENTS)

# Why is this command so complex?
#
# Glad you asked.
#
# [1] - Copying the *.tex into libtex/ enables usage of packages inside libtex. We
# benefit from local, reliable package installation without cluttering our root
# directory with package files.
#
# The effect of [1] is to make any paths in your latex relative to the libtex/
# directory. We include the symbolic link libtex/lib to enable paths to access
# files from the root of the repo without any ugliness.
#
# [2] - Latex with bibtex requires some strange reusing of commands. The
# bibliography is populated from the refs.bib file, but standard latex commands
# have to be run first to generate placeholders for the references in the latex
# intermediate files. As to why pdflatex requires being run twice, breaking
# traditional unix idempotency, I have no idea. Life sucks sometimes.
#
# [3] - The final step moves the pdf back out into the root, next to it's
# companion tex file. If the pdf is not generated, then an error has occured
# during compilation.
#
%.pdf: %.tex refs.bib $(RESOURCE_FILES)
	cp $< libtex/ && cd libtex && ( \
	  pdflatex $< && \
		bibtex $* && \
		pdflatex $* && \
		pdflatex $* \
	) && \
		mv $@ ../

clean:
	rm -f $(DOCUMENTS) && git clean -f ./libtex

watch:
	watch "make all" --wait 2
