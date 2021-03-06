#!/bin/bash

#tem que ter o scriptDTIfsl executado

FreeSurferHome="/usr/local/freesurfer"
export FREESURFER_HOME=$FreeSurferHome
source $FREESURFER_HOME/SetUpFreeSurfer.sh

estudo=$1
estudoDTI=$2
#$* = -l sujeito1 sujeito2
boolLabel=0


for i in $*
do
	if [ "$i" == "-l" ]
	then
		boolLabel=1
	elif [ "$boolLabel" -eq 1 ]
	then
		subject=$i
		subjectDir=$estudo/$subject
		estudosubjectDTI=$estudoDTI/$subject
		mkdir $subjectDir
		mri_convert $SUBJECTS_DIR/mri/brain.mgz $subjectDir/brain_anat_orig.nii.gz

		flip4fsl $subjectDir/brain_anat_orig.nii.gz $subjectDir/brain_anat.nii.gz

		tkregister2 --mov $subjectDir/brain_anat_orig.nii.gz --targ $subjectDir/brain_anat.nii.gz --regheader --noedit --fslregout $subjectDir/anatorig2anat.mat --reg $subjectDir/anat2anatorig.dat

		convert_xfm -omat $subjectDir/anat2anatorig.mat -inverse $subjectDir/anatorig2anat.mat

		fsl5.0-flirt -in $estudosubjectDTI/base_brain.nii.gz -ref $subjectDir/brain_anat.nii.gz -out $subjectDir/base_brain.flt.nii.gz -omat $subjectDir/diff2anat.flt.mat -cost corratio

		convert_xfm -omat $subjectDir/diff2anat.flt.mat -inverse $subjectDir/anat2diff.flt.mat

		mri_convert $SUBJECTS_DIR/aparc+aseg.mgz $subjectDir/aparc+aseg.nii.gz 

		fsl5.0-fslmaths $subjectDir/aparc+aseg.nii.gz -dilM -bin $subjectDir/aparc+aseg_mask.nii.gz

		flip4fsl $subjectDir/aparc+aseg.nii.gz $subjectDir/aparc+aseg.nii.gz

		fsl5.0-flirt -in $subjectDir/aparc+aseg.nii.gz -ref $estudosubjectDTI/lowb.nii.gz -out $subjectDir/aparc+aseg.flt.nii.gz -applyxfm -init $subjectDir/anat2diff.flt.mat -interp nearestneighbour

		mri_convert $SUBJECTS_DIR/wmparc.mgz $subjectDir/wmparc.nii.gz 

		fsl5.0-fslmaths $subjectDir/wmparc.nii.gz -dilM -bin $subjectDir/wmparc_mask.nii.gz

		flip4fsl $subjectDir/wmparc.nii.gz $subjectDir/wmparc.nii.gz

		fsl5.0-flirt -in $subjectDir/wmparc.nii.gz -ref $estudosubjectDTI/lowb.nii.gz -out $subjectDir/wmparc.flt.nii.gz -applyxfm -init $subjectDir/anat2diff.flt.mat -interp nearestneighbour
	fi
done
