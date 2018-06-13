function save_connection_probabilities(nNeurons,nParcels,neuronTypeNames,connectionProbabilities)
    % save probability data to file %%%%%%%%%%%%%%%%%%
    disp('Saving probability data ...');
    
    outputFileName = sprintf('output/probabilities_%s.xlsx', datestr(now, 'yyyymmddHHMMSS'));
    
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
            outputMatrix{i+1,1+j} = sum(connectionProbabilities.tensor(i,j,1:nParcels));
        end % j
    end %i

    [success, message] = xlswrite(outputFileName, outputMatrix);
    
end % save_connection_probabilities()