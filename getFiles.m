function file_names = getFiles(directory)
%{
    Arguments:
        takes a directory name as an arg

    Returns filenames from the directory, not including .,..
%}

% Read in the list of filenames of images to be processed
filelist = dir(directory);

% Remove invisible Thumbs.db file that's usually in Windows machines
filelist = filelist(arrayfun(@(x) ~strcmp(x.name, 'Thumbs.db'), filelist));

% Remove files that start with '.', including '.' and '..'
file_names = filelist(arrayfun(@(x) x.name(1) ~= '.', filelist));

end