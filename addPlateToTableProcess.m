function [ handles ] = addPlateToTableProcess( IM2, handles )
    % 8 items only
    if max(max(IM2)) == 8 
        [Charters, Heights] = plateToCharters(IM2);
        [dashes, match] = bestFitMatching( Charters, Heights, handles.characterMasks, handles.lookupTable);
        if size(dashes,2) == 3
            chars = getLetterNumericPatterFromProb(match, dashes, handles.lookupTable);
            set(handles.text6, 'String', chars);
            if size(chars, 2) == 8
                handles = addToTable(handles, chars, handles.frame);
            end;
        end;
    end;

end

