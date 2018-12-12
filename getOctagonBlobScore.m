function [confidence, props] = getOctagonBlobScore(image, blob)

props = regionprops(blob, 'MajorAxisLength', 'BoundingBox', 'Centroid');
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

dif = imabsdiff(out,blob);
totalDifference = sum(dif(:));
totalPixels = BoundingBox(3)*BoundingBox(4);
percentDifferent = totalDifference/totalPixels;
confidence = max(0, 100 - (percentDifferent/0.2)*100);
