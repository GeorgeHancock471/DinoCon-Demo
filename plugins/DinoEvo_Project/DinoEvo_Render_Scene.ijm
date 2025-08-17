close("*");
setBatchMode(true);
DD = File.openDialog("DinosaurPattern");
SD =File.openDialog("Scene");

open(SD);
rename("Scene");
run("To ROI Manager");
open(DD);
rename("Pattern");
run("DinoEvo Combine Scene & Pattern");
setBatchMode("show");