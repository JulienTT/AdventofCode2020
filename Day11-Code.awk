function count_neighbors(i,j,a, k,n,number,pos){
    #print "count neighbors",i,j;
    #print "length a " length(a)
    number=0;
    for(k=i-1;k<i+2;k++)
	for(n=j-1;n<j+2;n++){
	    pos=k*(NF+2)+n;
	    if( (pos in a) && (pos != (i*(NF+2)+j)) )
		number += a[pos];
	    
	}
    #print "neighbors: " number;
    return number;
}


function test(i,j,a, bool,nb){
    k=i*(NF+2)+j;
    if(k in a){
	nb=count_neighbors(i,j,a);
	if( a[k]==0 && nb==0 )
	    bool=1;
	else if( a[k]==1 && nb>3 )
	    bool=1;
	else bool=0;
    }
    else bool=0;
    #print "Change",i,j,bool;
    return bool;
}

function change(i,j){
    a[i*(NF+2)+j]= ( a[i*(NF+2)+j] + 1 ) % 2;
}

BEGIN{FS=""}

{
    #free sites correspond to 0
    #empty sites correspond to 1
    #the floor correspond to empty
    
    #left and right imaginary columns are filled with empty sites
    for(j=1;j<=NF;j++){
	if($j~/L/)
	    a[NR*(NF+2)+j]=0;
	else if ($j~/#/)
	    a[NR*(NF+2)+j]=1;
    }
}

END{
    iteration=0;
  
    nbchange=1;
    while(nbchange>0){
	for(i=1;i<=NF;i++){
	    for(j=1;j<=NF;j++)
		if (i*(NF+2)+j in a)
		    printf("%s",(a[i*(NF+2)+j]==1)?"#":"L");
		else
		    printf("%s",".");
	    printf("\n");
	}
	
	nbchange=0;
	iteration++;
	print "iteration " iteration;
	
	for (k in a){
	    j=k%(NF+2);
	    i=(k-j)/(NF+2);
	    #print "k in a:" i,j,k;
	    Bool[k]=test(i,j,a);
	}
	
	for (k in a){
	    j=k%(NF+2);
	    i=(k-j)/(NF+2);
	    #print "k in a:" i,j,k;
	    if(Bool[k]){
		change(i,j);
		nbchange++;
	    }
	}
    }
    
    number=0;
    for (k in a)
	number += a[k];
    print number
    
}
