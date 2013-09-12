#!/bin/bash
#files=$(ls n_*.wav 2> /dev/null | wc -l)
#if [ **"$files" != "0"** ]
if [ -f n_*.wav ]
then
	for f in n_*.wav
	do
		echo "Transcrevendo arquivo $f"
		speech2text $f > $f.txt
	done
else
	for f in *.wav
	do
		echo "Transcrevendo arquivo $f"
		speech2text $f > $f.txt
	done
fi
