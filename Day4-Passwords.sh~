#!/bin/bash
awk '
BEGIN{ntree=0;i=1;FS = ""}
$i~/#/ {ntree++}
{
 i=i+3;
 BC=int(i/(NF+1)+.000000000001);
 i=i-BC*NF;
 print NR,$i;
}
END {print ntree}' Day3-input.txt

