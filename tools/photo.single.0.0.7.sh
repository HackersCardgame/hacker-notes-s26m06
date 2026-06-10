#!/bin/bash

echo SUBSCRIPT

# Überprüfe, ob die Quelldatei angegeben ist
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <src_file>"
    exit 1
fi

src_file="$1"
dest_dir="$ZIEL/${src_file#$QUELLE/}"
dest_file="$dest_dir/$(basename "$src_file")"

# Erstelle das Zielverzeichnis, falls es nicht existiert
echo mkdir -p "$dest_dir"
read
mkdir -p "$("$dest_dir")"

# Prüfe, ob die Zieldatei existiert
if [ -f "$dest_file" ]; then
    # Vergleiche die Dateien
    if cmp -s "$src_file" "$dest_file"; then
        echo "Identisch: $(basename "$src_file") (wird nicht kopiert)"
        exit 0
    fi

    # Finde den höchsten bestehenden Index für diese Datei
    filename=$(basename "$src_file")
    base="${filename%.*}"
    ext="${filename##*.}"
    max_index=0

    # Suche nach bestehenden Dateien mit Index (z. B. DSC01234.01.jpg, DSC01234.02.jpg)
    for existing in "$(dirname "$dest_file")"/"$base".*; do
        if [[ "$existing" =~ \.$base\.([0-9]{2})\.$ext$ ]]; then
            idx="${BASH_REMATCH[1]}"
            if (( idx > max_index )); then
                max_index=$idx
            fi
        fi
    done

    # Erhöhe den Index um 1 und formatiere mit führenden Nullen
    new_index=$((max_index + 1))
    new_filename="${base}.$(printf "%02d" "$new_index").$ext"
    new_dest_file="$(dirname "$dest_file")/$new_filename"

    # Kopiere die Datei mit dem neuen Index
    cp "$src_file" "$new_dest_file"
    echo "Kopiert: $(basename "$src_file") -> $new_filename"
else
    # Ziel existiert nicht, einfach kopieren
    cp "$src_file" "$dest_file"
    echo "Kopiert: $(basename "$src_file")"
fi


