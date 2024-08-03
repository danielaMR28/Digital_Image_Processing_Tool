function [imageInfoStruct] = getImageInfo(fileName)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
imageInfo = imfinfo(fileName);
imageFileSize = imageInfo.FileSize;
imageFormat = imageInfo.Format;
imageBitDepth = imageInfo.BitDepth;
imageWidth = imageInfo.Width;
imageHeight = imageInfo.Height;
imageType = imageInfo.ColorType;
imageInfoStruct = struct("format", imageFormat, "depth", imageBitDepth, ...
    "width", imageWidth, "height", imageHeight,"type", imageType, ...
    "FileSize", imageFileSize);
end