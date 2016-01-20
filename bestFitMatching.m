function [ dashes , match] = bestFitMatching( Charters, Heights, characterMasks, lookupTable ) 
    avgHeights = mean(Heights);
    match = zeros(size(Charters, 3), size(characterMasks, 3));
    bestFit = zeros(size(Charters, 3), 2);
    chars = '________';
    
    for i = 1:size(Charters, 3)
        if Heights(i) < 1/2*avgHeights
            chars(i) = '-';
            bestFit(i, 1) = 1;
        else
            for j = 1:size(characterMasks, 3)
                match(i, j) = sum(sum(Charters(:,:,i).*characterMasks(:,:,j)))/(sum(sum(Charters(:,:,i))) + sum(sum(characterMasks(:,:,j))));
            end;
        end;
    end;
    
    if sum(chars == '-') ~= 2 || chars(1) == '-' || chars(8) == '-'
        dashes = '-';
        match = '-';
        return;
    end;
    
    dashes = [find(chars == '-'), 9];
end

