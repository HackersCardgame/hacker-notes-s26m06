#!/bin/bash
for i in $(ls *.WAV)
do
	if ( ls $i.mp3 )
	then
		echo found $i
		rm $i
	else
		echo $i not found
		ffmpeg -i $i $i.mp3
	fi
done
