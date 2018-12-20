%--------------------------------------------------------------------------
% getImageMask.m script is used generate mask for a particular section
% Developed for decreasing the prediction time by using mask
%% Developed and maintained by Kannan Umadevi Venkataraju <kannanuv@cshl.edu>
%% do not distribute without permission.
%
% Usage 
% maskFileName = getImageMask(startSection, endSection, binaryLabelFile, sectionID, sectionFileName)
% 
% History
% Author   | Date         |Change
%==========|==============|=================================================
% kannanuv | 2012 May 01  |Initial Creation
%--------------------------------------------------------------------------
function maskFileName = getImageMask(startSection, endSection, binaryLabelFile, sectionID, sectionFileName)

if (isdeployed)
    startSection = str2double(startSection);
    endSection = str2double(endSection);
    sectionID = str2double(sectionID);
end

addpath ('/usr/local/netgpu/fluoMouseBrain/scripts/utils/');
imSection = imread (sectionFileName);

binaryLabelImage = imreadstack (binaryLabelFile);
nSection = size (binaryLabelImage);

usableZSlices = [startSection:endSection];

nUsableSlices = length(usableZSlices);

startSlice = round ((300 - nUsableSlices)/2);
endSlice = startSlice + nUsableSlices - 1;

newSectionNumber = interp1 (usableZSlices, startSlice:endSlice, sectionID);

sectionMask = imresize (binaryLabelImage(:,:,newSectionNumber), 20);
sectionMask = sectionMask(1:size(imSection,1), 1:size(imSection,2));

maskFileName = sprintf ('%s_section_%3d_mask.tif', binaryLabelFile(1:end-4), sectionID);
imwrite (sectionMask, maskFileName);
