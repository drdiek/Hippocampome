%segmentImagePatchwise performs patchwise semantic segmentation on the input image
% using the provided network.
%
%  OUT = segmentImagePatchwise(IM, NET, PATCHSIZE) returns a semantically 
%  segmented image, segmented using the network NET. The segmentation is
%  performed patches-wise on patches of size PATCHSIZE.
%  PATCHSIZE is 1x2 vector holding [WIDTH HEIGHT] of the patch.

%   Copyright 1984-2018 The MathWorks, Inc.

function out = segmentImagePatchwise(im, net, patchSize)

[height, width, nChannel] = size(im);
patch = zeros([patchSize, nChannel], 'like', im);
size (patch);

% pad image to have dimensions as multiples of patchSize
padSize(1) = patchSize(1) - mod(height, patchSize(1));
padSize(2) = patchSize(2) - mod(width, patchSize(2));

im_pad = padarray (im, padSize, 0, 'post');
[height_pad, width_pad, nChannel_pad] = size(im_pad);

out = zeros([size(im_pad,1), size(im_pad,2)], 'uint8');

for i = 1:patchSize(1):height_pad
  for j =1:patchSize(2):width_pad
    patch = im_pad(i:i+patchSize(1)-1, j:j+patchSize(2)-1, :);
    patch_seg = semanticseg(patch, net);    
    out(i:i+patchSize(1)-1, j:j+patchSize(2)-1) = patch_seg;
  end
end

% Remove the padding
out = out(1:height, 1:width);