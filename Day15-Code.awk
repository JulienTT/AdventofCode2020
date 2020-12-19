#said contain numbers which have appeared at least once before the last line

#last contains the element of the last line

#new contains the element to add at the current line

function say(last_number){
    #if last number has been met before, new number = the difference between
    #the corresponding line numbers
    if (last_number in said){ 
	return i-said[last_number];
    }
    #otherwise last=0;
    else 
	return 0;
}

BEGIN{FS=","}
NF>1{
    delete said;
    
    for(i=1;i<NF;i++){
	said[$i]=i;
    }
    
    last=$i;
    
    while(i<30000001){

	#print "Content of said";
	#for (j in said)
	#    print j,said[j];
	if(i%10000000==0)
	    print i,last;
	#printf("i=%d\t", i);
	#find new number
	#printf(", word = %d\t",last);
	new=say(last);
	#printf(", next = %d\n",new);
	#classify last number
	said[last]=i;
	#update last number
	last=new;
	
	i++
    }
    #print "Finally " last;
}
