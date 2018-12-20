function [nonDuplicateTruePositiveLabels, duplicateTruePositiveLabels, falsePositiveLabels, falseNegativeLabels, precision, recall, fscore] = getSegmentationMetrics3D (imReferenceFileName, imPredictFileName, volumeThreshold, doWriteMetricsImages)

if (isdeployed)
  doWriteMetricsImages = str2double (doWriteMetricsImages);
else
  addpath ('../utils/');
end

%% Read the input image file stack or series
isReferenceImageSeries = isfolder (imReferenceFileName);
isPredictionLabelSeries = isfolder (imPredictFileName);
if (isReferenceImageSeries)
  imReference = imreadseries (imReferenceFileName, 'tif');
else
  imReference = imreadstack (imReferenceFileName);
end
imReference = (imReference > 0.5);
imReference = removeSmallRegions3D (imReference, volumeThreshold, 0);

if (isPredictionLabelSeries)
  imPredict = imreadseries (imPredictFileName, 'tif');
else
  imPredict = imreadstack (imPredictFileName);
end
imPredict = ((imPredict) > 0.5);
imPredict = removeSmallRegions3D (imPredict, volumeThreshold, 0);

[labelImageReference, nLabelReference] = bwlabeln (imReference, 6);
[labelImagePredict, nLabelPredict] = bwlabeln (imPredict, 6);

%% calculate True positives, False Positives and duplicates
truePositiveLabels = unique (uint16(labelImagePredict(imReference)));
truePositiveLabels = truePositiveLabels(truePositiveLabels ~= 0);
falsePositiveLabels = setdiff (unique(labelImagePredict(labelImagePredict~=0)), truePositiveLabels);

%% Caluclate False Negatives
falseNegativeLabels = unique (uint16(labelImageReference(imPredict)));
falseNegativeLabels = falseNegativeLabels(falseNegativeLabels ~= 0);
falseNegativeLabels = setdiff ([1:nLabelReference], falseNegativeLabels);

imTruePositive = ismember (labelImagePredict, truePositiveLabels) * 255;
imFalsePositive = ismember (labelImagePredict, falsePositiveLabels) * 255;
imFalseNegative = ismember (labelImageReference, falseNegativeLabels) * 255;

if (doWriteMetricsImages >= 1)
  metricsDirectory = [imPredictFileName '_prediction'];
  mkdir (metricsDirectory);
  if (isPredictionLabelSeries)
    imwriteseries (uint8(imTruePositive), metricsDirectory, 'truePositives', 'TP');
    imwriteseries (uint8(imFalsePositive), metricsDirectory, 'falsePositives', 'FP');
    imwriteseries (uint8(imFalseNegative), metricsDirectory, 'falseNegatives', 'FN');
  else
    imwritestack (uint8(imTruePositive), fullfile (metricsDirectory, 'imTruePositive.tif'));
    imwritestack (uint8(imFalsePositive), fullfile (metricsDirectory, 'imFalsePositive.tif'));
    imwritestack (uint8(imFalseNegative), fullfile (metricsDirectory, 'imFalseNegative.tif'));
  end
  imRGB(:,:,:,1) = uint8(imFalsePositive);
  imRGB(:,:,:,2) = uint8(imTruePositive);
  imRGB(:,:,:,3) = uint8(imFalseNegative);
  imRGB = permute (imRGB, [1 2 4 3]);
  imwritestack (uint8(imRGB), fullfile (metricsDirectory, 'imFP-TP-FN-map.tif'));
end

nonDuplicateTruePositiveLabels = truePositiveLabels;
duplicateTruePositiveLabels = [];

precision = numel(truePositiveLabels) / (numel(truePositiveLabels) + numel(falsePositiveLabels));
recall = numel(truePositiveLabels) / (numel(truePositiveLabels) + numel(falseNegativeLabels));
fscore = 2 * precision * recall / (precision + recall);
fprintf ('%d,%d,%d,%d,%f,%f,%f\n', length(nonDuplicateTruePositiveLabels), length(duplicateTruePositiveLabels), ...
  length(falsePositiveLabels), length(falseNegativeLabels), precision, recall, fscore);
