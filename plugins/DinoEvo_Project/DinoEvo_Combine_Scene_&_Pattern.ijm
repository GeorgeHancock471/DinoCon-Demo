setBatchMode(true);
selectImage("Scene");
run("Select None");
run("Duplicate...", "title=Combined");
run("RGB Stack"); run("32-bit"); 

roiManager("Select",0);
Roi.getBounds(x,y,w,h);

selectImage("Pattern");
run("Duplicate...", "title=P");
run("Size...", "width=w height=h depth=1 interpolation=Bilinear");

run("RGB Stack"); run("32-bit");

for(i=0;i<3;i++){
selectImage("P"); 
roiManager("Select",2);setSlice(i+1);
 run("Copy"); setPasteMode("Multiply");
selectImage("Combined"); 
roiManager("Select",1);setSlice(i+1);
run("Paste"); run("Divide...","value=255");
}

close("P");
run("8-bit");
run("RGB Color");
