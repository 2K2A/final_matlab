%% Boilerplate

% Image location.
image_sets_loc = 'signs/';
% Image set folder names.
image_set = getFolders(image_sets_loc);
% Grab only the vid sets.
j=1;
% Grab only the vid sets.
for i=1:length(image_set)
    if regexp(image_set(i).name, regexptranslate('wildcard','vid*'))
        vid_sets(j).name = image_set(i).name;
        j=j+1;
    end
end

% TODO: tracker, type struct with fields
    % name: image name
    % annotation: yes/no (from the image annotations)
    % output: percentage (confidence level from the algorithm)

% TODO: Get a random image set from the sets.
set_idx = floor(rand(1)*length(image_set))+1;


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