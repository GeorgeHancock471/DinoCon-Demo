D=getDirectory("");
F= getFileList(D);
close("*");
setBatchMode(true);

for(i=0;i<F.length;i++){
open(D+F[i]);
run("Size...", "width=2560 height=1440 depth=1 interpolation=Bilinear");
saveAs("PNG",D+F[i]);
close();
}
