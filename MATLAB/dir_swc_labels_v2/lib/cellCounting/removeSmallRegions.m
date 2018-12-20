function outputImage = removeSmallRegions (inputBinaryImage, minAreaSize, maxAreaSize)

[imLabel, nLabel] = bwlabel (inputBinaryImage, 8);
areaStruct = regionprops (imLabel, 'Area');
area = [areaStruct.Area];
labelList = [1:nLabel];
if (maxAreaSize == 0)
    % If there is a unspecified maxArea don't use it
    sizeFilteredLabels = labelList(area < minAreaSize);
else
    % List of regions greater than maxArea and less than minArea
    sizeFilteredLabels = labelList((area < minAreaSize) & (area > maxAreaSize));
end
    
[pixelsOfRegion] = ismember (imLabel, sizeFilteredLabels);
inputBinaryImage(pixelsOfRegion) = 0;
outputImage = inputBinaryImage;