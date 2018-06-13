function [quantity,neuritesQuantified,overlapColors] = initialize_periodic_table_plots(nNeurons,nParcels,nCells,quantity,neuritesQuantified,overlapBinary,subregionOfInterest)
    
    % reverse the order of the parcels so SO appears at the bottom of the Z-axis and SLM at the top
    for iNeuron = 1:nNeurons
        quantity.axons(iNeuron,1:nParcels) = quantity.axons(iNeuron,nParcels:-1:1);
        quantity.dendrites(iNeuron,1:nParcels) = quantity.dendrites(iNeuron,nParcels:-1:1);
    end % iNeuron
    
%     for iNeuron = 1:nNeurons % loop through presynaptic neurons
%         for jNeuron = 1:nNeurons % loop through postsynaptic neurons
%             quantity.tensor(iNeuron,jNeuron,1:nParcels) = quantity.tensor(iNeuron,jNeuron,nParcels:-1:1);
%         end % jNeuron
%     end % iNeuron
    
    if strcmp(subregionOfInterest,'DG')
        neuronStart = 1;
        neuronEnd = nCells.DG;
    elseif strcmp(subregionOfInterest,'CA3')
        neuronStart = nCells.DG+1;
        neuronEnd = nCells.DG+nCells.CA3;
    elseif strcmp(subregionOfInterest,'CA2')
        neuronStart = nCells.DG+nCells.CA3+1;
        neuronEnd = nCells.DG+nCells.CA3+nCells.CA2;
    elseif strcmp(subregionOfInterest,'CA1')
        neuronStart = nCells.DG+nCells.CA3+nCells.CA2+1;
        neuronEnd = nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1;
    elseif strcmp(subregionOfInterest,'Sub')
        neuronStart = nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1+1;
        neuronEnd = nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1+nCells.Sub;
    elseif strcmp(subregionOfInterest,'EC')
        neuronStart = nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1+nCells.Sub+1;
        neuronEnd = nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1+nCells.Sub+nCells.EC;
    else
        neuronStart = 1;
        neuronEnd = nNeurons;
    end
    
    % scale connection probabilities from 1 to nProbabilityColors for mapping to colormap colors
%     maximum = max(max(max(quantity.tensor)))
    maximum = max(max(max(quantity.tensor(neuronStart:neuronEnd,neuronStart:neuronEnd,1:nParcels))))
    nonZeroMinimum = min(min(min(quantity.tensor(quantity.tensor > 0))))
%     nonZeroMinimum = min(min(min(quantity.tensor(quantity.tensor(neuronStart:neuronEnd,neuronStart:neuronEnd,1:nParcels) > 0))))
    nProbabilityColors = round(maximum/nonZeroMinimum+0.5);
    if (nProbabilityColors > 1024)
        nProbabilityColors = 1024;
    end
    quantity.tensorScaled = mod(round(quantity.tensor/nonZeroMinimum+0.5),nProbabilityColors);
%     quantity.tensorScaled(neuronStart:neuronEnd,neuronStart:neuronEnd,1:nParcels) = mod(round(quantity.tensor(neuronStart:neuronEnd,neuronStart:neuronEnd,1:nParcels)/nonZeroMinimum+0.5),nProbabilityColors);
    
    overlapColors = [0.75 0.75 0.75; 0 0 0]; % gray, black

    figure(1);
    
    clf;
    
    plot3(0,0,0,'k'); % plot simple black point to establish 3D plot
        
    view(180-45,30);
    
    hold on;
    
    figure(2);
    
    clf;
    
    redStart = 1.000;
    redEnd = 0.500;
    redStep = (redStart-redEnd)/nProbabilityColors;
    greenStart = 0.750;
    greenEnd = 0.000;
    greenStep = (greenStart-greenEnd)/nProbabilityColors;
    blueStart = 1.000;
    blueEnd = 0.500;
    blueStep = (blueStart-blueEnd)/nProbabilityColors;    

    % colormap with nProbabilityColors shades of purple from light to dark
    for i = 0:nProbabilityColors
        quantity.colormap(i+1,1:3) = [redStart-i*redStep greenStart-i*greenStep blueStart-i*blueStep];
    end
    
    axons = zeros(nNeurons,nParcels);
    dendrites = zeros(nNeurons,nParcels);

    idx = quantity.idx; % indexes corresponding to unique neurites [subregion:layer:A/D]
    
    for k = 1:length(quantity.means)        
        i = find(overlapBinary.uniqueIds == neuritesQuantified.uniqueIds(idx(k)));
        j = parcel_lookup(neuritesQuantified.parcels{idx(k)});
        if strcmp(neuritesQuantified.neurites(idx(k)),'A')  
            if isnan(neuritesQuantified.percentOfNeuriteTree(idx(k)))
                axons(i,j) = 0;
            else
                axons(i,j) = neuritesQuantified.percentOfNeuriteTree(idx(k));
            end
        else   
            if isnan(neuritesQuantified.percentOfNeuriteTree(idx(k)))
                dendrites(i,j) = 0;
            else
                dendrites(i,j) = neuritesQuantified.percentOfNeuriteTree(idx(k));
            end
        end                    
    end % k
    
    quantity.axons = axons;
    quantity.dendrites = dendrites;

end % initialize_periodic_table_plots()