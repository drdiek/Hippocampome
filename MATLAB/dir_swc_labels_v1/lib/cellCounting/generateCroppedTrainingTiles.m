% inputFileName = 'D:\data\others\160824_RP_TONKSS1_processed\sampleTiles.csv'
% inputDirectory = 'D:\data\others\160824_RP_TONKSS1_processed\stitchedImage_ch2\'
% datasetPrefix = '160824_RP_TONKSS1';
% tileSize = 1000;
% once the tiles are generated convert them to nrrd in c3d and make markups
% in itk-snap
function generateCroppedTrainingTiles(inputFileName, datasetPrefix, inputDirectory, tileSize)

if (~isdeployed)
    addpath ('../utils/');
end

[directoryName, ~, ~] = fileparts(inputFileName);

tileTable = readtable(inputFileName, 'Delimiter', ',');
fileNames = tileTable{:,1};
xCoords = tileTable{:,2};
yCoords = tileTable{:,3};

for iTile = 1:size(tileTable,1)
    sectionFileName = [inputDirectory '\' fileNames{iTile}];
    imSection = imread (sectionFileName);
    [~, sectionFileName, ~] = fileparts(sectionFileName);
    fprintf ('Processing %s\n', sectionFileName)
    imTile = imSection(yCoords(iTile):yCoords(iTile)+tileSize-1, xCoords(iTile):xCoords(iTile)+tileSize-1);
    tileFileName = sprintf ('%s_%s_X%05d_Y%05d.tif', datasetPrefix, sectionFileName, xCoords(iTile), yCoords(iTile));
    tileFileName = fullfile (directoryName, tileFileName);
    imwrite (imTile, tileFileName);
end