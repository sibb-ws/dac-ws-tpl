
Workshop
---

## Vorbereitung
### Abhängigkeiten: 

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