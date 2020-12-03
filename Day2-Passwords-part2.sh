#!/bin/bash

file=Day2-input.txt
nbvalid=0;

sed -e 's/-/ /g; s/://;' Day2-input.txt | awk '
{
 split($4,a,"");
 if( (a[$1]==$3&&a[$2]!=$3) || (a[$1]!=$3&&a[$2]==$3) ){
    nbvalid++;
 }
}
END {print nbvalid}
' 
