function print_lattice(){
    for (i in lattice){
	for (j in lattice[i])
	    for (k in lattice[i][j])
		printf("%d ",lattice[i][j][k]);
	print "";
    }
}

function active_neighbour(i,j,k, nban){
    nban=0;
    for (ii=i-1;ii<=i+1;ii++){
	for (jj=j-1;jj<=j+1;jj++){
	    for (kk=k-1;kk<=k+1;kk++){
		if(ii!=i||jj!=j||kk!=k)
		    nban += lattice[ii][jj][kk];
	    }
	}
    }
    return nban;
}


BEGIN{
    i0=999;
    j0=999;
    k0=999;
    FS="";
}

{
    for(i=1;i<=NF;i++)
	lattice[i0+NR][j0+i][k0+1]=($i~/#/)?1:0;
}

END{
    imin=i0+1;
    imax=i0+NR;
    jmin=j0+1;
    jmax=j0+NF;
    kmin=k0+1;
    kmax=k0+1;
    
    for(n=1;n<7;n++){

	for (i=imin-1;i<=imax+1;i++){
	    for (j=jmin-1;j<=jmax+1;j++){
		for (k=kmin-1;k<=kmax+1;k++){
		    nb_act=active_neighbour(i,j,k);
		    if( (lattice[i][j][k]==1) && (nb_act==2||nb_act==3) )
			_next[i][j][k]=1;
		    else if( (lattice[i][j][k]==0) && (nb_act==3) )
			_next[i][j][k]=1;
		    else
			_next[i][j][k]=0;
		}
	    }
	}
	
	for (i=imin-1;i<=imax+1;i++)
	    for (j=jmin-1;j<=jmax+1;j++)
		for (k=kmin-1;k<=kmax+1;k++){
		    lattice[i][j][k]=_next[i][j][k];
		    if(lattice[i][j][k]==1){
			if (i<imin)
			    imin=i;
			if (i>imax)
			    imax=i;
			
			if (j<jmin)
			    jmin=j;
			if (j>jmax)
			    jmax=j;
			
			if (k<kmin)
			    kmin=k;
			if (k>kmax)
			    kmax=k;
		    }
		}		    
    }

    nactive=0;
    for (i=imin;i<=imax;i++)
	for (j=jmin;j<=jmax;j++)
	    for (k=kmin;k<=kmax;k++)
		nactive+=lattice[i][j][k];
    print nactive;
}
    
