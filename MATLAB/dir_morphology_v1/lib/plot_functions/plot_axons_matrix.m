function plot_axons_matrix(csvFile)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    fprintf(1, '\nConverting and plotting...')

    % retrieve parcellation data (manually stored in
    % current_parcellation_data)
    load parcellation.mat
    load isInclude.mat

    N = nAllCells;
    
    isJanelia = 1;
    
    axonsArray = zeros(1,nAllCells);
    dendritesArray = zeros(1,nAllCells);
    notes = zeros(1,nAllCells);
    notesUnique = zeros(1,nAllCells);
    notesCount = 0;

    foundCells = 0;
    rowLooper = rowSkip + 1;
    while foundCells < nAllCells
        if ~isempty(csvFile{rowLooper,cellIdColNum})          
            if strcmpi(csvFile{rowLooper,axonOrDendriteColNum},'axons')
                axonsArray(foundCells+1) = rowLooper;
                if ~isempty(csvFile{rowLooper,notesColNum})
                    number = str2num(csvFile{rowLooper,notesColNum});
                    notes(foundCells+1) = number;
                    if find(notesUnique == number)
                        notesUnique(foundCells+1) = -1;
                    else
                        notesUnique(foundCells+1) = number;
                        notesCount = notesCount + 1;
                        notesStrings{notesCount} = csvFile{rowLooper,notesColNum-1};
                    end
                else
                    notes(foundCells+1) = -1;
                    notesUnique(foundCells+1) = -1;
                end
            elseif strcmpi(csvFile{rowLooper,axonOrDendriteColNum},'dendrites')
                foundCells = foundCells + 1;
                dendritesArray(foundCells) = rowLooper;
            end
        end
        rowLooper = rowLooper + 1;
    end

    
    % retrieve cellIds from first column of input file and convert from
    % string to number
    cellIds = str2num(cell2mat(csvFile(axonsArray,cellIdColNum)));
    
    % also retrieve cell labels and save for plotting
    cellLabels = csvFile(axonsArray,labelColNum);
    cellEorI = csvFile(axonsArray,excitOrInhibColNum);
    
    
    % add 1 to each dimension to enable use of pcolor function
    % (these elements will not be filled or plotted)
    CijOverlap = zeros(nOfficialParcellations+1, nAllCells+1);
    CijAxonSomaOverlap = zeros(nOfficialParcellations+1, nAllCells+1);
    knownNegAxonLocations = zeros(nOfficialParcellations+1, nAllCells+1);
    knownNegDendriteLocations = zeros(nOfficialParcellations+1, nAllCells+1);
    
    % loop over rows (cell types)
    for iCell = 1:nAllCells         
        axonRow = axonsArray(iCell);
        dendriteRow = dendritesArray(iCell);
        
        if strcmpi(csvFile(axonRow,cellIdColNum),csvFile(dendriteRow,cellIdColNum))
            CijOFFICIALColCounter = nOfficialParcellations+1;
            
            % loop over columns (parcellations)
            for P = [1:nParcellations] + colSkip;
                
                % ensure it's an official parcellation
%                if strcmpi(csvFile{officialParcelRowNum,P},'1')
                    CijOFFICIALColCounter = CijOFFICIALColCounter - 1;
                
                    layerNames(CijOFFICIALColCounter) = cellstr(csvFile{parcelNamesRowNum,P});

                    % store axons as 1, dendrites as 2, both as 3
                    if ~isempty(csvFile{axonRow,P})
                        
                        axonIdsString = csvFile{axonRow,P};

                        [axonIds, negAxonIds, nNegAxonIds, nNegAxonIdsClassLinks, nNegAxonIdsNeuriteLocations] = find_negs(axonIdsString);

                        %if isempty(find(csvFile{axonRow,P} == '-', 1))
                        if (nNegAxonIdsNeuriteLocations <= 1)
                            CijOverlap(CijOFFICIALColCounter, iCell) = CijOverlap(CijOFFICIALColCounter, iCell) + 1;
                        else
                            knownNegAxonLocations(CijOFFICIALColCounter, iCell) = 1;
                        end

                    end% if ~isempty(csvFile{axonRow,P})

%                     if ~isempty(csvFile{dendriteRow,P})

