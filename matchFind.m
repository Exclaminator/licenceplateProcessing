%Niet 0 vorige
%indien verschillend
%	vanaf vorige to ...
%		indien niet 0 vorige
%		stop als te groot verschil avgVorige
%
%	geeft range
%	voor alle in range neem gemiddelde
%	getLetterNumericPatterFromProb

function [ chars, frame ] = matchFind( matches, frames, dashes, lookupTable)
    similartyTreshold = 0.8;
    if sum(sum(matches(:,:,2))) == 0;
        chars = '-';
        frame = 0;
        return;
    end;
    
    if sum(sum(matches(:,:,1)-matches(:,:,2))) < similartyTreshold;
        chars = '-';
        frame = 0;
        return;
    end;
    
    abs(sum(sum(matches(:,:,2)-matches(:,:,3))))
    n = 3;
    while n < 10 && sum(sum(matches(:,:,n))) > 0 && abs(sum(sum(matches(:,:,2)-matches(:,:,n)))) < similartyTreshold
        n = n+1;
    end;
    
    p = matches(:,:,2);
    if n > 3
        for i = 3:(n-1)
            p = p + matches(:,:,i);
        end;
        p = p./(n-2);
    end;
    frame = round(mean(frames(2:(n-1))));
    chars = getLetterNumericPatterFromProb(p, dashes, lookupTable);
end

