#!/bin/bash
# Rydder Pakker-mappa etter at nye bilder er kopiert inn.
#
# Når macOS finner et filnavn som finnes fra før, lagrer den den nye fila
# som "navn-1.png". Presentasjonen leter etter "navn.png" og viser derfor
# den gamle. Dette skriptet lar den nyeste vinne: den gamle flyttes til
# _erstattet, og "-1"-fila overtar det riktige navnet.
#
# Bruk: dobbeltklikk på fila etter at du har kopiert inn nye bilder.

cd "$(dirname "$0")/Pakker" || exit 1
mkdir -p _erstattet
endret=0

for ny in *-[0-9].png; do
  [ -e "$ny" ] || continue
  gammel="${ny%-[0-9].png}.png"
  if [ -e "$gammel" ]; then
    mv -f "$gammel" "_erstattet/$gammel"
    mv -f "$ny" "$gammel"
    echo "Oppdatert: $gammel"
    endret=$((endret+1))
  else
    mv -f "$ny" "$gammel"
    echo "Omdøpt:    $gammel"
    endret=$((endret+1))
  fi
done

if [ "$endret" -eq 0 ]; then
  echo "Ingenting å rydde. Alle bildene har riktig navn."
else
  echo ""
  echo "$endret bilde(r) oppdatert. Gamle versjoner ligger i Pakker/_erstattet."
fi
echo ""
echo "Last inn presentasjonen på nytt for å se endringene."
