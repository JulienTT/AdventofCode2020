#Convert the decimal number d into binary
function d2b(d,  b) {
      while(d) {
          b=d%2b
          d=int(d/2)
      }
      return(b)
}


$1~/mask/{
    #Store the positions of X
    delete _maskx;
    #Store the positions of 1
    delete _mask1;
    
    split($3,a,"");
    for(i=1;i<=length(a);i++){
 	if(a[i]~/X/){
 	    _maskx[""i]="X";
	}
	else if(a[i]~/1/){
	    _mask1[i]=1;
	}
    }
}

$1~/mem/ {
    # Store the value
    _value=$3;
    
    # Read memory as a string
    i=int(substr($1,5,length($1)-1));
    # convert in binary
    i_bin=sprintf("%036d",d2b(i));
    #split it in an array
    split(i_bin,mem,"");

    #when mask[i]==1, write a 1 at the good position
    for (i in _mask1)
	mem[i]=1;

    #temp contains the memory without the X
    temp=0;
    #when mask[i]==0, add the corresponding power of 2.
    for (j=1;j<=36;j++){
	if ( !(j  in _maskx) )
	    temp += 2^(36-j)*mem[j];
    }
    
    #Make the list of memories generated by _maskx
    delete _mask_mem;
    _mask_mem[1]=0;
    for (j in _maskx){
	#for each element in mask, add either 0 or 2^(good power) to
	#the elements already in _mask_memories
	_length=length(_mask_mem);
	for(k=1;k<=_length;k++){
	    _mask_mem[_length+k]=_mask_mem[k]+2^(36-j);
	}
    }

    #Write values at all memory places obtained by summing temp with
    #an element induced by the mask
    for(k=1;k<=_length;k++){
	_memory[temp+_mask_mem[k]]=_value;
    }
}

END{
    _value=0;
    for (i in _memory)
	_value+=_memory[i];
    print "Final result ", _value;
	
}