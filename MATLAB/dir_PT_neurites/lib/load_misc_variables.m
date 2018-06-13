function [neuronTypeNames,nCellsRecorded,is] = load_misc_variables(nNeurons,nParcels,percentOfPresence)
    % Load miscellaneous variables %%%%%%%%%%%%%%%%%%
    disp('Loading misc variables ...');
    
    for i = 1:nNeurons
        % read in neuron type names
        neuronTypeNames{i} = percentOfPresence.text(1+i*4,1);
        
        % read in Number of cells
        nCellsRecorded(i) = percentOfPresence.numbers(-3+i*4,nParcels+1);
        
        % read in E or I value
        is.excitatory(i) = strcmp(percentOfPresence.text(1+i*4,1+nParcels+3), 'E'); % skip first column of txt
    
        % read in Targeting values
        is.targeting.axonalDendritic(i) = strcmp(percentOfPresence.text(1+i*4,1+nParcels+4), 'AD');
        is.targeting.axonInitialSegment(i) = strcmp(percentOfPresence.text(1+i*4,1+nParcels+4), 'AIS');
        is.targeting.interneuronSpecific(i) = strcmp(percentOfPresence.text(1+i*4,1+nParcels+4), 'IS');
        is.targeting.somatic(i) = strcmp(percentOfPresence.text(1+i*4,1+nParcels+4), 'S');
        
        % read in PC? value
        is.principalCell(i) = strcmp(percentOfPresence.text(1+i*4,1+nParcels+5), 'Y');
    
        % read in Soma in PCL? value
        is.somaInPcl(i) = strcmp(percentOfPresence.text(1+i*4,1+nParcels+6), 'Y');        
    end % i

    % read in column locations of Principal Cell Layers
    for j = 1:nParcels
        columnHeaderStr = cell2mat(percentOfPresence.text(4,1+j));
        is.principalCellLayer(j) = (strcmp(columnHeaderStr, 'SP') || strcmp(columnHeaderStr, 'SG'));
    end % j

end % load_misc_variables()