#!/bin/bash

#input file
input=$1
#remove useless stuff
sed -e 's/ contain/,/; s/[ \.0-9]//g;s/bags*//g' $input >temp 

awk '
#list recursively all the bags that may contain bag i and i.
function conteneur(a,i, list,j,bags){
list=i 
#if bag i is contained in other, add them and those which contain them
if(i in a){
 split(a[i],bags,"-")
 for (j=1;j<=length(bags);j++){
  list=list "-" conteneur(a,bags[j])   
 }
}

return list
}

BEGIN{FS=","}
{
 #the associative array is such that a[i] contains the list of bags that contain bag i
 for (i=2;i<=NF;i++){ 
  a[$i] = ( ($i in a) ? ($1"-"a[$i]) : $1 )}
} 
END{print conteneur(a,"shinygold")}' temp | sed 's/shinygold-//'> temp2

# remove multiple occurences and count the number of unique bags
awk '{split($1,a,"-");for(i=1;i<=length(a);i++){b[a[i]]=1}}END{print length(b)}' temp2

rm temp,temp2
