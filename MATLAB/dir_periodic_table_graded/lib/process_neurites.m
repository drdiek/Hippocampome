function [nNeurons, nParcels, labels, isExcitatory, neurites] = process_neurites(fileName)

    fileNameFull = sprintf('./data/%s', fileName);

    [cells, isFileLoaded] = load_csvFile(fileNameFull);
        
    nNeurons = size(cells,1) - 1; % skip one row for column headers
    
    nParcels = size(cells,2) - 2; % skip two columns for row headers
    
    for iNeuron = 1:nNeurons
        
        labels{iNeuron} = cells{iNeuron+1, 1}; % skip one row for column headers
        
        EorI = cells{iNeuron+1, 2}; % skip one row for column headers
        
        isExcitatory(iNeuron) = strcmp(EorI, 'E');
        
        for iParcel = 1:nParcels
  
            neurites(iNeuron,iParcel) = str2num(cells{iNeuron+1, 2 + nParcels + 1 - iParcel}); % reverses the order of the parcels for better display in the plot
            
        end
        
    end

end % process_neurites()