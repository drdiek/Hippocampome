function [swcList, header] = morphologySWCReader(swcFileName, doVisualizeSWC)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% modified by Diek W. Wheeler 08/07/2018
  addpath ('./data/ARA/');
  addpath ('./data/CCF/');
  
  fid = fopen(swcFileName, 'r');
  txtLine = fgetl(fid);
  i = 0;
  while strcmp(txtLine(1), '#')
      i = i + 1;
      header{i} = txtLine;
      txtLine = fgetl(fid);
  end
  fclose(fid);
  
  swcFilePtr = fopen (swcFileName, 'r');
  %swcswcPointList = readtable (swcFileName);
  swcPointList = textscan(swcFilePtr, '%d %u %f %f %f %f %d', 'CommentStyle', '#');
  fclose (swcFilePtr);

  pointID = swcPointList{1};
  pointType = swcPointList{2};
  xCoord = swcPointList{3};
  yCoord = swcPointList{4};
  zCoord = swcPointList{5};
  radius = swcPointList{6};
  parentID = swcPointList{7};
  %swcList = struct('pointID', 0 ,'pointType', 0,'xCoord', 0,'yCoord', 0, 'zCoord', 0, 'radius', 0, 'parentID');
  for iPointStructure = 1:length(pointID)
    swcList(iPointStructure).pointID = pointID(iPointStructure);
    swcList(iPointStructure).pointType = pointType(iPointStructure);
    swcList(iPointStructure).xCoord = xCoord(iPointStructure);
    swcList(iPointStructure).yCoord = yCoord(iPointStructure);
    swcList(iPointStructure).zCoord = zCoord(iPointStructure);
    swcList(iPointStructure).radius = radius(iPointStructure);
    swcList(iPointStructure).parentID = parentID(iPointStructure);
  end
  
  %% A simple routine to 3-D plot SWC files
  if (doVisualizeSWC)
      figure(1);
      plot3 (xCoord, yCoord, zCoord, '.', 'Color', [1 1 1]);axis equal;
      for i = 1:length(pointID)
          if (i < 1000)
              plotColor = [1 0 0];
          elseif (i < 2000)
              plotColor = [0 1 0];
          else
              plotColor = [0 0 1];
          end
          plot3(xCoord(i), yCoord(i), zCoord(i), '.', 'Color', plotColor);
          hold on;
      end % i
      axis equal;
      pause
    plot3 (xCoord, yCoord, zCoord, '.', 'Color', [1 0 0]);axis equal;
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

