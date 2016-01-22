function [ handles ] = addToTable( handles, chars, frame)
    str = get(handles.uitable3,'Data');
    
    if size(str, 2) == 0
        cell = {chars, frame, toc(handles.startStamp), '________', '________'};
        str = [cell; str];
    elseif sum(str{1, 1} == chars) == 8
        
    elseif sum(str{1, 1} == chars) >= 6
        if sum(str{1, 5} == chars) == 8
            str{1,1} = chars;
        elseif sum(str{1, 4} == chars) == 8
            str{1,5} = chars;
        else
            str{1,4} = chars;
        end;
    else
        cell = {chars, frame, toc(handles.startStamp), '________', '________'};
        str = [cell; str];
    end
    assignin('base','output',str);
    set(handles.uitable3,'Data', str);
end

