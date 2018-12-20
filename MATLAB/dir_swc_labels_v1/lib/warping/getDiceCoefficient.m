function diceCoefficient = getDiceCoefficient(inputLabel1FileName, inputLabel2FileName)

if (~isdeployed)
  addpath ('../utils/');
end

inputLabel1 = imreadstack (inputLabel1FileName);
inputLabel2 = imreadstack (inputLabel2FileName);

inputLabel1 = (inputLabel1 > 0.5);
inputLabel2 = (inputLabel2 > 0.5);

intersectionImage = inputLabel1 .* inputLabel2;
nIntersectingVoxels = sum (intersectionImage(:));

diceCoefficient = 2 * sum (nIntersectingVoxels) / (sum (inputLabel1(:)) + sum(inputLabel2(:)));