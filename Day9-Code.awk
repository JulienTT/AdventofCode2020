#For any line i, this creates the sum of n_i and n_{i+j} with 1<= j <= nb-1
function _make_sum(nb ,i,j){
    for(i=1;i<NR-1;i++){
	for(j=1;j<=nb;j++)
	    if(i+j<=NR)
		Sum[(i-1)*nb+j]=Nb[i]+Nb[i+j];
    }
}

#check if the number `n' at line `line' is NOT the sum of two of the `nb' preceding numbers
#return 1 in such a case
function _test_sum(n,line,nb ,bool,i,j){
    #bool remains 0 until n is found by summing two numbers within the nb lines preceding `line'
    bool=0;
    for(i=line-nb;i<line-1;i++)
	for(j=i+1;j<line;j++){
	    #The sum of n_i and n_j is at (i-1)*nb+j-i
	    if(Sum[(i-1)*nb+j-i]==n){
		bool=1;
		break;
	    }
	}
    return bool;
}

function _try(_index, sum,j){
    sum=Nb[_index];
    j=_index;
    while(sum<weakness){
	j++;
	sum+=Nb[j];
    }
    if(sum==weakness){
	notfound=0;
	return j;
    }
    else return 0;
}

{
    Nb[NR]=$1
}

END{
    #number of successive items to consider
    number=25;
    #construct the array of n_i+n_j
    _make_sum(number);

    #test numbers until one is NOT the sum of one of two preceeding number among `number'
    for(i=number+1;i<=NR;i++){
	if(_test_sum(Nb[i],i,number)==0){
	    weakness=Nb[i];
	    break;
	}
    }
    #weakness is the guilty value
    print weakness;
    
    #boolean = 1 as long as a sequence summing up to weakness is not found
    notfound=1;

    #beginning of sequence to be tried
    _index=0;

    while(notfound){
	_index++;
	#try a sequence starting at index. Returns the last items of the successful sequence when found
	last=_try(_index);
    }
    min=Nb[_index];
    max=Nb[_index];
    for(i=_index+1;i<=last;i++){
	min=( (Nb[i]<min) ? (Nb[i]) : min );
	max=( (Nb[i]>max) ? (Nb[i]) : max );
    }
    print min+max;
    
}
