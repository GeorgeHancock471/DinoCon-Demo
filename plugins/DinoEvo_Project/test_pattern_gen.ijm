
//Directories
DinoEvo = "C:/Users/Localadmin_hangeorg/Documents/CamoEvo_CNN/TENSORFLOW_CamoEvo/ImageJ - DinoEvo/plugins/DinoEvo_Project/";
Dino ="/Tyrannosaurus/";

ReactDiffusion = getDirectory("plugins") + "2 CamoReq/Patterns/Pattern3001.png";

if(!isOpen("ReactDiffusion")){
open(ReactDiffusion);
rename("ReactDiffusion");
run("32-bit");
run("Enhance Contrast...", "saturated=0.35 normalize");
}

if(isOpen("Output")) close("Output");

setBatchMode(true);


//Traits
//...............................................................................................

//Pattern Shape
pat_hed_xcd = 0.1;
pat_hed_ycd = 0.1;
pat_hed_scv = 0.1;
pat_hed_sch = 0.4;

pat_ctr_xcd = 0.1;
pat_ctr_ycd = 0.5;
pat_ctr_scv = 0.5;
pat_ctr_sch = 0.5;

pat_tal_xcd = 0.5;
pat_tal_ycd = 0.5;
pat_tal_scv = 0.5;
pat_tal_sch = 0.5;

pat_scl_thr = 0.5;


//Colouration
//##############
//Head
col_hed_lmv = 0.5;
col_hed_rgv = 0.5;
col_hed_byv= 0.5;

//Centre
col_ctr_lmv = 0.5;
col_ctr_rgv = 0.5;
col_ctr_byv= 0.5;

//Tail
col_tal_lmv = 0.5;
col_tal_rgv = 0.5;
col_tal_byv= 0.5;

//Maculation
col_mac_lmv = 0.15;
col_mac_rgv = 0.5;
col_mac_byv= 0.5;

//Shading
col_shd_lmv = 1;
col_shd_rgv = 0.5;
col_shd_byv= 0.5;

//Gradient
//##############
//Head
grd_hed_rad = 0.5;
grd_hed_ycd = 0.5;
grd_hed_sig = 0.5;
grd_hed_val = 0.5;

//Centre
grd_ctr_rad = 0.5;
grd_ctr_ycd = 0.5;
grd_ctr_sig = 0.5;
grd_ctr_val = 0.5;

//Tail
grd_tal_rad = 0.5;
grd_tal_ycd = 0.5;
grd_tal_sig = 0.5;
grd_tal_val = 0.5;

//Countershading
//##############
csd_grd_sig=0.2;
csd_grd_thr=0.4;

//Edge Enhancement
//##############
eeGB=0.5;
eePB=0.5;
eeIB=0.5;

eeGR=0.5;
eePR=0.5;
eeIR=0.5;


eeWB=0.5;
eeVB=0.5;

//Images
//...............................................................................................
if(isOpen("Pat1")) close("Pat1");


Mask = DinoEvo+Dino+"Mask.png";
if(!isOpen("Mask")){
open(Mask);
rename("Mask");
run("32-bit");
}
selectImage("Mask");
w=getWidth();
h=getHeight();

w15 = w*1.5;
h15 = h*1.5;

run("Divide...","value=255");
run("Copy"); setPasteMode("Multiply");





Curve = DinoEvo+Dino+"Curve.png";
if(!isOpen("Curve")){
open(Curve);
rename("Curve");
run("32-bit");
}
selectImage("Curve");
setThreshold(255,255);
run("Create Selection");
Roi.getContainedPoints(cx,cy);
Array.getStatistics(cy, cmin, cmax, cmean, stdDev);


while(roiManager("count")>0){
roiManager("select",0); roiManager("delete");
run("Select None");
}

if(isOpen("Shade")) close("Shade");
Shade = DinoEvo+Dino+"ShadeMap_Tyrannosaurus.tif";
open(Shade);
rename("Shade");
run("To ROI Manager");


//Adjust traits
//...............................................................................................

//Colouration
col_ctr_lmv =1+col_ctr_lmv*95;
col_ctr_rgv = -30+col_ctr_rgv*50;
col_ctr_byv = -5+col_ctr_byv*45;

col_mac_lmv =1+col_mac_lmv*95   -  col_ctr_lmv;
col_mac_rgv = -30+col_mac_rgv*50 - col_ctr_rgv;
col_mac_byv = -5+col_mac_byv*45 - col_ctr_byv;

col_shd_lmv =1+col_shd_lmv*95   -  col_ctr_lmv;
col_shd_rgv = -30+col_shd_rgv*50 - col_ctr_rgv;
col_shd_byv = -5+col_shd_byv*45 - col_ctr_byv;

