#!/bin/bash
totaltree=1;
for r in 1 3 5 7; do
 nbtree=$(awk '
 BEGIN{ntree=0;i=1;FS = ""}
 $i~/#/ {ntree++}
 {
  i=i+'"$r"';
  BC=int(i/(NF+1)+.000000000001);
  i=i-BC*NF;
 }
 END {print ntree}' Day3-input.txt)
 echo $nbtree;
 totaltree=$(echo $totaltree $nbtree | awk '{print $1*$2}')
done

for r in 1; do
 nbtree=$(awk '
 BEGIN{ntree=0;i=1;FS = ""}
 {if( NR/2 - int(NR/2+.000001) >.25 )
  {
   if($i~/#/) {ntree++}
   i=i+'"$r"';
   BC=int(i/(NF+1)+.000000000001);
   i=i-BC*NF;
  }
 }
 END {print ntree}' Day3-input.txt)
 echo $nbtree;
 totaltree=$(echo $totaltree $nbtree | awk '{print $1*$2}')
done
echo $totaltree
