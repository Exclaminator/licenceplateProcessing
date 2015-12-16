function channelAsVector = flat(in, channel) 
    channelAsMatrix = double(in(:, :, channel))./double(in(:, :, 1) + in(:, :, 2) + in(:, :, 3));
    channelAsVector = channelAsMatrix(:);
end