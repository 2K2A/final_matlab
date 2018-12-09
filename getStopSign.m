function [stop_sign,center] = getStopSign(img)
%{ 
Grabs where it thinks a stopsign is in an image, crops the image. Also
passes back the center of the object.
%}

    % Get a BW image of red stuff.
    red_stuff = ((img(:,:,1))>(img(:,:,2)*2))&((img(:,:,1))>(img(:,:,3)*2))&(img(:,:,1)>50)&...
            (((abs(img(:,:,2)-img(:,:,3))./img(:,:,3))*100)<50);
    red_stuff = bwmorph(red_stuff,'dilate',10);
    red_stuff = bwmorph(red_stuff,'erode',10);

    % Find a bounding box for the red stuff.
    % Get some labels.
    labels = logical(red_stuff);
    % Get some improps.
    props = regionprops(labels,'BoundingBox','FilledArea','Centroid');

    % Check to see if we even have any regions:
    if (~isempty(props))&(max([props.FilledArea])>70)
        % Grab the largest red thing...
        idx_big_stuff = find([props.FilledArea]==max([props.FilledArea]));
        ul_x = uint16(props(idx_big_stuff).BoundingBox(1));
        ul_y = uint16(props(idx_big_stuff).BoundingBox(2));
        x_del = uint16(props(idx_big_stuff).BoundingBox(3));
        y_del = uint16(props(idx_big_stuff).BoundingBox(4));
        %{
        x_pad = x_del*0.1;
        y_pad = y_del*0.1;

        ul_x = floor(ul_x - x_pad);
        ul_y = floor(ul_y - y_pad);
        x_del = floor(x_del + 2*x_pad);
        y_del = floor(y_del + 2*y_pad);
        %}
        % Crop the image and return just the red stuff.
        stop_sign = img(ul_y:ul_y+y_del,ul_x:ul_x+x_del,:);
        center = props(idx_big_stuff).Centroid;
    else
        stop_sign=[];
        center=[];
    end
   
end