function score = featureMatch(img, template)
%{
    Takes an image and template, extracts features from the template, and
    looks to see if the features are in the target image.

    Input
        image: image to look in for the template object
        template: template of object to find

    Output
        matches: boolean, 1 if a match, 0 if no match

    Requires vl_feat package.
%}
    if nargin < 2
        template = imread('stop_sign_template.jpg');
    end
    % Get features from template.
%    gray_template = single(rgb2gray(template));
%    [t_frames,t_desc] = vl_sift(gray_template);

    % Get features from target image.
    [sign,props] = getStopSign(img);
    %center = props.Centroid;
    %figure;
    %imshow(sign);
    %sign = imresize(sign,[size(template,1) size(template,2)]);
    %template = imgaussfilt(template,floor(size(sign,1)*0.02));
    
    if isempty(sign)
        score = 0;
        return
    else
        %
        template = imresize(template,[size(sign,1) size(sign,2)]);
        temp_blur = imgaussfilt(template);
        temp_edge = edge(rgb2gray(temp_blur),'Canny',.2);
        temp_edge = imresize(temp_edge,[1000 1000]);
        %
        %thresh = sum(sum(rgb2gray(img)))/(size(img,1)*size(img,2))/255;
        sign_blur = imgaussfilt(sign);
        sign_edge = edge(rgb2gray(sign_blur),'Canny');%,thresh);
        sign_edge = imresize(sign_edge,[size(temp_edge,1) size(temp_edge,2)]);
        %template = imresize(template,[size(sign,1) size(sign,2)]);
        [t_frames,t_desc] = vl_sift(single(temp_edge));
        [i_frames, i_desc] = vl_sift(single(sign_edge));

        % Check the features against each other, see if we have a match.
        [matches, scores] = vl_ubcmatch(i_desc,t_desc,10);
%{
        figure;
        imshowpair(temp_edge,sign_edge, 'montage');
        %imshow(sign)
        hold on
        scatter(t_frames(1,:),t_frames(2,:));
        scatter(i_frames(1,:)+size(sign_edge,1),i_frames(2,:))
        plot([t_frames(1,matches(2,:));i_frames(1,matches(1,:))+size(sign_edge,1)],[t_frames(2,matches(2,:));i_frames(2,matches(1,:))],'r');
        hold off

        figure;
        hold on
        image(sign)
        scatter(i_frames(1,:),i_frames(2,:));
        %scatter(i_frames(1,:)+center(1)-size(sign,1)/2,...
        %    i_frames(2,:)+center(2)-size(sign,2)/2)
        %scatter(i_frames(2,matches(2,:))+center(1)-size(sign,1)/2,...
        %    i_frames(1,matches(2,:))+center(2)-size(sign,2)/2,'r','fill');
        hold off

        figure;
        hold on
        image(template)
        scatter(t_frames(1,:),t_frames(2,:))
        %scatter(t_frames(1,matches(1,:)),t_frames(2,matches(1,:)));
        hold off
%}
        if isempty(scores)
            score = 0;
        else
            score = 1/sqrt(sum(scores)/max(scores));
        end
    end
end