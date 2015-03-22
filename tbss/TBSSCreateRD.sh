study="/usr/local/Estudos/EstudoRosana/tbss/tbssControloVsClinico/RD"

for i in $*; do
 for j in $i/*_L2.nii.gz; do
   for k in $i/*_L3.nii.gz; do
    name=`echo $j|sed 's/dti_L2/dti_RD/g'`
    fsl5.0-fslmaths $j -add $k -div 2 $name
    cp 	$i/*dti_RD.nii.gz $study
  done
 done
done

rename -f 's/dti_RD.nii.gz/.nii.gz/g' $study/*.nii.gz
