# English Trainer

Persönlicher Englisch-Trainer als Web-App: Vokabel-Kartei mit Schreiben und Lückentext, Beschreiben-Übungen mit KI-Feedback, 13 Grammatik-Lektionen fürs Sprechen und Vorlesen mit wählbarer Stimme.

**App öffnen:** https://dennis44-bit.github.io/english-trainer/

## Einrichtung (einmalig pro Gerät)

Auf der Übersicht unter **⚙️ Einstellungen**:

- **Feedback (kostenlos):** „Feedback in Claude holen“ schickt die Übung an Claude (normales Claude-Abo). Entweder jedes Mal ein neuer Chat mit vorausgefülltem Text, oder – empfohlen – immer dasselbe Coach-Projekt bzw. derselbe Coach-Chat: Link einmal unter Einstellungen eintragen, die App kopiert den Text und öffnet den Coach, dort nur noch einfügen und senden. Der Knopf „Coach-Anweisungen kopieren“ liefert die Projekt-Anweisungen.

Auf dem Handy über „Zum Home-Bildschirm“ als App installierbar.

## Aufbau

Alles steckt in `index.html` (eine Datei, kein Build-Schritt). Dieselbe Datei läuft auch als Claude-Artefakt. Der Lernstand der Web-App liegt im Browser des jeweiligen Geräts (Sync per Gist ist vorbereitet, aber ausgeschaltet: `ET_SYNC`).

## Neue Version veröffentlichen

`python3 tools/release.py "Was ist neu"` setzt den Versionsstempel in `index.html` und schreibt `version.json`. Die App prüft `version.json` beim Öffnen und alle 10 Minuten und zeigt bei einer neueren Version oben den Knopf „Jetzt aktualisieren“.
