function [ normalized ] = normalize( i )
    I = double(sum(i, 3));
    normalized = cat(double(i(:,:,1))./I, double(i(:,:,2))./I, double(i(:,:,3))./I);
end

