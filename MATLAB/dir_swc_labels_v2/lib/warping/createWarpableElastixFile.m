function createWarpableElastixFile(dataFileName, usableZSlices_start, usableZSlices_end, nZSections)

load (dataFileName);

if (isdeployed)
    usableZSlices_start = str2double(usableZSlices_start);
    usableZSlices_end = str2double(usableZSlices_end);
    nZSections = str2double(nZSections);
else
    addpath ('../cellCounting/');
end

usableZSlices = [usableZSlices_start:usableZSlices_end];

nUsableSlices = length(usableZSlices);

startSlice = round ((nZSections - nUsableSlices)/2);
endSlice = startSlice + nUsableSlices - 1;

pointList = cell2mat (centroids);
pointList = pointList';
pointList0 = pointList (:, pointList(3,:) >= usableZSlices(1)-1 & pointList(3,:) < usableZSlices(end));
pointList1 = pointList0 + repmat ([0; 0; startSlice-usableZSlices(1)], 1, size (pointList0, 2));

warpableFileName = sprintf ('%s_elastix_warpable.txt', dataFileName(1:end-4));
vtkFileName = sprintf ('%s_elastix_warpable.vtk', dataFileName(1:end-4));

writeElastixPointFile (warpableFileName, pointList1);
writeSparsePointsVTKFile (vtkFileName, pointList1);
