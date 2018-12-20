function writeSWCToElastixFile (inputFileName)
% modified by Diek W. Wheeler 08/07/2018
if (~isdeployed)
    addpath ('./lib/cellCounting/');
    addpath ('./lib/utils/');
end

% Read morphology structure
morphologyStructure = morphologySWCReader (inputFileName, 0);

% Re-structure point co-ordinates the morphology structure to array
pointList = [[morphologyStructure.xCoord]; [morphologyStructure.yCoord]; [morphologyStructure.zCoord]]';

% Set elastix input text file name
elastixFileName = sprintf ('%s_pointList.txt', inputFileName(1:end-4));

% Write elastix file name
writeElastixPointFile (elastixFileName, pointList');