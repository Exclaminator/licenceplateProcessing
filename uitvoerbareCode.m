%Uitvoerbare code

a= readim('testData/frame1.png');
img=dip_array(a);
ndata=normalize(img);
bm=createMask(ndata);
corners=findCorners(bm);
deskewIm=deskewerImage(img, corners);
deskewBm=deskewerImage(bm, corners);
cornersNew=findCorners(deskewBm);
plate=cutInCorners(deskewIm, cornersNew);

binIm= im2bw(plate, 0.5);
IM1= imcomplement(binIm);
%De platen dezelfde size geven, dus nu zouden de pixels per letter (ongeveer) even groot moeten zijn.
IM2=imresize(IM1,[200 NaN]);
dip_image(IM2) 

connectivity=bwconncomp(IM2);
numPixels=cellfun(@numel,connectivity.PixelIdxList);

%Je haalt het eerste object weg want dit is de buitenrand. Dit kun je
%checken doordat er dan 8 elementen moeten zijn. Dit is absoluut niet een
%nette manier, het moet met propagatie uiteindelijk. Voor nu even een
%cheat.
IM2(connectivity.PixelIdxList{1})=0;
numPixels= numPixels([end-7:end]);

label=bwlabel(IM2); %bwlabeln(IM2) kan ook hier. 
dip_image(label) %linear stretch toepassen

%Alle losse objecten uit de kentenkenplaat verkregen
object1 = label ==1;
object2 = label ==2;
object3 = label ==3;
object4 = label ==4;
object5 = label ==5;
object6 = label ==6;
object7 = label ==7;
object8 = label ==8;

numberOfTruePixels = sum(object1(:));

%Finding the edges of the lettres
edges=edge(IM2, 'sobel');  



