function has_stop_sign = hasStopSign(image)
% By default there is no stop sign
% If all tests pass, then we can assume there is a stop sign
has_stop_sign = false;

if not(hasEightSides(image))
    return
end

% add tests by doing the following:
% if not(test(image)) % Please break test into another script test.m
%     return
% end

has_stop_sign = true;