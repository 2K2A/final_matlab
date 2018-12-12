%% Boilerplate
clear;

results = zeros(4,1);

positive_image_set = getFiles('signs/true');
nPositiveImages = length(positive_image_set); 
for i=1:nPositiveImages
   currentImageName = strcat('signs/true/', positive_image_set(i).name);
   currentImage = imread(currentImageName);
   %[has_stop_sign, confidence] = hasStopSign(currentImage);
   confidence = ratioCheck(currentImage);
   has_stop_sign = confidence >= 50;
   if (has_stop_sign)
       % We say there is a stop sign and there is (pass)
       results(1) = results(1) + 1;
   else
       % We say there is not a stop sign but there is (fail)
       %currentImageName
       results(2) = results(2) + 1;
   end
end
negative_image_set = getFiles('signs/false');
nNegativeImages = length(negative_image_set); 

for i=1:nNegativeImages
   currentImageName = strcat('signs/false/', negative_image_set(i).name);
   currentImage = imread(currentImageName);
   %[has_stop_sign, confidence] = hasStopSign(currentImage);
   confidence = ratioCheck(currentImage);
   has_stop_sign = confidence >= 50;
   if (has_stop_sign)
       % We say there is a stop sign but there isn't (fail)
       % currentImageName
       results(3) = results(3) + 1;
   else
       % We say there is not a stop sign and there isn't (pass)
       results(4) = results(4) + 1;
   end
end

%% Results
% results(1) - True positives
% results(2) - False negatives
% results(3) - False Positives
% results(4) - True negatives

results
total_correct = results(1) + results(4);
total_wrong = results(2) + results(3);
overall_accuracy = total_correct / (total_wrong + total_correct)