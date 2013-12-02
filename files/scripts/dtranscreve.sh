#!/bin/bash

# remover silêcio
sox $1.mp3 sil$1.mp3 silence 1 0.1 1% -1 0.5 1%
# faz a diarização
python spk_drztn.py sil$1
if [ ! -d "output_$1" ]; then #se não existe output_$1
	mkdir output_$1	      #então cria output_$1
fi
# move todos os áudios segmentados de todos os clusters para a pasta output
find ./sil$1/S* -iname '*.wav' -exec mv {} ./output_$1/ \;
# remove as pastas vazias dos clusters
rm -r ./sil$1/
# renomeia os arquivos de áudio removendo o prefixo do cluster
cd ./output_$1/
rename 's/^S[0-9]*_(.*\.wav)$/$1/' *wav
# transcreve áudio para texto
~/speech2text-master/transcreve.sh
#for f in *.wav
#do
#	echo "Transcrevendo arquivo $f"
#	speech2text $f > $f.txt
#done
# une as transcrições de todos os áudios em um único txt
cat *.txt > result.txt
# remove linhas em branco do arquivo
sed -i '/^$/d' result.txt
# remove aspas do arquivo
sed -i 's/"//g' result.txt
cd ..
rm sil$1.seg
rm sil$1.wav
rm sil$1.mp3
rm sil$1.c.gmm
