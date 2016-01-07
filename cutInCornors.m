function [ out ] = cutInCornors( Image, Cornors )
    xl = min(Cornors(:, 1));
    xu = max(Cornors(:, 1));
    yl = min(Cornors(:, 2));
    yu = max(Cornors(:, 2));
    out = Image(yl:yu, xl:xu, :);
end

