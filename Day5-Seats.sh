#!/bin/bash

#input file
input=$1

#number of valid passwords initialized to zero
max=0

sed -e 's/[FL]/0/g; s/[BR]/1/g;' $input | awk 'BEGIN{max=0} {split($1,a,""); row=a[1]*64+a[2]*32+a[3]*16+a[4]*8+a[5]*4+a[6]*2+a[7];col=a[8]*4+a[9]*2+a[10]; number=row*8+col;max=(max<number)?number:max} END{print max}'
