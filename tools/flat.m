function channelAsVector = flat(in, channel) 
    channelAsMatrix = double(in(:, :, channel))./double(sum(in, 3));
    channelAsVector = channelAsMatrix(:);
end