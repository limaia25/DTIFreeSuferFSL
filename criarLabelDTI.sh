#!/bin/bash

estudoDirectory=$1
file=$2
newStructureBool=0
startLabel=0
j=0

for subjectN in $estudoDirectory/*;
	for i in $*
		do
		subject=$subjectN/temp
		mkdir $subject
		if [ "$i" == "-l" ]
		then
		startLabel=1
		fi
		if [ "$startLabel" -eq 1] 
		then
			if [ "$i" == "-e" ] 
			then
			newStructureBool=1
			fi
			if [ "$newStructureBool" -ne 1 ] && [ "$newStructureBool" -ne 2 ]
					fsl5.0-fslmaths $subjectN/wmparc.flt.nii.gz -thr $i -uthr $i $subject'/'$i'.nii.gz'
					fsl5.0-fslmaths $subjectN/$newStructurename.nii.gz -add $subject'/'$i'.nii.gz' $subjectN/$newStructurename.nii.gz
				elif [ "$newStructureBool" -eq 2 ]
				then
					fsl5.0-fslmaths $subjectN/wmparc.flt.nii.gz -thr $i -uthr $i $subject'/'$i'.nii.gz'
					cp $subject'/'$i'.nii.gz' $subjectN/$newStructurename.nii.gz
					$newStructureBool=0				
				elif ["$newStructureBool" -eq 1 ]
				then
					newStructurename=$i
					ARRAYSTRUCTURE[$j]=$newStructurename
					j=$(( j + 1 ))
					newStructureBool=2
			fi
		fi
		
		echo $(basename $subjectN) >> $file
		echo "" >> $file

		for k in ${ARRAYSTRUCTURE[@]}

			echo $k >> $file
			echo "FA" >> $file
			fsl5.0-fslstats $subjectN/dtifit_FA.nii.gz -k $subjectN/$k.nii.gz -V -m >> $file
			echo "AD" >> $file
			fsl5.0-fslstats $subjectN/dtifit_L1.nii.gz -k $subjectN/$k.nii.gz -V -m >> $file
			echo "MD" >> $file
			fsl5.0-fslstats $subjectN/dtifit_MD.nii.gz -k $subjectN/$k.nii.gz -V -m >> $file
		done

	done
done
