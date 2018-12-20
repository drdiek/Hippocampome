%nTiles = 100;
%tileSize = 32;
%channel1ImageFile = 'D:\data\others\pisano\increased_resolution\input_rawdata';
%labelFile = 'D:\data\others\pisano\increased_resolution\output_labels';
%datasetPrefix = 'increased_resolution';
%outputFolder = 'D:\data\others\pisano\increased_resolution\333Dilation';
%doVisualizeOn = 0;

%% This function is choosen for genrating multiple training tiles with multiple channel and ground truth data
function chooseMultiChannelBalancedTrainingTile (nTiles, tileSize, channel1ImageFile, labelFile, datasetPrefix, outputFolder, doVisualizeOn)

if (isdeployed)
    nTiles = str2double(nTiles);
    tileSize = str2double(tileSize);
    doVisualizeOn = str2double(doVisualizeOn);
else
    addpath ('../utils/');
end

%% Read the input image file stack or series
isInputImageSeries = isfolder (channel1ImageFile);
isInputLabelSeries = isfolder (labelFile);
if (isInputImageSeries)
  channel1Images = imreadseries (channel1ImageFile, 'tif');
else
  channel1Images = imreadstack(channel1ImageFile);
end

if (isInputLabelSeries)
  labelImages = imreadseries (labelFile, 'tif');
else
  labelImages = imreadstack (labelFile);
end

%% Set output directory
outputFolder = validateDirectory (outputFolder);
mkdir (outputFolder, 'trainingImageTiles');
mkdir (outputFolder, 'trainingLabelTiles');
channel1TrainingTileFolder = fullfile (outputFolder, 'trainingImageTiles');
labelTrainingTileFolder = fullfile (outputFolder, 'trainingLabelTiles');

% imageHeight = 0; 
% imageWidth = 0;
% listOfImageFiles =  dir ([channel1ImageDirectory '*tif']);
% nImageFile = length(listOfImageFiles);

%% Generate random co-ordinates
%labelImages = imreadseries (labelDirectory);
%channel1Images = imreadseries(channel1ImageDirectory);
%channel2Images = imreadseries(channel2ImageDirectory);
%channel3Images = imreadseries(channel3ImageDirectory);
%labelImages = padarray(labelImages,[6 6],0,'both');

%channel2Images = imreadstack(channel2ImageFile);
%channel3Images = imreadstack(channel3ImageFile);

%% Create mask with dilation
dilationMask = ones (3,3,3);
labelImages = imdilate (labelImages, dilationMask);
idx = find (labelImages > 0.5);
y = randperm(length(idx),nTiles);
rand_idx = idx(y); 
[randomHeight, randomWidth, randomSection] = ind2sub (size (labelImages), rand_idx);

if (doVisualizeOn)
    maskBlankImage = zeros (size (channel1Images));
    maskBlankImage(rand_idx) = 1;
    imwritestack (maskBlankImage, [labelFile(1:end-4) '_sampleLocations.tif']);
end

randomPatchCoordinates = [randomHeight randomWidth randomSection];
randomPatchCoordinates = sortrows (randomPatchCoordinates, [3 2]);

%% Generate random tiles from co-ordinates generated
padSize = floor(tileSize/2);
channel1PaddedImages = padarray (channel1Images, [padSize padSize], 'symmetric', 'both');
labelPaddedImages = padarray (labelImages, [padSize padSize], 'symmetric', 'both');
nImage = size (labelPaddedImages, 3);
for iImage = 1:nImage
    randomPatchCoordinatesPerImage = randomPatchCoordinates (randomPatchCoordinates(:,3) == iImage, :);
    if (size (randomPatchCoordinatesPerImage, 1) ~= 0)
        for iTile = 1:size (randomPatchCoordinatesPerImage, 1)
            tileCoords = randomPatchCoordinatesPerImage(iTile, 1:2);
            channel1tileFileName = fullfile (channel1TrainingTileFolder, sprintf ('channel1%s_Slice_%04d_Tile_%05d.tif', datasetPrefix, iImage, iTile));
            labelTileFileName = fullfile (labelTrainingTileFolder, sprintf ('label%s_Slice_%04d_Tile_%05d.tif', datasetPrefix, iImage, iTile));
            channel1ImageTile = channel1PaddedImages (tileCoords(1):tileCoords(1)+2*padSize-1, tileCoords(2):tileCoords(2)+2*padSize-1, iImage);
            labelImageTile =    labelPaddedImages    (tileCoords(1):tileCoords(1)+2*padSize-1, tileCoords(2):tileCoords(2)+2*padSize-1, iImage);    
            fprintf ('File Sequence Number : %d, co-ords : (%d, %d)\n', iImage, tileCoords(2), tileCoords(1))
