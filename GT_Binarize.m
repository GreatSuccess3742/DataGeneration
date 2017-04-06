clc;
clear;
mystr = dir('*/*GT*');

%for statement
[M,N] = size(mystr);
for file_index = 1:M
    filename = mystr(file_index).name;
    if size(findstr(filename,'png')) > 0
        [data_,map_,input] = imread(filename);
        if(size(input) > 0)
            Binarized = imcomplement(imbinarize(input,0.5));
        else
            input = data_(:,:,1);
            Binarized = (imbinarize(input,0.5));
        end
        %remove the extension of the filename
        [pathstr,name,ext] = fileparts(filename);
        %output directory
        path = '../Binarized/';
        name = strcat(path,name,'_Binarized.png');
        imwrite(Binarized,name);
    elseif size(findstr(filename,'jpg')) > 0
        fprintf('%s file extension is jpg\n',filename);
        input = imread(filename);
        input  = input(:,:,1);
        Binarized = (imbinarize(input,0.5));
        
        [pathstr,name,ext] = fileparts(filename);
        path = '../Binarized/';
        name = strcat(path,name,'_Binarized.png');
        Binarized = imcomplement(Binarized);
        Binarized = bwareaopen(Binarized,20,4);
        Binarized = imfill(Binarized,'holes');
        Binarized = imcomplement(Binarized);
        imwrite(Binarized,name);
    elseif size(findstr(filename,'xcf')) > 0
        fprintf('file extension is xcf\n');   
    end

end