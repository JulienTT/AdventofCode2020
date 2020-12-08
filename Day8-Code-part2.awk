# read line n and store command/value/nb of times command has been run
# code is a GLOBAL variable
function _read(n){
code[3*n]=$1;
code[3*n+1]=int($2);
code[3*n+2]=0;
}

# store line numbers containing jmp or nop
# word and n are GLOBAL variables
function _locate_words(){
 if($1~/nop|jmp/){
  word[n]=NR
  n++
 }
}

# test if switch the command at line line solves the code
# acc and i are local variables
# code
function _test_bug(line, acc, i){
    acc=0;
    i=1;
    while(code[3*i+2]==0 && i<=NR){
	code[3*i+2]=1;
	
	if (code[3*i]~/^acc$/) {acc += (code[3*i+1]); i++;}
	else if (code[3*i]~/^jmp$/){
	    if(i!=line)
		i+= (code[3*i+1])
	}
	else {
	    if(i==line)
		i+= (code[3*i+1])
	    else
		i++
	}
    }
    if(i>NR){
	return acc;
	exit 1
    }
}

function _reset(code, i){
    for (i=1;i<=NR;i++)
	code[3*i+2]=0;
}

{
_read(NR);
_locate_words();
}

END{
    for(i=1;i<=n;i++){
	_test_bug(words[i])
	_reset(code)
    }
}

