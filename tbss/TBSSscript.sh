#!/bin/bash

pastaEstudo=$1
pastaSujeitos=$2

#for i in $pastaSujeitos/*; do
	#for j in $i/*_FA.nii.gz; do
		#cp $j $pastaEstudo/$(basename $i).nii.gz


for i in $pastaSujeitos/*_FA.nii.gz; do
cp $i -t $pastaEstudo/
rename -f 's/dti_FA.nii.gz/.nii.gz/g' $pastaEstudo/*.nii.gz
#done
done

cd $pastaEstudo
fsl5.0-tbss_1_preproc *.nii.gz
fsl5.0-tbss_2_reg -n
fsl5.0-tbss_3_postreg -S
fsl5.0-tbss_4_prestats 0.2


#fsl5.0-randomise -i all_FA_skeletonised -o tbss -m mean_FA_skeleton_mask -d design.mat -t design.con -n 500 --T2 -V




