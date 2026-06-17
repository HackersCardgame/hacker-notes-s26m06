#!/bin/bash

figlet "$1"
echo "$1" |espeak-ng -v de -s 199
echo "$1" |espeak-ng -v en -s 150
echo "$1" |espeak-ng -v de -s 99

if [ "$1" = "" ]
then
	exit 1
fi

t=$(cat $1|tr '\n' ' ')

#echo $t

IFS='.?!'
read -ra sentences <<< "$t"

echo $sentences

for sentence in "${sentences[@]}"
 do
	echo "$sentence".
	echo

	#speak-ng -v de -s 399 "$sentence"
	echo "$sentence" |espeak-ng -v de -s 399

	#sleep 1
	
done



