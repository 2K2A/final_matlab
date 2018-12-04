function has_equal_sides = hasEqualSides(image)

filtered_image = redFilter(image);

% Remove noise
dilated_image = bwmorph(filtered_image, 'dilate', 5);
filtered_image = bwmorph(dilated_image, 'erode', 5);

% Remove STOP letters
filtered_image = imfill(filtered_image,'holes');
filtered_image = imgaussfilt(uint8(filtered_image));

% Find minimum length of stop sign side
props = regionprops(filtered_image, 'MinorAxisLength');
mal = props.MinorAxisLength / 4;

% Round the edges
windowSize = 10;
kernel = ones(windowSize) / windowSize ^ 2;
filtered_image = conv2(single(filtered_image), kernel, 'same');
filtered_image = filtered_image > 0.6; % Rethreshold

% Find the edges
edge_image = edge(filtered_image);
edge_image = imgaussfilt(uint8(edge_image*255));
edge_image = edge_image > 0;

% Hough filter to find lines
[H,T,R] = hough(edge_image,'RhoResolution',0.2);
H = floor(imgaussfilt(H));
P  = houghpeaks(H,20,'threshold',ceil(0.3*max(H(:))));
lines = houghlines(filtered_image,T,R,P,'FillGap',500,'MinLength',mal);

figure, imshow(image), hold on
length(lines)
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',4,'Color','green');
   
   % plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end

numLines = length(lines);
%Going to try and figure out a way to be able to measure length of each
%line against the other (taking into consideration a small + and - margin)
%and then have a boolean result if lines were equal making image a regular
%octagon

