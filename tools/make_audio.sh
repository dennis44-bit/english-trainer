#!/bin/bash
# Nimmt alle Texte des English Trainers mit einer Mac-Stimme auf (Standard: Evan, erweiterte Version bevorzugt)
# und packt sie nach ~/EnglishTrainerAudio/audio.zip. Abgebrochene Laeufe machen beim naechsten Start weiter.
# Aufruf:  curl -fsSL https://raw.githubusercontent.com/dennis44-bit/english-trainer/main/tools/make_audio.sh | bash
#          (andere Stimme: ... | bash -s Daniel)
set -u
WANT="${1:-Evan}"
OUT="$HOME/EnglishTrainerAudio"
mkdir -p "$OUT/audio" && cd "$OUT" || exit 1
strip_voice(){ sed -E 's/[[:space:]]{2,}[a-z]{2,3}_[A-Za-z0-9]+.*$//'; }
VOICE=$(say -v '?' | grep -i "^$WANT" | grep -iE 'enhanced|erweitert|premium' | head -1 | strip_voice)
[ -z "$VOICE" ] && VOICE=$(say -v '?' | grep -i "^$WANT" | head -1 | strip_voice)
if [ -z "$VOICE" ]; then
  echo "Die Stimme \"$WANT\" wurde nicht gefunden. Englische Stimmen auf diesem Mac:"
  say -v '?' | grep -E 'en_(US|GB|AU|IE|IN|ZA)'
  exit 1
fi
echo "Stimme: $VOICE"
curl -fsSL "https://raw.githubusercontent.com/dennis44-bit/english-trainer/main/audio/texts.tsv" -o texts.tsv || { echo "Textliste konnte nicht geladen werden."; exit 1; }
TOTAL=$(wc -l < texts.tsv | tr -d ' ')
gen(){
  say -v "$VOICE" --file-format=m4af --data-format=aac@22050 --bit-rate=32000 -o "$1" "$2" 2>/dev/null && [ -s "$1" ] && return 0
  rm -f "$1" tmp.aiff
  say -v "$VOICE" -o tmp.aiff "$2" 2>/dev/null && afconvert -f m4af -d aac -b 32000 tmp.aiff "$1" 2>/dev/null && [ -s "$1" ]
}
N=0; FAIL=0
echo "Nehme $TOTAL Texte auf – das dauert etwa 10 bis 20 Minuten. Du kannst nebenbei weiterarbeiten."
while IFS=$'\t' read -r H T; do
  N=$((N+1))
  [ -z "$H" ] && continue
  [ -s "audio/$H.m4a" ] && continue
  gen "audio/$H.m4a" "$T" || { FAIL=$((FAIL+1)); echo; echo "Fehler bei: $T"; }
  [ $((N % 20)) -eq 0 ] && printf "\r  %s / %s" "$N" "$TOTAL"
done < texts.tsv
rm -f tmp.aiff
echo "$VOICE" > audio/voice.txt
rm -f audio.zip
(cd audio && zip -q -r ../audio.zip .)
COUNT=$(ls audio/*.m4a 2>/dev/null | wc -l | tr -d ' ')
echo; echo "Fertig: $COUNT Aufnahmen, $FAIL Fehler. Datei: $OUT/audio.zip ($(du -h audio.zip | cut -f1))"
echo "Sag Claude jetzt Bescheid."
