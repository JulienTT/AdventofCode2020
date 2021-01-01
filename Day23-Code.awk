BEGIN{
    L=1000000;
}

{
    split($1,a,"");
    La=length(a);
    List[a[1]][1]=L;
    List[a[1]][2]=a[2];
    
    for (i=2;i<La;i++){
	List[a[i]][1]=a[i-1];
	List[a[i]][2]=a[i+1];
    }
    List[a[La]][1]=a[La-1];
    List[a[La]][2]=La+1;

    List[La+1][1]=a[La];
    List[La+1][2]=La+2;
    
    for(j=La+2;j<L;j++){
	List[j][1]=j-1;
	List[j][2]=j+1;
    }
    List[L][1]=L-1;
    List[L][2]=a[1];
    print "Initialisation finished";
}

END{
    
    #Number of rounds
    N=10000000;
    
    #Starting label
    i=a[1];
    
    #print_list_from_current(i,L);

    for(j=1;j<=N;j++){
	#print "Round ",j;
	#print_list_from_current(i,L);
	remove_from_list(b,i);
	#print_list_from_current(i,L-3);
	dest=pick_dest(i);
	#print "dest ",dest;
	add_after_dest(dest);
	#print_list_from_current(i);
	i=Next(i);
	#print "Next ",i;
	#print "";
    }

    print List[1][2],List[List[1][2]][2],List[1][2] * List[List[1][2]][2];
    #print "Final";
    #print_final();
    
}

function print_final( j,_index){
    _index=1;
    for(j=1;j<L;j++){
	printf("%d",List[_index][2]);
	_index=List[_index][2];
    }
}

function remove_from_list(b,i){ 
    #store the labels which are being removed
    b[1]=List[i][2];
    b[2]=List[b[1]][2];
    b[3]=List[b[2]][2];

    #implement the new neighbor of i;
    List[i][2]=List[b[3]][2];
}

function pick_dest(i, j){
    j=(i-2+L)%L +1;
    while(j==b[1] || j==b[2] || j==b[3])
	j=(j-2+L)%L +1;
    return j;
}

function add_after_dest(j, neighb_of_j){
    #The next neighbor of b[3] is the current next neigbor of j
    neighb_of_j          = List[j][2];
    List[b[3]][2]        = neighb_of_j;
    List[neighb_of_j][1] = b[3];
    
    #The next neighbor of j is b[1]
    List[j][2]=b[1];
    List[b[1]][1]=j;
}

function Next(i){
    return List[i][2];
}

function print_list( i){
    for (i in List){
	print i,List[i][1],List[i][2];
    }    
}

function print_list_from_current(i,L, j,_index){
    _index=i;
    for(j=1;j<=L;j++){
	printf("%d ",_index);
	_index=List[_index][2];
    }
    print "";
}
