%--------------------------------------------------------------------------
% getImageStatistics.m script is used get mean and S.D. for the pixel 
% within the tissue intensities
%
%% Developed and maintained by Kannan Umadevi Venkataraju <kannanuv@cshl.edu>
%% do not distribute without permission.
%
% Usage 
% [meanValue standardDeviationValue] = getImageStatistics (imFileName, imMaskFileName)
% 
% History
% Author   | Date         |Change
%==========|==============|=================================================
% kannanuv | 2012 May 01  |Initial Creation
% kannanuv | 2013 Aug 03  |Remove high and low tail values that skew the dataset
% kannanuv | 2016 Oct 15  |Use Otsu thresholding to get the tissue pixels
%          |              |threshold and use those pixels
%--------------------------------------------------------------------------

function [meanValue standardDeviationValue] = getImageStatistics (imFileName, percentileCut)

if (isdeployed)
    percentileCut = str2double(percentileCut);
end

%% Boot strap and find a mean and standard Deviation
[imDirectory imFile imFileExt] = fileparts(imFileName);
statisticsDirectory = [imDirectory '/statistics/'];
mkdir(statisticsDirectory);
copyfile(imFileName, statisticsDirectory);

im = imread (imFileName);
medianFilteredim = medfilt2(im, [5 5]);

[thresh, metric] = multithresh (medianFilteredim);
imBin = (medianFilteredim > thresh);
imBin_filled = imfill (imBin, 'holes');
imagesc (imBin_filled)


imMask = imBin_filled;
maskFileName = [statisticsDirectory imFile '_mask.tif'];
imwrite (uint8(imMask), maskFileName);

imPoI = medianFilteredim(imMask);

imPoI = trimOutliers(imPoI, percentileCut, mean(imPoI), std(single(imPoI)));

meanValue = mean(imPoI);
standardDeviationValue = sqrt (var (imPoI));

writeStatisticsResult (meanValue, standardDeviationValue, imPoI, maskFileName, 0)

function writeStatisticsResult (meanValue, standardDeviationValue, imPoI, imFileName, iterationNumber)
sliceHistogram = figure(iterationNumber+1);
[nCount binCenters] = hist (imPoI, 100);
hist (imPoI, 100);
hold on;
plot ([meanValue meanValue], [0 max(nCount)], 'r-');
plot ([meanValue+standardDeviationValue meanValue+standardDeviationValue], [0 max(nCount)], 'g-');
plot ([meanValue-standardDeviationValue meanValue-standardDeviationValue], [0 max(nCount)], 'g-');
hold off;
title (sprintf ('Histogram of %s\n Mean = %4.2f, Standard Deviation = %4.2f', imFileName, meanValue, standardDeviationValue));
histogramFileName = [imFileName(1:end-4) '_histogram_' num2str(iterationNumber) '.pdf'];
saveas (sliceHistogram, histogramFileName);
close(sliceHistogram);

function imPoI = trimOutliers(imPoI, percentileCut, oldMeanValue, oldStdValue)
imPoI = single(imPoI);
ch_prcLOW = prctile (imPoI, percentileCut);
ch_prcHIGH = prctile (imPoI, 100-percentileCut);
ch_outlierLOW = oldMeanValue - 3.0*oldStdValue;
ch_outlierHIGH = oldMeanValue + 3.0*oldStdValue;
lowThreshold = 0; 
highThreshold = 0;
if (ch_prcLOW < ch_outlierLOW)
    lowThreshold = ch_outlierLOW;
else
    lowThreshold = ch_prcLOW;
end
if (ch_prcHIGH < ch_outlierHIGH)
    highThreshold = ch_prcHIGH;
else
    highThreshold = ch_outlierHIGH;
end
fprintf ('Thresholds = %2.3f,%2.3f,%2.3f,%2.3f,%2.3f,%2.3f\n', ch_prcLOW, ch_outlierLOW, ch_prcHIGH, ch_outlierHIGH, lowThreshold, highThreshold)
imPoI = single (imPoI((imPoI < highThreshold) & (imPoI > lowThreshold)));
