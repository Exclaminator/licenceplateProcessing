function [ IT ] = deskewerImage( Image, C )
    L = mean(C([1 4],1));
    R = mean(C([2 3],1));
    U = mean(C([1 2],2));
    D = mean(C([3 4],2));
    C2 = [L U; R U; R D; L D];
    try 
        T = cp2tform(C ,C2,'projective');
        IT = imtransform(Image,T);
    catch
        IT = Image;
    end
end

