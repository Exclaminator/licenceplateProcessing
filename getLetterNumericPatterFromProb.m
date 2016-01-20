function [ chars ] = getLetterNumericPatterFromProb( chars, match )
    prev = 1;
    prob = zeros(size(dashes, 2), 2);
    
    for i=1:size(dashes, 2)
       	selection = match(prev:(dashes(i)-1), :);
        numbers = selection(:, 1:10);
        letters  = selection(:, 11:27);
        prob(i, 1) = sum(max(numbers, [],  2));
        prob(i, 2) = sum(max(letters, [],  2));
        
        prev = dashes(i) + 1;
    end;
    
    % __-__-__ 222
    if isequal(dashes, [3, 6, 9])
        % 001, 010, 011, 100, 101, 110
        numericSections = prob(:, 1) < prob(:,2);
    
        if sum(numericSections) == 0
            numericSections(prob(:,1) == min(prob(:,1))) = 1;
        elseif sum(numericSections) == 3
            numericSections(prob(:,2) == min(prob(:,2))) = 0;
        end;
        
    % __-___-_ 231
    elseif isequal(dashes, [3, 7, 9])
         % 101 or 010
         if prob(1,1) + prob(2,2) + prob(3,1) > prob(1,2) + prob(2,1) + prob(3,2) 
             numericSections = [0, 1, 0];
         else
             numericSections = [1, 0, 1];
         end;
        
    % _-___-__ 132
    elseif isequal(dashes, [2, 6, 9])
        % 101 or 010
         if prob(1,1) + prob(2,2) + prob(3,1) > prob(1,2) + prob(2,1) + prob(3,2) 
             numericSections = [0, 1, 0];
         else
             numericSections = [1, 0, 1];
         end;
         
    % ___-__-_ 321
    elseif isequal(dashes, [4, 7, 9])
        % 101
        numericSections = [1, 0, 1];
        
    else 
        chars = '--';
        return;
        
    end;
    
    
    
    prev = 1;
    
    mach = zeros(size(dashes, 2), size(selection, 1));
    for i=1:size(dashes, 2)
        
       	selection = match(prev:(dashes(i)-1), :);
        numbers = selection(:, 1:10);
        letters  = selection(:, 11:27);
        
        if numericSections(i) == 0
            for j = 1:size(selection, 1)
                mach(i, prev+j-1) = find(numbers(j, :) ==  max(numbers(j, :)), 1, 'first');
            end
        else
            for j = 1:size(selection, 1)
                mach(i, prev+j-1) = find(letters(j, :) ==  max(letters(j, :)), 1, 'first')+10;
            end
        end
        
        for j = prev:(dashes(i)-1)
            chars(j) = lookupTable(mach(i, j));
        end;
        prev = dashes(i) + 1;
    end;

end

