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

    while( (length(Deck[1])<length(Deck[2])?(length(Deck[1])):(length(Deck[2])))>0 ){
	draw_card();
	print"Deck1", Deck[1];
	print "length Deck1", length(Deck[1]);
	print "";
	print"Deck2", Deck[2];
	print "length Deck2", length(Deck[2]);
    }

    if(length(Deck[1])<length(Deck[2])){
	split(Deck[2],a,"-");
	for (i=1;i<=length(a);i++)
	    n += a[length(a)-i+1]*i;
    }
    else{
	split(Deck[1],a,"-");
	for (i=1;i<=length(a);i++)
	    n += a[length(a)-i+1]*i;
    }
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
