function _read(n){
code[3*n]=$1;
code[3*n+1]=int($2);
code[3*n+2]=0;
}

function _locate_words(){
 if($1~/nop|jmp/){
  word[n]=NR
  n++
 }
}

{
_read(NR);
_locate_words();
}

END{
acc=0;
i=1;
while(code[3*i+2]==0 && i<=NR){
 code[3*i+2]=1;
 if (code[3*i]~/^acc$/) {acc += (code[3*i+1]); i++;}
 else if (code[3*i]~/^jmp$/) {i += (code[3*i+1])}
 else {i++}
}
if(i>NR)
 print acc;
else
 print "bug";
}
