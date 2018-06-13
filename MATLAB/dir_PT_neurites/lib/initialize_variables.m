function [nNeurons,nParcels,percentOfPresence,density] = initialize_variables(fileName)
    % initialize variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
    disp('Initializing variables ...');
    
    [percentOfPresence.numbers, percentOfPresence.text, percentOfPresence.raw] = xlsread(fileName, '% of Presence');
    [density.numbers, density.text, density.raw] = xlsread(fileName, 'Density summary');
    
    nRows = size(percentOfPresence.text,1);
    nCols = size(percentOfPresence.text,2);
    
    for i = 1:nRows
        if strcmp(cell2mat(percentOfPresence.text(i,1)), 'Color code')
            nNeurons = (i-6)/4; % Do not count 2 rows for title of table and 2 rows for column headers and 1 blank row and "Color code"
        end
    end
    
    for j = 1:nCols
        if strcmp(cell2mat(percentOfPresence.text(3,j)), 'Soma in PCL?')
            nParcels = j-7; % Do not count 1st column and "Number of cells" and "Actual pattern" and "E OR I" and "Targeting" and "PC?" and "Soma in PCL?"
        end
    end
        
    percentOfPresence.axons = zeros(nNeurons, nParcels);
    percentOfPresence.dendrites = zeros(nNeurons, nParcels);
    
    density.axons = zeros(nNeurons, nParcels);
    density.dendrites = zeros(nNeurons, nParcels);

end % initialize_variables()
