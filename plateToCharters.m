function [ Objects , Heights] = plateToCharters( plate )
        HObj = max(max(plate));
        
        Objects = zeros(200, 100, HObj, 'uint8');
        Heights = zeros(HObj+1, 1);
        for i = 1:HObj
            [Objects(:,:, i), Heights(i)] = minimizeImage(plate == i);
        end;
end

