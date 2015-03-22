estudoDirectory=$1

freeSurferHome="/usr/local/freesurfer"
export FREESURFER_HOME=$freeSurferHome
source $FREESURFER_HOME/SetUpFreeSurfer.sh
for subject in $estudoDirectory/*;
	do
		echo $subject
		mri_convert $subject/wmparc.mgz $subject/wmparco.nii.gz
		fsl5.0-fslswapdim $subject/wmparco.nii.gz x z -y $subject/wmparc.nii.gz

		fsl5.0-fslorient -forceradiological $subject/wmparc.nii.gz
		fsl5.0-flirt -in $subject/wmparc.nii.gz -ref $subject/lowb.nii.gz -out $subject/wmparc.flt.nii.gz -applyxfm -init $subject/anat2diff.flt.mat -interp nearestneighbour

	done


