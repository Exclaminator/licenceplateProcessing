function [ mask ] = getPlateBitmask( img )
    %img = ind2rgb(image);
    imgRed = img(:,:,1);
    imgGreen = img(:,:,2);
    imgBlue = img(:,:,3);
    mask = imgRed > 160 & imgRed < 240 & imgBlue > 125 & imgBlue < 175 & imgGreen > 65 & imgGreen < 110;
end

