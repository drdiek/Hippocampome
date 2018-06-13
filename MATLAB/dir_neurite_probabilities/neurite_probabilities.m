function neurite_probabilities()

    % initialize variables
    nNeurons = 10;
    
    % fetch probability data from file %%%%%%%%%%%%%%%%%%%%
    
    disp('Loading probability data from file ...');
    
    fileNameInput = 'Quantification_of_Neurites_table_contacts_updated_dww.xlsx';
   
    % read in neuron type names
    disp('    Loading neuron type names ...');
    for i = 1:nNeurons
        range = sprintf('B%d', 3+i*2); % B5, B7, B9, ..., B23
        [num, neuronTypeNames{i}] = xlsread(fileNameInput, 'Contacts', range);
    end % i
    
    % read in number of presynaptic boutons
    disp('    Loading numbers of presynaptic boutons ...');
    for i = 1:nNeurons
        range = sprintf('B%d', 4+i*2); % B6, B8, B10, ..., B24
        [nPresynapticBoutons(i,1)] = xlsread(fileNameInput, 'Contacts', range);
    end % i
    
    % read in number of postsynaptic cells
    disp('    Loading numbers of postsynaptic cells ...');
    range = sprintf('%c4:%c4', char(66+1), char(66+nNeurons)); % C4, D4, E4, ..., L4
    [nPostsynapticCells] = xlsread(fileNameInput, 'Contacts', range);
    
    probabilitiesAdOverlap = zeros(nNeurons, nNeurons);
    nContactsPerPostsynapticCellType = zeros(nNeurons, nNeurons);
    
    disp('    Loading probabilities ...');
    disp(['        Loading row #1 ...']);
    [probabilitiesAdOverlap(1,nNeurons)] = xlsread(fileNameInput, 'Contacts', 'L5'); % Axo-axonic row has only 1 value
    for i = 2:nNeurons
        disp(['        Loading row #', num2str(i), ' ...']);
        % read in probability values
        range = sprintf('%c%d:%c%d', char(66+1), 3+i*2, char(66+nNeurons), 3+i*2); % C7, D7, E7, ..., L7; ...; C23, D23, E23, ..., L23
        [probabilitiesAdOverlap(i,1:nNeurons)] = xlsread(fileNameInput, 'Contacts', range);
    end % i
    
    disp('    Loading numbers of contacts ...');
    disp(['        Loading row #1 ...']);
    [nContactsPerPostsynapticCellType(1,nNeurons)] = xlsread(fileNameInput, 'Contacts', 'L6'); % Axo-axonic row has only 1 value
    for i = 2:nNeurons
        disp(['        Loading row #', num2str(i), ' ...']);
        % read in contact values
        range = sprintf('%c%d:%c%d', char(66+1), 3+i*2+1, char(66+nNeurons), 3+i*2+1); % C8, D8, E8, ..., L8; ...; C24, D24, E24, ..., L24
        [nContactsPerPostsynapticCellType(i,1:nNeurons)] = xlsread(fileNameInput, 'Contacts', range);
    end % i
    
    % calculate contact ratios %%%%%%%%%%%%%%%%%%%%%
    
    disp('Calculating contact ratios ...');
    
    nPostsynapticCellsMatrix = repmat(nPostsynapticCells,nNeurons,1);
    nPostsynapticContacts = probabilitiesAdOverlap .* nPostsynapticCellsMatrix;
      
    for i = 1:nNeurons
        sumPostsynapticContacts(i,1) = sum(nPostsynapticContacts(i,1:nNeurons));
    end % i
    
    sumPostsynapticContactsMatrix = repmat(sumPostsynapticContacts,1,nNeurons);
    fractionPostsynapticContacts = nPostsynapticContacts ./ sumPostsynapticContactsMatrix;
    
    nPresynapticBoutonsMatrix = repmat(nPresynapticBoutons,1,nNeurons);
    nPresynapticBoutonsPerPostsynapticCellType = nPresynapticBoutonsMatrix ./ nContactsPerPostsynapticCellType;
    
    nPresynapticCellsContactingEachPostsynapticCellType = fractionPostsynapticContacts .* nPresynapticBoutonsPerPostsynapticCellType;
    
    for j = 1:nNeurons
        totalPresynapticCellsContactingEachPostsynapticCellType(1,j) = nansum(nPresynapticCellsContactingEachPostsynapticCellType(1:nNeurons,j));
    end % j
    
    totalPresynapticCellsContactingEachPostsynapticCellTypeMatrix = repmat(totalPresynapticCellsContactingEachPostsynapticCellType,nNeurons,1);
    probabilityPresynapticCellConnectedToPostsynapticCell = nPresynapticCellsContactingEachPostsynapticCellType ./ totalPresynapticCellsContactingEachPostsynapticCellTypeMatrix
    
    % save data to file %%%%%%%%%%%%%%%%%%%%%%%
    
    disp('Saving data to file ...');
    
    fileNameOutput = sprintf('./output/pre-post_synaptic_probabilities');
    fileNameOutput = sprintf('%s_%s.xlsx', fileNameOutput, datestr(now, 'yyyymmdd_HHMMSS'));
    
    % skip the first Excel cell
    outputMatrix{1,1} = '';
    
    % write out the column headers
    for j = 1:nNeurons
        outputMatrix{1,1+j} = cell2mat(neuronTypeNames{j});
    end % j
    
    for i = 1:nNeurons
        % write out the row headers
        outputMatrix{1+i,1} = cell2mat(neuronTypeNames{i});
        
        % write out the probabilities
        for j = 1:nNeurons
            outputMatrix{i+1,1+j} = probabilityPresynapticCellConnectedToPostsynapticCell(i,j);
        end % j
    end %i

    success = xlswrite(fileNameOutput, outputMatrix)
    
end % neurite_probabilities()