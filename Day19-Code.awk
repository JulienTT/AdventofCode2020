#this function returns zero if the test fails or the number of
#characters to jump forward if it is successful

function test_rule(n,str,pos, bool, ell){
    #rule[n] is either "a" or 123 or 12 34
    ell=length(rule[n]);
    
    if(ell==1){
	
        #rule[n] is either "a" or 123
	if(rule[n][1]~/"/){
	    #rule[n][1] is "a"
	    #rule[n][1][2] is a
	    return str[pos-1]==rule[n][1][2];
	}
	
	else{
	    #rule[n][1] is 123
	    bool=1;
	    for(j=1;j<=length(rule[n][1]);j++){
		#rule[n][1][1] = 1
		#rule[n][1][2] = 2
		bool = bool * (apply_rule(rule[n][1][j],str,pos));
		pos++;
	    }
	}
    }
    #rule[n] is 12 34
    else{
	bool=1;
	


    }
   
    
}

function apply_rule(n,str,pos, bool, ell){
    #rule[n] is either "a" or 123 or 12 34
    ell=length(rule[n]);
    
    if(ell==1){
	
        #rule[n] is either "a" or 123
	if(rule[n][1]~/"/){
	    #rule[n][1] is "a"
	    pos++;
	    #rule[n][1][2] is a
	    return str[pos-1]==rule[n][1][2];
	}
	
	else{
	    #rule[n][1] is 123
	    bool=1;
	    for(j=1;j<=length(rule[n][1]);j++){
		#rule[n][1][1] = 1
		#rule[n][1][2] = 2
		bool = bool * (apply_rule(rule[n][1][j],str,pos));
		pos++;
	    }
	}
    }
    #rule[n] is 12 34
    else{
	bool=1;
	


    }
    
    
}


BEGIN{FS=":"}
{
    if($0~/[0-9]+/){
	rule_nb=$1;
	printf("rule %d:",rule_nb);
	split($2,rule,"|");
	gsub(" ","",$2);
	split($2,rule,"|");
	for(i=1;i<=length(rule);i++)
	    printf("%s ",rule[i]);
	print "";
    }
    
    else if(NF>=1){
	split($1,message,"");
	bool=1;
	pos=1;
	while(pos<=length(message)){
	    bool = bool * apply_rule(0,message);
	}
	print bool,$0;
    }
}

Algo:
pos est la position actuelle dans le message.

si la regle contient un pipe:
  tester les regles pour trouver la premier qui marche.
  appliquer cette regle.

sinon
  appliquer la regle.

