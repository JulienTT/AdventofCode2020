function active_neighbour(i,j,k,l, nban){
    nban=0;
    for (ii=i-1;ii<=i+1;ii++){
	for (jj=j-1;jj<=j+1;jj++){
	    for (kk=k-1;kk<=k+1;kk++){
		for (ll=l-1;ll<=l+1;ll++){
		    if(ii!=i||jj!=j||kk!=k||ll!=l)
			nban += lattice[ii][jj][kk][ll];
		}
	    }
	}
    }
    return nban;
}


BEGIN{
    i0=999;
    j0=999;
    k0=999;
    l0=999;
    FS="";
}

{
    for(i=1;i<=NF;i++)
	lattice[i0+NR][j0+i][k0+1][l0+1]=($i~/#/)?1:0;
}

END{
    imin=i0+1;
    imax=i0+NR;

    jmin=j0+1;
    jmax=j0+NF;

    kmin=k0+1;
    kmax=k0+1;
    
    lmin=l0+1;
    lmax=l0+1;
    
    for(n=1;n<7;n++){

	for (i=imin-1;i<=imax+1;i++){
	    for (j=jmin-1;j<=jmax+1;j++){
		for (k=kmin-1;k<=kmax+1;k++){
		    for (l=lmin-1;l<=lmax+1;l++){
			nb_act=active_neighbour(i,j,k,l);
			if( (lattice[i][j][k][l]==1) && (nb_act==2||nb_act==3) )
			    _next[i][j][k][l]=1;
			else if( (lattice[i][j][k][l]==0) && (nb_act==3) )
			    _next[i][j][k][l]=1;
			else
			    _next[i][j][k][l]=0;
		    }
		}
	    }
	}
	
	for (i=imin-1;i<=imax+1;i++)
	    for (j=jmin-1;j<=jmax+1;j++)
		for (k=kmin-1;k<=kmax+1;k++){
		    for (l=lmin-1;l<=lmax+1;l++){
			lattice[i][j][k][l]=_next[i][j][k][l];
			if(lattice[i][j][k][l]==1){
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

			    if (l<lmin)
				lmin=l;
			    if (l>lmax)
				lmax=l;
			}
		    }		    
		}
    }
    
    nactive=0;
    for (i=imin;i<=imax;i++)
	for (j=jmin;j<=jmax;j++)
	    for (k=kmin;k<=kmax;k++)
		for (l=lmin;l<=lmax;l++)
		    nactive+=lattice[i][j][k][l];
    print nactive;
}
    
