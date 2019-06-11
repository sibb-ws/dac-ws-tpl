FROM ubuntu:18.04

RUN echo "Europe/Berlin" > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt install -y make wget plantuml graphviz texlive texlive-xetex texlive-lang-german texlive-fonts-extra python3 python3-pip

ENV PANDOC_VERSION "2.7.1"
RUN wget -q "https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-amd64.deb"
RUN dpkg -i pandoc-${PANDOC_VERSION}-1-amd64.deb

RUN apt install -y pandoc-citeproc

RUN pip3 install  pandoc-tablenos  pandoc-fignos pandoc-plantuml-filter pandoc-latex-fontsize

RUN echo " usage: docker run -v $PWD/your_working_directory/:/workdir/ name_of_your_container "


WORKDIR /workdir
ENTRYPOINT make all