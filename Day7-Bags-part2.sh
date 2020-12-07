#!/bin/bash

#input file
input=$1
#Remove useless stuff and organise as bag,number1:bag1,number2:bag2
sed -e 's/ contain/,/; s/\([0-9].\)/\1:/g;s/[ \.]//g;s/bags*//g' $input | awk '$0!~/noother/' > temp 

awk '
#functions count recursively the number of bags contained in bag i
function contenu(a,i, number,j,bags,c,detail){
 number=0
 #if the bag i contains other bags
 if(i in a){
  #get their list
  split(a[i],bags,"-")
  #for each of them, count one plus the number of bags they contain
  for (j=1;j<=length(bags);j++){
   c=split(bags[j],detail,":")
   number += detail[1] * (1 + contenu(a,detail[2]))
  }
 }
return number
}

BEGIN{FS=","}
{
 #the associative array is such that a[i] contains the list of bags contained in bag i
 a[$1]=$2;
 for (i=3;i<=NF;i++){a[$1] = a[$1] "-" $i}
}
END{print contenu(a,"shinygold")}' temp 
