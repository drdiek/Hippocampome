function writeTransformixToSWCFile (inputTranformixFileName, inputSWCFileName)

if (~isdeployed)
    addpath ('../cellCounting/');
    addpath ('../utils/');
end

morphologyStructure = morphologySWCReader (inputSWCFileName, 0);

fp = fopen (inputTranformixFileName);
C = textscan (fp, 'Point	%d	; InputIndex = [ %d %d %d ]	; InputPoint = [ %f %f %f ]	; OutputIndexFixed = [ %d %d %d ]	; OutputPoint = [ %f %f %f ]	; Deformation = [ %f %f %f ]');
fclose (fp);
pointList = cell2mat(C(11:13));

for iPoint = 1:length(morphologyStructure)
  morphologyStructure(iPoint).xCoord = pointList(iPoint,1);
  morphologyStructure(iPoint).yCoord = pointList(iPoint,2);
  morphologyStructure(iPoint).zCoord = pointList(iPoint,3);
end

morphologyStructureOutputFileName = sprintf ('%s_transformed.swc', inputTranformixFileName(1:end-4));
morphologySWCWriter (morphologyStructure, morphologyStructureOutputFileName);