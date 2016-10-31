function [ out ] = cutInCorners( Image, Corners )
    try
        xl = min(Corners(:, 1))-2;
        xu = max(Corners(:, 1))+2;
        yl = min(Corners(:, 2))-2;
        yu = max(Corners(:, 2))+2;
        out = Image(yl:yu, xl:xu, :);
    catch
        out = Image;
    end
end