col_hed_lmv =1+col_hed_lmv*95   -  col_ctr_lmv;
col_hed_rgv = -30+col_hed_rgv*50 - col_ctr_rgv;
col_hed_byv = -5+col_hed_byv*45 - col_ctr_byv;

col_tal_lmv =1+col_tal_lmv*95   -  col_ctr_lmv;
col_tal_rgv = -30+col_tal_rgv*50 - col_ctr_rgv;
col_tal_byv = -5+col_tal_byv*45 - col_ctr_byv;


//Pattern Shape
pat_hed_scv = w*(0.1+pat_hed_scv*3);
pat_hed_sch = h*(0.1+pat_hed_sch*3);
pat_hed_xcd = pat_hed_xcd*(3000-pat_hed_sch);
pat_hed_ycd = pat_hed_ycd*(3000-pat_hed_scv);

pat_ctr_scv = w*(0.1+pat_ctr_scv*3);
pat_ctr_sch = h*(0.1+pat_ctr_sch*3);
pat_ctr_xcd = pat_ctr_xcd*(3000-pat_ctr_sch);
pat_ctr_ycd = pat_ctr_ycd*(3000-pat_ctr_scv);

pat_tal_scv = w*(0.1+pat_tal_scv*3);
pat_tal_sch = h*(0.1+pat_tal_sch*3);
pat_tal_xcd = pat_tal_xcd*(3000-pat_tal_sch);
pat_tal_ycd = pat_tal_ycd*(3000-pat_tal_scv);



//Gradient
grd_hed_rad = grd_hed_rad*w/3;
grd_hed_ycd = grd_hed_ycd*h15;
grd_hed_sig = 6+grd_hed_sig *w/4;
grd_hed_val = -1+grd_hed_val *2;

grd_ctr_rad = grd_ctr_rad*w/3;
grd_ctr_ycd = grd_ctr_ycd*h15;
grd_ctr_sig = 6+grd_ctr_sig *w/4;
grd_ctr_val = -1+grd_ctr_val *2;

grd_tal_rad = grd_tal_rad*w/3;
grd_tal_ycd = grd_tal_ycd*h15;
grd_tal_sig = 6+grd_tal_sig *w/4;
grd_tal_val = -1+grd_tal_val *2;


//Create Pattern
//...............................................................................................

if(isOpen("grad_ctr")) close("grad_ctr");
if(isOpen("grad_hed")) close("grad_hed");
if(isOpen("grad_tal")) close("grad_tal");

// pat_ctr
//=============

if(isOpen("pat_ctr")) close("pat_ctr");

selectImage("ReactDiffusion");
makeRectangle(pat_ctr_xcd,pat_ctr_ycd,pat_ctr_sch,pat_ctr_scv);
run("Duplicate...", "title=pat_ctr");

run("Size...", "width=w height=h15 depth=1 interpolation=Bilinear");
//run("Paste");

// pat_hed
//===========

if(isOpen("pat_hed")) close("pat_hed");

selectImage("ReactDiffusion");
makeRectangle(pat_hed_xcd,pat_hed_ycd,pat_hed_sch,pat_hed_scv);
run("Duplicate...", "title=pat_hed");

run("Size...", "width=w height=h15 depth=1 interpolation=Bilinear");
//run("Paste");


run("Duplicate...", "title=grad_hed");
run("Select All");
run("Set...","value=0");
makeOval(-grd_hed_rad,grd_hed_ycd-grd_hed_rad,grd_hed_rad*2,grd_hed_rad*2);
run("Set...","value=1");
run("Select None");
run("Add Specified Noise...", "standard=0.2");
run("Gaussian Blur...", "sigma=&grd_hed_sig");
run("Enhance Contrast...", "saturated=0.35 normalize");
run("Add Specified Noise...", "standard=0.05");
run("Gaussian Blur...", "sigma=1");
run("Copy"); setPasteMode("Multiply");
selectImage("pat_hed");
run("Paste");
selectImage("grad_hed");
run("Multiply...","value=-1");
run("Add...","value=1");
run("Copy"); setPasteMode("Multiply");
run("Multiply...","value=-1");
run("Add...","value=1");
selectImage("pat_ctr");
run("Paste");
selectImage("pat_hed");
run("Copy"); setPasteMode("Add");
close();
selectImage("pat_ctr");
run("Paste");




// pat_tal
//=============

if(isOpen("pat_tal")) close("pat_tal");

selectImage("ReactDiffusion");
makeRectangle(pat_tal_xcd,pat_tal_ycd,pat_tal_sch,pat_tal_scv);
run("Duplicate...", "title=pat_tal");

run("Size...", "width=w height=h15 depth=1 interpolation=Bilinear");
//run("Paste");

