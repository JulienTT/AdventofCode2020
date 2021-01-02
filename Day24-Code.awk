# We will use a coordinate system along the hexagonal lattice such that:
# east = (1,0)
# north-east=(0,1)
# north-west=(-1,1)
# west=(-1,0)
# south-west=(0,-1)
# south-east=(1,-1)

{
    _command=gensub("ne","a","g",$1);
    _command=gensub("nw","b","g",_command);
    _command=gensub("se","c","g",_command);
    _command=gensub("sw","d","g",_command);
    
    split(_command,a,"");
    x=0;
    y=0;
    for (i=1;i<=length(a);i++){
	#printf("%s",a[i]);
	
	switch(a[i]){
	    #east
	    case "e":
		x++;
		break;
	    

	    #west
	    case "w":
		x--;
		break;

	    #north-east
	    case "a":
		y++;
		break;

	    #north-west
	    case "b":
		x--;
		y++;
		break;

	    #south-east
	    case "c":
		x++;
		y--;
		break;
	    
	    #south-west
	    case "d":
		y--;
		break;
	}
    }
    
    Tile[x][y]=1-Tile[x][y];
}

END{
    for (x in Tile)
	for (y in Tile[x])
	    nb+= Tile[x][y]
    print nb;
}


function _neighb(x,y, nb){
    #east
    nb = Tile[x+1][y];
    #west
    nb = Tile[x-1][y];
    #n-e
    nb = Tile[x][y+1];
    #n-w
    nb = Tile[x-1][y+1];
    #s-e
    nb = Tile[x][y-1];
    #s-w
    return nb + Tile[x+1][y-1];
}
    
