function pointList = readElastixPointFile (elastixFileName)
%% Read elastix point list file
% modified by Diek W. Wheeler 08/07/2018

addpath('./lib/data');

fp = fopen (elastixFileName, 'r');
lineOne = fgetl (fp);
nPoints = str2num (fgetl (fp));
pointList = zeros (nPoints, 3);
pointList = fscanf (fp, '%f %f %f');
pointList = reshape (pointList, [3 nPoints]);
%pointList = pointList';
fclose (fp);