function _eval_disordered(str2, num,n,op,a,i){
    #print "beginning of eval"
    gsub(" ","",str2);
    #print str;    
    split(str2,a,"");
    num="";
    n=0;
    op="+";
    for(i=1;i<=length(a);i+=1){
	if(a[i]~/[0-9]/)
	    num=num""a[i];
	else{
	    if(op~/+/)
		n += (num+0);
	    else if(op~/*/)
		n *= (num+0);
	    num="";
	    op=a[i];
	}
	#print i,a[i],". n = ",n;
    }
    if(op~/+/)
	n += (num+0);
    else if(op~/*/)
	n *= (num+0);
    return n;
}

function _eval_ordered(str, left, right, result){
    #print "evolordered of", str;
    if(str~/\*/){
	left =gensub(/([^*]*)\*(.*)/ , "\\1" , 1,str);
	right=gensub(/([^*]*)\*(.*)/ , "\\2" , 1,str);
	#print "splitting of " str;
	#print left;
	#print right;
	result=_eval_ordered(left) * _eval_ordered(right);
	#print "result ",result;
	return result;
    }
    else{
	#print "Standard eval of " str;
	return _eval_disordered(str);
    }
}

{
    #print $0;
    while ($0~/\(/){
	temp=gensub(/[^)]*\(([^()]*)\).*/,"\\1",1)
	#print "extracted: ",temp;
	temp=_eval_ordered(temp);
	#print "computed: ",temp;
	sub(/\(([^()]*)\)/,temp,$0);
    }
    print _eval_ordered($0);
    Sum += (_eval_ordered($0)+0);
    
}
END{print Sum;}
