#!/bin/bash

input=$1
output="bug"

line=0;

while [ $output == bug ];
do
    awk '
    NR>line && $1~/nop|jmp/ {
     line=NR; 
     if($1~/nop/) {print "jmp",$2};
     if($1~/jmp/) {print "nop",$2};
     exit 1;
     }' 
    echo $output
    output=123
done;
echo $output


