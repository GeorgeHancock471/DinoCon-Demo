run("Select None");
run("Duplicate...", "title=t");
run("32-bit");
run("Enhance Contrast...", "saturated=0.35 normalize");
setThreshold(0,random());
run("Create Selection");
run("Set...","value=0");
run("Make Inverse");
run("Set...","value=1");
run("Select None");



G=random()*40;
run("Gaussian Blur...", "sigma=G");



roiManager("select",2);
v=getValue("Min");
run("Add...","value=v");
run("Add...","value=v");
run("Divide...","value=3");
run("Select None");

run("Gaussian Blur...", "sigma=10");

exit
roiManager("select",0);
run("Make Inverse");
run("Set...","value=0");
run("Select None");
