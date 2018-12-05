function filtered_image = redFilter(image, minRed, maxRed)
I = image;
if nargin < 3
    maxRed = 255.000;
end
if nargin < 2
    minRed = 116.000;
end

% Define thresholds for channel 1 based on histogram settings
channel1Min = minRed;
channel1Max = maxRed;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.000;
channel2Max = 82.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 82.000;

% Create mask based on chosen histogram thresholds
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
filtered_image = sliderBW;

% Initialize output masked image based on input image.
% rgb_filtered_image = image;

% Set background pixels where BW is false to zero.
% rgb_filtered_image = image;(repmat(~filtered_image,[1 1 3])) = 0;