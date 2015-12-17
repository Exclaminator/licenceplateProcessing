%Het filter dat we gaan gebruiken om de gele nummerplaat beter te kunnen
%herkennen. Rood op kanaal 1, blauw op kanaal 2 en groen op kanaal 3 met
%het masker zoals we deze met colorThresholder hebben uitgerekend. (Moet
%nog worden aangepast!)
function [ mask ] = getPlateBitmask( img )
    %img = ind2rgb(image);
    imgRed = img(:,:,1);
    imgGreen = img(:,:,2);
    imgBlue = img(:,:,3);
    mask = imgRed > 160 & imgRed < 230 & imgBlue > 60 & imgBlue < 130 & imgGreen > 125 & imgGreen < 205;
end

