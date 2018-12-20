function imageLabelOverlay = createOverlayImage (inputGrey, redOverlayImage, greenOverlayImage, blueOverlayImage, ...
    redOverlayAlpha, greenOverlayAlpha, blueOverlayAlpha, greyContrastMin, greyContrastMax)

inputGrey = uint8 (interp1([greyContrastMin greyContrastMax], [0 255], single (inputGrey), 'linear', 'extrap'));

if (ismatrix(inputGrey))
    imageLabelOverlay (:,:, 1) = inputGrey + (uint8(redOverlayImage) * redOverlayAlpha);
    imageLabelOverlay (:,:, 2) = inputGrey + (uint8(greenOverlayImage) * greenOverlayAlpha);
    imageLabelOverlay (:,:, 3) = inputGrey + (uint8(blueOverlayImage) * blueOverlayAlpha);
end

if (ndims(inputGrey) == 3)
    imageLabelOverlay (:, :, 1, :) = reshape ((inputGrey + (uint8(redOverlayImage) * redOverlayAlpha)), [size(inputGrey, 1), size(inputGrey, 2), 1, size(inputGrey, 3)]);
    imageLabelOverlay (:, :, 2, :) = reshape ((inputGrey + (uint8(greenOverlayImage) * greenOverlayAlpha)), [size(inputGrey, 1), size(inputGrey, 2), 1, size(inputGrey, 3)]);
    imageLabelOverlay (:, :, 3, :) = reshape ((inputGrey + (uint8(blueOverlayImage) * blueOverlayAlpha)), [size(inputGrey, 1), size(inputGrey, 2), 1, size(inputGrey, 3)]);
end

% for iImage = 50:size(inputGrey, 3)
%     subplot (1, 3, 1); imshow (imageLabelOverlay(:,:,:,iImage));
%     subplot (1, 3, 2); imshow (uint8(greenOverlayImage(:,:,iImage) * 255));
%     subplot (1, 3, 3); imshow (uint8(redOverlayImage(:,:,iImage) * 255));
% 
%     fprintf ('Slice %d\n', iImage)
%     pause;
% end

imageLabelOverlay = uint8(imageLabelOverlay);