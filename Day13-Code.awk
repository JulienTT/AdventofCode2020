BEGIN {FS=","}
NR==1 {now=$1;min=2*now;id=0}
NR==2 {
    for (i=1;i<=NF;i++){
	if($i !~/x/){
	    time=$i*(int(now/$i)+1);
	    if(time<min){
		min=time;
		id=$i;
	    }
	}
    }
}
END{
    print id,min,(min-now)*id;
}
	
