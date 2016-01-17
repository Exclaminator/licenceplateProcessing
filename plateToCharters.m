function [ Objects ] = plateToCharters( plate )
        HObj = max(max(plate));
        Objects = zeros(200, 100, HObj+1, 'uint8');
        
        for i = 1:HObj
            Objects(:,:, i) = minimizeImage(plate == i);
        end;
end

