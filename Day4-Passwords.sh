#!/bin/bash

#input file
input=$1

#number of valid passwords initialized to zero
nbvalid=0

#temp file on which to work
cp $1 temp

#contains the fields a passport should contain
Pass="byr-iyr-eyr-hgt-hcl-ecl-pid-cid"

#awk command write on a line
#sed command remove the right hand sides of ":" until next blank space or end of line
awk 'NF>=1 {printf("%s ",$0)} NF==0 {print}' temp | sed -e 's/:[^ ]*[ \t]/ /g; s/-$//' > temp2

#add newline character if missing from last line
tail -c1 < temp2 | read -r _  || echo >> temp2


#read passports one by one
while read in;
do
    #initialize temp3 with passwords
    echo $Pass > temp3
    
    #print each word and remove its occurence from the list of needed words
    echo $in | awk '{for (i=1;i<=NF;i++) {print $i}}' | while read out;
    do
	sed -i 's/'"$out"'//' temp3
    done
    #remove the north pole word
    sed -i 's/cid//' temp3
    #if temp3 contains only -, the passport is valid
    bool=$(awk '$1~/^[-]*$/ {print 1}' temp3)
    nbvalid=$(echo "$nbvalid $bool" | awk '{print $1+$2}')
done < temp2

echo $nbvalid
#remove temp file
#rm temp temp2 temp3
