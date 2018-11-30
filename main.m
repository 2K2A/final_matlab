%% Boilerplate

% Image location.
img_sets_loc = 'signs/';
% Image set folder names.
img_sets = {'aiua120214-0','aiua120214-1','aiua120214-2','aiua120306-0','aiua120306-1'};

% tracker, type cell array, contains image annotation structs of best and 
% worst matches.
best_worst = {};

% Get a random image-set from the sets.
set_idx = floor(rand(1)*length(img_sets))+1;

% Get a list of images in the set (to pass to the next section).
img_set_sub = getFolders(strcat(image_sets_loc,image_sets{3}));
img_set = getFiles(strjoin({image_sets_loc,image_sets{3},sub_f.name},"/"));

%% Hough Transform

% TODO: For an image in image_set
    % TODO: 1. Generate an edge image.
    % TODO: 2. Compute the Hough transform.
    % TODO: 3. Look for a stop sign (using template matching).
        % Check the annotations to see if there is a stop sign.
        % Record the results to a struct.
    
%% Results

% TODO: Get the best and worst results (say, 4 of each) and display them.
    % Maybe draw a rectangle on where the algo thinks it found the sign?
% TODO: Show success rate (number of images correctly identified).