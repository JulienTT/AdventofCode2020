#!/bin/bash

#input file
input=$1

#Remove blank line
awk 'NF>=1 {printf("%s ",$0)} NF==0 {print}' $input |\
    sed 's/ //g' |\
    gawk 'BEGIN{FS=""}
    {for (i=1;i<=NF;i++) {a[$i]=1};nb += length(a); delete a}
    END{print nb}' 
