#!/bin/bash

#input file
input=$1

#awk:
#Non-empty lines -> print string and add space; increment number of persons in group
#Empty lines -> print number of person and get a new line
#END: do the same for last line
awk 'NF>=1 {n++;printf("%s ",$0)} NF==0 {printf("%d\n",n);n=0} END{printf("%d\n",n)}' $input |\
    #Remove spaces if followed by letter
    sed 's/ //g' > temp2
    #get the number of persons in group n
    #make an array which counts occurence of letters
    #any letter that appears n times gives +1
    gawk 'BEGIN{FS=""}
    {
    n=$NF;
    nb=0;
    for (i=1;i<=NF-1;i++) {a[$i]+=1};
    for (i in a){
    	if(a[i]==n) {nb++}
    }
    result += nb;
    delete a;
    }
    END{print result}' temp2
