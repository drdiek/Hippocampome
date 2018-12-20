function morphologySWCWriter(swcStructureArray, swcFileName)
%UNTITLED Summary of this function goes here
% Detailed explanation goes here
  pointID = single([swcStructureArray.pointID]);
  pointType = single([swcStructureArray.pointType]);
  xCoord =  single([swcStructureArray.xCoord]);
  yCoord =  single([swcStructureArray.yCoord]);
  zCoord =  single([swcStructureArray.zCoord]);
  radius = single([swcStructureArray.radius]);
  parentID =  single([swcStructureArray.parentID]);
  
  swcFilePtr = fopen (swcFileName, 'w+');

  if (isfield(swcStructureArray,'pointLabel'))
    pointLabel = single([swcStructureArray.pointLabel]);
    swcArray = [pointID' pointType' xCoord' yCoord' zCoord' radius' parentID' pointLabel'];
    fprintf(swcFilePtr, '%d %u %f %f %f %f %d #%d\n', swcArray');
  else
    swcArray = [pointID' pointType' xCoord' yCoord' zCoord' radius' parentID'];
    fprintf(swcFilePtr, '%d %u %f %f %f %f %d\n', swcArray');
  end
  
fclose (swcFilePtr);