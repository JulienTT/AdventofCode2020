function ReverseCount(a,n, sum,i){
    i=n+1;
    while(a[i]-a[n]<4 && i<NR+3){
	NbPath[n] += NbPath[i];
	i++;
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
    
    NbPath[NR+2]=1;
    for(i=NR+1;i>=0;i--)
	ReverseCount(a,i);
    print NbPath[1];
}
