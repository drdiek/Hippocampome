function PT_neurites()

    addpath data lib

    [fileName, reply] = get_file_name_PT_neurites();
    if strcmp(reply,'!')
        disp(' ');
        return
    end
    
    % initialize variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
    disp('Initializing variables ...');
    
    nProbabilityColors = 512;

    [num, txt] = xlsread(fileName, '% of Presence');
    nRows = size(txt,1);
    nCols = size(txt,2);
    
    for i = 1:nRows
        if strcmp(cell2mat(txt(i,1)), 'Color code')
            nNeurons = (i-6)/4; % Do not count 2 rows for title of table and 2 rows for column headers and 1 blank row and "Color code"
        end
    end
    
    for j = 1:nCols
        if strcmp(cell2mat(txt(3,j)), 'Soma in PCL?')
            nParcels = j-7; % Do not count 1st column and "Number of cells" and "Actual pattern" and "E OR I" and "Targeting" and "PC?" and "Soma in PCL?"
        end
    end
        
    percentOfPresenceAxons = zeros(nNeurons, nParcels);
    percentOfPresenceDendrites = zeros(nNeurons, nParcels);
    
    densityAxons = zeros(nNeurons, nParcels);
    densityDendrites = zeros(nNeurons, nParcels);

    isAxonalDendriticTargeting = zeros(nNeurons,1);
    isAxonInitialSegmentTargeting = zeros(nNeurons,1);
    isInterneuronSpecificTargeting = zeros(nNeurons,1);
    isSomaticTargeting = zeros(nNeurons,1);
    
    % fetch percent of presence data from file %%%%%%%%%%%%%%%%%%%%
    
    disp('Loading percent-of-presence data ...');
    
    % read in neuron type names
    for i = 1:nNeurons
        neuronTypeNames{i} = txt(1+i*4,1);
    end % i

    % read in column locations of Principal Cell Layers
    for j = 1:nParcels
        columnHeaderStr = cell2mat(txt(4,1+j));
        if (strcmp(columnHeaderStr, 'SP') || strcmp(columnHeaderStr, 'SG'))
            isPrincipalCellLayer(j) = 1;
        else
            isPrincipalCellLayer(j) = 0;
        end
    end % j

    
    for i = 1:nNeurons
        for j = 1:nParcels
            % read in percent of presence values for axons
            if ~isnan(num(-3+i*4,j)) % start with row 1 of num then skip every fourth
                percentOfPresenceAxons(i,j) = num(-3+i*4,j);
            end
            % read in percent of presence values for dendrites
            if ~isnan(num(-3+i*4+2,j))
                percentOfPresenceDendrites(i,j) = num(-3+i*4+2,j);
            end
        end % j
        
        % read in Number of cells
        nCellsRecorded(i) = num(-3+i*4,nParcels+1);
        
        % read in E or I value
        isExcitatory(i) = strcmp(txt(1+i*4,1+nParcels+3), 'E'); % skip first column of txt
    
        % read in Targeting value
        if strcmp(txt(1+i*4,1+nParcels+4), 'AD')
            isAxonalDendriticTargeting(i) = 1;
        elseif strcmp(txt(1+i*4,1+nParcels+4), 'AIS')
            isAxonInitialSegmentTargeting(i) = 1;
        elseif strcmp(txt(1+i*4,1+nParcels+4), 'IS')
            isInterneuronSpecificTargeting(i) = 1;
        elseif strcmp(txt(1+i*4,1+nParcels+4), 'S')
            isSomaticTargeting(i) = 1;
        end
        
        % read in PC? value
        if strcmp(txt(1+i*4,1+nParcels+5), 'Y')
            isPrincipalCell(i) = 1;
        else
            isPrincipalCell(i) = 0;
        end
    
        % read in Soma in PCL? value
        if strcmp(txt(1+i*4,1+nParcels+6), 'Y')
            isSomaInPcl(i) = 1;
        else
            isSomaInPcl(i) = 0;
        end
        
    end % i

    % fetch density data from file %%%%%%%%%%%%%%%%%%%%
    
    disp('Loading density data from file ...');
    
    [num, txt] = xlsread(fileName, 'Density');
    
    for i = 1:nNeurons
        for j = 1:nParcels
            % read in density values for axons
            if ~isnan(num(-3+i*4,j)) % start with row 1 of num then skip every fourth
                densityAxons(i,j) = num(-3+i*4,j);
            end
            % read in density values for dendrites
            if ~isnan(num(-3+i*4+2,j))
                densityDendrites(i,j) = num(-3+i*4+2,j);
            end
        end % j

    end % i

    % calculate cross-multiplied densities %%%%%%%%%%%%%%%%%%%%%
    
    disp('Multiplying densities ...');
    for iA = 1:nNeurons
        for iD = 1:nNeurons
            if isAxonalDendriticTargeting(iA)
                connectionProbabilities(iA,iD,1:nParcels) = densityAxons(iA,1:nParcels) .* densityDendrites(iD,1:nParcels);
            elseif isAxonInitialSegmentTargeting(iA)
                if isPrincipalCell(iD)
                    for j = 1:nParcels
                        if isPrincipalCellLayer(j)
                            connectionProbabilities(iA,iD,j) = densityAxons(iA,j) .* densityDendrites(iD,j);
                        else
                            connectionProbabilities(iA,iD,j) = 0;
                        end % if
                    end % j
                else
                    connectionProbabilities(iA,iD,1:nParcels) = 0;
                end % if
            elseif isInterneuronSpecificTargeting(iA)
                if isExcitatory(iD)
                    connectionProbabilities(iA,iD,1:nParcels) = 0;
                else
                    connectionProbabilities(iA,iD,1:nParcels) = densityAxons(iA,1:nParcels) .* densityDendrites(iD,1:nParcels);
                end
            elseif isSomaticTargeting(iA)
                if isSomaInPcl(iD)
                    for j = 1:nParcels
                        if isPrincipalCellLayer(j)
                            connectionProbabilities(iA,iD,j) = densityAxons(iA,j) .* densityDendrites(iD,j);
                        else
                            connectionProbabilities(iA,iD,j) = 0;
                        end % if
                    end % j
                else
                    connectionProbabilities(iA,iD,1:nParcels) = 0;
                end
            else
                connectionProbabilities(iA,iD,1:nParcels) = 0;
            end
        end % iD
    end % iA
    
    % plot periodic table %%%%%%%%%%%%%%%%%%
    
    disp('Plotting periodic table ...');
    
    cla;
    
    % reverse the order of the parcels so SO appears at the bottom of the Z-axis and SLM at the top
    for iNeuron = 1:nNeurons 
        percentOfPresenceAxons(iNeuron,1:nParcels) = percentOfPresenceAxons(iNeuron,nParcels:-1:1);
        percentOfPresenceDendrites(iNeuron,1:nParcels) = percentOfPresenceDendrites(iNeuron,nParcels:-1:1);
    end % iNeuron
    
    for iA = 1:nNeurons
        for iD = 1:nNeurons
            connectionProbabilities(iA,iD,1:nParcels) = connectionProbabilities(iA,iD,nParcels:-1:1);
        end % iD
    end % iA
    
