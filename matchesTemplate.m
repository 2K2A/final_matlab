function confidence = matchesTemplate(image)
confidence = 0;
filtered_image = redFilter(image);

dilated_image = bwmorph(filtered_image, 'dilate', 5);
filtered_image = bwmorph(dilated_image, 'erode', 5);

filtered_image = imfill(filtered_image,'holes');
filtered_image = imgaussfilt(uint8(filtered_image));

[labeledImage, numberOfBlobs] = bwlabel(filtered_image);
blobMeasurements = regionprops(labeledImage, 'area');
if numberOfBlobs == 0
    return
end
% Get all the areas
allAreas = [blobMeasurements.Area];
[sortedAreas, sortIndexes] = sort(allAreas, 'descend');
biggestBlob = ismember(labeledImage, sortIndexes(1));
%imshow(biggestBlob);

props = regionprops(biggestBlob, 'MajorAxisLength', 'BoundingBox', 'Centroid');
BoundingBox = props(1).BoundingBox;
Center = props(1).Centroid;
MAL = props(1).MajorAxisLength;
SideLength = MAL / 2.414213562;

hex = nsidedpoly(8,'Center',Center,'SideLength',SideLength);
hexX = hex.Vertices(:,1);
hexY = hex.Vertices(:,2);
hexMask = poly2mask(hexX,hexY,size(image,1),size(image,2));
maskProps = regionprops(hexMask, 'BoundingBox');
MaskBox = maskProps(1).BoundingBox;


movingPoints = [MaskBox(1) MaskBox(2);...
    MaskBox(1)+MaskBox(3) MaskBox(2);...
    MaskBox(1) MaskBox(2)+MaskBox(4);...
    MaskBox(1)+MaskBox(3) MaskBox(2)+MaskBox(4)];
fixedPoints = [BoundingBox(1) BoundingBox(2);...
    BoundingBox(1)+BoundingBox(3) BoundingBox(2);...
    BoundingBox(1) BoundingBox(2)+BoundingBox(4);...
    BoundingBox(1)+BoundingBox(3) BoundingBox(2)+BoundingBox(4)];
tform = fitgeotrans(movingPoints, fixedPoints, 'Projective');
RA = imref2d([size(hexMask,1) size(hexMask,2)], [1 size(hexMask,2)], [1 size(hexMask,1)]);
[out,r] = imwarp(hexMask, tform, 'OutputView', imref2d(size(hexMask)));
% figure, imshow(image), hold on
% rectangle('Position', props(1).BoundingBox);  
% image(out);
% roi = [floor(BoundingBox(1)) floor(BoundingBox(2))...
%     ceil(BoundingBox(1)+BoundingBox(3)) ceil(BoundingBox(2)+BoundingBox(4))];

dif = imabsdiff(out,biggestBlob);
totalDifference = sum(dif(:));
totalPixels = BoundingBox(3)*BoundingBox(4);
percentDifferent = totalDifference/totalPixels;
confidence = max(0, 100 - (percentDifferent/0.2)*100);
%imshowpair(out,biggestBlob);

