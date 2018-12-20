function morphologySWCHeader(swcStructureArray, swcFileName, header)
%UNTITLED Summary of this function goes here
% Detailed explanation goes here
% modified by Diek W. Wheeler 08/02/2018
  pointID = single([swcStructureArray.pointID]);
  pointType = single([swcStructureArray.pointType]);
  xCoord =  single([swcStructureArray.xCoord]);
  yCoord =  single([swcStructureArray.yCoord]);
  zCoord =  single([swcStructureArray.zCoord]);
  radius = single([swcStructureArray.radius]);
  parentID =  single([swcStructureArray.parentID]);
  
  swcFilePtr = fopen (swcFileName, 'w');
  
  for i = 1:length(header)
      fprintf(swcFilePtr, '%s\n', header{i});
  end
  fprintf(swcFilePtr, '#\n');
  fprintf(swcFilePtr, '# modified by Diek W. Wheeler %s\n', datestr(now, 'yyyy/mm/dd'));

  pointColors = {'white'; ...
                 'red'; ...
                 'gray'; ...
                 'green'; ...
                 'magenta'; ...
                 'cyan'; ...
                 'pink'; ...
                 'blue'; ...
                 'yellow'; ...
                 'orange'; ...
                 'purple'; ...
                 'dark red'; ...
                 'dark green'; ...
                 'dark blue'; ...
                 'light brown'; ...
                 'light green'};
  
  pointLabel = single([swcStructureArray.pointLabel]);
  pointNumber = ([swcStructureArray.pointNumber]);
  pointAcronym = ([swcStructureArray.pointAcronym]);
  pointName = ([swcStructureArray.pointName]);
  pointColor = ([swcStructureArray.pointColor]);
  
  pointColorUnique = unique(pointColor);
  nPointColorUnique = length(pointColorUnique);
  
  for iColor = 1:nPointColorUnique
      idx = find(ismember(pointColor, pointColorUnique(iColor)));
      pointNameUnique = unique(pointName(idx));
      strng = sprintf('# %d = %s:', mod(iColor-1, 16), pointColors{iColor});
      for i = 1:length(pointNameUnique)
          strng = sprintf('%s %s;', strng, pointNameUnique{i});
      end
      fprintf(swcFilePtr, '%s\n', strng);
  end % iColor
  
  fclose (swcFilePtr);