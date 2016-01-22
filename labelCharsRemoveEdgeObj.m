function [ labeld ] = labelCharsRemoveEdgeObj( Image )
    opend =  bopening(Image, 1, 2, 0);
    Image = bpropagation(opend, Image, Inf, -1, 0);
    labeld = bwlabel(dip_array(brmedgeobjs(Image)));
end

