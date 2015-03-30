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
All files will be on directory: `studyDirectory/DTIfsl`
* <subject>base.nii.gz
* <subject>base_brain_mask.nii.gz
* <subject>.bval
* <subject>.bvec
* <subject>dti.nii.gz
* <subject>ecDWI.nii.gz
* 
## 2. FreeSurfer


### Output Files
All Files of this processing will be on directory: `DTIfslFreeSurfer`







* m
* n

1. m
2. v

##DTI
