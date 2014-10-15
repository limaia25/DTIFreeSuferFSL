study="/usr/local/Estudos/EstudoRosana/tbss/tbssControloVsClinico/RD"

for i in $*; do
cp -f $i/*_RD.nii.gz -t $study

done

rename -f 's/dti_RD.nii.gz/.nii.gz/g' $study/*.nii.gz
