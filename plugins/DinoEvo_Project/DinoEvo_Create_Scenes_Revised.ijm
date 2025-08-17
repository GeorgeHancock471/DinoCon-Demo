D = getDirectory("Scenes");
F = getFileList(D);

S = newArray();
for(f=0; f<F.length;f++){
if(endsWith(F[f],"dino.png")) S=Array.concat(S,F[f]);
}



setBatchMode(true);
close("*");

for(s=0;s<S.length;s++){
while(roiManager("count")>0){ roiManager("select",0); roiManager("delete"); }

	sn = split(S[s],"_");
	sn = sn[0];

	if(!File.exists(D+sn+"_scene.tif")){
	
	open(D+sn+"_dino.png");
	rename("dino");
	run("RGB Stack");
	run("32-bit");
	setSlice(2); run("Multiply...","value=0.25"); run("Copy"); setPasteMode("Subtract");
	setSlice(3); run("Paste");
	
	setBatchMode("show");
	setTool("rectangle");
	waitForUser("Draw a rectangle around the dinosaur");
	run("Make Inverse");
	run("Set...","value=0");
	run("Make Inverse");
	setThreshold(47,255);
	run("Create Selection");
	roiManager("add");
	close();

	/*
	open(D+sn+"_fol.png");
	run("RGB Stack");
	setSlice(1); run("Copy"); setPasteMode("Subtract");
	setSlice(2); run("Paste");
	setSlice(3); run("Copy"); setPasteMode("Subtract");
	setSlice(2); run("Paste");
	setThreshold(-255,67);
	run("Create Selection");
	roiManager("add");
	roiManager("select", newArray(0,1));
	roiManager("AND");
	roiManager("add");
	roiManager("select", newArray(0,2));
	roiManager("XOR");
	roiManager("add");
	close();
	*/
	
	open(D+sn+"_dinofol.png");
	rename("dinofol");
	run("Duplicate...", "title=mask ignore");
	run("RGB Stack"); 
	roiManager("select",0);
	run("Make Inverse");
	run("Set...","value=0");
	run("Select None");
	setSlice(2); run("Multiply...","value=0.4"); run("Copy"); setPasteMode("Subtract");
	setSlice(3); run("Paste");

	setThreshold(64,255);
	run("Create Selection");
	roiManager("add");
	close();

	selectImage("dinofol");
	run("RGB Stack"); 
	roiManager("select",1);
	setSlice(3);
	run("Copy"); setPasteMode("Copy");
	setSlice(2); run("Paste");
	setSlice(1); run("Paste");
	setBatchMode("show");
	run("RGB Color");
	roiManager("select",1);
	roiManager("Add");
	roiManager("select",roiManager("Count")-1);
	Roi.move(0,0);
	roiManager("Update");

waitForUser("Screen");
	
	selectImage("dinofol");
	run("From ROI Manager");
	saveAs("Tiff", D+sn+"_scene.tif");

	close("*");
	}//if

setPasteMode("Copy");

}//scenes
