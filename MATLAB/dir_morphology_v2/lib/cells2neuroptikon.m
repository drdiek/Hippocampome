function [cellIds, areSaved] = cells2neuroptikon(csvFile, cellAbbrevs, Cij)

load parcellation.mat    
    
    axonsArray = zeros(1,nAllCells);
    dendritesArray = zeros(1,nAllCells);
     
    foundCells = 0;
    rowLooper = rowSkip + 1;
    while foundCells < nAllCells
        if ~isempty(csvFile{rowLooper,cellIdColNum})          
            if strcmpi(csvFile{rowLooper,axonOrDendriteColNum},'axons')
                axonsArray(foundCells+1) = rowLooper;
            elseif strcmpi(csvFile{rowLooper,axonOrDendriteColNum},'dendrites')
                foundCells = foundCells + 1;
                dendritesArray(foundCells) = rowLooper;
            end
        end      
        rowLooper = rowLooper + 1;
    end


    % retrieve cellIds from first column of input file and convert from
    % string to number
    cellIds = csvFile(axonsArray,cellIdColNum);
    cellIds = cellfun(@(cellIds) cellIds(2:end), cellIds, 'uni',false);
    cellIds = str2num(cell2mat(cellIds));    
    
    %theLabels = csvFile(axonsArray,labelColNum);
    theLabels = cellAbbrevs;
    EorIvalue = csvFile(axonsArray,excitOrInhibColNum);
    
    
    % record nodes

    saveAll = sprintf('neuroptikon_output/HC.py');
    saveDG = sprintf('neuroptikon_output/HC_DG.py');
    saveCA3 = sprintf('neuroptikon_output/HC_CA3.py');
    saveCA2 = sprintf('neuroptikon_output/HC_CA2.py');
    saveCA1 = sprintf('neuroptikon_output/HC_CA1.py');
    saveSUB = sprintf('neuroptikon_output/HC_SUB.py');
    saveEC = sprintf('neuroptikon_output/HC_EC.py');
    fidAll = fopen(saveAll, 'wt');
    fidDG = fopen(saveDG, 'wt');
    fidCA3 = fopen(saveCA3, 'wt');
    fidCA2 = fopen(saveCA2, 'wt');
    fidCA1 = fopen(saveCA1, 'wt');
    fidSUB = fopen(saveSUB, 'wt');
    fidEC = fopen(saveEC, 'wt');

    fprintf(fidAll, '# Hippocampome - all regions\n');
    fprintf(fidAll, '# Number of nodes: %d\n\n# Nodes\n\n',nAllCells);
    
    fprintf(fidDG, '# Hippocampome - dentate gyrus\n');
    fprintf(fidDG, '# Number of nodes: %d\n\n# Nodes\n\n',length(DGcells));
        fprintf(fidDG, 'regionCA3 = network.createRegion(name = ''CA3'')\n');
        fprintf(fidDG, 'regionCA2 = network.createRegion(name = ''CA2'')\n');
        fprintf(fidDG, 'regionCA1 = network.createRegion(name = ''CA1'')\n');
        fprintf(fidDG, 'regionSUB = network.createRegion(name = ''SUB'')\n');
        fprintf(fidDG, 'regionEC = network.createRegion(name = ''EC'')\n');
        %fprintf(fidDG, 'pathway = regionCA3.projectToRegion(regionCA2)\n');
        %fprintf(fidDG, 'pathway = regionCA3.projectToRegion(regionCA1)\n');
        %fprintf(fidDG, 'pathway = regionCA3.projectToRegion(regionSUB)\n');
        %fprintf(fidDG, 'pathway = regionCA3.projectToRegion(regionEC)\n');
        %fprintf(fidDG, 'pathway = regionCA2.projectToRegion(regionCA3)\n');
        %fprintf(fidDG, 'pathway = regionCA2.projectToRegion(regionCA1)\n');
        %fprintf(fidDG, 'pathway = regionCA2.projectToRegion(regionSUB)\n');
        %fprintf(fidDG, 'pathway = regionCA2.projectToRegion(regionEC)\n');
        %fprintf(fidDG, 'pathway = regionCA1.projectToRegion(regionCA3)\n');
        %fprintf(fidDG, 'pathway = regionCA1.projectToRegion(regionCA2)\n');
        %fprintf(fidDG, 'pathway = regionCA1.projectToRegion(regionSUB)\n');
        %fprintf(fidDG, 'pathway = regionCA1.projectToRegion(regionEC)\n');
        %fprintf(fidDG, 'pathway = regionSUB.projectToRegion(regionCA3)\n');
        %fprintf(fidDG, 'pathway = regionSUB.projectToRegion(regionCA2)\n');
        %fprintf(fidDG, 'pathway = regionSUB.projectToRegion(regionCA1)\n');
        %fprintf(fidDG, 'pathway = regionSUB.projectToRegion(regionEC)\n');
        %fprintf(fidDG, 'pathway = regionEC.projectToRegion(regionCA3)\n');
        %fprintf(fidDG, 'pathway = regionEC.projectToRegion(regionCA2)\n');
        %fprintf(fidDG, 'pathway = regionEC.projectToRegion(regionCA1)\n');
        %fprintf(fidDG, 'pathway = regionEC.projectToRegion(regionSUB)\n\n');
        
    fprintf(fidCA3, '# Hippocampome - CA3\n');
    fprintf(fidCA3, '# Number of nodes: %d\n\n# Nodes\n\n',length(CA3cells));
        fprintf(fidCA3, 'regionDG = network.createRegion(name = ''DG'')\n');
        fprintf(fidCA3, 'regionCA2 = network.createRegion(name = ''CA2'')\n');
        fprintf(fidCA3, 'regionCA1 = network.createRegion(name = ''CA1'')\n');
        fprintf(fidCA3, 'regionSUB = network.createRegion(name = ''SUB'')\n');
        fprintf(fidCA3, 'regionEC = network.createRegion(name = ''EC'')\n');
        %fprintf(fidCA3, 'pathway = regionDG.projectToRegion(regionCA2)\n');
        %fprintf(fidCA3, 'pathway = regionDG.projectToRegion(regionCA1)\n');
        %fprintf(fidCA3, 'pathway = regionDG.projectToRegion(regionSUB)\n');
        %fprintf(fidCA3, 'pathway = regionDG.projectToRegion(regionEC)\n');
        %fprintf(fidCA3, 'pathway = regionCA2.projectToRegion(regionDG)\n');
        %fprintf(fidCA3, 'pathway = regionCA2.projectToRegion(regionCA1)\n');
        %fprintf(fidCA3, 'pathway = regionCA2.projectToRegion(regionSUB)\n');
        %fprintf(fidCA3, 'pathway = regionCA2.projectToRegion(regionEC)\n');
        %fprintf(fidCA3, 'pathway = regionCA1.projectToRegion(regionDG)\n');
        %fprintf(fidCA3, 'pathway = regionCA1.projectToRegion(regionCA2)\n');
        %fprintf(fidCA3, 'pathway = regionCA1.projectToRegion(regionSUB)\n');
        %fprintf(fidCA3, 'pathway = regionCA1.projectToRegion(regionEC)\n');
        %fprintf(fidCA3, 'pathway = regionSUB.projectToRegion(regionDG)\n');
        %fprintf(fidCA3, 'pathway = regionSUB.projectToRegion(regionCA2)\n');
        %fprintf(fidCA3, 'pathway = regionSUB.projectToRegion(regionCA1)\n');
        %fprintf(fidCA3, 'pathway = regionSUB.projectToRegion(regionEC)\n');
        %fprintf(fidCA3, 'pathway = regionEC.projectToRegion(regionDG)\n');
        %fprintf(fidCA3, 'pathway = regionEC.projectToRegion(regionCA2)\n');
        %fprintf(fidCA3, 'pathway = regionEC.projectToRegion(regionCA1)\n');
        %fprintf(fidCA3, 'pathway = regionEC.projectToRegion(regionSUB)\n\n');
    
    fprintf(fidCA2, '# Hippocampome - CA2\n');
    fprintf(fidCA2, '# Number of nodes: %d\n\n# Nodes\n\n',length(CA2cells));
        fprintf(fidCA2, 'regionDG = network.createRegion(name = ''DG'')\n');
        fprintf(fidCA2, 'regionCA3 = network.createRegion(name = ''CA3'')\n');
        fprintf(fidCA2, 'regionCA1 = network.createRegion(name = ''CA1'')\n');
        fprintf(fidCA2, 'regionSUB = network.createRegion(name = ''SUB'')\n');
        fprintf(fidCA2, 'regionEC = network.createRegion(name = ''EC'')\n');
        %fprintf(fidCA2, 'pathway = regionDG.projectToRegion(regionCA3)\n');
        %fprintf(fidCA2, 'pathway = regionDG.projectToRegion(regionCA1)\n');
        %fprintf(fidCA2, 'pathway = regionDG.projectToRegion(regionSUB)\n');
        %fprintf(fidCA2, 'pathway = regionDG.projectToRegion(regionEC)\n');
        %fprintf(fidCA2, 'pathway = regionCA3.projectToRegion(regionDG)\n');
        %fprintf(fidCA2, 'pathway = regionCA3.projectToRegion(regionCA1)\n');
        %fprintf(fidCA2, 'pathway = regionCA3.projectToRegion(regionSUB)\n');
        %fprintf(fidCA2, 'pathway = regionCA3.projectToRegion(regionEC)\n');
        %fprintf(fidCA2, 'pathway = regionCA1.projectToRegion(regionDG)\n');
        %fprintf(fidCA2, 'pathway = regionCA1.projectToRegion(regionCA3)\n');
        %fprintf(fidCA2, 'pathway = regionCA1.projectToRegion(regionSUB)\n');
        %fprintf(fidCA2, 'pathway = regionCA1.projectToRegion(regionEC)\n');
        %fprintf(fidCA2, 'pathway = regionSUB.projectToRegion(regionDG)\n');
        %fprintf(fidCA2, 'pathway = regionSUB.projectToRegion(regionCA3)\n');
        %fprintf(fidCA2, 'pathway = regionSUB.projectToRegion(regionCA1)\n');
        %fprintf(fidCA2, 'pathway = regionSUB.projectToRegion(regionEC)\n');
        %fprintf(fidCA2, 'pathway = regionEC.projectToRegion(regionDG)\n');
        %fprintf(fidCA2, 'pathway = regionEC.projectToRegion(regionCA3)\n');
        %fprintf(fidCA2, 'pathway = regionEC.projectToRegion(regionCA1)\n');
        %fprintf(fidCA2, 'pathway = regionEC.projectToRegion(regionSUB)\n\n');
    
    fprintf(fidCA1, '# Hippocampome - CA1\n');
    fprintf(fidCA1, '# Number of nodes: %d\n\n# Nodes\n\n',length(CA1cells));
        fprintf(fidCA1, 'regionDG = network.createRegion(name = ''DG'')\n');
        fprintf(fidCA1, 'regionCA3 = network.createRegion(name = ''CA3'')\n');
        fprintf(fidCA1, 'regionCA2 = network.createRegion(name = ''CA2'')\n');
        fprintf(fidCA1, 'regionSUB = network.createRegion(name = ''SUB'')\n');
        fprintf(fidCA1, 'regionEC = network.createRegion(name = ''EC'')\n');
        %fprintf(fidCA1, 'pathway = regionDG.projectToRegion(regionCA3)\n');
        %fprintf(fidCA1, 'pathway = regionDG.projectToRegion(regionCA2)\n');
        %fprintf(fidCA1, 'pathway = regionDG.projectToRegion(regionSUB)\n');
        %fprintf(fidCA1, 'pathway = regionDG.projectToRegion(regionEC)\n');
        %fprintf(fidCA1, 'pathway = regionCA3.projectToRegion(regionDG)\n');
        %fprintf(fidCA1, 'pathway = regionCA3.projectToRegion(regionCA2)\n');
        %fprintf(fidCA1, 'pathway = regionCA3.projectToRegion(regionSUB)\n');
        %fprintf(fidCA1, 'pathway = regionCA3.projectToRegion(regionEC)\n');
        %fprintf(fidCA1, 'pathway = regionCA2.projectToRegion(regionDG)\n');
        %fprintf(fidCA1, 'pathway = regionCA2.projectToRegion(regionCA3)\n');
        %fprintf(fidCA1, 'pathway = regionCA2.projectToRegion(regionSUB)\n');
        %fprintf(fidCA1, 'pathway = regionCA2.projectToRegion(regionEC)\n');
        %fprintf(fidCA1, 'pathway = regionSUB.projectToRegion(regionDG)\n');
        %fprintf(fidCA1, 'pathway = regionSUB.projectToRegion(regionCA3)\n');
        %fprintf(fidCA1, 'pathway = regionSUB.projectToRegion(regionCA2)\n');
        %fprintf(fidCA1, 'pathway = regionSUB.projectToRegion(regionEC)\n');
        %fprintf(fidCA1, 'pathway = regionEC.projectToRegion(regionDG)\n');
        %fprintf(fidCA1, 'pathway = regionEC.projectToRegion(regionCA3)\n');
        %fprintf(fidCA1, 'pathway = regionEC.projectToRegion(regionCA2)\n');
        %fprintf(fidCA1, 'pathway = regionEC.projectToRegion(regionSUB)\n\n');
      
    fprintf(fidSUB, '# Hippocampome - subiculum\n');
    fprintf(fidSUB, '# Number of nodes: %d\n\n# Nodes\n\n',length(SUBcells));    
        fprintf(fidSUB, 'regionDG = network.createRegion(name = ''DG'')\n');
        fprintf(fidSUB, 'regionCA3 = network.createRegion(name = ''CA3'')\n');
        fprintf(fidSUB, 'regionCA2 = network.createRegion(name = ''CA2'')\n');
        fprintf(fidSUB, 'regionCA1 = network.createRegion(name = ''CA1'')\n');
        fprintf(fidSUB, 'regionEC = network.createRegion(name = ''EC'')\n');
        %fprintf(fidSUB, 'pathway = regionDG.projectToRegion(regionCA3)\n');
        %fprintf(fidSUB, 'pathway = regionDG.projectToRegion(regionCA2)\n');
        %fprintf(fidSUB, 'pathway = regionDG.projectToRegion(regionCA1)\n');
        %fprintf(fidSUB, 'pathway = regionDG.projectToRegion(regionEC)\n');
        %fprintf(fidSUB, 'pathway = regionCA3.projectToRegion(regionDG)\n');
        %fprintf(fidSUB, 'pathway = regionCA3.projectToRegion(regionCA2)\n');
        %fprintf(fidSUB, 'pathway = regionCA3.projectToRegion(regionCA1)\n');
        %fprintf(fidSUB, 'pathway = regionCA3.projectToRegion(regionEC)\n');
        %fprintf(fidSUB, 'pathway = regionCA2.projectToRegion(regionDG)\n');
        %fprintf(fidSUB, 'pathway = regionCA2.projectToRegion(regionCA3)\n');
        %fprintf(fidSUB, 'pathway = regionCA2.projectToRegion(regionCA1)\n');
        %fprintf(fidSUB, 'pathway = regionCA2.projectToRegion(regionEC)\n');
        %fprintf(fidSUB, 'pathway = regionCA1.projectToRegion(regionDG)\n');
        %fprintf(fidSUB, 'pathway = regionCA1.projectToRegion(regionCA3)\n');
        %fprintf(fidSUB, 'pathway = regionCA1.projectToRegion(regionCA2)\n');
        %fprintf(fidSUB, 'pathway = regionCA1.projectToRegion(regionEC)\n');
        %fprintf(fidSUB, 'pathway = regionEC.projectToRegion(regionDG)\n');
        %fprintf(fidSUB, 'pathway = regionEC.projectToRegion(regionCA3)\n');
        %fprintf(fidSUB, 'pathway = regionEC.projectToRegion(regionCA2)\n');
        %fprintf(fidSUB, 'pathway = regionEC.projectToRegion(regionCA1)\n\n');%

    fprintf(fidEC, '# Hippocampome - enthorinal cortex\n');
    fprintf(fidEC, '# Number of nodes: %d\n\n# Nodes\n\n',length(ECcells));
        fprintf(fidEC, 'regionDG = network.createRegion(name = ''DG'')\n');
        fprintf(fidEC, 'regionCA3 = network.createRegion(name = ''CA3'')\n');
        fprintf(fidEC, 'regionCA2 = network.createRegion(name = ''CA2'')\n');
        fprintf(fidEC, 'regionCA1 = network.createRegion(name = ''CA1'')\n');
        fprintf(fidEC, 'regionSUB = network.createRegion(name = ''SUB'')\n');
        %fprintf(fidEC, 'pathway = regionDG.projectToRegion(regionCA3)\n');
        %fprintf(fidEC, 'pathway = regionDG.projectToRegion(regionCA2)\n');
        %fprintf(fidEC, 'pathway = regionDG.projectToRegion(regionCA1)\n');
        %fprintf(fidEC, 'pathway = regionDG.projectToRegion(regionSUB)\n');
        %fprintf(fidEC, 'pathway = regionCA3.projectToRegion(regionDG)\n');
        %fprintf(fidEC, 'pathway = regionCA3.projectToRegion(regionCA2)\n');
        %fprintf(fidEC, 'pathway = regionCA3.projectToRegion(regionCA1)\n');
        %fprintf(fidEC, 'pathway = regionCA3.projectToRegion(regionSUB)\n');
        %fprintf(fidEC, 'pathway = regionCA2.projectToRegion(regionDG)\n');
        %fprintf(fidEC, 'pathway = regionCA2.projectToRegion(regionCA3)\n');
        %fprintf(fidEC, 'pathway = regionCA2.projectToRegion(regionCA1)\n');
        %fprintf(fidEC, 'pathway = regionCA2.projectToRegion(regionSUB)\n');
        %fprintf(fidEC, 'pathway = regionCA1.projectToRegion(regionDG)\n');
        %fprintf(fidEC, 'pathway = regionCA1.projectToRegion(regionCA3)\n');
        %fprintf(fidEC, 'pathway = regionCA1.projectToRegion(regionCA2)\n');
        %fprintf(fidEC, 'pathway = regionCA1.projectToRegion(regionSUB)\n');
        %fprintf(fidEC, 'pathway = regionSUB.projectToRegion(regionDG)\n');
        %fprintf(fidEC, 'pathway = regionSUB.projectToRegion(regionCA3)\n');
        %fprintf(fidEC, 'pathway = regionSUB.projectToRegion(regionCA2)\n');
        %fprintf(fidEC, 'pathway = regionSUB.projectToRegion(regionCA1)\n\n');
    
    DGstart = 1;
    DGend = DGstart+length(DGcells)-1;
    CA3start = DGend+1;
    CA3end = CA3start+length(CA3cells)-1;
    CA2start = CA3end+1;
    CA2end = CA2start+length(CA2cells)-1;
    CA1start = CA2end+1;
    CA1end = CA1start+length(CA1cells)-1;
    SUBstart = CA1end+1;
    SUBend = SUBstart+length(SUBcells)-1;
    ECstart = SUBend+1;
    ECend = ECstart+length(ECcells)-1;
        
    
    % output neurons
    outputCounter=1;

    for iNode=1:length(DGcells)
        fprintf(fidAll, 'neuron%d = network.createNeuron(name = ''DG_%s'')\n', outputCounter, char(theLabels(outputCounter)));
        if (outputCounter >= DGstart && outputCounter <= DGend)
            fprintf(fidDG, 'neuron%d = network.createNeuron(name = ''DG_%s'')\n', outputCounter, char(theLabels(outputCounter)));
        end
        outputCounter=outputCounter+1;
    end
    for iNode=1:length(CA3cells)
        fprintf(fidAll, 'neuron%d = network.createNeuron(name = ''CA3_%s'')\n', outputCounter, char(theLabels(outputCounter)));
        if (outputCounter >= CA3start && outputCounter <= CA3end)
            fprintf(fidCA3, 'neuron%d = network.createNeuron(name = ''CA3_%s'')\n', outputCounter, char(theLabels(outputCounter)));
        end
        outputCounter=outputCounter+1;
    end
    for iNode=1:length(CA2cells)
        fprintf(fidAll, 'neuron%d = network.createNeuron(name = ''CA2_%s'')\n', outputCounter, char(theLabels(outputCounter)));
        if (outputCounter >= CA2start && outputCounter <= CA2end)
            fprintf(fidCA2, 'neuron%d = network.createNeuron(name = ''CA2_%s'')\n', outputCounter, char(theLabels(outputCounter)));
        end
        outputCounter=outputCounter+1;
    end
    for iNode=1:length(CA1cells)
        fprintf(fidAll, 'neuron%d = network.createNeuron(name = ''CA1_%s'')\n', outputCounter, char(theLabels(outputCounter)));
        if (outputCounter >= CA1start && outputCounter <= CA1end)
            fprintf(fidCA1, 'neuron%d = network.createNeuron(name = ''CA1_%s'')\n', outputCounter, char(theLabels(outputCounter)));
        end
        outputCounter=outputCounter+1;
    end
    for iNode=1:length(SUBcells)
        fprintf(fidAll, 'neuron%d = network.createNeuron(name = ''SUB_%s'')\n', outputCounter, char(theLabels(outputCounter)));
        if (outputCounter >= SUBstart && outputCounter <= SUBend)
            fprintf(fidSUB, 'neuron%d = network.createNeuron(name = ''SUB_%s'')\n', outputCounter, char(theLabels(outputCounter)));
        end
        outputCounter=outputCounter+1;
    end
    for iNode=1:length(ECcells)
        fprintf(fidAll, 'neuron%d = network.createNeuron(name = ''EC_%s'')\n', outputCounter, char(theLabels(outputCounter)));
        if (outputCounter >= ECstart && outputCounter <= ECend)
            fprintf(fidEC, 'neuron%d = network.createNeuron(name = ''EC_%s'')\n', outputCounter, char(theLabels(outputCounter)));
        end
        outputCounter=outputCounter+1;
    end

    fprintf(fidAll, '\n\n# Connections\n\n');
    fprintf(fidDG, '\n\n# Connections\n\n');
    fprintf(fidCA3, '\n\n# Connections\n\n');
    fprintf(fidCA2, '\n\n# Connections\n\n');
    fprintf(fidCA1, '\n\n# Connections\n\n');
    fprintf(fidSUB, '\n\n# Connections\n\n');
    fprintf(fidEC, '\n\n# Connections\n\n');

    
    % output connections 

    connectionCtr = 1;

    % loop over rows (cell types)
    for iCell = 1:nAllCells  
        for jCell = 1:nAllCells % pst
            if (Cij(iCell,jCell))
                fprintf(fidAll, 's%d = neuron%d.synapseOn(neuron%d)\n', connectionCtr, iCell, jCell);
                if (Cij(iCell,jCell) == 1)
                    fprintf(fidAll, 's%d.activation = "excitatory"\n', connectionCtr);
                    fprintf(fidAll, 'display.setVisibleColor(s%d, (1,0,0))\n', connectionCtr);
                elseif (Cij(iCell,jCell) == -1)
                    fprintf(fidAll, 's%d.activation = "inhibitory"\n', connectionCtr);
                    fprintf(fidAll, 'display.setVisibleColor(s%d, (0,0,1))\n', connectionCtr);
                end
                
                % DG connections
                if (iCell >= DGstart && iCell <= DGend)
                    if (jCell >= DGstart && jCell <= DGend)
                        fprintf(fidDG, 's%d = neuron%d.synapseOn(neuron%d)\n', connectionCtr, iCell, jCell);
                        if (Cij(iCell,jCell) == 1)
                            fprintf(fidDG, 's%d.activation = "excitatory"\n', connectionCtr);
                            fprintf(fidDG, 'display.setVisibleColor(s%d, (1,0,0))\n', connectionCtr);
                        elseif (Cij(iCell,jCell) == -1)
                            fprintf(fidDG, 's%d.activation = "inhibitory"\n', connectionCtr);
                            fprintf(fidDG, 'display.setVisibleColor(s%d, (0,0,1))\n', connectionCtr);
                        end
                    elseif (jCell >= CA3start && jCell <= CA3end)
                        fprintf(fidDG, 'neuron%d.arborize(regionCA3)\n', iCell);
                    elseif (jCell >= CA2start && jCell <= CA2end)
                        fprintf(fidDG, 'neuron%d.arborize(regionCA2)\n', iCell);
                    elseif (jCell >= CA1start && jCell <= CA1end)
                        fprintf(fidDG, 'neuron%d.arborize(regionCA1)\n', iCell);
                    elseif (jCell >= SUBstart && jCell <= SUBend)
                        fprintf(fidDG, 'neuron%d.arborize(regionSUB)\n', iCell);
                    elseif (jCell >= ECstart && jCell <= ECend)
                        fprintf(fidDG, 'neuron%d.arborize(regionEC)\n', iCell);
                    end
                end
                
                % CA3 connections
                if (iCell >= CA3start && iCell <= CA3end)
                    if (jCell >= CA3start && jCell <= CA3end)
                        fprintf(fidCA3, 's%d = neuron%d.synapseOn(neuron%d)\n', connectionCtr, iCell, jCell);
                        if (Cij(iCell,jCell) == 1)
                            fprintf(fidCA3, 's%d.activation = "excitatory"\n', connectionCtr);
                            fprintf(fidCA3, 'display.setVisibleColor(s%d, (1,0,0))\n', connectionCtr);
                        elseif (Cij(iCell,jCell) == -1)
                            fprintf(fidCA3, 's%d.activation = "inhibitory"\n', connectionCtr);
                            fprintf(fidCA3, 'display.setVisibleColor(s%d, (0,0,1))\n', connectionCtr);
                        end
                    elseif (jCell >= DGstart && jCell <= DGend)
                        fprintf(fidCA3, 'neuron%d.arborize(regionDG)\n', iCell);
                    elseif (jCell >= CA2start && jCell <= CA2end)
                        fprintf(fidCA3, 'neuron%d.arborize(regionCA2)\n', iCell);
                    elseif (jCell >= CA1start && jCell <= CA1end)
                        fprintf(fidCA3, 'neuron%d.arborize(regionCA1)\n', iCell);
                    elseif (jCell >= SUBstart && jCell <= SUBend)
                        fprintf(fidCA3, 'neuron%d.arborize(regionSUB)\n', iCell);
                    elseif (jCell >= ECstart && jCell <= ECend)
                        fprintf(fidCA3, 'neuron%d.arborize(regionEC)\n', iCell);
                    end
                end
                
                % CA2 connections
                if (iCell >= CA2start && iCell <= CA2end)
                    if (jCell >= CA2start && jCell <= CA2end)
                        fprintf(fidCA2, 's%d = neuron%d.synapseOn(neuron%d)\n', connectionCtr, iCell, jCell);
                        if (Cij(iCell,jCell) == 1)
                            fprintf(fidCA2, 's%d.activation = "excitatory"\n', connectionCtr);
                            fprintf(fidCA2, 'display.setVisibleColor(s%d, (1,0,0))\n', connectionCtr);
                        elseif (Cij(iCell,jCell) == -1)
                            fprintf(fidCA2, 's%d.activation = "inhibitory"\n', connectionCtr);
                            fprintf(fidCA2, 'display.setVisibleColor(s%d, (0,0,1))\n', connectionCtr);
                        end
                    elseif (jCell >= DGstart && jCell <= DGend)
                        fprintf(fidCA2, 'neuron%d.arborize(regionDG)\n', iCell);
                    elseif (jCell >= CA3start && jCell <= CA3end)
                        fprintf(fidCA2, 'neuron%d.arborize(regionCA3)\n', iCell);
                    elseif (jCell >= CA1start && jCell <= CA1end)
                        fprintf(fidCA2, 'neuron%d.arborize(regionCA1)\n', iCell);
                    elseif (jCell >= SUBstart && jCell <= SUBend)
                        fprintf(fidCA2, 'neuron%d.arborize(regionSUB)\n', iCell);
                    elseif (jCell >= ECstart && jCell <= ECend)
                        fprintf(fidCA2, 'neuron%d.arborize(regionEC)\n', iCell);
                    end
                end
                
                % CA1 connections
                if (iCell >= CA1start && iCell <= CA1end)
                    if (jCell >= CA1start && jCell <= CA1end)
                        fprintf(fidCA1, 's%d = neuron%d.synapseOn(neuron%d)\n', connectionCtr, iCell, jCell);
                        if (Cij(iCell,jCell) == 1)
                            fprintf(fidCA1, 's%d.activation = "excitatory"\n', connectionCtr);
                            fprintf(fidCA1, 'display.setVisibleColor(s%d, (1,0,0))\n', connectionCtr);
                        elseif (Cij(iCell,jCell) == -1)
                            fprintf(fidCA1, 's%d.activation = "inhibitory"\n', connectionCtr);
                            fprintf(fidCA1, 'display.setVisibleColor(s%d, (0,0,1))\n', connectionCtr);
                        end
                    elseif (jCell >= DGstart && jCell <= DGend)
                        fprintf(fidCA1, 'neuron%d.arborize(regionDG)\n', iCell);
                    elseif (jCell >= CA3start && jCell <= CA3end)
                        fprintf(fidCA1, 'neuron%d.arborize(regionCA3)\n', iCell);
                    elseif (jCell >= CA2start && jCell <= CA2end)
                        fprintf(fidCA1, 'neuron%d.arborize(regionCA2)\n', iCell);
                    elseif (jCell >= SUBstart && jCell <= SUBend)
                        fprintf(fidCA1, 'neuron%d.arborize(regionSUB)\n', iCell);
                    elseif (jCell >= ECstart && jCell <= ECend)
                        fprintf(fidCA1, 'neuron%d.arborize(regionEC)\n', iCell);
                    end
                end
                
                % SUB connections
                if (iCell >= SUBstart && iCell <= SUBend)
                    if (jCell >= SUBstart && jCell <= SUBend)
                        fprintf(fidSUB, 's%d = neuron%d.synapseOn(neuron%d)\n', connectionCtr, iCell, jCell);
                        if (Cij(iCell,jCell) == 1)
                            fprintf(fidSUB, 's%d.activation = "excitatory"\n', connectionCtr);
                            fprintf(fidSUB, 'display.setVisibleColor(s%d, (1,0,0))\n', connectionCtr);
                        elseif (Cij(iCell,jCell) == -1)
                            fprintf(fidSUB, 's%d.activation = "inhibitory"\n', connectionCtr);
                            fprintf(fidSUB, 'display.setVisibleColor(s%d, (0,0,1))\n', connectionCtr);
                        end
                    elseif (jCell >= DGstart && jCell <= DGend)
                        fprintf(fidSUB, 'neuron%d.arborize(regionDG)\n', iCell);
                    elseif (jCell >= CA3start && jCell <= CA3end)
                        fprintf(fidSUB, 'neuron%d.arborize(regionCA3)\n', iCell);
                    elseif (jCell >= CA2start && jCell <= CA2end)
                        fprintf(fidSUB, 'neuron%d.arborize(regionCA2)\n', iCell);
                    elseif (jCell >= CA1start && jCell <= CA1end)
                        fprintf(fidSUB, 'neuron%d.arborize(regionCA1)\n', iCell);
                    elseif (jCell >= ECstart && jCell <= ECend)
                        fprintf(fidSUB, 'neuron%d.arborize(regionEC)\n', iCell);
                    end
                end
                
                % EC connections
                if (iCell >= ECstart && iCell <= ECend)
                    if (jCell >= ECstart && jCell <= ECend)
                        fprintf(fidEC, 's%d = neuron%d.synapseOn(neuron%d)\n', connectionCtr, iCell, jCell);
                        if (Cij(iCell,jCell) == 1)
                            fprintf(fidEC, 's%d.activation = "excitatory"\n', connectionCtr);
                            fprintf(fidEC, 'display.setVisibleColor(s%d, (1,0,0))\n', connectionCtr);
                        elseif (Cij(iCell,jCell) == -1)
                            fprintf(fidEC, 's%d.activation = "inhibitory"\n', connectionCtr);
                            fprintf(fidEC, 'display.setVisibleColor(s%d, (0,0,1))\n', connectionCtr);
                        end
                    elseif (jCell >= DGstart && jCell <= DGend)
                        fprintf(fidEC, 'neuron%d.arborize(regionDG)\n', iCell);
                    elseif (jCell >= CA3start && jCell <= CA3end)
                        fprintf(fidEC, 'neuron%d.arborize(regionCA3)\n', iCell);
                    elseif (jCell >= CA2start && jCell <= CA2end)
                        fprintf(fidEC, 'neuron%d.arborize(regionCA2)\n', iCell);
                    elseif (jCell >= CA1start && jCell <= CA1end)
                        fprintf(fidEC, 'neuron%d.arborize(regionCA1)\n', iCell);
                    elseif (jCell >= SUBstart && jCell <= SUBend)
                        fprintf(fidEC, 'neuron%d.arborize(regionSUB)\n', iCell);
                    end
                end                
                
                connectionCtr = connectionCtr + 1;
            end % if Cij(i,j)
        end % jCell loop
        fprintf(fidAll, '\n');
    end % iCell


    fprintf(fidAll, '\ndisplay.performLayout()');
    fclose(fidAll);
    fclose(fidDG);
    fclose(fidCA3);
    fclose(fidCA2);
    fclose(fidCA1);
    fclose(fidSUB);
    fclose(fidEC);

    areSaved = 1;


end % plot_Cij_matrix
