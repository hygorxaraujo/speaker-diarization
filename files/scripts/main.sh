#!/bin/bash

# Script usado para editar os arquivos de áudio. Uso: ./editar.sh *.wav (-s) para fazer transcrição dos arquivos sem e com edição.

# Para executar: ./main.sh <nome do arquivo de audio sem a extensão>

#./edita.sh $1 #para realizar a edição do audio original anteriormente
./diariza.sh $1 #para fazer a diarixação

cd ./output_$1/ #entra na pasta com os resultados da diarização
../edita.sh #realiza a edição dos audios resultados da diarização
../transcreve.sh #faz a transcrição do audio
#renomeia os arquivos txt retirando o prefixo que identifica o cluster, para poder fazer a união na ordem correta
files=$(ls n_*.txt 2> /dev/null | wc -l) 
if [ **"$files" != "0"** ]; 
then
	rename 's/^n_S[0-9]*_(.*\.txt)$/$1/' *txt
else
	rename 's/^S[0-9]*_(.*\.txt)$/$1/' *txt
fi
cd ..

if [ ! -d "results" ]; then #verifica se a pasta results existe
	mkdir results	   #se não existe, cria
fi
#une os arquivos txt na pasta output do audio para formar o txt com todo o audio transcrito
cat ./output_$1/*.txt > ./results/Transcript_$1.txt
#remove arquivos gerados durante a diarização
rm $1.seg
rm $1.c.gmm
rm $1_.wav
#rm -r output_$1 #remove a pasta output com os audios separados por cluster e as transcrições de cada
echo "Transcrição na pasta results"
#nautilus results 
