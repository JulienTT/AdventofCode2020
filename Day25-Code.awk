function one_step(n,subject_number){
    return (n*subject_number)%20201227;
}

{
    key[NR]=$1;
    print "key ",NR,key[NR];
}

END{
    bool1=0;
    bool2=0;
    n=7;
    loop_size=1;
    subject_number=7;
    
    while(bool1==0||bool2==0){
	loop_size++;
	n=one_step(n,subject_number);
	#print loop_size,n;
	if(n==key[1]){
	    bool1=1;
	    loop_size1=loop_size;
	}
	else if(n==key[2]){
	    bool2=1;
	    loop_size2=loop_size;
	}
    }
    print loop_size1,loop_size2;

    if(loop_size1<loop_size2){
	subject_number=key[2];
	loop_size=loop_size1;
    }
    else{
	subject_number=key[1];
	loop_size=loop_size2;
    }
    n=1;
    for(i=1;i<=loop_size;i++){
	n=(n*subject_number)%20201227;
	#print i,n;
    }
    print n;
	
}
