% imlabelFileName = C:\Users\kannanuv\Documents\temp\gadTraining\20180510_GADH2BGFP\results\Z21-2000-2200_labels.tif
% imCellPredictionImageFileName = C:\Users\kannanuv\Documents\temp\gadTraining\20180510_GADH2BGFP\results\imPredictionsBinary.tif
% stepSize = 0.1
function [nonDuplicateTruePositiveLabels, duplicateTruePositiveLabels, falsePositiveLabels, falseNegativeLabels, precision, recall, fscore] = optimizeTissueCutForCellCount (imLabelFileName, imCellPredictionImageFileName, processingDir, nStep)

if (~isdeployed)
  addpath ('../utils/');
end

imLabel = imreadstack (imLabelFileName);
imPrediction = imreadstack (imCellPredictionImageFileName);

volumeHeight = size (imLabel, 1);
stepSize = 1 / double(nStep);
volumeSizeThreshold = 38;

for iStep = 0:nStep
  croppedVolumeHeight = volumeHeight - round(volumeHeight * iStep * stepSize);
  fprintf ('Processing : Cropping %d pixels /%d pixels\n', croppedVolumeHeight, volumeHeight)
  imLabelCropped = imLabel (1:croppedVolumeHeight, :, :);
  imPredictionCropped = imPrediction (1:croppedVolumeHeight, :, :);
  imCroppedReferenceFileName = fullfile (processingDir, 'croppedLabels.tif');
  imCroppedPredictFileName = fullfile (processingDir, 'croppedPredictions.tif');
  imwritestack (imLabelCropped, imCroppedReferenceFileName);
  imwritestack (imPredictionCropped, imCroppedPredictFileName);
  [nonDuplicateTruePositiveLabels{iStep+1}, duplicateTruePositiveLabels{iStep+1}, falsePositiveLabels{iStep+1}, falseNegativeLabels{iStep+1}, precision{iStep+1}, recall{iStep+1}, fscore{iStep+1}] = getSegmentationMetrics3D (imCroppedReferenceFileName, imCroppedPredictFileName, volumeSizeThreshold, 0);
end





