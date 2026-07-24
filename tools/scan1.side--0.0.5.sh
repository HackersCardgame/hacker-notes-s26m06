#!/bin/bash

# ca 10:15 wurden relativ viele terroristen mit neurowaffen aktiviert welche spazialisiert darauf sind programmierarbeiten zu sabotieren ,bzw die sind selber zu blöd dazu das ist eine KI welche denen sagt welchen Teil sie wegschiessen sollen damit sie sich als Helden deren Terrornetzwerks fühlen können
# technisch sind das vermutlich hidden markov models für einen spezifischen teil-code im code, und dort wird dann für jedne möglcihen weg ein Terrorist mit cyberwaffen aufgestellt welcher schiessen darf falls ich diesen lösungsweg einschlage und sich dann mit "good shot" wie im collateral murder video als die 2 kinder erschossen haben feiern dürfen
#

echo parameter: $1 $2

#scanPDFs=$(ls /run/media/marc/*/B*R -t |tail -n2 |tac)
scanPDFs=$(ls /run/media/marc/*/B*R |tail -n2 )
echo $scanPDFs 

echo find /run/media/marc/*/B*R/$(echo $scanPDFs |cut -d" " -f1)
find /run/media/marc/*/B*R/$(echo $scanPDFs |cut -d" " -f1)
vorder=$( find /run/media/marc/*/B*R/$(echo $scanPDFs |cut -d" " -f1) )



echo find /run/media/marc/*/B*R/$(echo $scanPDFs |cut -d" " -f2)
find /run/media/marc/*/B*R/$(echo $scanPDFs |cut -d" " -f2)
rueck=$( find /run/media/marc/*/B*R/$(echo $scanPDFs |cut -d" " -f2) )

echo vorderseite: $vorder
echo rückseite: $rueck

echo press any SPACE bar key to contunez
read

echo cp $vorder vorderseiten.pdf
cp $vorder vorderseiten.pdf

echo cp $rueck rueckseiten.pdf
cp $rueck rueckseiten.pdf


# \Ufffffffferpr\Uffffffffob gs (Ghostscript) installiert ist
if ! command -v gs &> /dev/null; then
    echo "Fehler: Ghostscript (gs) ist nicht installiert. Bitte installiere es mit 'sudo apt-get install ghostscript'."
    exit 1
fi

# \Ufffffffferpr\Uffffffffob die Eingabedateien existieren
if [ ! -f "vorderseiten.pdf" ] || [ ! -f "rueckseiten.pdf" ]; then
    echo "Fehler: Eine oder beide Eingabedateien (vorderseiten.pdf, rueckseiten.pdf) fehlen."
    exit 1
fi

# \Ufffffffferpr\Uffffffffob die ben\Ufffffffften Tools installiert sind
for cmd in gs pdfseparate pdfunite; do
    if ! command -v $cmd &> /dev/null; then
        echo "Fehler: $cmd ist nicht installiert. Bitte installiere poppler-utils mit 'sudo apt-get install poppler-utils'."
        exit 1
    fi
done

# \Ufffffffferpr\Uffffffffob die Eingabedateien existieren
if [ ! -f "vorderseiten.pdf" ] || [ ! -f "rueckseiten.pdf" ]; then
    echo "Fehler: Eine oder beide Eingabedateien (vorderseiten.pdf, rueckseiten.pdf) fehlen."
    exit 1
fi

# Tempor\Uffffffff Verzeichnisse erstellen
mkdir -p temp_vorder temp_rueck && rm temp_vorder/* temp_rueck/*

# PDFs in einzelne Seiten aufteilen
pdfseparate vorderseiten.pdf temp_vorder/vorder_%03d.pdf
pdfseparate rueckseiten.pdf temp_rueck/rueck_%03d.pdf

ls temp_rueck temp_vorder


# Anzahl der Seiten ermitteln
vorder_count=$(ls temp_vorder | wc -l)
rueck_count=$(ls temp_rueck | wc -l)

# \Ufffffffferpr\Uffffffffob die Anzahl der Seiten \Uffffffffnstimmt
if [ "$vorder_count" -ne "$rueck_count" ]; then
    echo "Fehler: Die Anzahl der Seiten in vorderseiten.pdf und rueckseiten.pdf stimmt nicht \Uffffffffn."
    exit 1
fi

echo vordercounter: $vorder_count

# Abwechselnd kombinieren
for i in $(seq  $vorder_count)
  do
    echo counter: $i  v:  $vorder_count i: $i printf $(printf "%03d" $i).pdf $(printf "%03d" $(( $vorder_count - $i )) ).pdf

    pdf_files+=("temp_vorder/vorder_$(printf "%03d" $i).pdf" "temp_rueck/rueck_$(printf "%03d" $(( $vorder_count - $i + 1 )) ).pdf")
done

pdfunite "${pdf_files[@]}" duplex_scan.pdf

# Tempor\Uffffffff Verzeichnisse bereinigen
#rm -rf temp_vorder temp_rueck

echo "Fertig! Das kombinierte PDF wurde als 'duplex_scan.pdf' gespeichert."
