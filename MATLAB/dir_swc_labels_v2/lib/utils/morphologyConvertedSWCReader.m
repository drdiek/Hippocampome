function swcList = morphologyConvertedSWCReader(swcFileName, doVisualizeSWC)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% modified by Diek W. Wheeler 09/13/2018
  addpath ('./output/');
  
  swcFilePtr = fopen (swcFileName, 'r');
  %swcswcPointList = readtable (swcFileName);
  swcPointList = textscan(swcFilePtr, '%d %u %f %f %f %f %d %s', 'CommentStyle', '%');
%   swcPointList = textscan(swcFilePtr, '%d %u %f %f %f %f %d', 'CommentStyle', '#');
  fclose (swcFilePtr);

  pointID = swcPointList{1};
  pointType = swcPointList{2};
  xCoord = swcPointList{3};
  yCoord = swcPointList{4};
  zCoord = swcPointList{5};
  radius = swcPointList{6};
  parentID = swcPointList{7};
  colors = swcPointList{8};
  %swcList = struct('pointID', 0 ,'pointType', 0,'xCoord', 0,'yCoord', 0, 'zCoord', 0, 'radius', 0, 'parentID');
%   for iPointStructure = 1:length(pointID)
%     swcList(iPointStructure).pointID = pointID(iPointStructure);
%     swcList(iPointStructure).pointType = pointType(iPointStructure);
%     swcList(iPointStructure).xCoord = xCoord(iPointStructure);
%     swcList(iPointStructure).yCoord = yCoord(iPointStructure);
%     swcList(iPointStructure).zCoord = zCoord(iPointStructure);
%     swcList(iPointStructure).radius = radius(iPointStructure);
%     swcList(iPointStructure).parentID = parentID(iPointStructure);
%   end
  
  %% A simple routine to 3-D plot SWC files
  if (doVisualizeSWC)
      figure(1);
      plot3 (xCoord, yCoord, zCoord, '.', 'Color', [1 1 1]);axis equal;
      for i = 1:length(pointID)
          rHexStr = extractAfter(colors(i), 1);
          rHexStr = rHexStr{1}(1:2);
          R = hex2dec(rHexStr)/255;
          gHexStr = extractAfter(colors(i), 3);
          gHexStr = gHexStr{1}(1:2);
          G = hex2dec(gHexStr)/255;
          bHexStr = extractAfter(colors(i), 5);
          B = hex2dec(bHexStr)/255;
          plotColor = [R G B];
          plot3(xCoord(i), yCoord(i), zCoord(i), '.', 'Color', plotColor);
          hold on;
      end % i
      axis equal;
      pause
    for iPoint = 1:length(pointID)
      if (parentID(iPoint) ~= -1)
        if (mod(iPoint, 100) == 1)
            fprintf ('Plotting %d\n', iPoint)
        end
        X1 = [xCoord(iPoint) xCoord(parentID(iPoint))];
        Y1 = [yCoord(iPoint) yCoord(parentID(iPoint))];
        Z1 = [zCoord(iPoint) zCoord(parentID(iPoint))];
        hold on; plot3 (X1, Y1, Z1, 'LineStyle', '-');
      end
    end
    hold off;
  end
end

