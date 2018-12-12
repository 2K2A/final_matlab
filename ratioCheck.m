function score = ratioCheck(image)
score = 0;
[f1, blob] = getRedBlob(image);
if (size(blob,1) == 0)
    return
end
totalPixelsOfOct = sum(sum(blob));
f3 = ((blob == 0) | f1) == 0;
totalPixelsOfSTOP = sum(sum(f3));
hasStopRatio = totalPixelsOfOct / totalPixelsOfSTOP;
% The ration should be 6.34
idealRatio = 6.34;
score = max(0, 100 - (100 * abs(hasStopRatio - idealRatio) / idealRatio));