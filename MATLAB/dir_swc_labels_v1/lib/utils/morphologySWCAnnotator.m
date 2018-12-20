% Given a standard SWC file, the annotator gives the annotation of the
% morphology file
%inputSWCFile = 'C:\Users\kannanuv\Downloads\gaa\Han_etal_ARA.swc';
%outputSWCFile = 'C:\Users\kannanuv\Downloads\gaa\Han_etal_ARA_openSTP.swc';
%labelImageFile = 'D:\data\CerterraDropbox\Dropbox (CSHL-Certerra)\allenAtlas\annot_025.nrrd';
%scalingFactor = 1/25;

function morphologySWCAnnotator (inputSWCFile, outputSWCFile, labelImageFile, scalingFactor)
% modified by Diek W. Wheeler 08/02/2018
if (~isdeployed)
  addpath ('./lib/utils');
end

doVisualizeSWC = 0;

[swcList, header] = morphologySWCReader(inputSWCFile, doVisualizeSWC); % swcList data are in order (x) x (y) x (z)

pointList = [swcList.xCoord; swcList.yCoord; swcList.zCoord]; % pointList data are in order (x) x (y) x (z)
pointList = pointList * scalingFactor;

% labelImageFile has data that are 528(z) x 320(y) x 456(x)
labelImage = nrrdread (labelImageFile); % labelImage data have dimensions 320(y) x 456(x) x 528(z)

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
pointLabels = interp3 (labelImage, pointList(1,:), pointList(2,:) , pointList(3,:), 'nearest');

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

pNANC = read_numbers_acronyms_names_colors(0);

for iPoint = 1:length (swcList)
  swcList(iPoint).pointLabel = pointLabels(iPoint);
%   if (pointLabels(iPoint) == 0)
  if ~pointLabels(iPoint)
      swcList(iPoint).pointNumber = 0;
      swcList(iPoint).pointAcronym = 'dww';
      swcList(iPoint).pointName = 'Diek W. Wheeler';
      swcList(iPoint).pointColor = '#FFFFFF';
  else
      idx = find(pNANC.numbers == pointLabels(iPoint))
      swcList(iPoint).pointNumber = pNANC.numbers(idx);
      swcList(iPoint).pointAcronym = pNANC.acronyms(idx);
      swcList(iPoint).pointName = pNANC.names(idx)
      swcList(iPoint).pointColor = pNANC.colors(idx);
  end
end

morphologySWCWriter (swcList, outputSWCFile, header);