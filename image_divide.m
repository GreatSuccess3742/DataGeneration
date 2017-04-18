%%%#TeamREM
%%%1. can customize the strides
%%%2. can customize the windowsize(image size)
%%%3. if image size < 500 resize it to 500

clc;
clear;

filename = 'show_girl.png';

img = imread(filename);
window_size = 500;
stride = 250;
pivot = [1,1];
aspect_ratio = size(img);

%%% handling input image

%aspect_ratio(1) is smaller than the window size
if (aspect_ratio(1) < window_size && aspect_ratio(2) >= window_size)
    scale_factor = window_size / aspect_ratio(1);
    img = imresize(img, [window_size (aspect_ratio(2) * scale_factor)]);
%aspect_ratio(2) is smaller than the window size
elseif (aspect_ratio(2) < window_size && aspect_ratio(1) >= window_size)
    scale_factor = window_size / aspect_ratio(2);
    img = imresize(img, [aspect_ratio(1)* scale_factor window_size]);
%both of the aspect_ratio are smaller than the window size
elseif (aspect_ratio(1) < window_size && aspect_ratio(2) < window_size)
    % first of all, we need to find out the scale_factor by finding out
    % which side is smaller.
    
    %aspect_ratio(1) is smaller
    if(aspect_ratio(1) < aspect_ratio(2))
        scale_factor = window_size / aspect_ratio(1);
        img = imresize(img, [window_size (aspect_ratio(2) * scale_factor) ]);
    %aspect_ratio(2) is smaller
    elseif(aspect_ratio(2) < aspect_ratio(1))
        scale_factor = window_size / aspect_ratio(2);
        img = imresize(img, [(aspect_ratio(1) * scale_factor)  window_size]);
    %height equals to width, and both smaller than the window_size
    elseif(aspect_ratio(1) == aspect_ratio(2))
        img = imresize(img, [window_size window_size]);
    end
    
    
end

aspect_ratio = size(img); %refresh aspect ratio after resizing(i.e. ratio change after resizing)

%%% calculate how many tiles are the images divided to
num_of_row = 1 + ceil( (aspect_ratio(1) - window_size) / stride);
num_of_col = 1 + ceil( (aspect_ratio(2) - window_size) / stride);
if(num_of_row < 1)
    num_of_row = 1;
end
if(num_of_col < 1)
    num_of_col = 1;
end

batch = cell(num_of_row, num_of_col);
for i = 1 : num_of_row
    for j = 1 : num_of_col
        if (pivot(2) + window_size) > aspect_ratio(2) %out of the boundary, shift back
            offset = pivot(2) - aspect_ratio(2) + window_size;
            pivot(2) = pivot(2) - offset;
        end
        
        if (pivot(1) + window_size) > aspect_ratio(1) %out of the boundary, shift back
            offset = pivot(1) - aspect_ratio(1) + window_size;
            pivot(1) = pivot(1) - offset;
        end
        batch(i,j) = {imcrop(img,[pivot(2) pivot(1) window_size-1 window_size-1])};
        %pivot(1) = pivot(1) + stride;
        pivot(2) = pivot(2) + stride; %shifting the pivot's "y" coordinate
    end
    %pivot(2) = pivot(2) + stride;
    pivot(1) = pivot(1) + stride; %shifting the pivot's "x" coordinate
    pivot(2) = 1;
    %pivot(2) = 1;%starting a new row, shift pivot to the begining

end

%%% to access the image stored in batch, use batch{i,j}
count = 1;% "count" is used for counting the files
for i = 1 : num_of_row
    for j = 1 : num_of_col
        token = strtok(filename,'.'); %seperate the filename from its extension
        output_name = strcat(filename(1:end-4),'_tile_',int2str(count),'.png'); %construct the ouput filename
        imwrite(batch{i,j},output_name,'png');
        count = count + 1;
    end
end




