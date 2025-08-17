D = getDirectory("plugins")+"/1 CamoEvo/Populations/DinoCon_Rank_Coastal/";
run("1 Evolve Loop", "select=["+D+"] measure=[Calculator 00 DINO Rank]");
run("1 Combine Genes&Ranks", "population=["+D+"]");
open(D+"Data_Gene&Ranks_DinoCon_Rank_Coastal");
waitForUser("Send this file to gh471@exeter.ac.uk");
