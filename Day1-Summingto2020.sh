#!/bin/bash

file=Day1-input.txt

nbline=$(awk '{n++;printf("%d\t",$1)} END{print n}' $file > temp)

awk '{
for (i=1;i<NF;i++){
    for(j=i+1;j<=NF;j++){
	print $i+$j,$i*$j
	}
}
}' temp > temp2
awk '$1~/^2020$/ {print $2}' temp2

