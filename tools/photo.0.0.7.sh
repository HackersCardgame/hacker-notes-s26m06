#!/bin/bash

# Überprüfe, ob Quelle und Ziel angegeben sind
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <quelle> <ziel>"
    exit 1
fi

QUELLE="$1"
ZIEL="$2"

# Exportiere die Variablen, damit sie im Hilfsskript verfügbar sind
export QUELLE ZIEL
echo QUELLE = $QUELLE ZIEL = $ZIEL

ls -lah $0
ls -lah $(dirname $0)

# Durchsuche alle Dateien in der Quelle (rekursiv) und rufe das Hilfsskript auf
echo find "$QUELLE" -type f -name "DSC*.jpg" -exec $(dirname $0)/photo.single.0.0.7.sh  '{}' \;
find "$QUELLE" -type f -name "DSC*.jpg" -exec $(dirname $0)/photo.single.0.0.7.sh  '{}' \;
find "$QUELLE" -type f -name "DSC*.JPG" -exec $(dirname $0)/photo.single.0.0.7.sh  '{}' \;



