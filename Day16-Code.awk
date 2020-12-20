function test(field,nb){
    return ( (my_rule[nb][1]<=field && field<=my_rule[nb][2]) || (my_rule[nb][3]<=field && field<=my_rule[nb][4]) )
}

BEGIN{
    FS=":";
    rule=1;
    your_ticket=0;
    nearby_ticket=0;
    nb_nearby_tickets;
    nb_invalid_tickets;
    scanning_error_rate=0;
}

{
    if($0~/[0-9]/ && rule==1){
	nbrule++;
	local_rule=$0;
	gsub(/.*:/,"",local_rule);
	gsub(/ or /,"-",local_rule);
	split(local_rule,a,"-");
	for(i=1;i<5;i++){
	    my_rule[nbrule][i]=int(a[i]);
	}
    }
    
    if(your_ticket==1 && NF>1){
	split($0,Ticket,",");
	your_ticket=0;
    }
    
    if(nearby_ticket==1 && $0~/[0-9]/){
	#test each field
	for(i=1;(i<NF+1);i++){
	    print NR,i,$i;
	    invalid=1;
	    #test each rule until valid one is found
	    for(rule_nb=1;( (rule_nb<nbrule+1) && invalid==1);rule_nb++){
		#test return 1 if field is invalid for rule rule_nb
		invalid=1-test($i,rule_nb);
		print "rule ", rule_nb, " ", invalid;
	    }
	    if (invalid)
		scanning_error_rate += $i;
	}
	#if(valid==0)
	#    nb_invalid_tickets++;
	#nb_nearby_tickets++;
    }
    if($0~/your ticket/){
	FS=",";
	your_ticket=1;
	rule=0;
    }

    if($0~/nearby tickets/){
	nearby_ticket=1;
	your_ticket=0;
    }
}

END{
    print scanning_error_rate;
}





