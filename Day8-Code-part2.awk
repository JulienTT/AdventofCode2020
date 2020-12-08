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
	words[n]=NR;
	n++;
    }
}

# test if switching the command at line `line' solves the code
##
# acc and i are local variables code
function _test_bug(line, acc, i){
    acc=0;
    i=1;
    # run all lines before NR which have not been run before
    while(code[3*i+2]==0 && i<=NR){
	code[3*i+2]=1;
	
	if (code[3*i]~/^acc$/) {acc += (code[3*i+1]); i++;}
	#if a jump is at line `line' switch for a nop
	else if (code[3*i]~/^jmp$/){
	    if(i!=line)
		i += (code[3*i+1]);
	    else
		i++;
	}
	#if a nop is at line `line' switch for a jmp
	else if (code[3*i]~/^nop$/){
	    if(i!=line)
		i++;
	    else
		i += (code[3*i+1]);
	}
	else{
	    print "problem";
	    exit 666;
	}
    }
    #if code succesful, give output
    if(i>NR){
	print acc;
	exit 1
    }
}

#Set the code lines back to unread
function _reset(code, i){
    for (i=1;i<=NR;i++)
	code[3*i+2]=0;
}

BEGIN{
    n=1;
}

{
    #read lines
    _read(NR);
    #find words to be replaced
    _locate_words();
}

END{
    #Try all switch until the good one is found
    for(i=1;i<=n;i++){
	_test_bug(words[i])
	_reset(code)
    }
}

