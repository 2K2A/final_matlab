function has_stop_sign = hasStopSign(image)
% By default there is no stop sign
% If all tests pass, then we can assume there is a stop sign
score = 0;
maxScore = 100;

score = score + matchesTemplate(image);

stop_sign_confidence = score / maxScore;
has_stop_sign = stop_sign_likelihood >= 0.5;