function has_stop_sign = hasStopSign(image)
score = 0;
maxScore = 300;
% Include these in the maxScore
templateScore = matchesTemplate(image);
featureScore = featureMatch(image);
ratioScore = detectStop(image);

% wordScore not included in maxScore as it is a bonus
wordScore = hasWordStop(image);

% Total score is calculated here
score = templateScore + featureScore + ratioScore + wordScore;

stop_sign_confidence = score / maxScore;
has_stop_sign = stop_sign_confidence >= 0.5;