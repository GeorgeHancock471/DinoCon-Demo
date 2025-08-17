setBatchMode(true);

nA=4;
nO=8;

run("Gabor ROI Bandpass Smooth", "number_of_angles=&nA sigma=2 gamma=1 frequency=3 number_of_octaves=&nO label=Clipboard");
rename("Gab");
run("Abs", "stack");
//run("Gaussian Blur...", "sigma=5 stack");


w=getWidth();
h=getHeight();

for(A=0;A<nA;A++){

newImage("S1", "32-bit ramp", w, h, nO);
for(i=0;i<nO;i++){
selectImage("Gab");
setSlice(i*nA+1+A);
run("Copy"); setPasteMode("Copy");
selectImage("S1");
setSlice(i+1);
run("Paste");
}


for(i=0;i<nO;i++){
setSlice(i+1);
getStatistics(area,mean,min,max,dev);
//if(dev>0) run("Divide...","value=dev");

v=i+1;
run("Divide...","value=v");

}


for(i=0;i<nO-1;i++){
run("Copy"); setPasteMode("Add");
run("Delete Slice");
run("Paste");
}

n=toString("A"+A+1);
rename(n);

run("Copy");
run("Add Slice");
setPasteMode("Add");
setSlice(2);
run("Paste");


arr1=newArray(1,0,-1,0);
arr2=newArray(0,-1,0,1);

v1=arr1[A];
v2=arr2[A];

setSlice(1);
run("Multiply...","value=v2");
setSlice(2);
run("Multiply...","value=v1");

}

imageCalculator("Add stack", "A1","A2"); close("A2");
imageCalculator("Add stack", "A1","A3"); close("A3");
imageCalculator("Add stack", "A1","A4"); close("A4");


// Actual Results


rename("Anisotropy & Orientation");
setSlice(1);
run("Copy"); setPasteMode("Copy");
setSlice(2);
run("Add Slice"); run("Paste");
setSlice(1); 

run("Duplicate...", "duplicate");
run("Square","stack");

setSlice(2);
run("Copy"); setPasteMode("Add");
setSlice(3);
run("Paste");
run("Square Root","Stack");
run("Copy");
close();

setSlice(1); setPasteMode("Copy");
run("Paste");

rename("Anisotropy & Orientation");
setBatchMode("show");


run("Duplicate...", "title=[Map Temp] duplicate");

setSlice(1); getStatistics(area,mean,min,max,d1);
setSlice(2); getStatistics(area,mean,min,max,d2);
dmx=d1;
if(d2>dmx) dmx=d2;



setSlice(1); 
run("Divide...","value=dmx");
run("Multiply...","value=15");

setSlice(2); 
run("Divide...","value=dmx");
run("Multiply...","value=15");

setSlice(3); 
run("Divide...","value=dmx");
run("Multiply...","value=15");


run("CIELAB 32Bit to RGB24 smooth");
setBatchMode("show");
exit


