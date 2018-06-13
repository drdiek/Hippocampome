function [nNeurons,nParcels,nMeasurements,nCells,nLayers,overlapBinary,neuritesQuantified] = initialize_variables()
    % initialize variables for neurites_quantified() %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Initializing variables ...');
    
    [overlapBinary.numbers, overlapBinary.text, overlapBinary.raw] = xlsread('overlap_matrix.csv', 'overlap_matrix');
    [neuritesQuantified.numbers, neuritesQuantified.text, neuritesQuantified.raw] = xlsread('neurites_quantified_v1.0.xlsx', 'data');
    
    nNeurons = size(overlapBinary.numbers,1);
    nParcels = size(overlapBinary.text,2)-4; % ignore columns for UniqueIDs and Names and Abbreviations and EorI
    nMeasurements = size(neuritesQuantified.numbers,1);
    
    overlapBinary.uniqueIds = overlapBinary.numbers(1:nNeurons,1);
    overlapBinary.names = overlapBinary.text(2:nNeurons+1,2); % skip header row
    overlapBinary.abbreviations = overlapBinary.text(2:nNeurons+1,3); % skip header row
    overlapBinary.EorI = overlapBinary.text(2:nNeurons+1,4); % skip header row
    overlapBinary.parcels = overlapBinary.text(1,5:nParcels+4) % skip UniqueIDs and Names and Abbreviations and EorI columns 
    for j = 1:nParcels
        idx = strfind(overlapBinary.parcels{1,j},':');
        overlapBinary.subregions{1,j} = overlapBinary.parcels{1,j}(1:idx-1);
        overlapBinary.layers{1,j} = overlapBinary.parcels{1,j}(idx+1:end);
    end
    overlapBinary.data = overlapBinary.numbers(1:nNeurons,5:nParcels+4); % skip UniqueIDs and Names and Abbreviations and EorI columns

    nCells.DG = length(find(overlapBinary.uniqueIds < 2000));
    nCells.CA3 = length(find(overlapBinary.uniqueIds < 3000)) - nCells.DG;
    nCells.CA2 = length(find(overlapBinary.uniqueIds < 4000)) - nCells.DG - nCells.CA3;
    nCells.CA1 = length(find(overlapBinary.uniqueIds < 5000)) - nCells.DG - nCells.CA3 - nCells.CA2;
    nCells.Sub = length(find(overlapBinary.uniqueIds < 6000)) - nCells.DG - nCells.CA3 - nCells.CA2 - nCells.CA1;
    nCells.EC = length(find(overlapBinary.uniqueIds > 5999));
    
    nLayers.DG = 4;
    nLayers.CA3 = 5;
    nLayers.CA2 = 4;
    nLayers.CA1 = 4;
    nLayers.Sub = 3;
    nLayers.EC = 6;
    
    neuritesQuantified.uniqueIds = neuritesQuantified.numbers(1:nMeasurements,1);
    for i = 1:nMeasurements
        neuriteTxt = cell2mat(neuritesQuantified.text(i+1,8));
        idx = strfind(neuriteTxt,':');
        neuritesQuantified.subregions{i} = neuriteTxt(1:idx(1)-1);
        neuritesQuantified.layers{i} = neuriteTxt(idx(1)+1:idx(2)-1);
        neuritesQuantified.parcels{i} = neuriteTxt(1:idx(2)-1);
        neuritesQuantified.neurites{i} = neuriteTxt(idx(2)+1:end);
    end % for i
    neuritesQuantified.totalLength = neuritesQuantified.numbers(1:nMeasurements,10);
    neuritesQuantified.percentOfNeuriteTree = neuritesQuantified.numbers(1:nMeasurements,11);
    neuritesQuantified.density = neuritesQuantified.numbers(1:nMeasurements,12);
    neuritesQuantified.avgMaxPathLength = neuritesQuantified.numbers(1:nMeasurements,13);
    neuritesQuantified.avgMeanPathLength = neuritesQuantified.numbers(1:nMeasurements,14);
    
end % initialize_variables()
