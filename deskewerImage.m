function [ IT ] = deskewerImage( Image, C )
    L = mean(C([1 4],1));
    R = mean(C([2 3],1));
    U = mean(C([1 2],2));
    D = mean(C([3 4],2));
    C2 = [L U; R U; R D; L D];
    T = fitgeotrans(C ,C2,'projective');
    IT = imwarp(Image,T);
end