%             figure(1);
%             subplot(1,2,1), imagesc(channel1ImageTile)
%             subplot(1,2,2), imagesc(labelImageTile)
%             pause;
            imwrite (channel1ImageTile, channel1tileFileName);
            imwrite (uint8(labelImageTile * 255), labelTileFileName);
        end
    end
end

listOfTilesInfo = zeros (nTiles, 3);

%if (doVisualizeOn)
%    figure(1); hold on;
%    generateMaskVolume (downSampledMaskImage);
%end

%generateTileListLogFile (listOfImageFiles, randomPatchCoordinates, tileSize, outputFolder, 0)
%scatter3 (listOfTilesInfo(:,1), listOfTilesInfo(:,2), listOfTilesInfo(:,3), 's', 'MarkerFaceColor', 'flat');

function generateTileListLogFile (listOfImageFiles, listOfTilesInfo, tileSize, outputFolder, doVisualizeOn)

logFileName = sprintf ('%s/log1.txt', outputFolder);
filePtr = fopen (logFileName, 'w+');
for iTile = 1:size(listOfTilesInfo,1)
    xCoord = listOfTilesInfo(iTile, 1);
    yCoord = listOfTilesInfo(iTile, 2);
    imageFileName = listOfImageFiles(listOfTilesInfo(iTile, 3)).name;
    
    fprintf (filePtr, '%s, %d, %d, %d\n', imageFileName, xCoord, yCoord, tileSize);
    
    % draw rectangle in 3D
    if (doVisualizeOn)
        xCoord = xCoord/20; 
        yCoord = yCoord/20; 
        zCoord = listOfTilesInfo(iTile, 3);
        tileSize1 = tileSize/20;
        p1 = [xCoord yCoord zCoord];
        p2 = [xCoord yCoord+tileSize1 zCoord];
        p4 = [xCoord+tileSize1 yCoord zCoord];
        p3 = [xCoord+tileSize1 yCoord+tileSize1 zCoord];

        x = [p1(1) p2(1) p3(1) p4(1)];
        y = [p1(2) p2(2) p3(2) p4(2)];
        z = [p1(3) p2(3) p3(3) p4(3)];

        fill3(x, y, z, [0.5 0 0]);
    end
end

fclose (filePtr);

function generateMaskVolume (downSampledMaskImage)

[x, y, z] = meshgrid ((1:size(downSampledMaskImage,2)), (1:size(downSampledMaskImage,1)), (1:size(downSampledMaskImage,3)));
[faces,verts,colors] = isosurface(x,y,z,downSampledMaskImage,0.99, downSampledMaskImage);


patch ('Vertices', verts, 'Faces', faces, ... 
    'FaceVertexCData', colors, 'FaceAlpha', 0.8, 'EdgeAlpha', 0.8, ...
     'FaceColor','interp', ... 
    'edgecolor', 'interp');
%isonormals(x,y,z,downSampledMaskImage,p)
%p.FaceColor = [0 0.5 0];
%p.EdgeColor = 'red';
%p.FaceAlpha = 0.3;
daspect([1,1,0.2])
view(3); axis tight
camlight 
lighting gouraud