%                         dendriteIdsString = csvFile{dendriteRow,P};

%                         [dendriteIds, negDendriteIds, nNegDendriteIds, nNegDendriteIdsClassLinks, nNegDendriteIdsNeuriteLocations] = find_negs(dendriteIdsString);

%                         %if isempty(find(csvFile{dendriteRow,P} == '-', 1))
%                         if (nNegDendriteIdsNeuriteLocations <= 1)
%                             CijOverlap(CijOFFICIALColCounter, iCell) = CijOverlap(CijOFFICIALColCounter, iCell) + 2;
%                         else
%                             knownNegDendriteLocations(CijOFFICIALColCounter, iCell) = 1;
%                         end

%                     end % if ~isempty(csvFile{dendriteRow,P})

		    if (strcmp(csvFile{axonRow,pclFlagColNum},'1') && ...
			((strcmp(csvFile{parcelNamesRowNum,P},pclName.DG)) || ...
			 (strcmp(csvFile{parcelNamesRowNum,P},pclName.CA3)) || ...
			 (strcmp(csvFile{parcelNamesRowNum,P},pclName.CA2)) || ...
			 (strcmp(csvFile{parcelNamesRowNum,P},pclName.CA1)) || ...
			 (strcmp(csvFile{parcelNamesRowNum,P},pclName.SUB))))
			if (strcmp(csvFile{axonRow,cellIdColNum}(2), csvFile{layerIdRowNum,P}(2)))
			    CijAxonSomaOverlap(CijOFFICIALColCounter, iCell) = 1;
 			end
		    end

            end % P loop

        end % if axonArray ID = dendritesArray iD

    end % iCell loop
 
    %PLOT    
    clf; cla;
    figure(1);
    
    % properties for figure 1
    scrsz = get(0,'ScreenSize');
    set(gcf, 'OuterPosition', [50 50 scrsz(3)*0.9 scrsz(4)*0.9])
    set(gcf, 'color', 'w');

            
    colormap([1 1 1; 0 0 0]);
    pcolor(CijOverlap)
    
    axis ij
    %axis square
    axis off 
    
    axis([-10 nAllCells+2 0 nOfficialParcellations+10])

    DGtab = 1 + nOfficialParcellations - nParcels(DG)/2;
    CA3tab = 1 + nOfficialParcellations - nParcels(DG) - nParcels(CA3)/2;
    CA2tab = 1 + nOfficialParcellations - nParcels(DG) - ...
	     nParcels(CA3) - nParcels(CA2)/2;
    CA1tab = 1 + nOfficialParcellations - nParcels(DG) - ...
	     nParcels(CA3) - nParcels(CA2) - nParcels(CA1)/2;
    SUBtab = 1 + nOfficialParcellations - nParcels(DG) - ...
	     nParcels(CA3) - nParcels(CA2) - nParcels(CA1) ...
	     - nParcels(SUB)/2;
    ECtab = 1 + nOfficialParcellations - nParcels(DG) - ...
	     nParcels(CA3) - nParcels(CA2) - nParcels(CA1) ...
	     - nParcels(SUB) - nParcels(EC)/2;

    text(-3, DGtab, ['DG'], 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-3, CA3tab, ['CA3'], 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-3, CA2tab, ['CA2'], 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-3, CA1tab, ['CA1'], 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-3, SUBtab, ['SUB'], 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-3, ECtab, ['EC'], 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);

    DGstart = 1 + nCells(DG)/2;
    CA3start = 1 + nCells(DG) + nCells(CA3)/2;
    CA2start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2)/2;
    CA1start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1)/2;
    SUBstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + ...
	nCells(SUB)/2;
    ECstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + ...
	nCells(SUB) + nCells(EC)/2;

    if isJanelia
        text(DGstart, nOfficialParcellations+9.5, 'DG', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(CA3start, nOfficialParcellations+9.5, 'CA3', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(CA2start, nOfficialParcellations+9.5, 'CA2', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(CA1start, nOfficialParcellations+9.5, 'CA1', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(SUBstart, nOfficialParcellations+9.5, 'SUB', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(ECstart, nOfficialParcellations+9.5, 'EC', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);

        text(-3, nOfficialParcellations+9.5, 'Axonal Locations', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 6);
    else
        text(DGstart, nOfficialParcellations+7.5, 'DG', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(CA3start, nOfficialParcellations+7.5, 'CA3', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(CA2start, nOfficialParcellations+7.5, 'CA2', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(CA1start, nOfficialParcellations+7.5, 'CA1', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(SUBstart, nOfficialParcellations+7.5, 'SUB', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(ECstart, nOfficialParcellations+7.5, 'EC', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);

        text(-3, nOfficialParcellations+7.5, hippocampomeVersion, ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 6);
    end



    legendStart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + ...
	nCells(SUB) + nCells(EC) + 1;
    notesStart = legendStart;
    notesCount = 0;
    notesExtraLines = 0;

    % plot labels & shading lines
    for i = 1:nAllCells
        if (cellEorI{i} == 'E')
            clear cellLabel
            cellLabel = cellLabels{i};
            cellLabel = deblank(cellLabel);
            if isJanelia
                text(i+0.5, nOfficialParcellations+1.55, cellLabel, 'color', [0 0 0], 'HorizontalAlignment', 'right', 'Rotation', 90, 'FontSize', 6)
            else
                text(i+0.5, nOfficialParcellations+2.3, cellLabels{i}, 'color', [0 0 0], 'HorizontalAlignment', 'right', 'Rotation', 90, 'FontSize', 6)
            end
            if(notes(i) ~= -1)
                if isJanelia
                    text(i+0.5, nOfficialParcellations+1.45, num2str(notes(i)), 'color', [0 0 0], 'Rotation', 90, 'FontSize', 4)
                else
                    text(i+0.5, nOfficialParcellations+2, num2str(notes(i)), 'color', [0 0 0], 'Rotation', 90, 'FontSize', 4)
                end
            end
        elseif (cellEorI{i} == 'I')
            clear cellLabel
            cellLabel = cellLabels{i};
            cellLabel = deblank(cellLabel);
            if isJanelia
                text(i+0.5, nOfficialParcellations+1.55, cellLabel, 'color', [0 0 0], 'HorizontalAlignment', 'right', 'Rotation', 90, 'FontSize', 6)
            else
                text(i+0.5, nOfficialParcellations+2.3, cellLabels{i}, 'color', [0 0 0], 'HorizontalAlignment', 'right', 'Rotation', 90, 'FontSize', 6)
            end
            if(notes(i) ~= -1)
                if isJanelia
                    text(i+0.5, nOfficialParcellations+1.45, num2str(notes(i)), 'color', [0 0 0], 'Rotation', 90, 'FontSize', 4)
                else
                    text(i+0.5, nOfficialParcellations+2, num2str(notes(i)), 'color', [0 0 0], 'Rotation', 90, 'FontSize', 4)
                end
            end
        end
        if(notesUnique(i) ~= -1)
            notesCount = notesCount + 1;
            strng = sprintf('%d %s', notesCount, notesStrings{notesCount});
            semicolonIdx = strfind(strng, ';');

            if (semicolonIdx > 50)
                text(notesStart+1.25*(notesCount+notesExtraLines), nOfficialParcellations+1.0, strng(1:semicolonIdx), ...
                     'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 4, ...
                     'Color', 'k');
                notesExtraLines = notesExtraLines + 1;
                strng = sprintf('      %s', strng(semicolonIdx+2:end));
                text(notesStart+1.25*(notesCount+notesExtraLines), nOfficialParcellations+1.0, strng, ...
                     'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 4, ...
                     'Color', 'k');
            else
                text(notesStart+1.25*(notesCount+notesExtraLines), nOfficialParcellations+1.0, strng, ...
                     'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 4, ...
                     'Color', 'k');
            end
            
        end

        for j = 1:nOfficialParcellations
            if (i == 1)
                text(0, j+0.5, layerNames{j}, 'rotation', 180, 'FontSize', 6)
            end
 
%             % plot shading lines
%             switch (CijOverlap(j,i))
%                 % axons are blue and get horizontal lines (after graph rotation)
%                 case 1
%                     line ([i+0.3, i+0.3], [j, j+1], 'color', [1 1 1])                    
%                     line ([i+0.7, i+0.7], [j, j+1], 'color', [1 1 1])                    
%                 % dendrites are red and get vertical lines (after graph rotation)
%                 case 2
%                     line ([i, i+1], [j+0.3, j+0.3], 'color', [1 1 1])                                      
%                     line ([i, i+1], [j+0.7, j+0.7], 'color', [1 1 1])
                    
%                 % both are purple and get horizontal & vertical lines
%                 % (after graph rotation)
%                 case 3
%                     line ([i+0.3, i+0.3], [j, j+1], 'color', [1 1 1])                    
%                     line ([i+0.7, i+0.7], [j, j+1], 'color', [1 1 1])    
%                     line ([i, i+1], [j+0.3, j+0.3], 'color', [1 1 1])                                      
%                     line ([i, i+1], [j+0.7, j+0.7], 'color', [1 1 1])
% 		otherwise
% 		    ; % do nothing
%             end % switch
            
%  	    if (CijAxonSomaOverlap(j,i) & isIncludeAxonSomaOverlap)
                
%                     line ([i+0.1, i+0.95], [j+0.1, j+0.1], 'color', 'g', 'linewidth', 0.5);
%                     line ([i+0.1, i+0.95], [j+0.95, j+0.95], 'color', 'g', 'linewidth', 0.5);
%                     line ([i+0.1, i+0.1], [j+0.1, j+0.95], 'color', 'g', 'linewidth', 0.5);
%                     line ([i+0.95, i+0.95], [j+0.1, j+0.95], 'color', 'g', 'linewidth', 0.5);
                
%             end
      
%  	    if isIncludeKnownNegNeuriteLocations

%                 if knownNegAxonLocations(j,i)
                    
%                     line ([i, i+1], [j, j+1], 'color', 'r', 'linewidth', 0.5);
%                     line ([i, i+1], [j+1, j], 'color', 'r', 'linewidth', 0.5);
                    
%                 end
                
%                 if knownNegDendriteLocations(j,i)

%                     line ([i, i+1], [j, j+1], 'color', 'b', 'linewidth', 0.5);
%                     line ([i, i+1], [j+1, j], 'color', 'b', 'linewidth', 0.5);

%                 end

%                 knownNegNeuriteLocations = knownNegAxonLocations + knownNegDendriteLocations;

%                 if (knownNegNeuriteLocations(j,i) == 2)

%                     line ([i, i+1], [j, j+1], 'color', [0.5 0 0.5], 'linewidth', 0.5);
%                     line ([i, i+1], [j+1, j], 'color', [0.5 0 0.5], 'linewidth', 0.5);

%                 end

%           end % if isIncludeKnownNegNeuriteLocations

        end % for j

    end % for i

    DGline = length(DGcells) + 1;
    CA3line = DGline + length(CA3cells);
    CA2line = CA3line + length(CA2cells);
    CA1line = CA2line + length(CA1cells);
    SUBline = CA1line + length(SUBcells);
    ECline = SUBline + length(ECcells);
    
    % linewidth = 1.5 for me, 1 for Diek
    if isunix
	line_width = 1;
    else
	line_width = 1.5;
    end
    line([-2, N+1], [23, 23], 'linewidth', line_width, 'color', [0 0 0])    
    line([DGline, DGline], [1, nOfficialParcellations+7], 'linewidth', line_width, 'color', [0 0 0])
    line([-2, N+1], [18, 18], 'linewidth', line_width, 'color', [0 0 0])
    line([CA3line, CA3line], [1, nOfficialParcellations+7], 'linewidth', line_width, 'color', [0 0 0])
    line([-2, N+1], [14, 14], 'linewidth', line_width, 'color', [0 0 0])
    line([CA2line, CA2line], [1, nOfficialParcellations+7], 'linewidth', line_width, 'color', [0 0 0])
    line([-2, N+1], [10, 10], 'linewidth', line_width, 'color', [0 0 0])
    line([CA1line, CA1line], [1, nOfficialParcellations+7], 'linewidth', line_width, 'color', [0 0 0])
    line([-2, N+1], [7, 7], 'linewidth', line_width, 'color', [0 0 0])
    line([SUBline, SUBline], [1, nOfficialParcellations+7], 'linewidth', line_width, 'color', [0 0 0])

    tabShift = 1.0;

%     if isIncludeKnownNegNeuriteLocations
%         text(legendStart, nOfficialParcellations+tabShift, 'Red = axon/X', ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
%          'Color', 'r');

%         tabShift = tabShift - 3.6;

%         text(legendStart, nOfficialParcellations+tabShift, 'Blue = dendrite/X', ...
% 	 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ... 
%              'Color', 'b');

%         tabShift = tabShift - 4.6;

%         text(legendStart, nOfficialParcellations+tabShift, 'Purple = both/X', ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
%              'Color', [0.5 0 0.5]);

%         tabShift = tabShift - 4.5;

%     else
%         text(legendStart, nOfficialParcellations+tabShift, 'Red = axon', ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
%          'Color', 'r');

%         tabShift = tabShift - 3.0;

%         text(legendStart, nOfficialParcellations+tabShift, 'Blue = dendrite', ...
% 	 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ... 
%              'Color', 'b');

%         tabShift = tabShift - 4.0;

%         text(legendStart, nOfficialParcellations+tabShift, 'Purple = both', ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
%              'Color', [0.5 0 0.5]);

%         tabShift = tabShift - 4.0;

%     end
%     if isIncludeAxonSomaOverlap
%         text(legendStart, nOfficialParcellations+tabShift, ' ', ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 1, ...
%              'Color', 'g', 'EdgeColor', 'g'); % green

%         tabShift = tabShift - 0.4;

%         text(legendStart, nOfficialParcellations+tabShift, '= soma in principal cell layer', ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
%              'Color', 'g'); % green

%         tabShift = tabShift - 7.1;

%     end
%     if isIncludeFlaggedDuplicates
%         text(legendStart, nOfficialParcellations+tabShift, 'a,b,... = identical patterns', ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ... 
%              'Color', 'k');
%     end % if isIncludeFlaggedDuplicate

%     if isJanelia
%         strng = sprintf('%d parcellations', nOfficialParcellations);
%         text(-1.85, nOfficialParcellations+9.5, strng, ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
%              'Color', 'k');
%         strng = sprintf('%d neuronal classes', nAllCells);
%         text(-0.75, nOfficialParcellations+9.5, strng, ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
%              'Color', 'k');
%         text(0.35, nOfficialParcellations+9.5, 'Black = excitatory', ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
%              'Color', 'k'); % black
%         text(1.45, nOfficialParcellations+9.5, 'Gray = inhibitory', ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
%              'Color', [0 0 0]); % gray
%     else
%         strng = sprintf('%d parcellations', nOfficialParcellations);
%         text(-1.85, nOfficialParcellations+7.5, strng, ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
%              'Color', 'k');
%         strng = sprintf('%d neuronal classes', nAllCells);
%         text(-0.75, nOfficialParcellations+7.5, strng, ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
%              'Color', 'k');
%         text(0.35, nOfficialParcellations+7.5, 'Black = exc.', ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
%              'Color', 'k'); % black
%         text(1.45, nOfficialParcellations+7.5, 'Gray = inh.', ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
%              'Color', [0 0 0]); % gray

%     end

%     if isIncludeFlaggedDuplicates

%         overlapMatrix = CijOverlap';

%         overlapStr = num2str(overlapMatrix);

%         overlapStrUnique = unique(overlapStr,'rows');

%         nRowsUnique = size(overlapStrUnique,1);

%         nDuplicates = 0;

%         for iRow = 1:nRowsUnique

%             overlapDuplicateRows = strmatch(overlapStrUnique(iRow,:),overlapStr);

%             if (length(overlapDuplicateRows) > 1)
                
%                 nDuplicates = nDuplicates + 1;

%                 for iDups = 1:length(overlapDuplicateRows)

%                     %                    text(overlapDuplicateRows(iDups)+0.5, 1, num2str(nDuplicates), ...
%                     text(overlapDuplicateRows(iDups)+0.5, 0.8, char(96+nDuplicates), ...
%                          'Rotation', 90, 'FontSize', 4);

%                 end % for iDups

%             end % if

%         end % for iRow

%     end % if isIncludeFlaggedDuplicates


    % delete old plot with same name and export new one
    if (isunix)
        delete 'Cij_axons.eps';
        print(gcf, '-depsc', '-r800', './Cij_axons.eps'); 
    end

end % plot_axons_matrix

