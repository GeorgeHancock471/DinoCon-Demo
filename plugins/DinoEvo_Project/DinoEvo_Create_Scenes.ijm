D = getDirectory("Scenes");
F = getFileList(D);

S = newArray();
for(f=0; f<F.length;f++){
if(endsWith(F[f],"dino.png")) S=Array.concat(S,F[f]);
}


while(roiManager("count")>0){ roiManager("select",0); roiManager("delete"); }
setBatchMode(true);
close("*");

for(s=0;s<S.length;s++){


	sn = split(S[s],"_");
	sn = sn[0];

	if(!File.exists(D+sn+"_scene.tif")){
	
	open(D+sn+"_dino.png");
	rename("dino");
	run("Lab Stack");
	setSlice(2);
	
	
	setBatchMode("show");
	setTool("rectangle");
	waitForUser("Draw a rectangle around the dinosaur");
	roiManager("add");
	
	

	
	open(D+sn+"_dinofol.png");
	rename("dinofol");
	run("Duplicate...", "title=mask");
	run("Lab Stack"); 
	
	open(D+sn+"_fol.png");
	rename("fol");
	run("Lab Stack");
	setSlice(2); run("Copy"); setPasteMode("Subtract");
	close();
	setSlice(2);
	run("Paste");
	roiManager("select",0);
	run("Make Inverse");
	run("Set...","value=0");
	run("Make Inverse");
	setThreshold(10,100);
	run("Create Selection");
	run("Set...","value=255");
	run("Make Inverse");
	run("Set...","value=0");
	run("Select None");
	setBatchMode("show");
	setForegroundColor(255, 255, 255);
	waitForUser("Fill Noise");
	setThreshold(255,255);
	run("Create Selection");
	roiManager("Add");

	selectImage("dinofol");
	run("From ROI Manager");
	saveAs("Tiff", D+sn+"_scene.tif");

	
	}//if

setPasteMode("Copy");

}//scenes
