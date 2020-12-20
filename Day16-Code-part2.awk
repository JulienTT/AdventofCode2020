function test(field,nb){
    return ( (my_rule[nb][1]<=field && field<=my_rule[nb][2]) || (my_rule[nb][3]<=field && field<=my_rule[nb][4]) )
}

function find_length(ell,rule_pos, kk){
    for(kk=1; kk<nbrule+1;kk++){
	if(length(rule_pos[kk])==ell){
	    return kk;
	}
    }
}

BEGIN{
    FS=":";
    rule=1;
    your_ticket=0;
    nearby_ticket=0;
    nb_nearby_tickets;
    nb_invalid_tickets;
    scanning_error_rate=0;
    total_rule=20;
}

{
    if($0~/[0-9]/ && rule==1){
	nbrule++;
	rule_name[nbrule]=$1;
	local_rule=$0;
	gsub(/.*:/,"",local_rule);
	gsub(/ or /,"-",local_rule);
	split(local_rule,a,"-");
	for(i=1;i<5;i++){
	    my_rule[nbrule][i]=int(a[i]);
	}
    }
    
    if(your_ticket==1 && NF>1){
	split($0,MyTicket,",");
	your_ticket=0;
    }
    
    if(nearby_ticket==1 && $0~/[0-9]/){
	invalid=0;
	#test each field but only proceed if field was valid
	for(i=1;(i<NF+1)&&(invalid==0);i++){
	    invalid=1;
	    #test each rule until valid one is found
	    for(rule_nb=1;( (rule_nb<nbrule+1) && invalid==1);rule_nb++){
		#test return 1 if field is valid for rule rule_nb
		invalid=1-test($i,rule_nb);
	    }
	}
	#if all field are valid, so is the ticket. Then restrict the position of each rule
	if(invalid==0){
	    for(rule_nb=1;rule_nb<nbrule+1;rule_nb++)
		for(i=1;(i<NF+1);i++)
		    if (test($i,rule_nb)==0)
			delete rule_pos[rule_nb][i];
	}

    }
    
    if($0~/your ticket/){
	FS=",";
	your_ticket=1;
	rule=0;
    }

    if($0~/nearby tickets/){
	nearby_ticket=1;
	your_ticket=0;
	for(j=1;j<=nbrule;j++){
	    for(k=1;k<=total_rule;k++)
		rule_pos[j][k]=1;
	}
    }
}

END{
    
    for(ell=1;ell<=nbrule;ell++){
	k=find_length(ell,rule_pos);
	for(m=1;m<ell;m++)
	    delete rule_pos[k][Pos[m]];
	for (j in rule_pos[k]){
	    Pos[ell]=j;
	}
	Name[ell]=rule_name[k];
    }

    value=1;
    for(ell=1;(ell<=nbrule);ell++){
	printf("Rule %s field %d\n",Name[ell],Pos[ell]);
	if(index(Name[ell],"departure")>0)
	    value = value * MyTicket[Pos[ell]];
    }
    print "value " value;
}
