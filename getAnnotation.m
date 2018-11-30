function annotation = getAnnotation(image_path)
%{
Uses an image name to reach into the LISA set and grab the annotations for
that image.

Argument
    image_path, type string: contains full path of image
Return
    annotation, type struct: contains all annotations relevant to the image
%}

    % Frame annotation file name:
    fa = 'frameAnnotations.csv';

    % Split the image name from the image_path.
    dir_elems = strsplit(image_path,"/");
    image_path = strjoin(dir_elems(1:end-1),"/");
    image_name = dir_elems{end};

    % Open up the CSV
    csv = readtable(strcat(image_path,"/",fa));
    j=0;
    % For row in the table
    for i=1:height(csv)
        % Find our filename.
        if csv.Filename{i} == image_name
            j=i;
            break;
        end
    end

    my_struct = table2struct(csv);
    annotation = my_struct(j);

end