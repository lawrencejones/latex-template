# latex-template

A basic latex report template that should compile correctly with a default installation of
`pdflatex`.

## Build

Run `make report.pdf` to compile pdf. The `.sty` files in the `libtex` directory are required for
a successful build.

## Live reloading

For this, I recommend [Skim](http://skim-app.sourceforge.net/) which can be used to detect changes
to the source pdf file and reload on demand. Trigger the `make report.pdf` command on a file change
to get automatic reloading.
