%--------------------------------------------------------------------------
% function predictLabels2Channel is similair to function predictLabels.m but
% this function allows prediction of c-fos-gfp nuclei or equivalent
% structures
%
% Usage 
% predictLabels2Channel (gpu_id, inputDirectoryFluorescence, inputDirectoryAutoFluorescence, ...
%    contrastRange, ...
%    meanFluorescence, varianceFluorescence, ...
%    meanAutoFluorescence, varianceAutoFluorescence)
% History
% Author   | Date         |Change
%==========|==============|=================================================
% kannanuv | 2012 Feb 22  |Initial Creation
% kannanuv | 2013 May 17  |Adapt to different networks
% kannanuv | 2013 Aug 04  |Fixed bug for deployment
% kannanuv | 2013 Sep 20  |flag for writing overlay images
%--------------------------------------------------------------------------

function predictLabels2Channel (gpu_id, network_id, inputDirectoryFluorescence, inputDirectoryAutoFluorescence, contrastRangeMin, contrastRangeMax, meanFluorescence, varianceFluorescence, ...
    meanAutoFluorescence, varianceAutoFluorescence, doCreateOverlayImages, minAreaSize, maxAreaSize, threshold)

if (isdeployed)
    gpu_id = str2double (gpu_id);
    network_id = str2double (network_id);
    contrastRangeMin = str2double (contrastRangeMin);
    contrastRangeMax = str2double (contrastRangeMax);
    meanFluorescence = str2double (meanFluorescence);
    varianceFluorescence = str2double (varianceFluorescence);
    meanAutoFluorescence = str2double (meanAutoFluorescence);
    varianceAutoFluorescence = str2double (varianceAutoFluorescence);    
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
    CNS_ROOT = '/usr/local/netgpu/jimGPUnet/';
    present_dir = pwd;
    % enable CNS (GPU predictions)
    cd (CNS_ROOT);
    startup;
    cd (present_dir)
end

contrastRange = [contrastRangeMin contrastRangeMax];


%% Check parameter validity
inputDirectoryFluorescence = validateDirectory (inputDirectoryFluorescence);
inputDirectoryAutoFluorescence = validateDirectory (inputDirectoryAutoFluorescence);

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
  if (isImageFile)
      imageCount = imageCount + 1;
      fileName = listOfFiles(iFile).name;
      listOfImageFiles(imageCount).fluorescenceImage = strcat (inputDirectoryFluorescence, fileName);
      listOfImageFiles(imageCount).autoFluorescenceImage = strcat (inputDirectoryAutoFluorescence, fileName);
      listOfImageFiles(imageCount).prediction = strcat (predictionDirectory, fileName(1:end-4), '_prediction.tif');
      listOfImageFiles(imageCount).cleanup = strcat (cleanupDirectory, fileName(1:end-4), '_cleanup.tif');
      listOfImageFiles(imageCount).overlay = strcat (overlayDirectory, fileName(1:end-4), '_overlay.tif');
      
      imFluorescence = single (imread (listOfImageFiles(imageCount).fluorescenceImage));
      imAutoFluorescence = single (imread (listOfImageFiles(imageCount).autoFluorescenceImage));
      imOriginal = imread (listOfImageFiles(imageCount).fluorescenceImage);
      im = ((imFluorescence - meanFluorescence)/varianceFluorescence) - ((imAutoFluorescence - meanAutoFluorescence)/varianceAutoFluorescence); 
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
