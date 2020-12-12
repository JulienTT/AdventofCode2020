#count numbers in a direction
function count_dir(i,j,a,k,n){
    #if target site is in the system
    if(i+k>=1 && i+k<=NR && j+n>=1 && j+n<=NF){
	pos=(i+k)*(NF+2)+j+n;
	#if there is a seat, return the occupancy
	if(pos in a){
	    return a[pos];
	}
	#otherwise, keep on going
	else
	    return count_dir(i+k,j+n,a,k,n);
    }
    #if target site is outside the system
    else{
	return 0;
    }
}

#look in all direction (\pm 1|0,\pm 1|0) BUT (0,0) to count the neighbours
function count_neighbors(i,j,a, k,n,number){
    number=0;
    for(k=-1;k<=1;k++)
	for(n=-1;n<=1;n++)
	    if( k!=0 || n!=0 )
		number += count_dir(i,j,a,k,n);
    return number;
}

#test if a seat occupancy must change
function test(i,j,a, bool,nb){
    k=i*(NF+2)+j;
    #only happens if the seat exists
    if(k in a){
	nb=count_neighbors(i,j,a);
	if( a[k]==0 && nb==0 )
	    bool=1;
	else if( a[k]==1 && nb>4 )
	    bool=1;
	else bool=0;
    }
    else bool=0;
    return bool;
}

#change occupancy
function change(i,j){
    a[i*(NF+2)+j]= ( a[i*(NF+2)+j] + 1 ) % 2;
}

BEGIN{FS=""}

{
    #free sites correspond to 0
    #empty sites correspond to 1
    #the floor correspond to empty
    
    for(j=1;j<=NF;j++){
	if($j~/L/)
	    a[NR*(NF+2)+j]=0;
	else if ($j~/#/)
	    a[NR*(NF+2)+j]=1;
    }
}

END{
    nbchange=1;
    while(nbchange>0){
	#uncomment to print boat
	# for(i=1;i<=NF;i++){
	#     for(j=1;j<=NF;j++)
	# 	if (i*(NF+2)+j in a)
	# 	    printf("%s",(a[i*(NF+2)+j]==1)?"#":"L");
	# 	else
	# 	    printf("%s",".");
	#     printf("\n");
	# }
	
	nbchange=0;
	#test if all seat must change
	for (k in a){
	    j=k%(NF+2);
	    i=(k-j)/(NF+2);
	    Bool[k]=test(i,j,a);
	}

	#apply the changes
	for (k in a){
	    j=k%(NF+2);
	    i=(k-j)/(NF+2);
	    if(Bool[k]){
		change(i,j);
		nbchange++;
	    }
	}
    }
    
    number=0;
    #count the number of occupied sites
    for (k in a)
	number += a[k];
    print number
    
}
