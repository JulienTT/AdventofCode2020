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
    x=1000;
    y=1000;
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
    Nday=100;
    
    for(i=1;i<=Nday;i++){
	print "Day ",i;
	#print "Tiles"
	#print_tiles();
	#nb_black();
	FindMinMax();
	delete Tile_next;
	for (x=xmin-10;x<=xmax+10;x++)
	    for (y=ymin-10;y<=ymax+10;y++){
		Update(x,y);
	    }
	
	for (x in Tile_next)
	    for (y in Tile_next[x]){
		Tile[x][y]=Tile_next[x][y];
		#print x,y,Tile[x][y],nb,Tile_next[x][y];
	    }
	
	nb_black();
    }
}

function print_tiles( x,y){
    FindMinMax();
    print "x from ",xmin-3," to ",xmax+3;
    for (y=ymax+3;y>=ymin-3;y--){
	for(k=0;k<(y-ymin+3);k++)
	    printf(" ");
	for (x=xmin-3;x<=xmax+3;x++){
	    printf("%d ",Tile[x][y]);
	}
	printf(" y=%d\n",y);
    }
}


function nb_black(x,y){
    nb=0;
    for (x in Tile)
	for (y in Tile[x])
	    nb+= Tile[x][y];
    print "Nb of black tiles ",nb;
}

function Update(x,y, nb){
    
    nb=neighb(x,y);
    
    if(Tile[x][y]==1){
	if(nb==0||nb>2)
	    Tile_next[x][y]=0;
    }
    else if(Tile[x][y]==0){
	if(nb==2)
	    Tile_next[x][y]=1;
    }
}


function neighb(x,y, nb){
    nb=0;
    #east
    nb += Tile[x+1][y]==1;
    #west
    nb += Tile[x-1][y]==1;
    #n-e
    nb += Tile[x][y+1]==1;
    #n-w
    nb += Tile[x-1][y+1]==1;
    #s-w
    nb += Tile[x][y-1]==1;
    #s-e
    return nb + (Tile[x+1][y-1]==1);
}

function FindMinMax( x,y){
    xmin=1000000;
    xmax=-1000000;
    ymin=1000000;
    ymax=-1000000;
    
    for (x in Tile)
	for (y in Tile[x])
	    if(Tile[x][y]==1){
		xmin = x<xmin?x:xmin;
		xmax = x>xmax?x:xmax;
		ymin = y<ymin?y:ymin;
		ymax = y>ymax?y:ymax;
		#print "x ",x,xmin,xmax;
		#print "y ",y,ymin,ymax;
				
	    }
    #print "xmin ",xmin, " xmax ", xmax;
    #print "ymin ",ymin, " ymax ", ymax;
}
