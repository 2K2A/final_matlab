function has_stop_ocr = hasStopOcr(image)
filtered_image = redFilter(image);

dilated_image = bwmorph(filtered_image, 'dilate', 5);
filtered_image = bwmorph(dilated_image, 'erode', 5);
imshow(filtered_image);
filtered_image = imfill(filtered_image,'holes');
filtered_image = imgaussfilt(uint8(filtered_image));

[labeledImage, numberOfBlobs] = bwlabel(filtered_image);
blobMeasurements = regionprops(labeledImage, 'area');
if numberOfBlobs == 0
    has_stop_ocr = false;
    return
end

% Get all the areas
allAreas = [blobMeasurements.Area];
[sortedAreas, sortIndexes] = sort(allAreas, 'descend');
biggestBlob = ismember(labeledImage, sortIndexes(1));
props = regionprops(biggestBlob, 'BoundingBox');
BoundingBox = props(1).BoundingBox;

%roi = BoundingBox;
roi = [277 256 404 210];
ocrResults = ocr(image, roi, 'CharacterSet', 'OPST', 'TextLayout', 'Word');
deblank(ocrResults.Text)
                       
                       
ocrImage = insertText(image,roi(1:2),ocrResults.Text,'AnchorPoint',...
    'RightTop','FontSize',16);
figure, imshow(ocrImage), hold on
rectangle('Position', roi);  





