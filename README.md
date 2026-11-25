# English Trainer

Persönlicher Englisch-Trainer als Web-App: Vokabel-Kartei mit Schreiben und Lückentext, Beschreiben-Übungen mit KI-Feedback, 13 Grammatik-Lektionen fürs Sprechen und Vorlesen mit wählbarer Stimme.

**App öffnen:** https://dennis44-bit.github.io/english-trainer/

## Einrichtung (einmalig pro Gerät)

Auf der Übersicht unter **⚙️ Einstellungen**:

- **KI-Feedback:** einen Anthropic-API-Key eintragen (console.anthropic.com → API Keys). Der Key bleibt nur im Browser des Geräts gespeichert und steht nicht im Code.
- **Sync zwischen Geräten:** einen GitHub-Token mit dem Recht `gist` eintragen. Der Lernstand liegt dann in einem privaten Gist und ist auf allen Geräten gleich.
- **Fortschritt übertragen:** Export/Import, z. B. um den Lernstand aus der Claude-Artefakt-Version zu übernehmen.

Auf dem Handy über „Zum Home-Bildschirm“ als App installierbar.

## Aufbau

Alles steckt in `index.html` (eine Datei, kein Build-Schritt). Dieselbe Datei läuft auch als Claude-Artefakt; dort kommen KI und Sync von Claude, auf GitHub Pages von API-Key und Gist.
