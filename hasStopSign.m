function [has_stop_sign, confidence_level] = hasStopSign(image)
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

confidence_level = score / maxScore;
has_stop_sign = confidence_level >= 0.5;