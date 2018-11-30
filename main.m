%% Boilerplate
clear;
% Image location.
img_sets_loc = 'signs/';
% Image set folder names.
img_sets = {'aiua120214-0','aiua120214-1','aiua120214-2','aiua120306-0','aiua120306-1'};

% tracker, type cell array, contains image annotation structs of best and 
% worst matches, as well as % confidence of each match.
num_best_worst = 4;
best_worst = {};

% Get a random image-set from the sets.
set_idx = floor(rand(1)*length(img_sets))+1;

% Get a list of images in the set (to pass to the next section).
img_set_sub = getFolders(strcat(img_sets_loc,img_sets{3}));
img_set = getFiles(strjoin({img_sets_loc,img_sets{3},img_set_sub.name},"/"));

%% Hough Transform

for i=length(img_set)
% For an image in image_set
    % Read the image in.
    img = imread(strjoin({img_set(i).folder,img_set(i).name},"/"));
    % TODO: implement an object recognition algorithm.
end

%% Results

% TODO: Get the best and worst results (say, 4 of each) and display them.
    % Maybe draw a rectangle on where the algo thinks it found the sign?
% TODO: Show success rate (number of images correctly identified).