function [syntheticImage, cellCenters, cellRadii, labelSyntheticImage] = createSyntheticDataset()

if (~isdeployed)
  addpath ('../utils/');
end

imageBounds = [500 500 500];
nNuclei = 300;
radii = [6:0.2:8];
%radii = [10 10];
nRadii = length (radii);
syntheticImage = zeros (imageBounds);

cellCentersX = randi ([1 imageBounds(1)], nNuclei,1);
cellCentersY = randi ([1 imageBounds(2)], nNuclei,1);
cellCentersZ = randi ([1 imageBounds(3)], nNuclei,1);
cellCenters = [cellCentersX cellCentersY cellCentersZ];
cellRadii = radii(randi([1 nRadii], nNuclei, 1));

%plot3(cellCentersX, cellCentersY, cellCentersZ, '*');
fprintf ('processing %d\n', size(syntheticImage,1))

for iX = 1:size(syntheticImage,1)
  fprintf ('%d ', iX);
    for iY = 1:size(syntheticImage,2)
        for iZ = 1:size(syntheticImage,3)
            %syntheticImage(iX, iY, iZ) = getIntensity ([iX iY iZ], cellRadii, cellCenters);
        end
    end
end

labelSyntheticImage = zeros (size (syntheticImage));
nLabel = 8;
iLabel = 0;
for iX = 0:1
    if (iX == 0)
        xRange = 1:floor(size(labelSyntheticImage,2)/2);
    else
        xRange = floor(size(labelSyntheticImage,2)/2)+1:size(labelSyntheticImage,2);
    end
    for iY = 0:1
    if (iY == 0)
        yRange = 1:floor(size(labelSyntheticImage,1)/2);
    else
        yRange = floor(size(labelSyntheticImage,1)/2)+1:size(labelSyntheticImage,1);
    end
        for iZ = 0:1
        if (iZ == 0)
            zRange = 1:floor(size(labelSyntheticImage,3)/2);
        else
            zRange = floor(size(labelSyntheticImage,3)/2)+1:size(labelSyntheticImage,3);
        end
            iLabel = iX * 4 + iY * 2 + iZ + 1;
            labelSyntheticImage(yRange, xRange, zRange) = iLabel;
        end
    end
end
bevelSize = floor (size(syntheticImage,1)/ 20);
syntheticImage(1:bevelSize,:,:) = 0;
syntheticImage(end-bevelSize:end,:,:) = 0;
syntheticImage(:, 1:bevelSize,:) = 0;
syntheticImage(:, end-bevelSize:end,:) = 0;
syntheticImage(:,:,1:bevelSize) = 0;
syntheticImage(:,:,end-bevelSize:end) = 0;

imwritestack (uint8(syntheticImage), 'syntheticCellImage.tif');
imwritestack (uint8(labelSyntheticImage), 'syntheticLabelImage.tif');

function pixelIntensity = getIntensity (point, cellRadii, cellCenters)

point = repmat (point, length(cellRadii), 1);
distance = (sum((point - cellCenters).^2, 2)).^0.5;
isWithinRadii = (cellRadii - distance');
if (sum(isWithinRadii > 0))
    %pixelIntensity = sum (cellRadii(isWithinRadii > 0) - isWithinRadii(isWithinRadii > 0));
    pixelIntensity = sum (isWithinRadii(isWithinRadii > 0));
    %pixelIntensity = 255;
else
    pixelIntensity = 0;
end