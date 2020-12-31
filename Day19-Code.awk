function replacement(rule,nb, local_str,i,_character){
    local_str="";
    for (i=1;i<=length(rule[nb]);i++){
	if(rule[nb][i]~/^[\|ab]/){
	    #print "in |ab"
	    local_str=local_str rule[nb][i];
	}
	else{
	    #print "else "
	    local_str=local_str "(" replacement(rule,rule[nb][i]) ")";
	}
	#print local_str;
	
    }
    return local_str;
}

BEGIN{FS=":";debut=1000}

NF>1 {
    #rule[$1]=gensub("\"","","g",$2);
    split(gensub("\"","","g",$2),a," ");
    for(i=1;i<=length(a);i++){
	rule[$1][i]=a[i]
    }
}

NF==0{
    debut=NR;
    final_rule="^"replacement(rule,0)"$"
    print final_rule;
}

NR>debut{
    if($1~final_rule){
	print $1,"match"
	nbmatch++;
    }
    else
	print $1,"does not match"
}
END{print nbmatch}

