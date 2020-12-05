#!/bin/bash

#input file
input=$1

#number of valid passwords initialized to zero
nbvalid=0


#contains the fields a passport should contain
Pass="byr-iyr-eyr-hgt-hcl-ecl-pid-cid"

#awk command write on a line
#sed command remove cid
#awk command only retain passports with seven fields
awk 'NF>=1 {printf("%s ",$0)} NF==0 {print}' $input  | sed -e 's/cid:[^ ]*[ \t]/ /; s/cid:[^ ]*$//' | awk 'NF==7' > temp2

#add newline character if missing from last line
tail -c1 < temp2 | read -r _  || echo >> temp2

#read passports one by one and store each field in f1-f7

while read f1 f2 f3 f4 f5 f6 f7;
do
    #initialize temp3 with passwords
    NbGood=0

    #Parse each field
    for field in $f1 $f2 $f3 $f4 $f5 $f6 $f7;
    do
	result=$(echo $field | gawk '
	BEGIN{FS=":"}
	$1~/^byr$/ {if($2~/[0-9]{4}/ && ($2>=1920) && ($2<=2002)) {print 1}; exit 1} 
	$1~/^iyr$/ {if($2~/[0-9]{4}/ && ($2>=2010) && ($2<=2020)) {print 1}; exit 1}
	$1~/^eyr$/ {if($2~/[0-9]{4}/ && ($2>=2020) && ($2<=2030)) {print 1}; exit 1}
	$1~/^hgt$/ {
		    if($2~/^[0-9]+cm$/) {H=substr($2,1,length($2)-2); if(H>=150 && H<=193) {print 1}};
		    if($2~/^[0-9]+in$/) {H=substr($2,1,length($2)-2); if(H>=59 && H<=76) {print 1}};
 		    exit 1
		   }
	$1~/^hcl$/ {if($2~/^#[0-9a-f]{6}$/) {print 1}; exit 1}
	$1~/^ecl$/ {if ($2~/^amb$/ || $2~/^blu$/ || $2~/^brn$/ || $2~/^gry$/ || $2~/^grn$/ || $2~/^hzl$/ || $2~/^oth$/ ) {print 1}; exit 1}
	$1~/^pid$/ {if($2~/^[0-9]{9}$/) {print 1}; exit 1}
       	')
	NbGood=$(echo "$NbGood $result" | awk '{print $1+$2}')
    done
    #test the number of successes
    if [ $NbGood -eq 7 ]
    then
	nbvalid=$(($nbvalid+1))
    fi
done < temp2

echo $nbvalid

rm temp temp2 temp3
