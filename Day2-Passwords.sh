#!/bin/bash

file=Day2-input.txt
nbvalid=0;
sed -e 's/-/ /g; s/://;' Day2-input.txt | while read in;
do
    set -- $in;
    n1=$1;
    n2=$2;
    n3=$3;
    pass=$(echo $4|sed -e 's/[^'"$3"']//g');
    l=$(echo $pass | awk '{print length}');
    if [ $l -ge $1 ] && [ $l -le $2 ];
    then
	nbvalid=$(($nbvalid+1));
    fi
done
echo $nbvalid

