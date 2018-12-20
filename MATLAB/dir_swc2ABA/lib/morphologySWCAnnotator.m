% Given a standard SWC file, the annotator gives the annotation of the
% morphology file
%inputSWCFile = 'C:\Users\kannanuv\Downloads\gaa\Han_etal_ARA.swc';
%outputSWCFile = 'C:\Users\kannanuv\Downloads\gaa\Han_etal_ARA_openSTP.swc';
%labelImageFile = 'D:\data\CerterraDropbox\Dropbox (CSHL-Certerra)\allenAtlas\annot_025.nrrd';
%scalingFactor = 1/25;

function morphologySWCAnnotator (inputSWCFile, outputSWCFile, labelImageFile, scalingFactor)

if (~isdeployed)
  addpath ('../utils/');
end

swcList = morphologySWCReader(inputSWCFile, 0); 
  
pointList = [swcList.xCoord; swcList.yCoord; swcList.zCoord];
pointList = pointList * scalingFactor;

labelImage = nrrdread (labelImageFile);

pointLabels = interp3 (labelImage, pointList(2,:), pointList(1,:) , pointList(3,:), 'nearest');

for iPoint = 1:length (swcList)
  swcList(iPoint).pointLabel = pointLabels(iPoint);
end

morphologySWCWriter (swcList, outputSWCFile);