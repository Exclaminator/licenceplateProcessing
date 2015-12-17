%Het normalizen van een image (img). Met I wordt de intensiteit uitgerekend en
%daarna wordt deze genormaliseerd op de drie kanalen. Moet het kanaal van
%groen en blauw niet andersom?
function [ normalized ] = normalize( img )
    I = double(sum(img, 3));
    normRed=double(img(:,:,1))./I;
    normGreen=double(img(:,:,3))./I;
    normBlue=double(img(:,:,2))./I;
    
    normalized = cat(3, normRed, normGreen,normBlue);
   
end

