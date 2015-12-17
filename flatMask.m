function [ out ] = flatMask( input, mask )
    out = cat(3, input(:,:,1).*mask, input(:,:,2).*mask, input(:,:,3).*mask);
end

