function [ out, H] = minimizeImage( Obj )
    Height = find(conv(double(sum(removeEdgeObjects(Obj),2) > 0), [1 -1]));
    Width = find(conv(double(sum(removeEdgeObjects(Obj),1) > 0), [1 -1]));
    H = max(Height) - min(Height);
    
    Cut = Obj(min(Height):max(Height), min(Width):max(Width));
    out = imresize(Cut, [200 100]);
end

