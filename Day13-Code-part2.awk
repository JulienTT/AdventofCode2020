function eucl(r,u,v,rp,up,vp, q){
    if (rp==0){
	res[1]=r;
	res[2]=u;
	res[3]=v;
    }
    else{
	q=int(r/rp);
	eucl(rp, up, vp, r - q*rp, u - q*up, v - q*vp)
    }
}

function euclid(a,b){
    res[1]=0;
    res[2]=0;
    res[3]=0;
    eucl(a, 1, 0, b, 0, 1);
}

function Extrema(T1,totalnumber, i){
    min=T1[2];
    imin=2;
    max=T1[2];
    imax=2;
    for(i=3;i<=totalnumber;i++){
	if(T1[i]<min){
	    imin=i;
	    min=T1[i];
	}
	if(T1[i]>max){
	    max=T1[i];
	    imax=i;
	}
    }
}

BEGIN {FS=","; n=0;prod[1]=1;}
NR==2 {
    for (i=1;i<=NF;i++){
	if($i !~/x/){
	    n++;
	    num[n]=$i;
	    offset[n]=(i-1);
	    if(n>1)
		prod[1]=prod[1]*num[n];
	}
    }
}
END{
    totalnumber=length(num);
    sol=0;
    for(i=2;i<=totalnumber;i++){
	prod[i]=prod[1]/num[i];
	
	euclid(num[i],prod[i]);
	sol += -res[3]*prod[i]*offset[i];
    }
    
    print "sol ",sol;
    for(i=2;i<=totalnumber;i++){
    	print " bus i ",num[i], " offset ",offset[i]," sol%num[i] ", sol%(num[i]);
    }
    while(sol>0){
	sol -= prod[1];
    }
    while(sol<0 || sol%num[1]!=0)
	sol += prod[1];
    print "sol ",sol;

}
	
