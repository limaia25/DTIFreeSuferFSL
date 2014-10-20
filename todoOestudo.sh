#!/bin/bash

#todoOestudo.sh estudoDir -s sujeito1 sujeito2 -d dicomImage1 dicomImage2

estudo=$1
estudoDTI=$estudo/DTIfsl
estudoDTIFreeSurfer=$estudo/DTIfslFreeSurfer
mkdir $estudoDTI
mkdir estudoDTIFreeSurfer
boolnames=0
boolDWIfiles=0
j=1
k=1
m=1

for i in $*
do
echo "eu estou $i"
	if [ "$i" != "-s" ]
	then
		if [ "$i" != "-d" ] && [ "$boolnames" -eq 1 ] 
		then
			NAMESubject[$j]="$i"
			j=$(( j + 1 ))

		elif [ "$boolDWIfiles" -eq 1 ]
		then
			DWIfiles[$k]="$i"
			k=$(( k + 1 ))
		elif [ "$i" == "-d" ]
		then
			boolnames=0
			boolDWIfiles=1
		fi
	else
		boolnames=1	
	fi

done

for l in ${NAMESubject[*]}
do
	mkdir $estudoDTI/$l
 	./scriptDTIfsl "${DWIfiles[$m]}" $estudoDTI/$l $l
	m=$(( m + 1 ))
done

./pipeline.sh $estudoDTIFreeSurfer $estudoDTI -l NAMESubject[@]
./criarLabelDTI.sh $estudoDTIFreeSurfer $estudoDTIFreeSurfer/log.txt
