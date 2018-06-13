function neurites()

    % initialize variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
    disp('Initializing variables ...');
    
    nProbabilityColors = 512;
    
    fileName = 'Quantification_of_Neurites_table_contacts_updated.xlsx';
   
    [num, txt] = xlsread(fileName, '% of Presence');
    nRows = size(txt,1);
    nCols = size(txt,2);
    nNeurons = -2; % Do not count title of table and "Color code"
    for i = 1:nRows
        cellNameStr = cell2mat(txt(i,1));
        if ~isempty(cellNameStr)
            nNeurons = nNeurons + 1;
        end % if
    end % i
    
    nParcels = -3; % Do not count "Number of cells" and "Actual pattern" AND "E OR I"
    for j = 1:nCols
        columnHeaderStr = cell2mat(txt(4,j));
        if ~isempty(columnHeaderStr)
            nParcels = nParcels + 1;
        end % if
    end % j

    isAxonalDendriticTargeting = zeros(nNeurons,1);
    isInterneuronSpecificTargeting = zeros(nNeurons,1);
    isSomaticTargeting = zeros(nNeurons,1);

    percentOfPresenceAxons = zeros(nNeurons, nParcels);
    percentOfPresenceDendrites = zeros(nNeurons, nParcels);
    
    densityAxons = zeros(nNeurons, nParcels);
    densityDendrites = zeros(nNeurons, nParcels);
    
    % fetch percent of presence data from file %%%%%%%%%%%%%%%%%%%%
    
    disp('Loading percent-of-presence data from file ...');
    
    % read in neuron type names
    for i = 1:nNeurons
        range = sprintf('B%d', 2+i*4); % B6, B10, B14, ...
        [num, neuronType{i}] = xlsread(fileName, 'Density Summary', range);
    end % i
    
    for i = 1:nNeurons
        for j = 1:nParcels
            % read in percent of presence values for axons
            range = sprintf('%c%d', char(65+j*2), 2+i*4); % C6, E6, G6, ...; C10, E10, G10, ...; C14, E14, G14, ...; ...
            [num, txt] = xlsread(fileName, '% of Presence', range);
            if ~isempty(num)
                percentOfPresenceAxons(i,j) = num;
            end
            % read in percent of presence values for dendrites
            range = sprintf('%c%d', char(65+j*2), 2+i*4+2); % C8, E8, G8, ...; C12, E12, G12, ...; C16, E16, G16, ...; ...
            [num, txt] = xlsread(fileName, '% of Presence', range);
            if ~isempty(num)
                percentOfPresenceDendrites(i,j) = num;
            end
        end % j
        
        % read in Number of cells
        % read in E or I value
        range = sprintf('O%d', 2+i*4);
        [nCellsRecorded(i)] = xlsread(fileName, '% of Presence', range);
        
        % read in E or I value
        range = sprintf('Q%d', 2+i*4);
        [num, txt] = xlsread(fileName, '% of Presence', range);
        isExcitatory(i) = strcmp(txt, 'E');
    
        % read in Targeting value
        range = sprintf('R%d', 2+i*4);
        [num, txt] = xlsread(fileName, '% of Presence', range);
        targetingStr = cell2mat(txt);
        if strcmp(targetingStr,'AD')
            isAxonalDendriticTargeting(i) = 1;
        elseif strcmp(targetingStr,'IS')
            isInterneuronSpecificTargeting(i) = 1;
        elseif strcmp(targetingStr,'S')
            isSomaticTargeting(i) = 1;
        end
        
        % merge alveus values with SO values
        percentOfPresenceAxons(i,nParcels-1) = percentOfPresenceAxons(i,nParcels-1) + percentOfPresenceAxons(i,nParcels)/nCellsRecorded(i);
        percentOfPresenceDendrites(i,nParcels-1) = percentOfPresenceDendrites(i,nParcels-1) + percentOfPresenceDendrites(i,nParcels)/nCellsRecorded(i);
    
    end % i
        
    % fetch density data from file %%%%%%%%%%%%%%%%%%%%
    
    disp('Loading density data from file ...');
    
    for i = 1:nNeurons
        for j = 1:nParcels
            % read in density values for axons
            range = sprintf('%c%d', char(64+j*2), 3+i*4); % B7, D7, F7, ...; B11, D11, F11, ...; B15, D15, F15, ...; ...
            [num, txt] = xlsread(fileName, 'Density summary', range);
            if ~isempty(num)
                densityAxons(i,j) = num;
            end
            % read in density values for dendrites
            range = sprintf('%c%d', char(64+j*2), 3+i*4+2); % B9, D9, F9, ...; B13, D13, F13, ...; B17, D17, F17, ...; ...
            [num, txt] = xlsread(fileName, 'Density summary', range);
            if ~isempty(num)
                densityDendrites(i,j) = num;
            end
        end % j

        % merge alveus values with SO values
        densityAxons(i,nParcels-1) = densityAxons(i,nParcels-1) + densityAxons(i,nParcels)/nCellsRecorded(i);
        densityDendrites(i,nParcels-1) = densityDendrites(i,nParcels-1) + densityDendrites(i,nParcels)/nCellsRecorded(i);
    
    end % i
    
    % calculate cross-multiplied densities %%%%%%%%%%%%%%%%%%%%%
    
    disp('Multiplying densities ...');
    
    for iA = 1:nNeurons
        for iD = 1:nNeurons
            if isInterneuronSpecificTargeting(iA) % check if presynaptic cell is Interneuron Specific
                if ~isExcitatory(iD) % check if postsynaptic cell is inhibitory
                    connectionProbabilities(iA,iD,1:nParcels) = densityAxons(iA,1:nParcels) .* densityDendrites(iD,1:nParcels);
                else 
                    connectionProbabilities(iA,iD,1:nParcels) = 0;
                end
            else % presynaptic cell is not Interneuron Specific
                connectionProbabilities(iA,iD,1:nParcels) = densityAxons(iA,1:nParcels) .* densityDendrites(iD,1:nParcels);
            end
        end % iD
    end % iA
    
    % scale connection probabilities from 1-nProbabilityColors for mapping to colormap colors   
    connectionProbabilitiesMax = max(max(max(connectionProbabilities)));
    connectionProbabilitiesMin = min(min(min(connectionProbabilities)));
    connectionProbabilitiesScaled = round(connectionProbabilities*nProbabilityColors/(connectionProbabilitiesMax-connectionProbabilitiesMin) + 0.5);
    
    % plot periodic table %%%%%%%%%%%%%%%%%%
    
    disp('Plotting periodic table ...');
    
    cla;
    
    % reverse the order of the parcels so Alveus/SO appears at the bottom of the Z-axis and SLM at the top
    for iNeuron = 1:nNeurons 
        percentOfPresenceAxons(iNeuron,1:nParcels) = percentOfPresenceAxons(iNeuron,nParcels:-1:1);
        percentOfPresenceDendrites(iNeuron,1:nParcels) = percentOfPresenceDendrites(iNeuron,nParcels:-1:1);
    end % iNeuron
    
    nParcels = nParcels - 1; % omit DG:SM for CA1 cells
    
    % remove the first parcel so SO appears at the bottom of the Z-axis
    for iNeuron = 1:nNeurons 
        percentOfPresenceAxons(iNeuron,1:nParcels-1) = percentOfPresenceAxons(iNeuron,2:nParcels);
        percentOfPresenceDendrites(iNeuron,1:nParcels-1) = percentOfPresenceDendrites(iNeuron,2:nParcels);
    end % iNeuron
    
    nParcels = nParcels - 1; % omit Alveus for CA1 cells
    
    colors = [1 0 0; 0 0 1; 0.5 0 0.5; 0.75 0.25 0.75]; % red, blue, dark purple, light purple
    
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
    
