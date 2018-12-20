%function outputNetwork = trainDetectionNetwork (inputImageDirectory, inputLabelDirectory)

inputImageDirectory = 'D:\data\others\anarasim\tracingTraining\trainingImages\';
inputLabelDirectory = 'D:\data\others\anarasim\tracingTraining\trainingLabels\';
testImageInputDirectory = 'D:\data\others\anarasim\tracingTraining\testImages\Z18_Y08_3101-3650\';
testOutputDirectory = 'D:\data\others\anarasim\tracingTraining\testImages\Z18_Y08_3101-3650_prediction\';

inputImageDirectory = 'D:\data\tmp\cellDetection\cellDetectionZ20TrainDirectory\images\';
inputLabelDirectory = 'D:\data\tmp\cellDetection\cellDetectionZ20TrainDirectory\labels\';
testImageInputDirectory = 'D:\data\tmp\cellDetection\cellDetectionZ20TestDirectory\images\';
testOutputDirectory = 'D:\data\tmp\cellDetection\cellDetectionZ20TestDirectory\predictions\';

inputImageDirectory = 'C:\Users\kannanuv\Downloads\no_dilation\trainingData\trainingImageTiles\';
inputLabelDirectory = 'C:\Users\kannanuv\Downloads\no_dilation\trainingData\trainingLabelTiles\';
testImageInputDirectory = 'C:\Users\kannanuv\Downloads\no_dilation\input_rawdata\';
testOutputDirectory = 'C:\Users\kannanuv\Downloads\no_dilation\trainingData\cellDetection\';

if (~isdeployed)
    addpath ('../utils/');
end

inputImageDirectory = validateDirectory (inputImageDirectory);
inputLabelDirectory = validateDirectory (inputLabelDirectory);

%% Create Datastores for the images
% for input images
inputImageDataStore = imageDatastore (inputImageDirectory);

% for label images
classNames = ["background", "cell"];
labelIDs   = [0 255];
pixelLabelDataStore = pixelLabelDatastore(inputLabelDirectory,classNames,labelIDs);

%% Create semantic segmentation network
numFilters = 64;
filterSize = 3;
numClasses = 2;
layers = [
    imageInputLayer([32 32 1])
    convolution2dLayer(filterSize,numFilters,'Padding',1)
    reluLayer()
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(filterSize,numFilters,'Padding',1)
    reluLayer()
    transposedConv2dLayer(4,numFilters,'Stride',2,'Cropping',1);
    convolution2dLayer(1,numClasses);
    softmaxLayer()
    pixelClassificationLayer()
    ];

opts = trainingOptions('sgdm', ...
    'InitialLearnRate', 1e-3, ...
    'MaxEpochs', 10, ...
    'MiniBatchSize', 64);

trainingData = pixelLabelImageSource(inputImageDataStore, pixelLabelDataStore);

outputNetwork = trainNetwork(trainingData,layers,opts);

testImagesDataStore = imageDatastore(testImageInputDirectory);

pxdsResults = semanticseg(testImagesDataStore, outputNetwork, "WriteLocation", testOutputDirectory);