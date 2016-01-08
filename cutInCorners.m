function [ out ] = cutInCorners( Image, Corners )
    xl = min(Corners(:, 1));
    xu = max(Corners(:, 1));
    yl = min(Corners(:, 2));
    yu = max(Corners(:, 2));
    out = Image(yl:yu, xl:xu, :);
end

