%Uitvoerbare code

a= readim('frame1.png');
img=dip_array(a);
ndata=normalize(img);
bm=createMask(ndata);
corners=findCorners(bm);
deskewIm=deskewerImage(img, corners);
deskewBm=deskewerImage(bm, corners);
cornersNew=findCorners(deskewBm);
plate=cutInCorners(deskewIm, cornersNew);

binIm= im2bw(plate, 0.5);
IM2= imcomplement(binIm);
dip_image(IM2) %linear stretch toepassen
label=bwlabel(IM2);