%     nParcels = nParcels - 1; % omit DG:SM for CA1 cells
%     
%     % remove the first parcel which is Alveus so SO appears at the bottom of the Z-axis
%     for iNeuron = 1:nNeurons 
%         percentOfPresenceAxons(iNeuron,1:nParcels-1) = percentOfPresenceAxons(iNeuron,2:nParcels);
%         percentOfPresenceDendrites(iNeuron,1:nParcels-1) = percentOfPresenceDendrites(iNeuron,2:nParcels);
%     end % iNeuron
% 
%     for iA = 1:nNeurons
%         for iD = 1:nNeurons
%             connectionProbabilities(iA,iD,1:nParcels-1) = connectionProbabilities(iA,iD,2:nParcels);
%         end % iD
%     end % iA
    
%     nParcels = nParcels - 1; % omit Alveus for CA1 cells
    
    % scale connection probabilities from 1 to nProbabilityColors for mapping to colormap colors       
    connectionProbabilitiesMax = max(max(max(connectionProbabilities)));
    connectionProbabilitiesNonZeroMin = min(min(min(connectionProbabilities(connectionProbabilities > 0))));
    nProbabilityColors = round(connectionProbabilitiesMax/connectionProbabilitiesNonZeroMin+0.5);
    connectionProbabilitiesScaled = round(connectionProbabilities/connectionProbabilitiesNonZeroMin+0.5);
    
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
                                        
                if (connectionProbabilities(iNeuron,jNeuron,iParcel) > 0)
                        
                    figure(2);
                    
                    [x,y,z] = ellipsoid(iNeuron-0.5,jNeuron-0.5,iParcel-0.5,0.25,0.25,0.25+0.25/1);%4);
                    
                    hs = surf(x,y,z,zeros(21),'EdgeColor','none','FaceAlpha',1.0);
                    
                    set(hs, 'FaceColor', colormapProb(connectionProbabilitiesScaled(iNeuron,jNeuron,iParcel),:));
                    
                    hold on;
                    
                    isOverlap = 1;
                    
                end % if (connectionProbabilitiesSumsScaled(iNeuron,jNeuron) > 1)
                    
            end % iParcel

            outputData(iNeuron,jNeuron) = sum(connectionProbabilities(iNeuron,jNeuron,1:nParcels));
            
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
            outputMatrix{i+1,1+j} = sum(connectionProbabilities(i,j,1:nParcels));
        end % j
    end %i

    [success, message] = xlswrite(outputFileName, outputMatrix);
    
%     plotFileName = ['PT_output/', fileName(1:end-4), '_fig2.eps'];
%     
%     print(gcf, '-depsc', '-r800', plotFileName);
%     
%     plotFileName = ['PT_output/', fileName(1:end-4), '_fig2.tif'];
% 
%     print(gcf, '-dtiffnocompression', '-r600', plotFileName);
    
end % neurites()