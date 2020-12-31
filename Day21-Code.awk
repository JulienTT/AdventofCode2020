function Intersection(Liste1,Liste2){
    for (i in Liste1)
	if( !(i in Liste2))
	    delete Liste1[i];
    
}

BEGIN {FS="("}

{
    print NR;
    delete ingredients_loc;
    delete allergens_loc;
    
    split($1,liste," ");
    for (i in liste)
	ingredients_loc[liste[i]]==1;
    
    for (i in ingredients_loc){
	Ingredients[i] +=1;
	printf("%s\t",i);
    }
    print "";
    
    split(gensub(/(contains )|\)| /,"","g",$2),liste,",");
    for (i in liste)
	allergens_loc[liste[i]]==1;
    for (i in allergens_loc)
     	printf("%s\t",i);
    print "";
    
    for (j in allergens_loc)
	if(j in Allergens)
	    Intersection(Allergens[j],ingredients_loc);
	else
	    for (i in ingredients_loc)
		Allergens[j][i]=1;

    for (j in Allergens){
	print "Allergen " j;
	for (i in Allergens[j])
	    printf("%s ", i);
	print "";
    }
    print "";
    
}

END{
    for(i in Ingredients){
	bool=1;
	for (j in Allergens)
	    bool = bool * (!(i in Allergens[j]));
	if (bool){
	    Safe[i]=Ingredients[i];
	    print i;
	}
    }

    for (i in Safe){
	nb += Safe[i];
    }
    print nb;


}