%     % colormap with 10 shades of purple    
%     colormapProb = ([1.000 0.750 1.000; ... % very light purple
%                      0.950 0.675 0.950; ...
%                      0.900 0.600 0.900; ...
%                      0.850 0.525 0.850; ...
%                      0.800 0.450 0.800; ...
%                      0.750 0.375 0.750; ...
%                      0.700 0.300 0.700; ...
%                      0.650 0.225 0.650; ...
%                      0.600 0.150 0.600; ...
%                      0.550 0.075 0.550; ...
%                      0.500 0.000 0.500]);   % very dark purple
    
    redStart = 1.000;
    redEnd = 0.500;
    redStep = (redStart-redEnd)/nProbabilityColors;
    greenStart = 0.750;
    greenEnd = 0.000;
    greenStep = (greenStart-greenEnd)/nProbabilityColors;
    blueStart = 1.000;
    blueEnd = 0.500;
    blueStep = (blueStart-blueEnd)/nProbabilityColors;    

    % colormap with nProbabilityColors shades of purple 
    for i = 0:nProbabilityColors
        colormapProb(i+1,1:3) = [redStart-i*redStep greenStart-i*greenStep blueStart-i*blueStep];
    end

    for iNeuron = 1:nNeurons % loop through presynaptic neurons
    
        for jNeuron = 1:nNeurons % loop through postsynaptic neurons
        
            isOverlap = 0;
            
            for iParcel = 1:nParcels

                if (jNeuron == 1) % draw axon and dendrite patches only once
                
                    if (percentOfPresenceAxons(iNeuron,iParcel) > 0) % check for axons in current parcel
                        
                        figure(1);
                        
                        if (percentOfPresenceAxons(iNeuron,iParcel) >= 15.0) % plot red square
                            patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [0 0 0 0 0], [iParcel iParcel-1 iParcel-1 iParcel iParcel], [1 0 0]);
                        else % plot light red square
                            patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [0 0 0 0 0], [iParcel iParcel-1 iParcel-1 iParcel iParcel], [1 0.6 0.6]);
                        end
                            
                        hold on;
                        
                    end
                    
                    if (percentOfPresenceDendrites(iNeuron,iParcel) > 0) % check for dendrites in current parcel
                        
                        figure(1);
                        
                        if (percentOfPresenceDendrites(iNeuron,iParcel) >= 15.0) % plot blue square
                            patch([0 0 0 0 0], [iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [iParcel iParcel-1 iParcel-1 iParcel iParcel], [0 0 1]);
                        else % plot light blue square
                            patch([0 0 0 0 0], [iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [iParcel iParcel-1 iParcel-1 iParcel iParcel], [0.6 0.6 1]);
                        end

                        hold on;
                        
                    end
                    
                    figure(1);
                    
                    % draw black border around axon square
                    plot3([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [0 0 0 0 0], [iParcel iParcel-1 iParcel-1 iParcel iParcel], 'k');
                    
                    hold on;
                    
                    % draw black border around dendrite square
                    plot3([0 0 0 0 0], [iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [iParcel iParcel-1 iParcel-1 iParcel iParcel], 'k');
                    
                    hold on;
                    
                end % if (jNeuron == 1)
                                        
                if ((percentOfPresenceAxons(iNeuron,iParcel)*percentOfPresenceDendrites(jNeuron,iParcel) > 0) && (iNeuron ~= 1))
                        
                    figure(2);
                    
                    [x,y,z] = ellipsoid(iNeuron-0.5,jNeuron-0.5,iParcel-0.5,0.25,0.25,0.25+0.25/1);%4);
                    
                    hs = surf(x,y,z,zeros(21),'EdgeColor','none','FaceAlpha',1.0);
                    
                    set(hs, 'FaceColor', colormapProb(connectionProbabilitiesScaled(iNeuron,jNeuron,iParcel),:));
                    
                    hold on;
                    
                    if (iNeuron == 1) % omit if Axo-axonic
                        isOverlap = 0;
                    else
                        isOverlap = 1;
                    end
                    
                end % if (connectionProbabilitiesSumsScaled(iNeuron,jNeuron) > 1)
                    
            end % iParcel
            
            if isOverlap % plot black/gray square indicating potential overlap
               
                figure(1);
                
                % plot black square for excitatory overlap and gray for inhibitory overlap
                patch([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [jNeuron jNeuron-1 jNeuron-1 jNeuron jNeuron], [0 0 0 0 0], overlapColors(isExcitatory(iNeuron)+1,:));
                
                hold on;
                    
            end
                    
            figure(1);
            
            % draw black border around overlap square
            plot3([iNeuron iNeuron iNeuron-1 iNeuron-1 iNeuron], [jNeuron jNeuron-1 jNeuron-1 jNeuron jNeuron], [0 0 0 0 0], 'k');
            
            hold on;
                
        end % jNeuron
        
    end % iNeuron
            
    figure(1);
    
    % draw black border along the top of the X-Z and Y-Z planes
    plot3([nNeurons 0 0], [0 0 nNeurons], [0 0 0], 'Color', [0 0 0], 'LineWidth', 2);
    
    % draw black border along the Z-axis
    plot3([0 0], [0 0], [0 nParcels], 'Color', [0 0 0], 'LineWidth', 2);
    
    % draw black border around X-Y plane
    plot3([nNeurons nNeurons 0 0 0 nNeurons nNeurons], [0 0 0 nNeurons nNeurons nNeurons 0], [0 nParcels nParcels nParcels 0 0 0], 'k', 'LineWidth', 2);
    
    xlabel(' '); % Presyaptic
    
    ylabel(' '); % Postsynaptic
    
    zlabel(' '); % Parcels
    
%     plotFileName = ['PT_output/', fileName(1:end-4), '_fig1_', datestr(now, 'yyyymmdd_HHMMSS'), '.eps'];
%     
%     print(gcf, '-depsc', '-r800', plotFileName);
% 
%     plotFileName = ['PT_output/', fileName(1:end-4), '_fig1_', datestr(now, 'yyyymmdd_HHMMSS'), '.tif'];
%     
%     print(gcf, '-dtiffnocompression', '-r800', plotFileName);
    
    figure(2);
    
    view(149,48);
    
    axis([0 nNeurons 0 nNeurons 0 nParcels]);

    xlabel(' '); % Presynaptic
    
    ylabel(' '); % Postsynaptic
    
    zlabel(' '); % Parcels
    
    pbaspect([1,1,0.4]) % uniform is [1,1,1]
    
    ax = gca;
    
    set(ax,'ZTick',[0:nParcels]);
    
%     plotFileName = ['PT_output/', fileName(1:end-4), '_fig2.eps'];
%     
%     print(gcf, '-depsc', '-r800', plotFileName);
%     
%     plotFileName = ['PT_output/', fileName(1:end-4), '_fig2.tif'];
% 
%     print(gcf, '-dtiffnocompression', '-r600', plotFileName);
    
end % neurites()