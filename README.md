## Workshop Setup

Wenn live coding statt findet, die Teilnehmer benötigen eine Vorbereitung:
1. Link auf die Vorbereitung (z.B. Github)
    1. Ziel und Ablauf werden beschrieben
    2. Softwareabhängigkeiten werden aufgelistet und ihre Instllation kurz wird erläutertert
    3. Ein ausführbares Beispiel wird gegeben, um die erfolgreiche Vorbereitung zu Testen


### Beispiel:

Gestaltung eigener Dokumentation als Quellcode
---

#### Abhängigkeiten: 

[Docker](https://www.docker.com) mit dem gebauten [Dockerfile](Dockerfile) wird benötigt. **Bitte installieren**.

1. Im Projektverzeichniss folgenden Befehl ausführen
```bash
docker build -t na . 
```

2. Bild testen mit
```bash
docker run -v /Users/dmilasinovic/netass/dac-ws-tpl/:/workdir/ ws
```

3. Liegt im `out` Verzeichniss die `out.pdf` Detei, ist Ihre Umgebung bereit. 