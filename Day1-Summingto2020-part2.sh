#!/bin/bash

file=Day1-input.txt

awk '{n++;printf("%d\t",$1)}' $file > temp

awk '{
    for (i=1;i<=NF-2;i++){
    	for(j=i+1;j<=NF-1;j++){
		for(k=j+1;k<=NF;k++){
			print $i,$j,$k,$i+$j+$k,$i*$j*$k
	       	}		
        }
    }
}' temp > temp2

awk '$4~/^2020$/' temp2

rm temp temp2
