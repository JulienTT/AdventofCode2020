function Intersection(Liste1,Liste2){
    for (i in Liste1)
	if( !(i in Liste2))
	    delete Liste1[i];
    
}

BEGIN {FS="("}

{
    delete ingredients_loc;
    delete allergens_loc;
    
    split($1,liste," ");
    for (i in liste)
	ingredients_loc[liste[i]]==1;
    
    for (i in ingredients_loc){
	Ingredients[i] +=1;
	#printf("%s\t",i);
    }
    #print "";
    
    split(gensub(/(contains )|\)| /,"","g",$2),liste,",");
    for (i in liste)
	allergens_loc[liste[i]]==1;
    # for (i in allergens_loc)
    #  	printf("%s\t",i);
    # print "";
    
    for (j in allergens_loc)
	if(j in Allergens)
	    Intersection(Allergens[j],ingredients_loc);
	else
	    for (i in ingredients_loc)
		Allergens[j][i]=1;

    # for (j in Allergens){
    # 	print "Allergen " j;
    # 	for (i in Allergens[j])
    # 	    printf("%s ", i);
    # 	print "";
    # }
    # print "";
    
}

END{
    #If an ingredient is not associated to any Allergens, it is safe.
    for(i in Ingredients){
	bool=1;
	for (j in Allergens)
	    bool = bool * (!(i in Allergens[j]));
	if (bool){
	    Safe[i]=Ingredients[i];
	    #print i;
	}
    }

    #Count the number of safe ingredients
    for (i in Safe){
	nb += Safe[i];
    }
    print nb;
    
    # for (j in Allergens){
    # 	print "Allergen " j;
    # 	for (i in Allergens[j])
    # 	    printf("%s ", i);
    # 	print "";
    # }
    # print "";

    print     "Associate allergens and ingredients";
    
    ell=1;
    #Find the allergens associated to a single ingredient and remove
    #it from the list
    while(length(Allergens)>=1){
	for (i in Allergens){
	    if (length(Allergens[i])==1)
		name=i;
	}
	#The name of the allergen is stored in name
	#print name;
	for (j in Allergens[name])
	    List[name]=j;
	#The corresponding ingredient is stored in List[name]
	#Remove the ingredient from all other allergens
	for (i in Allergens)
	    delete Allergens[i][j];
	delete Allergens[name];

	# print "Round ",ell;
	# for (j in Allergens){
	#     print "Allergen " j;
	#     for (i in Allergens[j])
	# 	printf("%s ", i);
	#     print "";
	#     ell++;
	# }
	# print "";
    }
    # for (i in List)
    # 	print i,List[i];


    n=asorti(List, sorted)
    for (i=1; i<=n; i++) {
        printf("%s,",List[sorted[i]]);
}

}



