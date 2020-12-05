#!/bin/bash

#input file
input=$1

#number of valid passwords initialized to zero
max=0

sed -e 's/[FL]/0/g; s/[BR]/1/g;' $input | awk '
BEGIN{
for(i=0;i<128;i++){
  for(j=0;j<8;j++){
   b[i*8+j]=1;
  }		
 }
}
{
 split($1,a,""); 
 row=a[1]*64+a[2]*32+a[3]*16+a[4]*8+a[5]*4+a[6]*2+a[7];
 col=a[8]*4+a[9]*2+a[10]; 
 number=row*8+col;
 b[number]=0;
} 
END{
for(i=1;i<127;i++){
  for(j=0;j<8;j++){
   number=i*8+j;
   if(b[number]==1){
    if(b[number-1]==0 && b[number+1]==0)
     print number;
   }
  }
 }
}'
