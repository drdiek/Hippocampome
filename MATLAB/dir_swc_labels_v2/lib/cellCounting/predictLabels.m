%--------------------------------------------------------------------------
% function predictLabels 
%
% Usage 
% predictLabels2Channel (gpu_id, network_id, inputDirectoryFluorescence, contrastRangeMin, contrastRangeMax, mean1, variance1, doCreateOverlayImages)
%
% History
% Author   | Date         |Change
%==========|==============|=================================================
% kannanuv | 2011 Feb 00  |Initial Creation
% kannanuv | 2013 Sep 20  |flag for writing overlay images
% kannanuv | 2013 Dec 17  |Bringing out smallest area size and threshold as variables
%--------------------------------------------------------------------------
function predictLabels (gpu_id, network_id, inputDirectoryFluorescence, contrastRangeMin, contrastRangeMax, mean1, variance1, doCreateOverlayImages, minAreaSize, maxAreaSize, threshold)

if (isdeployed)
    gpu_id = str2double (gpu_id);
    network_id = str2double (network_id);
    contrastRangeMin = str2double (contrastRangeMin);
    contrastRangeMax = str2double (contrastRangeMax);
    mean1 = str2double (mean1);
    variance1 = str2double (variance1);
    doCreateOverlayImages = str2double (doCreateOverlayImages);
    minAreaSize = str2double (minAreaSize);
    if (strcmp (maxAreaSize, 'blank'))
        maxAreaSize = 0;
    else
        maxAreaSize = str2double (maxAreaSize);
    end
    threshold = str2double (threshold);
else
    addpath ('../utils/');
    % enable CNS (GPU predictions)
    CNS_ROOT = '/usr/local/netgpu/jimGPUnet/';
    present_dir = pwd;
    cd (CNS_ROOT);
    startup;
    cd (present_dir);
    if (strcmp (maxAreaSize, 'blank'))
        maxAreaSize = 0;
    end
end

contrastRange = [contrastRangeMin contrastRangeMax];

%% Check parameter validity
inputDirectoryFluorescence = validateDirectory (inputDirectoryFluorescence);

%% initialization settings
networkFile = sprintf ('/usr/local/prototype_matlab/data/%d.mat', network_id);
load (networkFile);

%% Create directories for result image files
networkDirectory = sprintf ('%d', network_id);
mkdir (inputDirectoryFluorescence, networkDirectory);
networkDirectory = [inputDirectoryFluorescence '/' networkDirectory '/'];
mkdir (networkDirectory, 'prediction');
predictionDirectory = [networkDirectory 'prediction/'];
mkdir (networkDirectory, 'cleanup');
cleanupDirectory = [networkDirectory 'cleanup/'];
if (doCreateOverlayImages)
    mkdir (networkDirectory, 'overlay');
end
overlayDirectory = [networkDirectory 'overlay/'];

listOfFiles = dir (inputDirectoryFluorescence);
listOfImageFiles = struct;
imageCount = 0;

for iFile = 1:length(listOfFiles)
  isImageFile = ~isempty(findstr(listOfFiles(iFile).name, 'tif'));
  isMarkupFile = ~isempty(findstr(listOfFiles(iFile).name, 'markup'));
  isMaskFile = ~isempty(findstr(listOfFiles(iFile).name, 'mask'));
  isNormalizedFile = ~isempty(findstr(listOfFiles(iFile).name, 'normalized'));
  isPredictedFile = ~isempty(findstr(listOfFiles(iFile).name, 'prediction.tif'));
  if (isImageFile & ~isMarkupFile & ~isNormalizedFile & ~isPredictedFile & ~isMaskFile)
      imageCount = imageCount + 1;
      fileName = listOfFiles(iFile).name;
      fprintf ('Detecting cells in %s\n', [inputDirectoryFluorescence fileName]);
      listOfImageFiles(imageCount).image = strcat (inputDirectoryFluorescence, fileName);
      listOfImageFiles(imageCount).label = strcat (inputDirectoryFluorescence, fileName(1:end-4), '_markup.tif');
      listOfImageFiles(imageCount).normalized = strcat (inputDirectoryFluorescence, fileName(1:end-4), '_normalized.tif');
      listOfImageFiles(imageCount).prediction = strcat (predictionDirectory, fileName(1:end-4), '_prediction.tif');
      listOfImageFiles(imageCount).cleanup = strcat (cleanupDirectory, fileName(1:end-4), '_cleanup.tif');
      listOfImageFiles(imageCount).overlay = strcat (overlayDirectory, fileName(1:end-4), '_overlay.tif');
      
      im = single (imread (listOfImageFiles(imageCount).image));
      imOriginal = imread (listOfImageFiles(imageCount).image);
      im = (im - mean1)/variance1; 
      mask1 = single (ones (size (im)));
    
      input{1} = single(reshape(im,1,size(im,1),size(im,2),1));
      mask{1} = single(reshape(mask1,1,size(mask1,1),size(mask1,2),1));
      input2label{1} = single(1); 
      
      testDataFileName = sprintf ('%sTestFile%03d.mat', inputDirectoryFluorescence, imageCount);
      save (testDataFileName, 'input', 'mask', 'input2label', 'fileName');
      
      [output]=cnpkg2_test_split(gpu_id, m,testDataFileName, [1000 1000 1]);
      
      outputImage = shiftdim (output{1});      
      outputImage_cleanup = removeSmallRegions ((outputImage > threshold), minAreaSize, maxAreaSize);
      overlayImage = createOverlayImage (imOriginal, outputImage_cleanup, 0, 0, 64, 0, 0, contrastRangeMin, contrastRangeMax);
     
      imwrite (uint8(outputImage * 255), listOfImageFiles(imageCount).prediction, 'compress', 'lzw');
      imwrite (uint8(outputImage_cleanup * 255), listOfImageFiles(imageCount).cleanup, 'compress', 'lzw');
      if (doCreateOverlayImages)
          imwrite (overlayImage, listOfImageFiles(imageCount).overlay, 'compress', 'lzw');
      end

      delete (testDataFileName);
  end
end

cns done;