function getOverlappingCells (inputDirectory1, inputDirectory2, outputDirectory)

inputDirectory1 = validateDirectory (inputDirectory1);
inputDirectory2 = validateDirectory (inputDirectory2);
outputDirectory = validateDirectory (outputDirectory);

listOfFiles = dir ([inputDirectory1 '*tif']);

nFile = length(listOfFiles);

for iFile = 1:nFile
    fileName = listOfFiles(iFile).name;
    inputBinaryImage1 = imread ([inputDirectory1 fileName]); inputBinaryImage1 = (inputBinaryImage1 > 0.5);
    inputBinaryImage2 = imread ([inputDirectory2 fileName]); inputBinaryImage2 = (inputBinaryImage2 > 0.5);
    outputImage = (inputBinaryImage1 & inputBinaryImage2);
    imwrite (uint8 (outputImage * 255), [outputDirectory fileName]);
end