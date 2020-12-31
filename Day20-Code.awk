function find_right(i ,j,bool,n){
    bool=0;
    for (j in Contact[i]){
	for(n=1;n<=8;n++){
	    if(MatchRight(i,j)==1){
		bool=1;
		delete Contact[i][j];
		delete Contact[j][i];
		break;
	    }
	    else if (n==4){
		Flip(j);
	    }
	    else{
		Rotate(j);
	    }
	}
	if (bool==1)
	    return j;
    }
}

function find_below(i ,j,bool,n){
    print "Below Tile ",i;
    print_tile(i);

    bool=0;
    for (j in Contact[i]){
	#print j;		
	for(n=1;n<=8;n++){
	    #print_tile(j);
	    
	    if(MatchDown(i,j)==1){
		bool=1;
		delete Contact[i][j];
		delete Contact[j][i];
		break;
	    }
	    else if (n==4){
		Flip(j);
	    }
	    else{
		Rotate(j);
	    }
	    #print "bool " bool;
	}
	if (bool==1)
	    return j;
    }
}

function find_corner( bool,n,i,j1,j2){
    for (i in Tile)
	if(length(Contact[i])==2){
	    _first=1;
	    print "Tile ",i;
	    print_tile(i);
	    for (j in Contact[i]){
		if(_first==1){
		    print "First neighbor ",j;
		    n=0;
		    while(MatchRight(i,j)==0){
			n++;
			if(n%8!=0 && n%4==0)
			    Flip(j);
			else if(n%8==0){
			    Rotate(i);
			}
			else
			    Rotate(j);
			
		    }
		    print_tile(j);
		    _first=0;
		}
		else{
		    print "Second neighbor ",j;
		    bool=0;
		    for(n=1;n<=8;n++){
			if(MatchDown(i,j)==1){
			    bool=1;
			    break;
			}
			else if(n==4)
			    Flip(j);
			else
			    Rotate(j);
		    }
		}
	    }	    
	    if(bool==0)
		Rotate(i);
	    print "bool ",bool;
	    
	    print_tile(j);

	    
		    
	    return i;
	}
}


function print_contacts( i,j){
    for (i in Contact){
	print "Tile ",i," neighbours ", length(Contact[i]);
	print_tile(i);
	print "";
	for (j in Contact[i]){
	    print j;
	    print_tile(j);
	    print "";
	}
    }
}

function print_tile(i, j,k){
    for (j=1;j<=L;j++){
	for (k=1;k<=L;k++)
	    printf("%d ",Tile[i][j][k]);
	print "";
    }
    print "";
}

function print_tiles( i){
    for (i in Tile){
	print i;
	print_tile(i);
    }
}

function Rotate(ell, mat_temp,i,j){
    for(i=1;i<=L;i++)
	for(j=1;j<=L;j++)
	    mat_temp[i][j]=Tile[ell][L+1-j][i]
    for(i=1;i<=L;i++)
	for(j=1;j<=L;j++)
	    Tile[ell][i][j]=mat_temp[i][j]
}

function Flip(ell, i,j,_temp){
    for(i=1;i<=L;i++)
	for(j=1;j<=L/2;j++){
	    _temp=Tile[ell][i][j];
	    Tile[ell][i][j]=Tile[ell][i][L+1-j];
	    Tile[ell][i][L+1-j]=_temp;
	}
}



#Fonction a finir
#Trop d'operation inutiles
function Match(i,j){
    
    if(MatchRight(i,j)||MatchLeft(i,j)||MatchTop(i,j)||MatchDown(i,j)){
	Contact[i][j]=1;
	Contact[j][i]=1;
	return 1;
    }
    
    Rotate(j);    
    if(MatchRight(i,j)||MatchLeft(i,j)||MatchTop(i,j)||MatchDown(i,j)){
	Contact[i][j]=1;
	Contact[j][i]=1;
	return 1;
    }
    
    Rotate(j);    
    if(MatchRight(i,j)||MatchLeft(i,j)||MatchTop(i,j)||MatchDown(i,j)){
	Contact[i][j]=1;
	Contact[j][i]=1;
	return 1;
    }
    Rotate(j);    
    if(MatchRight(i,j)||MatchLeft(i,j)||MatchTop(i,j)||MatchDown(i,j)){
	Contact[i][j]=1;
	Contact[j][i]=1;
	return 1;
    }

    Flip(j)

    if(MatchRight(i,j)||MatchLeft(i,j)||MatchTop(i,j)||MatchDown(i,j)){
	Contact[i][j]=1;
	Contact[j][i]=1;
	return 1;
    }

    Rotate(j);    
    if(MatchRight(i,j)||MatchLeft(i,j)||MatchTop(i,j)||MatchDown(i,j)){
	Contact[i][j]=1;
	Contact[j][i]=1;
	return 1;
    }

    Rotate(j);    
    if(MatchRight(i,j)||MatchLeft(i,j)||MatchTop(i,j)||MatchDown(i,j)){
	Contact[i][j]=1;
	Contact[j][i]=1;
	return 1;
    }

    Rotate(j);    
    if(MatchRight(i,j)||MatchLeft(i,j)||MatchTop(i,j)||MatchDown(i,j)){
	Contact[i][j]=1;
	Contact[j][i]=1;
	return 1;
    }
    
    return 0;
}

function MatchRight(i,j, bool,n){
    bool=1;
    n=1;
    while(bool&&n<=L){
	bool= (Tile[i][n][L]==Tile[j][n][1]);
	n++;
    }
    return bool;
}

function MatchLeft(i,j){
    return MatchRight(j,i);
}

function MatchTop(i,j, bool,n){
    bool=1;
    n=1;
    while(bool&&n<=L){
	bool= (Tile[i][1][n]==Tile[j][L][n]);
	n++;
    }
    return bool;
}

function MatchDown(i,j){
    return MatchTop(j,i);
}

BEGIN{L=10;LS=12;}

$1~/Tile/{
    n=gensub(":","","g",$2);
    n_NR=NR;
    #print "Tile ",n;
}

NF==1{
    split($1,a,"");
    for(i=1;i<=length(a);i++)
	if(a[i]~/#/)
	    Tile[n][NR-n_NR][i]=1;
	else
	    Tile[n][NR-n_NR][i]=0;
}

END{
    #print_tiles();
    for(i in Tile){
     	for (j in Tile){
	    if (i<j){
		Match(i,j);
	    }
	}
    }
    #print_contacts();

    Square[1][1]=find_corner();
    print "top-left "  Square[1][1];
    print_tile(Square[1][1]);
    i=1;
    for(j=2;j<=LS;j++){
	Square[i][j]=find_right(Square[i][j-1]);
	print Square[i][j];
	print_tile(Square[i][j]);
    }
    for(i=2;i<=LS;i++){
	Square[i][1]=find_below(Square[i-1][1]);
	print Square[i][1];
	print_tile(Square[i][1]);
	
	for(j=2;j<=LS;j++)
	    Square[i][j]=find_right(Square[i][j-1]);
    }

    for(i=1;i<=LS;i++){
	for(j=1;j<=LS;j++)
	    printf("%d ", Square[i][j]);
	print "";
    }
    print Square[1][1]*Square[LS][1]*Square[1][LS]*Square[LS][LS]
}
