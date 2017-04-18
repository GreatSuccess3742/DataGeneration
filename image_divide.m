%%%1. can customize the strides
%%%2. can customize the windowsize(image size)
%%%3. if image size < 500 resize it to 500

clc;
clear;
img = imread('dog2.jpg');
window_size = 500;
stride = 100;
pivot = [1,1];
aspect_ratio = size(img);

%%% handling input image
if (aspect_ratio(1) < window_size && aspect_ratio(2) >= window_size)
    img = imresize(img, [window_size aspect_ratio(2)]);
elseif (aspect_ratio(2) < window_size && aspect_ratio(1) >= window_size)
    img = imresize(img, [aspect_ratio(1) window_size]);
elseif (aspect_ratio(1) < window_size && aspect_ratio(2) < window_size)
    img = imresize(img, [window_size window_size]);
end

aspect_ratio = size(img); %refresh aspect ratio after resizing(i.e. ratio change after resizing)

%%% calculate how many tiles are the images divided to
num_of_row = floor(aspect_ratio(1) / stride);
num_of_col = floor(aspect_ratio(2) / stride);
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
        batch(j,i) = {imcrop(img,[pivot(1) pivot(2) window_size-1 window_size-1])};
        pivot(2) = pivot(2) + stride; %shifting the pivot's "y" coordinate
    end
    pivot(1) = pivot(1) + stride; %shifting the pivot's "x" coordinate
    pivot(2) = 1;%starting a new row, shift pivot to the begining

end

%%% to access the image stored in batch, use batch{i,j}




