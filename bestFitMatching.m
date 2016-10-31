function [ dashes , match] = bestFitMatching( Charters, Heights, characterMasks, lookupTable ) 
    avgHeights = mean(Heights);
    match = zeros(size(Charters, 3), size(characterMasks, 3)+1);
    bestFit = zeros(size(Charters, 3), 2);
    chars = '________';
    
    
    
    for i = 1:size(Charters, 3)
        if Heights(i) < 1/2*avgHeights
            chars(i) = '-';
            bestFit(i, 27) = 1;
        else
            for j = 1:size(characterMasks, 3)
                match(i, j) = sum(sum(Charters(:,:,i).*characterMasks(:,:,j)))/(sum(sum(Charters(:,:,i))) + sum(sum(characterMasks(:,:,j))));
                
                %if bweuler(Charters(:,:,i)) ~= bweuler(characterMasks(:,:,j))
                %    match(i, j) = match(i, j)/2;
                %end
            end;
        end;
    end;
    
    if sum(chars == '-') ~= 2 || chars(1) == '-' || chars(8) == '-'
        dashes = [0, 0];
        return;
    end;
    
    dashes = [find(chars == '-'), 9];
end

