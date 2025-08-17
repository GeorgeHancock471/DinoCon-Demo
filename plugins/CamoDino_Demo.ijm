//D = getDirectory("plugins")+"/1 CamoEvo/Populations/DinoCon_Rank_Desert/";
//run("1 Evolve Loop", "select=["+D+"] measure=[Calculator 00 DINO Rank]");

setBackgroundColor(244, 244, 244);

print(1);


setBatchMode(false);
run("ROI Manager...");
roiManager("Show None");
setBatchMode(true);

screenScales = getDirectory("plugins") + "2 CamoReq/GameModule/screenScales.txt";
screenSettings = File.openAsString(screenScales);
screenSettings = split(screenSettings, "\n");
interfaceX= parseFloat(screenSettings[0] );
interfaceY= parseFloat( screenSettings[1] );
interfaceW= parseFloat( screenSettings[2] );
interfaceH= parseFloat( screenSettings[3] );
gameARatio= parseFloat( screenSettings[4] );

interfaceHeight= 1130*1.5;
interfaceWidth= 1130*gameARatio*1.5;

      shift=1;
      ctrl=2; 
      rightButton=4;
      alt=8;
      leftButton=16;


screenScales = getDirectory("plugins") + "2 CamoReq/GameModule/screenScales.txt";
screenSettings = File.openAsString(screenScales);
screenSettings = split(screenSettings, "\n");
interfaceX= parseFloat(screenSettings[0] );
interfaceY= parseFloat( screenSettings[1] );
interfaceW= parseFloat( screenSettings[2] );
interfaceH= parseFloat( screenSettings[3] );
gameARatio= parseFloat( screenSettings[4] );

interfaceHeight= floor(1130*1.5);
interfaceWidth= floor(1130*gameARatio*1.5);

// Functions
//...........................................................
function scaleScreen() {
run("Select None");
run("Canvas Size...", "width="+interfaceWidth+" height="+interfaceHeight+" position=Center");
setBatchMode("show");
setLocation(interfaceX, interfaceY, interfaceW, interfaceH);
}


function waitForLeftClick() {
im = getTitle();
run("Select None");
setTool("arrow");
noClick=1;
while(noClick){
getCursorLoc(mouseX, mouseY, mouseZ, flag); 
if(flag&leftButton!=0){ 
 
 noClick=0;
 return newArray(mouseX,mouseY);
 
 if(!isOpen(im)){close("*"); exit}
}
wait(75);
}
}


function waitForNoClick(slice) {
run("Select None");
setTool("arrow");
Click=1;
while(Click){
setSlice(slice);
getCursorLoc(mouseX, mouseY, mouseZ, flag); 
if(flag&leftButton!=0){ 
}else{
 Click=0;
}
wait(75);
}
}



close("*");
setBatchMode(true);


DemoD = getDirectory("Plugins")+"DinoEvo_Project/Demo/";
File.openSequence(DemoD+"/Loading/");
rename("Loading");



// Step 1: Open Main Menu
//...........................................................
open(DemoD+"/Main/00.png");
scaleScreen();


open(DemoD+"/Main/01.png");
scaleScreen();
click = waitForLeftClick();
close();



// Step 2: Obtain Habitat Choice
//...........................................................
if(click[0] < getWidth()/2){
D = getDirectory("plugins")+"/1 CamoEvo/Populations/DinoCon_Rank_Coastal/";
rD = DemoD+"/Results/Forest.png";
}else {
D = getDirectory("plugins")+"/1 CamoEvo/Populations/DinoCon_Rank_Desert/";
rD = DemoD+"/Results/Desert.png";
}

aD = D+"AlgorithmSettings.txt";
pD = D+"Settings_Population.txt";




// Step 3: Run Game
//...........................................................

selectImage("Loading");
scaleScreen();




if(isOpen("Loading")){
selectImage("Loading");
 run("Animation Options...", "speed="+6);
doCommand("Start Animation");
run("Select None");
} else{
close("*"); exit
}


g=1;
while(g){

run("1 Evolve", "select=["+D+"] measure=[Calculator 00 DinoCon Game]");

open(DemoD+"/Main/03.png");
scaleScreen();

waitForNoClick(1);

click = waitForLeftClick();
g = 0;
if(click[0] < getWidth()/2) g= 1;
close();

if(g==1){

	waitForNoClick(1);
	wait(100);

	if(!isOpen("Evolving")){
	File.openSequence(DemoD+"/Evolving/");
	rename("Evolving");
	scaleScreen();
	}
	selectImage("Evolving");
	run("Animation Options...", "speed="+6);
	doCommand("Start Animation");

	//Update AlgorithmSettings
	tS = File.openAsString(aD);
	tA = split(tS,"\n");
	tA[3] = parseFloat(tA[3])+1;
	Generation=tA[3];
	dataFile = File.open(aD);
	for(i=0;i<tA.length;i++){
	print(dataFile, tA[i]);
	}
	File.close(dataFile);

	//Update PopulationSettings
	tS = File.openAsString(pD);
	tA = split(tS,"\n");
	tA[1] = "Generation ="+"\t"+Generation+"\t"+"The number of generations, will overide algorithm settings if there are none existing.";
	tS = String.join(tA);
	dataFile = File.open(pD);
	for(i=0;i<tA.length;i++){
	print(dataFile, tA[i]);
	}
	File.close(dataFile);
}


}




// Display Examples;
setBatchMode(true);
open(rD);

fD = getFileList(D);
GenPat=newArray();
Generation=-1;
for(i=0; i<fD.length;i++){
if(startsWith(fD[i],"GenPat")) Generation=Generation+1;
}


dG = D+"/GenPat_"+Generation+"/";
fG = getFileList(dG);



for(i=0;i<4;i++){
for(j=0; j<2;j++){
open(dG+fG[i*2+j]);
run("Copy"); setPasteMode("Copy");
close();
makeRectangle(1400+j*(449+50), 510+i*(154+50),449,154);
run("Paste");
}
}

open(getDirectory("Plugins")+"DinoEvo_Project/Tyrannosaurus/Mask.png");
run("Copy");
setPasteMode("Min");
close();

for(i=0;i<4;i++){
for(j=0; j<2;j++){
makeRectangle(1400+j*(449+50), 510+i*(154+50),449,154);
run("Paste");
}
}
run("Select None");
scaleScreen();
close("\\Others");





