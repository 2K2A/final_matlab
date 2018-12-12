function [f1, blob]  = getRedBlob(img)
blob = [];
coder.extrinsic('imresize','imwrite');
img = imresize(img,[640 480]);

f1 = ((img(:,:,1)>70)&((img(:,:,1) - img(:,:,2))>17)&((img(:,:,1) - img(:,:,3))>17)&img(:,:,2)<120&img(:,:,3)<120);

f2 = imfill(f1, 'holes');
totalPixelsOfOct = sum(sum(f2));

LB =2000;
UB = 30000;
% Iout = xor(bwareaopen(f2,LB),  bwareaopen(f2,UB));
Iout = bwareaopen(f2,LB);
blob_image = Iout;

[labeledImage, numberOfBlobs] = bwlabel(blob_image);
blobMeasurements = regionprops(labeledImage, 'area');
if numberOfBlobs == 0
    return
end

% Get all the areas
allAreas = [blobMeasurements.Area];
[sortedAreas, sortIndexes] = sort(allAreas, 'descend');
bestScore = -1;
for i=1:numberOfBlobs
    currentBlob = ismember(labeledImage, sortIndexes(i));
    [currentBlobScore, currentBlobProps] = getOctagonBlobScore(img, currentBlob);
    if currentBlobScore > bestScore
        bestBlob = currentBlob;
        bestProps = currentBlobProps;
        bestScore = currentBlobScore;
    end
end
if bestScore > 0.4
    blob = bestBlob;
end

