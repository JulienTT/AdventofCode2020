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

BEGIN {FS=","; n=0;}
NR==2 {
    for (i=1;i<=NF;i++){
	if($i !~/x/){
	    n++;
	    num[n]=$i;
	    offset[n]=(i-1);
	}
    }
}
END{
    totalnumber=length(num);
    prod=1;
    for(i=2;i<=totalnumber;i++){
	euclid(num[1],num[i]);
	T1[i]=num[1]*(-res[2])*offset[i];
	TI[i]=num[i]*(res[3])*offset[i];
	prod=prod*num[i];
    }
    Extrema(T1,totalnumber);
    count=0;
    
    while (min<0 || min!=max){
	if((max-min)>(num[1]*num[imin]))
	    increase=int( (max-min)/(num[1]*num[imin]) ) *  num[1]*num[imin];
	else
	    increase=(num[1]*num[imin]);
	print "increase " increase;
	T1[imin]+=increase;
	TI[imin]+=increase;
	Extrema(T1,totalnumber);
	count++;
	if(count%1==0){
	    print "";
	    for(i=2;i<=totalnumber;i++){
	 	print "bus 1 ", num[1]," bus i ",num[i], " offset ",offset[i]," T1 ",T1[i]," Ti ",TI[i], " T1+offset ",T1[i]+offset[i];
	    }
	}
	
    }
    print "";
    for(i=2;i<=totalnumber;i++){
    	print "bus 1 ", num[1]," bus i ",num[i], " offset ",offset[i]," T1 ",T1[i]," Ti ",TI[i], " T1+offset ",T1[i]+offset[i];
    }
    print T1[2]+num[1];
}
	
