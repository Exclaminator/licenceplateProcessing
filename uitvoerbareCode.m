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
dip_image(IM2) 

connectivity=bwconncomp(IM2);
numPixels=cellfun(@numel,connectivity.PixelIdxList);

%Je haalt het eerste object weg als deze (bijvoorbeeld) groter is dan 150.
%Dit moet een getal zijn dat altijd groter is dan de letters. Het verschil
%zou groot genoeg moeten zijn om ook een kleine buitenrand weg te halen.  
if numPixels(1) > 150
    IM2(connectivity.PixelIdxList{1})=0;
end

label=bwlabel(IM2); %bwlabeln(IM2) kan ook hier. 
dip_image(label) %linear stretch toepassen