function [ mask ] = getPlateBitmask( img )
    %img = ind2rgb(image);
    imgRed = img(:,:,1);
    imgBlue = img(:,:,2);
    imgGreen = img(:,:,3);
    mask = imgRed > 160 & imgRed < 240 & imgBlue > 125 & imgBlue < 175 & imgGreen > 65 & imgGreen < 110;
end

