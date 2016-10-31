function [ out ] = removeShadowsAndSharpen( in )
    plate = dip_image(in(:,:,1));
    shadows = maxf(plate, 11, 'elliptic');
    plate = 255 + plate - shadows;
    out = plate - 4 * laplace(plate);
end

