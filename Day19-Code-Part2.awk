function replacement(rule,nb, local_str,i,_character){
    local_str="";
    switch (nb){
	case 8:{
	    print nb "=8";
	    local_str= "((" replacement(rule,42) ")+)"
	    print local_str;
	    break;
	}
	    
	case 11:{
	    print nb "=11";
	    local_str="(" "(" replacement(rule,42) ")" "(" replacement(rule,31) ")" "|" "(" replacement(rule,42) ")" "(" replacement(rule,42) ")" "(" replacement(rule,31) ")" "(" replacement(rule,31) ")"  "|"  "(" replacement(rule,42) ")" "(" replacement(rule,42) ")" "(" replacement(rule,42) ")" "(" replacement(rule,31) ")" "(" replacement(rule,31) ")" "(" replacement(rule,31) ")"  "|"    "(" replacement(rule,42) ")" "(" replacement(rule,42) ")" "(" replacement(rule,42) ")" "(" replacement(rule,42) ")" "(" replacement(rule,31) ")" "(" replacement(rule,31) ")" "(" replacement(rule,31) ")" "(" replacement(rule,31) ")"  "|"    "(" replacement(rule,42) ")" "(" replacement(rule,42) ")" "(" replacement(rule,42) ")" "(" replacement(rule,42) ")"  "(" replacement(rule,42) ")" "(" replacement(rule,31) ")" "(" replacement(rule,31) ")" "(" replacement(rule,31) ")" "(" replacement(rule,31) ")" "(" replacement(rule,31) ")" ")"
	    print local_str;
	    break;
	}


	default:{ 
	    for (i=1;i<=length(rule[nb]);i++){
		if(rule[nb][i]~/^[\|ab]/){
		    #print "in |ab"
		    local_str=local_str rule[nb][i];
		}
		else{
		    #print "else "
		    local_str=local_str "(" replacement(rule,rule[nb][i]) ")";
		}
	    }
	    #print local_str;
	}
    }
    return local_str;
}

BEGIN{FS=":";debut=1000}

NF>1 {
    split(gensub("\"","","g",$2),a," ");
    for(i=1;i<=length(a);i++){
	rule[$1][i]=a[i]
    }
}

NF==0{
    debut=NR;
    final_rule="^"replacement(rule,0)"$"
    rule_42=replacement(rule,42)
    rule_31=replacement(rule,31)

    print "rule 42 " rule_42;
    print "rule 31 " rule_31;
    print "final rule " final_rule;
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
	  


