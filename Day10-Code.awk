{
    a[NR]=$1
    max=($1>max)?($1):max;
}


END{
    a[NR+1]=max+3;
    a[NR+2]=0;
    asort(a);
    for(i=1;i<=NR+1;i++)
	histo[a[i+1]-a[i]] += 1;
    print histo[1]*histo[3]
}
