.PHONY: clean

report.pdf: report.tex
	(cd libtex && pdflatex ../report.tex) && \
		mv libtex/report.pdf ./

clean:
	rm -f report.pdf && git clean -f
