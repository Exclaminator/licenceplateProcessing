function [ plate ] = imageToPlate( data )
    % get mask for plate location
    ndata = normalize(data);
    bm = createMask(ndata);

    % find the corners of the licence plate
    C = findCorners(bm);
    
    % deskewer image and bitmask
    DeSkIm = deskewerImage(data, C);
    DeSkBM = deskewerImage(bm, C);
    C2 = findCorners(DeSkBM);

    plate = cutInCorners(DeSkIm, C2);
end

