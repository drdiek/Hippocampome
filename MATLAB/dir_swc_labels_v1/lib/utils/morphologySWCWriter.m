function morphologySWCWriter(swcStructureArray, swcFileName, header)
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
  
  swcFilePtr = fopen (swcFileName, 'w+');
  
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
  
  if (isfield(swcStructureArray,'pointLabel'))
    pointLabel = single([swcStructureArray.pointLabel]);
    pointNumber = ([swcStructureArray.pointNumber]);
    pointAcronym = ([swcStructureArray.pointAcronym]);
    pointName = ([swcStructureArray.pointName]);
    pointColor = ([swcStructureArray.pointColor]);
%     swcArray = [pointID' pointType' xCoord' yCoord' zCoord' radius' parentID' pointLabel'];
%     swcArray = [pointID' pointLabel' xCoord' yCoord' zCoord' radius' parentID' pointAcronym' pointName' pointColor'];

    pointNameUnique = unique(pointName);
    nPointNameUnique = length(pointNameUnique)
    pointColorUnique = unique(pointColor);
    nPointColorUnique = length(pointColorUnique)
    pointNumberUnique = unique(pointNumber);
    nPointNumberUnique = length(pointNumberUnique)
    pause
    
    c = 1;
    for iColor = 1:nPointColorUnique
        idx = find(ismember(pointColor, pointColorUnique(iColor)));
        pointNameUnique = unique(pointName(idx));
        strng = sprintf('# %d = %s:', mod(iColor-1, 16), pointColors{iColor});
        for i = 1:length(pointNameUnique)
            strng = sprintf('%s %s;', strng, pointNameUnique{i});
            nameLookupTable{c} = pointNameUnique{i};
            colorLookupTable(c) = mod(iColor-1, 16);
            c = c + 1;
        end
        fprintf(swcFilePtr, '%s\n', strng);
    end % iColor
    
    [pointIDSorted, idx] = sort(pointID);
    
    for i = 1:length(pointID)
%         [num2str(i),' ',pointID(idx(i)),' ',pointAcronym{idx(i)},' ',pointName{idx(i)},' ',pointColor{idx(i)}]
        jdx = find(ismember(nameLookupTable, pointName{idx(i)}));
%         fprintf(swcFilePtr, '%d %u %f %f %f %f %d\n', pointID(idx(i)), pointType(idx(i)), ...
        fprintf(swcFilePtr, '%d %u %f %f %f %f %d\n', pointID(idx(i)), colorLookupTable(jdx), ...
            xCoord(idx(i)), yCoord(idx(i)), zCoord(idx(i)), radius(idx(i)), parentID(idx(i)));
%         fprintf(swcFilePtr, '%d %u %f %f %f %f %d %s %% %u; %s; %s\n', pointID(i), pointType(i), ...
%             xCoord(i), yCoord(i), zCoord(i), radius(i), parentID(i), pointColor{i}, pointNumber(i), ...
%             pointAcronym{i}, pointName{i});
    end
    nUniquePointNumbers = length(unique(pointNumber))
  else
    swcArray = [pointID' pointType' xCoord' yCoord' zCoord' radius' parentID'];
    fprintf(swcFilePtr, '%d %u %f %f %f %f %d\n', swcArray');
  end
  
  fclose (swcFilePtr);