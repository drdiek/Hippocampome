%% This function was written to generate training tiles for training to do the inpainting task
function chooseTrainingTile (nTiles, tileSize, imageDirectory, downSampledMaskImageFile, datasetPrefix, outputFolder, doVisualizeOn)

if (isdeployed)
    nTiles = str2double(nTiles);
    tileSize = str2double(tileSize);
    doVisualizeOn = str2double(doVisualizeOn);
else
    addpath ('../utils/');
end

imageDirectory = validateDirectory (imageDirectory);
outputFolder = validateDirectory (outputFolder);

imageHeight = 0; 
imageWidth = 0;
listOfImageFiles =  dir ([imageDirectory '*tif']);
nImageFile = length(listOfImageFiles);

%% Generate random co-ordinates
if (strcmp (downSampledMaskImageFile, 'blank'))
    downSampledMaskImage = 0;
    listOfImageFiles =  dir ([imageDirectory '*tif']);
    firstImageFile = [imageDirectory listOfImageFiles(1).name];
    imStitchedImageInfo = imfinfo (firstImageFile);
    imageWidth = imStitchedImageInfo.Width;
    imageHeight = imStitchedImageInfo.Height;
    randomHeight = randi ((imageHeight - tileSize), [nTiles, 1]);
    randomWidth = randi ((imageWidth - tileSize), [nTiles, 1]);
    randomSection = randi (nImageFile, [nTiles, 1]);
    randomListOfFiles = randi (nImageFile, [nTiles 1]);
else
    downSampledMaskImage = imreadstack (downSampledMaskImageFile);
    %% Create mask with dilation on Left and top
    maskZeros = zeros (tileSize / 20);     maskOnes = ones (tileSize / 20);
    dilationMask = [maskOnes maskZeros; maskZeros maskZeros];
    downSampledMaskImage = imdilate (downSampledMaskImage, dilationMask);
    %imwritestack (downSampledMaskImage, [downSampledMaskImageFile(1:end-4) '_dilated.tif']);
    idx = find (downSampledMaskImage > 0.5);
    y = randperm(length(idx),nTiles);
    rand_idx = idx(y); 
    [randomHeight, randomWidth, randomSection] = ind2sub (size (downSampledMaskImage), rand_idx);
    randomHeight = randomHeight * 20;
    randomWidth = randomWidth * 20;
    if (doVisualizeOn)
        maskBlankImage = zeros (size (downSampledMaskImage));
        maskBlankImage(rand_idx) = 1;
        imwritestack (maskBlankImage, [downSampledMaskImageFile(1:end-4) '_sampleLocations.tif']);
    end
end

randomPatchCoordinates = [randomHeight randomWidth randomSection];
randomPatchCoordinates = sortrows (randomPatchCoordinates, [3 2]);

%% Generate random tiles from co-ordinates generated
for iImage = 1:nImageFile
    randomPatchCoordinatesPerImage = randomPatchCoordinates (randomPatchCoordinates(:,3) == iImage, :);
    if (size (randomPatchCoordinatesPerImage, 1) ~= 0)
        imageFileName = [imageDirectory listOfImageFiles(iImage).name];
        imageSlice = imread (imageFileName);
        for iTile = 1:size (randomPatchCoordinatesPerImage, 1)
            tileCoords = randomPatchCoordinatesPerImage(iTile, 1:2);
            tileFileName = sprintf ('%s%s_Slice_%04d_Tile_%05d.tif', outputFolder, datasetPrefix, iImage, iTile);
            tileImage = imageSlice (tileCoords(1):tileCoords(1)+tileSize-1, tileCoords(2):tileCoords(2)+tileSize-1);
            imwrite (tileImage, tileFileName);
        end
    end
end

listOfTilesInfo = zeros (nTiles, 3);

if (doVisualizeOn)
    figure(1); hold on;
    generateMaskVolume (downSampledMaskImage);
end

generateTileListLogFile (listOfImageFiles, randomPatchCoordinates, tileSize, outputFolder, doVisualizeOn)
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