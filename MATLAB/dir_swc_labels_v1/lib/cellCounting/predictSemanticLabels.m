function predictSemanticLabels (testImageInputDirectory, detectionNetworkFileName, testOutputDirectory, varargin)

% Load the outputNetwork (has the neural network with weight)
load (detectionNetworkFileName);

listOfTestFiles = dir ([testImageInputDirectory '/*.tif']);
if (size(varargin) > 0)
  patchSizeX = varargin{1};
  if (size (varargin) == 1)
    patchSizeY = varargin{1};
  else
    patchSizeY = varargin{2};
  end
  patchSize = [patchSizeY patchSizeX];
else
  patchSize = [200 200];
end

fprintf ('Predicting for segmentation for %d images.\n', length(listOfTestFiles))
for iImage = 1:length(listOfTestFiles)
  fprintf ('Predicting for image %d / %d\n', iImage, length(listOfTestFiles))
  imTestImage = imread (fullfile (testImageInputDirectory, listOfTestFiles(iImage).name));
  if (numel (imTestImage) > prod(patchSize))
    imTestImageOutput = segmentImagePatchwise(imTestImage, outputNetwork, patchSize);
  else
    imTestImageOutput = semanticseg(imTestImage, outputNetwork);
  end
  imwrite (imTestImageOutput, fullfile (testOutputDirectory, listOfTestFiles(iImage).name));
end