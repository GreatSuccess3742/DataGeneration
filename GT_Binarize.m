clc;
clear;
mystr = dir('*/*GT*');
%for statement
[M,N] = size(mystr);
for file_index = 1:M
    filename = mystr(file_index).name;
    input = imread(filename);
    input = input(:,:,1);
    %Binarized = input > 0;
    Binarized = imbinarize(input,0.5);
    %remove the extension of the filename
    [pathstr,name,ext] = fileparts(filename);
    %output directory
    path = '../Binarized/';
    name = strcat(path,name,'_Binarized.png');
    %name = strcat(path,name,'_Binarized');
    imwrite(Binarized,name);
end