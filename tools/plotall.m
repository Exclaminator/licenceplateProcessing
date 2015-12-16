function [ ] = plotall(red, green, orange, bg, channel1, channel2)
    hold
    scatter(flat(bg, channel1), flat(bg, channel2), [], [1/2 1/2 1/2])
    scatter(flat(green, channel1), flat(green, channel2), [], [0 1 0])
    scatter(flat(red, channel1), flat(red, channel2), [], [1 0 0])
    scatter(flat(orange, channel1), flat(orange, channel2), [], [1 1/2 0])
end

