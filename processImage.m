function [ bRed, bGreen, bOrange] = processImage( image )
    mIintensity = sum(image, 3);
    mGreen = double(image(:,:,2))./mIintensity;
    mBlue = double(image(:,:,3))./mIintensity;
    
    bmAboveL1 = mBlue > ((23/11*mGreen)-0.32);
    bmBelowL2 = mBlue < ((16/11*mGreen)-0.4);
    bmBelowL3 = mBlue < ((32/11*mGreen)-1.22);
    
    %joinchannels('RGB',image(:,:,1), image(:,:,2), image(:,:,3))
    %r = joinchannels('RGB',image(:,:,1), image(:,:,2), image(:,:,3));
    %g = joinchannels('RGB',image(:,:,1), image(:,:,2), image(:,:,3));
    %o = joinchannels('RGB',image(:,:,1), image(:,:,2), image(:,:,3));
    %r(~bmAboveL1) = 0
    %g(~(bmBelowL2&bmBelowL3)) = 0
    %o(~(bmBelowL2&(~bmBelowL3))) = 0

    sTreshhold = size(image,1)*size(image,2)/50;
    bRed = sum(sum(double(bmAboveL1))) > sTreshhold;
    bGreen = sum(sum(double(bmBelowL2&bmBelowL3))) > sTreshhold;
    bOrange = sum(sum(double(bmBelowL2&(~bmBelowL3)))) > sTreshhold;
end

