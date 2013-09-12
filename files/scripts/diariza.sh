#!/bin/bash

python spk_drztn.py $1 #faz a diarização
if [ ! -d "output_$1" ]; then #se não existe output_$1
	mkdir output_$1	      #então cria output_$1
fi
#move todos os audios segmentados de todos os clusters para a pasta output
find ./$1/S* -iname '*.wav' -exec mv {} ./output_$1/ \;
rm -r ./$1/ #remove as pastas vazias dos clusters
