# Einleitung Markdown & Pandoc - Doku-Beispiel

## Pandoc Überblick

![Pandoc Überblick](media/pandoc_overview.png "Pandoc Überblick"){#fig:pandoc_overview}

## Workflow / Processing Pipeline

1. Mediendaten in /media hinterlegen
2. Referenzen als Bibliografie (ref.bib) Datei in /ref hinterlegen
3. Die Inhalte in Markdown in den chapter-Dateien (chapter_[1...n].md) schreiben
4. Bei Bedarf Latex Template (template.tex) in /templates anpassen
5. Bei Bedarf Citation Styles (z.B. ieee.csl) in /templates anpassen
6. Bei Bedarf Metadaten und allgemeine Konfiguration in root.md anpassen
7. Bei Bedarf Pandoc Konfiguration im Makefile anpassen
8. make clean & make
9. Output PDF / TEX (out.pdf, out.tex) im /out Verzeichnis

## Verzeichnisstruktur

* /doku-test (Ordner für Makefile, root.md und chapter.md)
    - /media (Ordner für Abbildungen & Medien)
    - /out (Zielordner für erzeugte Dokumente)
    - /plantuml-images (Ordner für erzeugte PlantUML Abbildungen)
    - /ref (Ordner für Bibliografie .bib Dateien)
    - /templates (Ordner für Latex Template und CSL Styles)

## Makefile

Arbeitsverzeichnisse, Dateien, Pandoc Konfiguration, Pandoc Ausführung.

* make (komplettes Dokument in out/ erzeugen)
* make clean (alle erzeugten Dateien in out/ entfernen)

~~~{#makefile .sh caption="Makefile"}
OUTDIR = out/
PANDOC = pandoc
TEX_TEMPLATE = templates/template.tex # Latex Template

INPUT_MD = root.md chapter_1.md chapter_2.md chapter_3.md # Liste Input Files

PDF_FILE = $(addprefix $(OUTDIR),$(addsuffix .pdf, out)) # Output File - build/out.pdf
TEX_FILE = $(addprefix $(OUTDIR),$(addsuffix .tex, out))

PANDOC_OPTS += --highlight-style tango -N -s
PANDOC_OPTS += --latex-engine=xelatex
PANDOC_OPTS += --metadata link-citations=true # Citations als Links
PANDOC_OPTS += --number-sections
PANDOC_OPTS += --listings # Code Listings
PANDOC_OPTS += --filter pandoc-tablenos # Referenzierung von Tabellen
PANDOC_OPTS += --filter pandoc-fignos # Referenzierung von Grafiken
PANDOC_OPTS += --filter pandoc-citeproc # Erzeugung von Bibliographie ohne explizite Latex Tools
PANDOC_OPTS += --filter pandoc-plantuml # PlantUML Unterstützung
PANDOC_OPTS += --csl templates/ieee.csl # Bib-Template, Citation Style Language
PANDOC_OPTS += --bibliography=refs/ref.bib # Bib-File mit Referenzen
#PANDOC_OPTS += --verbose # Debug

#Font_Opts vermutlich unnötig ... siehe Template.tex
#FONTS_OPTS  += --variable mainfont="Noto Sans CJK JP"
#FONTS_OPTS  += --variable sansfont=Arial
#FONTS_OPTS  += --variable monofont="Courier"
#FONTS_OPTS  += --variable fontsize=12pt

.PHONY: all clean

all: $(PDF_FILE) $(TEX_FILE)
    $(PDF_FILE): ; $(PANDOC) $(PANDOC_OPTS) $(FONTS_OPTS) $(INPUT_MD) -o $@ --template $(TEX_TEMPLATE)
    $(TEX_FILE): ; $(PANDOC) $(PANDOC_OPTS) $(FONTS_OPTS) $(INPUT_MD) -o $@

clean: ;@rm -rf $(PDF_FILE), @rm -rf $(TEX_FILE)
~~~

## Root.md (Präambel)

Metadaten und allgemeine Konfiguration.

~~~{#root.md .md caption="root.md Datei"}
---
title: "Dokumentation mit Markdown & Pandoc"
date: "2019-02-28"
author: [Robert Fischer, Dragoljub Milasinovic, NetworkedAssets]
subject: "Markdown"
keywords: [Markdown, Dokumentation, Pandoc]
subtitle: "Doku-Beispiel zum Workshop"
titlepage: true
logo: media/na-logo.jpg

toc-own-page: true
toc: true
lot: true
lof: true
lol: true

header_string: "Dokumentation mit Markdown & Pandoc"
footer_string: "Beispiel Dokument zum Doku-Workshop"
biblio-style: numeric
caption-justification: justified

listings-no-page-break: true
listings-disable-line-numbers: false
colorlinks: true
...
~~~

## Latex Template

~~~{#template.tex .tex caption="Latex Template, template.tex (Ausschnitt)"}
%%
% For usage information and examples visit the GitHub page of this template:
% https://github.com/Wandmalfarbe/pandoc-latex-template
%%

\PassOptionsToPackage{unicode=true$for(hyperrefoptions)$,$hyperrefoptions$$endfor$}{hyperref} % options for packages loaded elsewhere
\PassOptionsToPackage{hyphens}{url}
\PassOptionsToPackage{dvipsnames,svgnames*,x11names*,table}{xcolor}
$if(dir)$
$if(latex-dir-rtl)$
\PassOptionsToPackage{RTLdocument}{bidi}
$endif$
$endif$
%
\documentclass[
$if(fontsize)$
  $fontsize$,
$endif$
$if(lang)$
  $babel-lang$,
$endif$
$if(papersize)$
  $papersize$paper,
$else$
  a4paper,
$endif$
$if(beamer)$
  ignorenonframetext,
$if(handout)$
  handout,
$endif$
$if(aspectratio)$
  aspectratio=$aspectratio$,
$endif$
$endif$
$for(classoption)$
  $classoption$$sep$,
$endfor$
,tablecaptionabove
]{$if(book)$scrbook$else$scrartcl$endif$}
$if(beamer)$
$if(background-image)$
\usebackgroundtemplate{%
  \includegraphics[width=\paperwidth]{$background-image$}%
}
$endif$
\usepackage{pgfpages}
~~~

## Citation Style, CSL 

~~~{#ieee.csl .xml caption="Citation Style, ieee.csl (Ausschnitt)"}
<?xml version="1.0" encoding="utf-8"?>
<style xmlns="http://purl.org/net/xbiblio/csl" class="in-text" version="1.0" demote-non-dropping-particle="sort-only">
  <info>
    <title>IEEE</title>
    <id>http://www.zotero.org/styles/ieee</id>
    <link href="http://www.zotero.org/styles/ieee" rel="self"/>
    <link href="http://www.ieee.org/documents/style_manual.pdf" rel="documentation"/>
    <link href="http://www.ieee.org/documents/auinfo07.pdf" rel="documentation"/>
    <author>
      <name>Michael Berkowitz</name>
      <email>mberkowi@gmu.edu</email>
    </author>
    <contributor>
      <name>Julian Onions</name>
      <email>julian.onions@gmail.com</email>
    </contributor>
    <contributor>
      <name>Rintze Zelle</name>
      <uri>http://twitter.com/rintzezelle</uri>
    </contributor>
    <contributor>
      <name>Stephen Frank</name>
      <uri>http://www.zotero.org/sfrank</uri>
    </contributor>
    <contributor>
      <name>Sebastian Karcher</name>
    </contributor>
    <category citation-format="numeric"/>
    <category field="engineering"/>
    <category field="generic-base"/>
    <updated>2013-12-17T18:04:02+00:00</updated>
    <rights license="http://creativecommons.org/licenses/by-sa/3.0/">This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 License</rights>
...
</style>
~~~

## Verzeichnisse

### ToC, LoT, LoF & LoL

In root.md:
```java
toc: true
lot: true
lof: true
lol: true
```

### Style-Anpassung / Sprache

In templates/template.tex:
```java
\setdefaultlanguage{german}
\setmainlanguage[]{german}
\usepackage[shorthands=off,german]{babel}
```

## Vagrant-Box
```java
sudo apt-get install vagrant
sudo apt install virtualbox

vagrant box add generic/ubuntu1804
vagrant plugin install vagrant-vbguest

mkdir ~/Vagrant/ubuntu1804
cd ~/Vagrant/ubuntu1804

vi Vagrantfile

# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure("2") do |config|
  ##### DEFINE VM #####
  config.vm.define "ubuntu-01" do |config|
  config.vm.hostname = "ubuntu-01"
  config.vm.box = "generic/ubuntu1804"
  config.vm.box_check_update = false
  config.vm.network "private_network", ip: "172.28.128.1"
  end
end

vagrant up
vagrant ssh

sudo -i
apt-get update && apt-get upgrade && apt-get dist-upgrade

vagrant halt
Hibernate the VM with the command vagrant suspend
Destroy the VM with the command vagrant destroy
```

* sudo apt install pandoc
* sudo apt install pandoc-citeproc
* sudo apt install plantuml
* sudo apt install graphviz

* sudo apt install texlive
* sudo apt install texlive-xetex
* sudo apt install texlive-lang-german
* sudo apt install texlive-fonts-extra

* sudo apt install python
* sudo apt install python-pip

* pip install pandoc-tablenos
* pip install pandoc-fignos
* pip install pandoc-plantuml-filter

## Tools

* pandoc
    - pandoc-citeproc
    - pandoc-tablenos
    - pandoc-fignos
    - pandoc-plantuml
* plantuml
* graphviz
* texlive
* panview
* texlive
* texstudio
* lyx
* jabref
* zotero
* ...

