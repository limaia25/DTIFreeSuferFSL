estudoDirectory=$1
file=/usr/local/Estudos/EstudoWS/estudo1/DTI_Roi/out.txt

for subjectN in $estudoDirectory/*;
	do
		subject=$subjectN/temp
		mkdir $subject
		fsl5.0-fslmaths $subjectN/wmparc.flt.nii.gz -thr 3002 -uthr 3002 $subject/um.nii.gz
		fsl5.0-fslmaths $subjectN/wmparc.flt.nii.gz -thr 4002 -uthr 4002 $subject/dois.nii.gz
		fsl5.0-fslmaths $subjectN/wmparc.flt.nii.gz -thr 3026 -uthr 3026 $subject/tres.nii.gz
		fsl5.0-fslmaths $subjectN/wmparc.flt.nii.gz -thr 4026 -uthr 4026 $subject/quatro.nii.gz
		fsl5.0-fslmaths $subjectN/wmparc.flt.nii.gz -thr 3028 -uthr 3028 $subject/cinco.nii.gz
		fsl5.0-fslmaths $subjectN/wmparc.flt.nii.gz -thr 4028 -uthr 4028 $subject/seis.nii.gz
		fsl5.0-fslmaths $subjectN/wmparc.flt.nii.gz -thr 3016 -uthr 3016 $subject/sete.nii.gz
		fsl5.0-fslmaths $subjectN/wmparc.flt.nii.gz -thr 4016 -uthr 4016 $subject/oito.nii.gz
		fsl5.0-fslmaths $subjectN/wmparc.flt.nii.gz -thr 3025 -uthr 3025 $subject/nove.nii.gz
		fsl5.0-fslmaths $subjectN/wmparc.flt.nii.gz -thr 4025 -uthr 4025 $subject/dez.nii.gz



		fsl5.0-fslmaths $subject/um.nii.gz -add $subject/dois.nii.gz $subject/temp1.nii.gz

		fsl5.0-fslmaths $subject/temp1.nii.gz -add $subject/tres.nii.gz $subject/temp2.nii.gz
		fsl5.0-fslmaths $subject/temp2.nii.gz -add $subject/quatro.nii.gz $subject/temp3.nii.gz
		fsl5.0-fslmaths $subject/temp3.nii.gz -add $subject/cinco.nii.gz $subject/temp4.nii.gz
		fsl5.0-fslmaths $subject/temp4.nii.gz -add $subject/seis.nii.gz $subject/temp5.nii.gz
		cp $subject/temp5.nii.gz $subjectN/vMPFC.nii.gz
		fsl5.0-fslmaths $subject/sete.nii.gz -add $subject/oito.nii.gz $subject/temp6.nii.gz
		cp $subject/temp6.nii.gz $subjectN/paraHipocampalG.nii.gz
		fsl5.0-fslmaths $subject/nove.nii.gz -add $subject/dez.nii.gz $subject/temp7.nii.gz
		cp $subject/temp7.nii.gz $subjectN/Precuneus.nii.gz

		
		echo $(basename $subjectN) >> $file
		echo "" >> $file
		echo "vMPFC" >> $file
		echo "FA" >> $file
		fsl5.0-fslstats $subjectN/dtifit_FA.nii.gz -k $subjectN/vMPFC.nii.gz -V -m >> $file
		echo "AD" >> $file
		fsl5.0-fslstats $subjectN/dtifit_L1.nii.gz -k $subjectN/vMPFC.nii.gz -V -m >> $file
		echo "MD" >> $file
		fsl5.0-fslstats $subjectN/dtifit_MD.nii.gz -k $subjectN/vMPFC.nii.gz -V -m >> $file

		echo "paraHipocampalG" >> $file
		echo "FA" >> $file
		fsl5.0-fslstats $subjectN/dtifit_FA.nii.gz -k $subjectN/paraHipocampalG.nii.gz -V -m >> $file
		echo "AD" >> $file
		fsl5.0-fslstats $subjectN/dtifit_L1.nii.gz -k $subjectN/paraHipocampalG.nii.gz -V -m >> $file
		echo "MD" >> $file
		fsl5.0-fslstats $subjectN/dtifit_MD.nii.gz -k $subjectN/paraHipocampalG.nii.gz -V -m >> $file
		
		echo "Precuneus" >> $file
		echo "FA" >> $file
		fsl5.0-fslstats $subjectN/dtifit_FA.nii.gz -k $subjectN/Precuneus.nii.gz -V -m >> $file
		echo "AD" >> $file
		fsl5.0-fslstats $subjectN/dtifit_L1.nii.gz -k $subjectN/Precuneus.nii.gz -V -m >> $file
		echo "MD" >> $file
		fsl5.0-fslstats $subjectN/dtifit_MD.nii.gz -k $subjectN/Precuneus.nii.gz -V -m >> $file

		

	done
