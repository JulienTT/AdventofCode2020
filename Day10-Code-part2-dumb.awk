function Count(a,n, sum,i){
    if ( n==(NR+2) ){
	return 1;
    }
    else{
	sum=0;
	i=n+1;
	while(a[i]-a[n]<4 && i<NR+3){
	    sum += Count(a,i);
	    i++;
	}
	return sum;
    }
}

{
    a[NR]=$1
    max=($1>max)?($1):max;
}


END{
    a[NR+1]=max+3;
    a[NR+2]=0;
    asort(a);

    print Count(a,1);
}
