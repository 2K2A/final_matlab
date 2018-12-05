function has_stop_sign = findStopSign(image)
% This is for testing! Not meant to be a test

filtered_image = redFilter(image);

dilated_image = bwmorph(filtered_image, 'dilate', 5);
filtered_image = bwmorph(dilated_image, 'erode', 5);


filtered_image = imfill(filtered_image,'holes');
filtered_image = imgaussfilt(uint8(filtered_image));
props = regionprops(filtered_image, 'MinorAxisLength');

mal = props.MinorAxisLength / 5


% figure;
% Ca = corner(filtered_image,'QualityLevel',.5);
% 
% imshow(image)
% 
% hold on
% 
% scatter(Ca(:,1),Ca(:,2),80,'filled','k');
% 
% hold off

% Commented out section is using a hough transform
% The corners seem to be a good start though

windowSize = 10;
kernel = ones(windowSize) / windowSize ^ 2;
filtered_image = conv2(single(filtered_image), kernel, 'same');
filtered_image = filtered_image > 0.6; % Rethreshold

edge_image = edge(filtered_image);
edge_image = imgaussfilt(uint8(edge_image*255));
edge_image = edge_image > 0;

[B,L] = bwboundaries(filtered_image,'noholes');
imshow(filtered_image);
[H,T,R] = hough(edge_image,'RhoResolution',0.2);
H = floor(imgaussfilt(H));
P  = houghpeaks(H,20,'threshold',ceil(0.3*max(H(:))));
lines = houghlines(filtered_image,T,R,P,'FillGap',200,'MinLength',mal);

figure, imshow(image), hold on
length(lines)
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',4,'Color','green');

%    % Plot beginnings and ends of lines
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end