function [nameAndPath, imageStruct] = readImage()
%readImage() use this to retrieve an image's full path and a structure
%containing the image
%   
tipos = {'*.jpg; *.jpeg;*.bmp;*.png;*.tif;*.gif'};

[fileName, inputPath] = uigetfile(tipos);

if fileName == 0
    return
end
nameAndPath = fullfile(inputPath, fileName);
imageInfo = getImageInfo(nameAndPath);

if imageInfo.type == "truecolor"
    inputImage = rgb2gray(imread(nameAndPath));
    map = gray(256);
else
    [inputImage, map] = imread(nameAndPath);
end
imageStruct = struct("imageMatrix", inputImage, "map", map, "imageInfo", imageInfo);
end