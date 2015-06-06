# DTIFreeSuferFSL

Directory that helps you to process the workflow of intermodality analysis of DTI and structural Images of FreeSurfer.

## Executing
To execute all study, use the following:

`todoOestudo.sh studyDirectory -s subject1 subject2 -d dicomImageSujeito1 dicomImageSujeito2` 
which:
* <b>studyDirectory</b> Study Directory: Where output will be put on
* <b>subject<n></b> subject name (resulting from FreeSurfer processing) 
* <b>dicomImageSubject1<n></b> first DWI Image from subject1

## 1. DTI
1. <b> DWI Converting </b> DWI converting is made throws dcm2nii tool from FSL. The DWI DICOM files are converted in NIFTI image and bvals and bvecs files was created.
2. <b>Eddy correct </b> The artifacts corrections are processed using the FSL tool eddy_correct
3. <b>bet</b> The skull extration are made by bet - fractional intensity threshold = 0.2 vertical gradient in fractional intensity threshold=0  and generate binary brain mask.
4. <b> baseline creation </b>
5. <b> DTI fit</b> DTI computing was processed using DTI_Fit 

### Output Files
All files will be on directory: `studyDirectory/DTIfsl`. For each subject directory:
* {subject}base.nii.gz
* {subject}base_brain_mask.nii.gz
* {subject}.bval
* {subject}.bvec
* {subject}dti.nii.gz
* {subject}ecDWI.nii.gz
 
## 2. FreeSurfer
On this process, all files resulting from FreeSurfer processing are co-registrated on DTI space. All the files resulting from FreeSurfer processing are flipped to FSL orientation. Using fsl5.0-flirt, the brain.mgz are co-registrated on the same space as base_DTI and the transformed file is used for the following steps.
1.Co-registration of wmparc and aparc_aseg on 

### Output Files
All Files of this processing will be on directory: `DTIfslFreeSurfer`
For each subjec:
* brain_anat_orig.nii.gz  - Converted file resulted from brain.mgz [FreeSurfer processing]
* brain_anat.nii.gz - Flipped image to fsl orientation
* anatorig2anat.mat and anat2anatorig.dat - Calculate original anatomical to flipped anatomical
* base_brain.flt.nii.gz - using flirt tool, output resulted from registration of <subject>base.nii.gz on brain_anat(reference).
* diff2anat.flt.mat - transformation file from registration
* anat2diff.flt.mat - reversed transformation file
* aparc+aseg.nii.gz  - Converted file resulted from aparc+aseg.mgz [FreeSurfer processing]
* aparc+aseg_mask.nii.gz - binarization of aparc+aseg file (used for masking) and flipped for fsl
* aparc+aseg.flt.nii.gz -using flirt tool, output resulted from registration of aparc+aseg.nii.gz on <subject>lowb image(reference) and using the anat2diff transforming file.
* wmparc.nii.gz  - Converted file resulted from wmparc.mgz [FreeSurfer processing]
* wmparc_mask.nii.gz - binarization of wmparc file (used for masking) and flipped for fsl
* wmparc.flt.nii.gz -using flirt tool, output resulted from registration of wmparc.nii.gz on <subject>lowb image(reference) and using the anat2diff transforming file.

##Computing metrics/stats of strutures
On this process, we choose the labels numbers of the strutures of each file. Some strutures are the sum of number of labels, some strutures are only the labels it self. The image are segmented into label files, using `fslmaths -thr -uthr` If the struture have more than one label numbers, the estructure resulting is the "sum" of the labels, using `fslmaths -add`. 
The stats (FA,MD and AD) are resulted from `fsl5.0-fslstats -V -m`

### Output Files
* {strutureName}.nii.gz
* file with:
   * FA name 