run("Duplicate...", "title=grad_tal");
run("Select All");
run("Set...","value=0");
makeOval(w-grd_tal_rad,grd_tal_ycd-grd_tal_rad,grd_tal_rad*2,grd_tal_rad*2);
run("Set...","value=1");
run("Select None");
run("Add Specified Noise...", "standard=0.2");
run("Gaussian Blur...", "sigma=&grd_tal_sig");
run("Enhance Contrast...", "saturated=0.35 normalize");
run("Add Specified Noise...", "standard=0.05");
run("Gaussian Blur...", "sigma=1");
run("Copy"); setPasteMode("Multiply");
selectImage("pat_tal");
run("Paste");
selectImage("grad_tal");
run("Multiply...","value=-1");
run("Add...","value=1");
run("Copy"); setPasteMode("Multiply");
run("Multiply...","value=-1");
run("Add...","value=1");
selectImage("pat_ctr");
run("Paste");
selectImage("pat_tal");
run("Copy"); setPasteMode("Add");
close();
selectImage("pat_ctr");
run("Paste");



//Gradient Center
run("Select All");
run("Duplicate...", "title=Gradient");
run("Set...","value=0.5");
makeOval(w/2-grd_ctr_rad*1.5,grd_ctr_ycd-grd_ctr_rad,grd_ctr_rad*2.5,grd_ctr_rad*2);
run("Set...","value=&grd_ctr_val");
run("Select None");

run("Gaussian Blur...", "sigma=&grd_ctr_sig");
run("Enhance Contrast...", "saturated=0.35 normalize");
run("Copy"); setPasteMode("Multiply"); close();
selectImage("pat_ctr");
run("Paste");




run("Select None");
run("Gaussian Blur 3D...", "x=1.5 y=1.5 z=2");


for(i=0;i<cx.length;i++){
makeRectangle(cx[i],0,1,h15);
ty = cy[i]-cmean;
run("Translate...", "x=0 y=ty interpolation=None");
}
run("Canvas Size...", "width=w height=h position=Center zero");



run("Select None");
getStatistics(area, mean, min, max);
nBins = 100000;
getHistogram(values, counts, nBins, min, max);

count = 0;
tVal = 1;
target = area*(1-pat_scl_thr);
for(i=0; i<nBins; i++){
	count += counts[i];
	if(count >= target){
		tVal = values[i];
		i = nBins;
	}
}

tValOld=tVal;
maxOld=max;
setThreshold(tVal, max);
run("Create Selection");
roiManager("add");
run("Set...","value=255");
run("Make Inverse");
run("Set...","value=0");
run("Select None");
run("Copy to System");

rename("Patterning");


//Countershading
//...............................................................................................
if(isOpen("Countershading")) close("Countershading");

selectImage("Shade");
run("Duplicate...", "title=t");
run("32-bit");
run("Enhance Contrast...", "saturated=0.35 normalize");
setThreshold(0,csd_grd_thr);
run("Create Selection");
run("Set...","value=0.5");
run("Make Inverse");
run("Set...","value=1");
run("Select None");



G=csd_grd_sig*40;
run("Gaussian Blur...", "sigma=G");

roiManager("select",0);
v=getValue("Min");
run("Add...","value=v");
run("Add...","value=v");
run("Divide...","value=3");
run("Select None");

run("Gaussian Blur...", "sigma=5");
run("Enhance Contrast...", "saturated=0.35 normalize");
run("Multiply...","value=-1");
run("Add...","value=1");
rename("Countershading");



//Colouration
//...............................................................................................
run("Duplicate...", "title=col ignore");
run("Add Slice");run("Add Slice");

setSlice(1); run("Set...","value=col_ctr_lmv");
setSlice(2); run("Set...","value=col_ctr_rgv"); 
setSlice(3); run("Set...","value=col_ctr_byv");

selectImage("grad_tal");
run("32-bit");run("Copy");setPasteMode("Copy");
run("Add Slice"); run("Paste");
run("Add Slice"); run("Paste");
setSlice(1);run("Multiply...","value=col_tal_lmv slice");
setSlice(2); run("Multiply...","value=col_tal_rgv slice"); 
setSlice(3); run("Multiply...","value=col_tal_byv slice");



imageCalculator("Add stack", "col","grad_tal");close("grad_tal");

selectImage("grad_hed");
run("32-bit");run("Copy");setPasteMode("Copy");
run("Add Slice"); run("Paste");
run("Add Slice"); run("Paste");
setSlice(1);run("Multiply...","value=col_hed_lmv slice");
setSlice(2); run("Multiply...","value=col_hed_rgv slice"); 
setSlice(3); run("Multiply...","value=col_hed_byv slice");

