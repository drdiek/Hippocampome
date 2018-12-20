%resizeImages ('/home/kannanuv/data/TissueVisionScope/101210_JT_halo-tta/101210_JT_halo_stitch/', '/home/kannanuv/data/TissueVisionScope/101210_JT_halo-tta/101210_JT_halo_stitch/warping/123.tif', 'Stit', 0.05, [450 650])

function resizeImages (inputDirectory, scaledFileName, filter, scale, finalSizestart, finalSizeend, imageType)

%addpath ('/usr/local/netgpu/fluoMouseBrain/scripts/utils/');

%% Check parameter validity
if (inputDirectory(end) ~= '/')
    inputDirectory = [inputDirectory '/'];
end

%% Check if the file is deployed
if (isdeployed)
    scale = str2double(scale);
    finalSizestart = str2double(finalSizestart);
    finalSizeend = str2double(finalSizeend);
    finalSize = [finalSizestart finalSizeend];
end

%% Check image type
switch (imageType)
    case 'label'
        interpolationTechnique = 'nearest';
    case 'greyscale'
        interpolationTechnique = 'bilinear';
    otherwise
        warning ('Image type can be either ''label'' or ''greyscale'' only.');
end

listOfFiles = dir ([inputDirectory '*tif']);
numberOfImages = 0;
imageIndex = -1;

for iFile = 1:length(listOfFiles)
    imageFileName = listOfFiles(iFile).name;
    isInImageSet= ~isempty(findstr(listOfFiles(iFile).name, filter));
    if (isInImageSet)
        numberOfImages = numberOfImages + 1;
        imageIndex = iFile;
    end
end


% TBD final size and scaling validation
sampleImageFile = [inputDirectory listOfFiles(imageIndex).name]
im = imread(sampleImageFile);
imscaled = imresize (im, scale);

scaledImage = zeros (size(imscaled, 1), size(imscaled, 2), numberOfImages);

iImage = 1;
for iFile = 1:length(listOfFiles)
    imageFileName = [inputDirectory listOfFiles(iFile).name]
    isInImageSet= ~isempty(findstr(imageFileName, filter));
    if (isInImageSet)
        scaledImage(:,:,iImage) = imresize (single (imread (imageFileName)), scale, interpolationTechnique);
        iImage = iImage + 1;
    end
end

paddingSize = finalSize - [size(imscaled,1) size(imscaled,2)];
if (paddingSize(1) < 0)
    scaledImage = scaledImage(1:finalSize(1), :);
end
if (paddingSize(2) < 0)
    scaledImage = scaledImage(:, 1:finalSize(2));
end
paddingSize = finalSize - [size(imscaled,1) size(imscaled,2)];

scaledImage = padarray (scaledImage, paddingSize , 'post');

imwritestack(cast(scaledImage, class(imscaled)), scaledFileName); 
