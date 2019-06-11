OUTDIR = out/
PANDOC = pandoc
PYTHON = python3

TEX_TEMPLATE = templates/template.tex # Latex Template

INPUT_MD = src/main/markdown/root.md out/main.md # Liste Input Files

DOCX_FILE = $(addprefix $(OUTDIR),$(addsuffix .docx, main))
MD_FILE = $(addprefix $(OUTDIR),$(addsuffix .md, main))
PDF_FILE = $(addprefix $(OUTDIR),$(addsuffix .pdf, out)) # Output File - build/out.pdf
TEX_FILE = $(addprefix $(OUTDIR),$(addsuffix .tex, out))

PANDOC_OPTS += --highlight-style tango -N -s
#PANDOC_OPTS += --latex-engine=xelatex
PANDOC_OPTS += --pdf-engine=xelatex
PANDOC_OPTS += --metadata link-citations=true # Citations als Links
PANDOC_OPTS += --number-sections
PANDOC_OPTS += --listings # Code Listings
PANDOC_OPTS += --filter pandoc-tablenos # Referenzierung von Tabellen
PANDOC_OPTS += --filter pandoc-fignos # Referenzierung von Grafiken
PANDOC_OPTS += --filter pandoc-citeproc # Erzeugung von Bibliographie ohne explizite Latex Tools
PANDOC_OPTS += --filter pandoc-plantuml # PlantUML Unterstützung
#PANDOC_OPTS += --filter pandoc-latex-fontsize # Anpassung Schriftgröße einzelner Elemente
PANDOC_OPTS += --csl templates/ieee.csl # Bib-Template, Citation Style Language
PANDOC_OPTS += --bibliography=refs/ref.bib # Bib-File mit Referenzen
#PANDOC_OPTS += --verbose # Debug

.PHONY: all
all: md pdf tex

md:
	$(PYTHON) build-system/python/tree-test.py --mapping src/main/markdown/files.yml  --md_sources_root src/main/markdown/ --base_path out/ --output_file_name "main"

pdf:
	$(PANDOC) $(PANDOC_OPTS) $(FONTS_OPTS) $(INPUT_MD) -o $(PDF_FILE) --template $(TEX_TEMPLATE)

tex:
	$(PANDOC) $(PANDOC_OPTS) $(FONTS_OPTS) $(INPUT_MD) -o $(TEX_FILE)


.PHONY: clean
clean:
	@rm -rf $(MD_FILE) @rm -rf $(PDF_FILE) @rm -rf $(TEX_FILE)
