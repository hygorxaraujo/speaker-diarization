#!/bin/bash

if [ -z "$1" ];
then
	for f in S*.wav
	do
		normalize $f
		#parâmetros de compand otimizados para nivelar gravações faladas.
		sox $f n_$f compand 0.03,1 -90,-90,-70,-70,-60,-45,0,0 -5
	done
	rm S*.wav
else
	
	normalize $1.wav
	#parâmetros de compand otimizados para nivelar gravações faladas.
	sox $1.wav n_$1.wav compand 0.03,1 -90,-90,-70,-70,-60,-45,0,0 -5
	#rm $1.wav	
	mv n_$1.wav $1.wav
fi
