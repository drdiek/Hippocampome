% Given a standard SWC file, the annotator gives the annotation of the
% morphology file
%inputSWCFile = 'C:\Users\kannanuv\Downloads\gaa\Han_etal_ARA.swc';
%outputSWCFile = 'C:\Users\kannanuv\Downloads\gaa\Han_etal_ARA_openSTP.swc';
%labelImageFile = 'D:\data\CerterraDropbox\Dropbox (CSHL-Certerra)\allenAtlas\annot_025.nrrd';
%scalingFactor = 1/25;

function morphologyMatrix = morphologySWCAnnotator (inputSWCFile, outputSWCFile, ...
    labelImageFile, scalingFactor, isARA, processingFunction, morphologyMatrix)
% modified by Diek W. Wheeler 09/19/2018
if (~isdeployed)
  addpath ('./lib/utils');
end

CONVERT = 1;
PLOT = 2;
MATRIX = 3;

doVisualizeSWC = 0;

[swcList, header] = morphologySWCReader(inputSWCFile, doVisualizeSWC); % swcList data are in order (x) x (y) x (z)

pointList = [swcList.xCoord; swcList.yCoord; swcList.zCoord]; % pointList data are in order (x) x (y) x (z)
pointList = pointList * scalingFactor;

% labelImageFile has data that are 528(z) x 320(y) x 456(x)
labelImage = nrrdread (labelImageFile, isARA); % labelImage data have dimensions 320(y) x 456(x) x 528(z)

% pointList data are in order (x) x (y) x (z)
% labelImage data have dimensions 320(y) x 456(x) x 528(z)
whos labelImage pointList

% li = labelImage(79,199,281)
% li = labelImage(84,150,349)
% pause

% figure;
% for i = 1:320
%     imagesc(squeeze(labelImage(i,:,:)));
%     colormap(lines)
%     ii = i
%     pause
% end
% pause

% pointList data are in order (x) x (y) x (z)
% labelImage data have dimensions 320(y) x 456(x) x 528(z)
if isARA
    pointLabels = interp3 (labelImage, pointList(2,:), pointList(3,:) , pointList(1,:), 'nearest');
else % is CCF
    pointLabels = interp3 (labelImage, pointList(1,:), pointList(2,:) , pointList(3,:), 'nearest');
end    
whos pointLabels
% fid = fopen('./output/pointLabels.csv', 'w');
% % labelImage has dimensions 320(y) x 528(z) x 456(x)
% % Re-arrange pointLabels so they are 528(z)
% for i = 1:length(pointList)
%     fprintf(fid, '%u,%.6f,%.6f,%.6f,%u\n', pointLabels(i), pointList(2,i), pointList(1,i), pointList(3,i), labelImage(round(pointList(2,i)),round(pointList(1,i)),round(pointList(3,i))));
%     pointLabels(i) = labelImage(round(pointList(2,i)),round(pointList(1,i)),round(pointList(3,i)));
% end
% fclose(fid)
% pause

pNANC = read_numbers_acronyms_names_colors(isARA);

length(swcList)
% pause

for iPoint = 1:length (swcList)
  swcList(iPoint).pointLabel = pointLabels(iPoint);
%   if (pointLabels(iPoint) == 0)
  idx = find(pNANC.numbers == pointLabels(iPoint));
  if (~pointLabels(iPoint) || isempty(idx))
      swcList(iPoint).pointNumber = 0;
      swcList(iPoint).pointAcronym = {'unknown'};
      swcList(iPoint).pointName = {'unknown'};
      swcList(iPoint).pointColor = {'#FFFFFF'};
  else
      swcList(iPoint).pointNumber = pNANC.numbers(idx);
      swcList(iPoint).pointAcronym = pNANC.acronyms(idx);
      swcList(iPoint).pointName = pNANC.names(idx);
      swcList(iPoint).pointColor = pNANC.colors(idx);
  end
end

if ((processingFunction == CONVERT) || (processingFunction == PLOT))
    morphologySWCWriter (swcList, outputSWCFile, header, labelImageFile);
elseif (processingFunction == MATRIX)
    morphologyMatrix = morphology_matrix(swcList, inputSWCFile, morphologyMatrix);
end