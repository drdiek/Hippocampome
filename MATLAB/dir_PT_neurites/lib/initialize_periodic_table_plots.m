function [percentOfPresence,connectionProbabilities,overlapColors] = initialize_periodic_table_plots(nNeurons,nParcels,percentOfPresence,connectionProbabilities)
    
    % reverse the order of the parcels so SO appears at the bottom of the Z-axis and SLM at the top
    for iNeuron = 1:nNeurons 
        percentOfPresence.axons(iNeuron,1:nParcels) = percentOfPresence.axons(iNeuron,nParcels:-1:1);
        percentOfPresence.dendrites(iNeuron,1:nParcels) = percentOfPresence.dendrites(iNeuron,nParcels:-1:1);
    end % iNeuron
    
    for iNeuron = 1:nNeurons % loop through presynaptic neurons
        for jNeuron = 1:nNeurons % loop through postsynaptic neurons
            connectionProbabilities.tensor(iNeuron,jNeuron,1:nParcels) = connectionProbabilities.tensor(iNeuron,jNeuron,nParcels:-1:1);
        end % iD
    end % iA
    
    % scale connection probabilities from 1 to nProbabilityColors for mapping to colormap colors       
    connectionProbabilities.max = max(max(max(connectionProbabilities.tensor)));
    connectionProbabilities.nonZeroMin = min(min(min(connectionProbabilities.tensor(connectionProbabilities.tensor > 0))));
    nProbabilityColors = round(connectionProbabilities.max/connectionProbabilities.nonZeroMin+0.5);
    if (nProbabilityColors > 1024)
        nProbabilityColors = 1024;
    end
    connectionProbabilities.tensorScaled = mod(round(connectionProbabilities.tensor/connectionProbabilities.nonZeroMin+0.5),nProbabilityColors);
    
    overlapColors = [0.75 0.75 0.75; 0 0 0]; % gray, black

    figure(1);
    
    clf;
    
    plot3(0,0,0,'k'); % plot simple black point to establish 3D plot
        
    view(180-45,30);
    
    axis([0 nNeurons 0 nNeurons 0 nParcels]);
    
    pbaspect([3.75,3.75,1.5]) % uniform is [3.75,3.75,1]
    
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
        connectionProbabilities.colormap(i+1,1:3) = [redStart-i*redStep greenStart-i*greenStep blueStart-i*blueStep];
    end

end % initialize_periodic_table_plots()