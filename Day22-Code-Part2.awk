#decks are stored as strings
function Play_game(n,deck1,deck2, i,j,a,b,new1,new2,card1,card2,winner){
    #print "Game ",n;
    #Play as long as no one has won this game
    while( (length(deck1)<length(deck2)?(length(deck1)):(length(deck2)))>0){
#Check if the decks have already been served in game[n]
	#print "";
	
	#print "deck1 ",deck1, "deck2 ",deck2;
	
	for (i in Histo1[n]){
	    #print "Histo ", a[1], a[2];
	    if(Histo1[n][i]==deck1){
		for (j in Histo2[n]){
		    if(Histo2[n][j]==deck2){
			#print "INFINITE LOOP AVOIDED"
			if(n==1)
			    finalsequence=deck1;
			delete Histo1[n];
			delete Histo2[n];
			return 1;
		    }
		}
	    }
	}
	
	#If not, add deck1 and deck2 to Histo[n]
	Histo1[n][length(Histo1[n])+1]=deck1;
	Histo2[n][length(Histo2[n])+1]=deck2;
	
	#turn decks into arrays
	split(deck1,a,"-");
	card1=a[1];
	#print "Card 1 " card1, "length of deck ",length(a);
	
	split(deck2,b,"-");
	card2=b[1];
	#print "Card 2 " card2, "length of deck ",length(b);
	
	if(n==1){
	    print "";
	    print "length of deck1 ",length(a);
	    print "length of deck2 ",length(b);
	    print "length of Historic", length(Histo1[1]);
	    print "length of Historic", length(Histo2[1]);
	    print deck1;
	    print deck2;
	}
	
	#check if recursive game must be played
	if( (length(a)>=card1+1) && (length(b)>=card2+1) ){
	    new1="";
	    new2="";
	    for(i=1;i<=card1;i++)
		new1=new1 "-" a[i+1];
	    for(i=1;i<=card2;i++)
		new2=new2 "-" b[i+1];
	    
	    gsub(/^-/,"",new1);
	    gsub(/^-/,"",new1);
	    gsub(/^-/,"",new2);
	    gsub(/^-/,"",new2);
	    Histo1[n+1][1]="";
	    Histo2[n+1][1]="";
	    winner=Play_game(n+1,new1,new2);
	    #print "Back to game ",n;
	}
	#Otherwise the largest card win
	else{
	    if (card1>card2)
		winner=1;
	    else
		winner=2;
	}
	#print "Winner ",winner;
	#Remove top of decks and give cards to winner
	delete a[1];
	delete b[1];
	if(winner==1){
	    ell=length(a);
	    a[ell+2]=card1;
	    a[ell+3]=card2;
	}
	else{
	    ell=length(b);
	    b[ell+2]=card2;
	    b[ell+3]=card1;
	}
	
	#Turn back the deck into strings (should probably starts at i=2)
	deck1="";
	deck2="";
	for (i=1;i<=length(a);i++)
	    deck1=deck1 "-" a[i];
	
	for (i=1;i<=length(b);i++)
	    deck2=deck2 "-" b[i];
	#Remove heading "-"
	gsub(/^-/,"",deck1);
	gsub(/^-/,"",deck2);
	gsub(/^-/,"",deck1);
	gsub(/^-/,"",deck2);
    }
    
    if(length(deck1)<length(deck2)){
	if(n==1)
	    finalsequence=deck2;
	delete Histo1[n];
	delete Histo2[n];
	return 2;
    }
    else{
	if(n==1)
	    finalsequence=deck1;
	delete Histo1[n];
	delete Histo2[n];
	return 1;
    }
}


$0~/Player 1/{
    name="Player1";
}

$0~/Player 2/{
    name="Player2"
}

NF==1{
    if(name~/Player1/)
	Deck[1]=Deck[1] "-" $1;
    else{
	Deck[2]=Deck[2] "-" $1;
    }

}

END{
    gsub(/^-/,"",Deck[1]);
    gsub(/^-/,"",Deck[2]);

    print"Deck1", Deck[1];
    print "";
    print"Deck2", Deck[2];

    Histo1[1][1]="";
    Histo2[1][1]="";
    Play_game(1,Deck[1],Deck[2]);
    
    split(finalsequence,a,"-");
    for (i=1;i<=length(a);i++)
	n += a[length(a)-i+1]*i;
    print n;
    
}

function draw_card(){
    split(Deck[1],a,"-");
    card1=a[1];
    print "Card 1 " card1;
    split(Deck[2],b,"-");
    card2=b[1];
    print "Card 2 " card2;
    delete a[1];
    delete b[1];
    if (card1>card2){
	ell=length(a);
	a[ell+2]=card1;
	a[ell+3]=card2;
    }
    else{
	ell=length(b);
	b[ell+2]=card2;
	b[ell+3]=card1;
    }
    
    delete Deck[1];
    delete Deck[2];    
    for (i=1;i<=length(a);i++)
	Deck[1]=Deck[1] "-" a[i];
    
    for (i=1;i<=length(b);i++)
	Deck[2]=Deck[2] "-" b[i];

    gsub(/^-/,"",Deck[1]);
    gsub(/^-/,"",Deck[2]);
    gsub(/^-/,"",Deck[1]);
    gsub(/^-/,"",Deck[2]);

    
    
}
