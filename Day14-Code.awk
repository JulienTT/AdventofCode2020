function d2b(d,  b) {
      while(d) {
          b=d%2b
          d=int(d/2)
      }
      return(b)
}

$1~/mask/{
    delete _mask;
    split($3,a,"");
    for(i=1;i<=length(a);i++)
 	if(a[i]!~/X/)
 	    _mask[i]=a[i];
}

$1~/mem/ {
    i=int(substr($1,5,length($1)-1));
    #delete mem[i];
    mem[i]=sprintf("%036d",d2b($3));
    split(mem[i],_binary,"");
    n=0;
    for(j=1;j<=36;j++){
	if (j in _mask)
	    n+=2^(36-j)*_mask[j];
	else
	    n+=2^(36-j)*_binary[j];
    }
    numb[i]=n;
}
END{
    total=0;
    for (i in numb){
	total+=numb[i];
    }
    print total;
}
