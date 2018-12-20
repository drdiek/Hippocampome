function createWarpableImage(imFileName, usableZSlices_start, usableZSlices_end, xSize, ySize, zSize)

if (isdeployed)
    usableZSlices_start = str2double(usableZSlices_start);
    usableZSlices_end = str2double(usableZSlices_end);
    xSize = str2double(xSize);
    ySize = str2double(ySize);
    zSize = str2double(zSize);
else
    addpath ('/usr/local/netgpu/fluoMouseBrain/scripts/utils/');
end

usableZSlices = [usableZSlices_start:usableZSlices_end];

im = imreadstack (imFileName);
imOut = cast (zeros (size (im,1), size (im,2), zSize), class(im));

nUsableSlices = length(usableZSlices);

startSlice = round ((zSize - nUsableSlices)/2);
endSlice = startSlice + nUsableSlices - 1;

imOut (:,:, startSlice:endSlice) = im(:,:, usableZSlices);

imOut1 = cast (zeros (ySize, xSize, zSize), class(im));
imOut1(1:size(imOut,1), 1:size(imOut,2), :) = imOut;

warpableFileName = sprintf ('%s_warpable.tif', imFileName(1:end-4));
imwritestack (uint16(imOut1), warpableFileName);