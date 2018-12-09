%% Boilerplate
clear;
% Image location.
img_sets_loc = 'signs/';
% Image set folder names.
img_sets = {'vid0','vid1','vid2','vid3','vid4','vid5','vid6','vid7','vid8','vid9','vid10','vid11',};

results = zeros(4,2);

% Get a random image-set from the sets.
set_idx = floor(rand(1)*length(img_sets))+1;

% Get a list of images in the set (to pass to the next section).
img_set_sub = getFolders(strcat(img_sets_loc,img_sets{3}));
img_set = getFiles(strjoin({img_sets_loc,img_sets{3},img_set_sub.name},"/"));

%% Some tests
for i=350:length(img_set)
% For an image in image_set
    im_path = strjoin({img_set(i).folder,img_set(i).name},"/");
    % Read the image in.
    img = imread(im_path);
    % TODO: implement an object recognition algorithm.
    [has_stop_sign,confidence] = hasStopSign(img);
    a = getAnnotation(im_path);
    % Now do some math.
    actual_val = strcmp(a.AnnotationTag,'stop');
    if (has_stop_sign & actual_val)
        results(1,1) = results(1) + 1;
        results(1,2) = confidence;
    elseif (has_stop_sign & ~actual_val)
        results(2,1) = results(2) + 1;
        results(2,2) = confidence;
    elseif (~has_stop_sign & actual_val)
        results(3,1) = results(3) + 1;
        results(3,2) = confidence;
    else
        % ~has_stop_sign & ~actual_val
        results(4,1) = results(4) + 1;
        results(4,2) = confidence;
    end
    results
end

%% Results

results