function folders = getFolders(filepath)
%{
    Argument, filepath: a string, full filepath to folder to look in.
    Returns, folders: a struct with only folder names from the filepath.

    ex: folders(3).name % returns 
%}
    files_folders = getFiles(filepath);

    j = 1;

    for i=1:size(files_folders)
        if isfolder(strcat(files_folders(i).folder,'/',files_folders(i).name))
            folders(j).name = files_folders(i).name;
            j = j + 1;
        end
    end
end