imageCalculator("Add stack", "col","grad_hed");close("grad_hed");


selectImage("Countershading");
run("32-bit");run("Copy");setPasteMode("Copy");
run("Add Slice"); run("Paste");
run("Add Slice"); run("Paste");


setSlice(1);run("Multiply...","value=col_mac_lmv slice");
setSlice(2); run("Multiply...","value=col_mac_rgv slice"); 
setSlice(3); run("Multiply...","value=col_mac_byv slice");

imageCalculator("Add stack", "col","Countershading");

selectImage("Patterning");
run("32-bit");
run("Add Slice");run("Add Slice");
setSlice(1); setThreshold(255,255); run("Create Selection");
setSlice(1);run("Set...","value=col_mac_lmv");
setSlice(2); run("Set...","value=col_mac_rgv"); 
setSlice(3); run("Set...","value=col_mac_byv");



imageCalculator("Add stack", "col","Patterning");
close("Patterning");


R=random();
getStatistics(area,mean,min,max,dev);

if(dev>0.1){

eeW=0;
eeV=0;


for(EE=0;EE<2;EE++){


if(EE==0){

GR=1;
PR=1;
IR=1;

if(eeGR<0.5) GR=1-pow(1-eeGR*2,2);
if(eePR<0.5) PR=1-pow(1-eePR*2,2);
if(eeIR<0.5) IR=1-pow(1-eeIR*2,2);

}

if(EE==1){

GR=1;
PR=1;
IR=1;

if(eeGR>0.5) GR=(1-pow((eeGR-0.5)*2,2));
if(eePR>0.5) PR=(1-pow((eePR-0.5)*2,2));
if(eeIR>0.5) IR=(1-pow((eeIR-0.5)*2,2));
}



eeG=2+pow(eeGB,3)*GR*20;
eeP=eePB*PR;
eeG=eeG-eeP*eeG*0.8;
eeI=pow(eeIB*IR,1.5)*40;
eeI=eeI+eeI*(1-eeP);


eeW=0;
eeV=0;

eeW=pow(abs(eeW),1)*(3+eeG);
eeV=pow(abs(eeV),1)*(3+eeG);



selectImage("col");
setSlice(1);


//EE revised
//....................
TargetChoicePattern = "no";

run("Duplicate...", " ");
rename("EE");


setPasteMode("Copy");
//Blur
run("Gaussian Blur...", "sigma=&eeG"); 

//Bilateral
if( TargetChoicePattern == "yes"){

//Stretch Horizontal

w2= 400+eeW*2;
run("Scale...", "x=- y=- width=&w2 height=400 interpolation=Bilinear average create");

run("Copy"); 
close();
run("Paste");

} else{

//Translate Horizontal
run("Translate...", "x=&eeW y=0 interpolation=None");

if(eeW>0) makeRectangle(eeW,0,400-eeW,400);
if(eeW<0) makeRectangle(0,0,400+eeW,400);

}


//Translate Vertical
run("Duplicate...", " ");

run("Translate...", "x=0 y=&eeV interpolation=None");


if(eeV>0) makeRectangle(0,eeV,400,400-eeV);
if(eeV<0) makeRectangle(0,0,400,400+eeV);

run("Copy");
close();
run("Paste");
run("Select None");

selectImage("col");
run("Copy"); setPasteMode("Subtract");
selectImage("EE");
run("Paste");

run("Multiply...","value=-1");
dev=getValue("StdDev");

if(dev>0.001){

if(EE==0) run("Min...","value=0");
if(EE==1) run("Max...","value=0");

run("Abs");

max=getValue("Max");
run("Divide...","value=max");
setThreshold(0.0001,1); run("Create Selection");
run("Macro...", "code=v=v/(abs(v)*"+eeP+"+"+1-eeP+");");
run("Select None");

max=getValue("Max");
run("Divide...","value=max");


if(EE==1) run("Multiply...","value=-1");


run("Multiply...","value=&eeI ");

}
rename("EE_"+EE);
}


selectImage("EE_"+0);
run("Copy"); setPasteMode("Add"); 
close();
selectImage("col"); run("Paste");
selectImage("EE_"+1);
run("Copy"); setPasteMode("Add"); 
close();
selectImage("col"); run("Paste");
}


noiL1 = random();
noiSP1 = random();
noiS1 = random();
noiP1 = random();
cenreMod=0;


imageCalculator("Multiply stack", "col","Demo_Rex_Shade.tif");
run("CIELAB 32Bit to RGB24 smooth");
close("Col");

run("Copy to System");
setBatchMode("show");

exit
roiManager("select",0);
run("Make Inverse");
run("Set...","value=0");
run("Select None");

