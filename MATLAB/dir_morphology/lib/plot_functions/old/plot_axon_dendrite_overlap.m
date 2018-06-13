function plot_axon_dendrite_overlap(csvFile, axdeOverlapFilledPercentage)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    reply = [];
    
    isIncludeSomataLocations = 0;

    if (1 == 0)

    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))

        clc;

        if isIncludeSomataLocations
            isIncludeSomataLocationsStr = 'YES';
        else
            isIncludeSomataLocationsStr = [];
            isIncludeSomataLocationsStr = 'NO';
        end
        strng = sprintf('    1) Toggle inclusion of somata locations: %s', isIncludeSomataLocationsStr);
        disp(strng);

        strng = sprintf('    p) Proceed with plotting');
        disp(strng);    

        reply = input('\nYour selection: ', 's');

        switch reply

          case '1'
            isIncludeSomataLocations = ~isIncludeSomataLocations;
            reply = [];
            
          case 'p'
            ;

          otherwise
            reply = [];

        end % switch reply

    end % while (isempty(reply))

    end % if (1 == 0)


    fprintf(1, '\nPlotting overlap matrix...')

    % retrieve parcellation data (manually stored in
    % current_parcellation_data)
    load parcellation.mat
    load isInclude.mat
    load overlap.mat

    N = nAllCells;
    
    isJanelia = 0;
    
    %PLOT    
    clf; cla;
    figure(1);
    
    % properties for figure 1
    scrsz = get(0,'ScreenSize');
    set(gcf, 'OuterPosition', [50 50 scrsz(3)*0.9 scrsz(4)*0.9])
    set(gcf, 'color', 'w');

            
    colormap([1 1 1; 1 0 0; 0 0 1; .5 0 .5;])
    pcolor(CijOverlap)
    
    axis ij
    axis off 
    
    if (isunix)
        axis([-10 nAllCells+2 0 nOfficialParcellations+10])
    else
        axis([-10 nAllCells+2 -10 nOfficialParcellations+10])
    end

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

    % layer sugregions
    text(-3, DGtab, ['DG'], 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-3, CA3tab, ['CA3'], 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-3, CA2tab, ['CA2'], 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-3, CA1tab, ['CA1'], 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-3, SUBtab, ['SUB'], 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-3, ECtab, ['EC'], 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);

    DGstart = 1 + nCells(DG)/2;
    CA3start = 1 + nCells(DG) + nCells(CA3)/2;
    CA2start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2)/2;
    CA1start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1)/2 ...
        + 1; % fudge factor to avoid long class name
    SUBstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + ...
	nCells(SUB)/2;
    ECstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + ...
	nCells(SUB) + nCells(EC)/2;

    % cell class subregions
    if isJanelia
        text(DGstart, nOfficialParcellations+9.5, 'DG', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(CA3start, nOfficialParcellations+9.5, 'CA3', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(CA2start, nOfficialParcellations+9.5, 'CA2', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(CA1start, nOfficialParcellations+9.5, 'CA1', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(SUBstart, nOfficialParcellations+9.5, 'SUB', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(ECstart, nOfficialParcellations+9.5, 'EC', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);

        strng = sprintf('%s (%.1f%% filled)', hippocampomeVersion, axdeOverlapFilledPercentage);
        text(-3, nOfficialParcellations+9.5, strng, ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 6);
    else % 7.5 -> 8.5
        text(DGstart, nOfficialParcellations+9.5, 'DG', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(CA3start, nOfficialParcellations+9.5, 'CA3', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(CA2start, nOfficialParcellations+9.5, 'CA2', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(CA1start, nOfficialParcellations+9.5, 'CA1', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(SUBstart, nOfficialParcellations+9.5, 'SUB', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
        text(ECstart, nOfficialParcellations+9.5, 'EC', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);

        strng = sprintf('%s (%.1f%% filled)', hippocampomeVersion, axdeOverlapFilledPercentage);
        text(-3, nOfficialParcellations+9.5, strng, ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5);
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
                text(i+0.5, nOfficialParcellations+1.55, cellLabel, 'color', [0 0 0], 'HorizontalAlignment', 'right', 'Rotation', 90, 'FontSize', 5.0)
            else
                text(i+0.5, nOfficialParcellations+2.3, cellLabels{i}, 'color', [0 0 0], 'HorizontalAlignment', 'right', 'Rotation', 90, 'FontSize', 5.0)
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
                text(i+0.5, nOfficialParcellations+1.55, cellLabel, 'color', [0.7 0.7 0.7], 'HorizontalAlignment', 'right', 'Rotation', 90, 'FontSize', 5.0)
            else
                text(i+0.5, nOfficialParcellations+2.3, cellLabels{i}, 'color', [0.7 0.7 0.7], 'HorizontalAlignment', 'right', 'Rotation', 90, 'FontSize', 5.0)
            end
            if(notes(i) ~= -1)
                if isJanelia
                    text(i+0.5, nOfficialParcellations+1.45, num2str(notes(i)), 'color', [0.7 0.7 0.7], 'Rotation', 90, 'FontSize', 4)
                else
                    text(i+0.5, nOfficialParcellations+2, num2str(notes(i)), 'color', [0.7 0.7 0.7], 'Rotation', 90, 'FontSize', 4)
                end
            end
        end

        if isIncludeKeyAndComments

            if (notesUnique(i) ~= -1)

                if (isunix)
                    notesCountThreshold = [2 2];
                else % PC
                    notesCountThreshold = [1 2];
                end

                notesCount = notesCount + 1;
                strng = sprintf('%d %s', notesCount, notesStrings{notesCount});

                if (notesCount == notesCountThreshold(1)+1)
                    notesExtraLines = 0;
                end

                if (notesCount == notesCountThreshold(2)+1)
                    notesExtraLines = 0;
                end

                pcVerticalStepSize = 1;
                pcHorizontalStepSize = 45;
                notesStartPChorz = legendStart - 10; %120;
                notesStartPCvert = -1+pcVerticalStepSize;


                if (notesCount <= notesCountThreshold(1))

                    notesVerticalPosition = notesStart+1.25*(notesCount+notesExtraLines);

                    notesHorizontalPosition = nOfficialParcellations+1.0;

                    notesVerticalPositionPC = notesStartPCvert-pcVerticalStepSize*(notesCount+notesExtraLines);

                    notesHorizontalPositionPC = notesStartPChorz;

                elseif ((notesCount > notesCountThreshold(1)) & (notesCount <= notesCountThreshold(2)))

                    notesVerticalPositionPC = notesStartPCvert-pcVerticalStepSize*(notesCount-notesCountThreshold(1)+notesExtraLines);
                    
                    notesHorizontalPositionPC = notesStartPChorz-pcHorizontalStepSize;

                else % notesCount > notesCountThreshold
                    
                    notesVerticalPosition = notesStart+1.25*(notesCount-notesCountThreshold(1)+notesExtraLines);
                    
                    notesHorizontalPosition = nOfficialParcellations+1.0-13.25;
                    
                    notesVerticalPositionPC = notesStartPCvert-pcVerticalStepSize*(notesCount-notesCountThreshold(2)+notesExtraLines);
                    
                    notesHorizontalPositionPC = notesStartPChorz-2*pcHorizontalStepSize;

                end % if notesCount

                semicolonIdx = strfind(strng, ';');

                if (semicolonIdx > 25)

                    if (isunix)

                        text(notesVerticalPosition, notesHorizontalPosition, strng(1:semicolonIdx), ...
                             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 4, ...
                             'Color', 'k');
                        
                    else % PC

                        text(notesHorizontalPositionPC, notesVerticalPositionPC, strng(1:semicolonIdx), ...
                             'HorizontalAlignment', 'left', 'Rotation', 180, 'FontSize', 6, ...
                             'Color', 'k');

                    end % if (isunix)

                    notesExtraLines = notesExtraLines + 1;

                    notesVerticalPosition = notesVerticalPosition+1.25*(1);

                    notesVerticalPositionPC = notesVerticalPositionPC-pcVerticalStepSize*(1);

                    strng = sprintf('      %s', strng(semicolonIdx+2:end));

                end % if (semicolonIdx > 25)

                semicolonIdx = strfind(strng, ';');
                
                if (semicolonIdx > 25)

                    if (isunix)

                        text(notesVerticalPosition, notesHorizontalPosition, strng(1:semicolonIdx), ...
                             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 4, ...
                             'Color', 'k');

                    else % PC
                        
                        text(notesHorizontalPositionPC, notesVerticalPositionPC, strng(1:semicolonIdx), ...
                             'HorizontalAlignment', 'left', 'Rotation', 180, 'FontSize', 6, ...
                             'Color', 'k');

                    end % if (isunix)

                    notesExtraLines = notesExtraLines + 1;

                    notesVerticalPosition = notesVerticalPosition+1.25*(1);

                    notesVerticalPositionPC = notesVerticalPositionPC-pcVerticalStepSize*(1);

                    strng = sprintf('      %s', strng(semicolonIdx+2:end));

                end % if (semicolonIdx > 25)

                if (isunix)

                    text(notesVerticalPosition, notesHorizontalPosition, strng, ...
                         'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 4, ...
                         'Color', 'k');

                else % PC

                    text(notesHorizontalPositionPC, notesVerticalPositionPC, strng, ...
                         'HorizontalAlignment', 'left', 'Rotation', 180, 'FontSize', 6, ...
                         'Color', 'k');

                end % if (isunix)

            end % if (notesUnique(i) ~= -1)

        end % if isIncludeKeyAndComments

        for j = 1:nOfficialParcellations

            if (i == 1)
                text(0, j+0.5, layerNames{j}, 'rotation', 180, 'FontSize', 6)
            end
 
 	    if (somataLocations(j,i) & isIncludeSomataLocations)
                
                    line ([i+0.05, i+0.95], [j+0.05, j+0.05], 'color', 'y', 'linewidth', 0.5);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.95], 'color', 'y', 'linewidth', 0.5);
                    line ([i+0.05, i+0.05], [j+0.05, j+0.95], 'color', 'y', 'linewidth', 0.5);
                    line ([i+0.95, i+0.95], [j+0.05, j+0.95], 'color', 'y', 'linewidth', 0.5);
%                     line ([i+0.1, i+0.95], [j+0.1, j+0.1], 'color', [255 153 0]/255, 'linewidth', 0.5);
%                     line ([i+0.1, i+0.95], [j+0.95, j+0.95], 'color', [255 153 0]/255, 'linewidth', 0.5);
%                     line ([i+0.1, i+0.1], [j+0.1, j+0.95], 'color', [255 153 0]/255, 'linewidth', 0.5);
%                     line ([i+0.95, i+0.95], [j+0.1, j+0.95], 'color', [255 153 0]/255, 'linewidth', 0.5);
                
            end
      
 	    if (CijAxonSomaOverlap(j,i) & isIncludeAxonSomaOverlap)
                
                    line ([i+0.05, i+0.95], [j+0.05, j+0.05], 'color', 'g', 'linewidth', 0.5);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.95], 'color', 'g', 'linewidth', 0.5);
                    line ([i+0.05, i+0.05], [j+0.05, j+0.95], 'color', 'g', 'linewidth', 0.5);
                    line ([i+0.95, i+0.95], [j+0.05, j+0.95], 'color', 'g', 'linewidth', 0.5);
                
            end
      
            % plot shading lines
            switch (CijOverlap(j,i))
                % axons are blue and get horizontal lines (after graph rotation)
                case 1
                    %line ([i+0.3, i+0.3], [j, j+1], 'color', [1 1 1])                    
                    %line ([i+0.7, i+0.7], [j, j+1], 'color', [1 1 1])                    
                    line ([i+0.5, i+0.5], [j+0.05, j+0.95], 'color', [1 1 1], 'linewidth', 0.5)                    
                % dendrites are red and get vertical lines (after graph rotation)
                case 2
                    %line ([i, i+1], [j+0.3, j+0.3], 'color', [1 1 1])                                      
                    %line ([i, i+1], [j+0.7, j+0.7], 'color', [1 1 1])
                    line ([i+0.05, i+0.95], [j+0.5, j+0.5], 'color', [1 1 1], 'linewidth', 0.5)
                    
                % both are purple and get horizontal & vertical lines
                % (after graph rotation)
                case 3
                    %line ([i+0.3, i+0.3], [j, j+1], 'color', [1 1 1])                    
                    %line ([i+0.7, i+0.7], [j, j+1], 'color', [1 1 1])    
                    %line ([i, i+1], [j+0.3, j+0.3], 'color', [1 1 1])                                      
                    %line ([i, i+1], [j+0.7, j+0.7], 'color', [1 1 1])
                    line ([i+0.5, i+0.5], [j+0.05, j+0.95], 'color', [1 1 1], 'linewidth', 0.5)    
                    line ([i+0.05, i+0.95], [j+0.5, j+0.5], 'color', [1 1 1], 'linewidth', 0.5)                     
		otherwise
		    ; % do nothing
            end % switch
            
 	    if isIncludeKnownNegNeuriteLocations

                if knownMixedAxonLocations(j,i)
                   
                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', 'k', 'linewidth', 0.5);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', 'k', 'linewidth', 0.5);
                    
                elseif knownNegAxonLocations(j,i)
                   
                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', 'r', 'linewidth', 0.5);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', 'r', 'linewidth', 0.5);
                    
                end
                
                if knownMixedDendriteLocations(j,i)
                   
                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', 'k', 'linewidth', 0.5);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', 'k', 'linewidth', 0.5);
                    
                elseif knownNegDendriteLocations(j,i)

                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', 'b', 'linewidth', 0.5);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', 'b', 'linewidth', 0.5);

                end

                knownNegNeuriteLocations = knownNegAxonLocations + knownNegDendriteLocations;

                knownMixedNeuriteLocations = knownMixedAxonLocations + knownMixedDendriteLocations;

                if knownMixedNeuriteLocations(j,i)
                   
                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', 'k', 'linewidth', 0.5);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', 'k', 'linewidth', 0.5);
                    
                elseif (knownNegNeuriteLocations(j,i) == 2)

                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', [0.5 0 0.5], 'linewidth', 0.5);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', [0.5 0 0.5], 'linewidth', 0.5);

                end

          end % if isIncludeKnownNegNeuriteLocations

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

    %% Add Key and Comments to the bottom of the matrix

    if isIncludeKeyAndComments

        tabShift = 1.0;

        if isIncludeKnownNegNeuriteLocations
            text(legendStart, nOfficialParcellations+tabShift, 'Red = axon/X', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
                 'Color', 'r');

            tabShift = tabShift - 3.6;

            text(legendStart, nOfficialParcellations+tabShift, 'Blue = dendrite/X', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ... 
                 'Color', 'b');

            tabShift = tabShift - 4.6;

            text(legendStart, nOfficialParcellations+tabShift, 'Purple = both/X', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
                 'Color', [0.5 0 0.5]);

            tabShift = tabShift - 4.5;

        else
            text(legendStart, nOfficialParcellations+tabShift, 'Red = axon', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
                 'Color', 'r');

            tabShift = tabShift - 3.0;

            text(legendStart, nOfficialParcellations+tabShift, 'Blue = dendrite', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ... 
                 'Color', 'b');

            tabShift = tabShift - 4.0;

            text(legendStart, nOfficialParcellations+tabShift, 'Purple = both', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
                 'Color', [0.5 0 0.5]);

            tabShift = tabShift - 4.0;

        end
        if isIncludeAxonSomaOverlap
            text(legendStart, nOfficialParcellations+tabShift, ' ', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 1, ...
                 'Color', 'g', 'EdgeColor', 'g'); % green

            tabShift = tabShift - 0.4;

            text(legendStart, nOfficialParcellations+tabShift, '= soma in principal cell layer', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
                 'Color', 'g'); % green

            tabShift = tabShift - 7.1;

        end
        if (isIncludeFlaggedDuplicates && isunix)
            text(legendStart, nOfficialParcellations+tabShift, 'a,b,... = identical patterns', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ... 
                 'Color', 'k');
        end % if isIncludeFlaggedDuplicate

    end % if isIncludeKeyAndComments

    %% displays current stats

    if isJanelia
        strng = sprintf('%d parcellations', nOfficialParcellations);
        text(-1.85, nOfficialParcellations+9.5, strng, ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
             'Color', 'k');
        strng = sprintf('%d neuronal classes', nAllCells);
        text(-0.75, nOfficialParcellations+9.5, strng, ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
             'Color', 'k');
        text(0.35, nOfficialParcellations+9.5, 'Black = excitatory', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
             'Color', 'k'); % black
        text(1.45, nOfficialParcellations+9.5, 'Gray = inhibitory', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
             'Color', [0.7 0.7 0.7]); % gray
    else
        strng = sprintf('%d parcellations', nOfficialParcellations);
        text(-0.30, nOfficialParcellations+9.0, strng, ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
             'Color', 'k');
        strng = sprintf('%d neuronal classes', nAllCells);
        text(1.05, nOfficialParcellations+9.0, strng, ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
             'Color', 'k');
        text(2.40, nOfficialParcellations+9.0, 'Black = exc.', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
             'Color', 'k'); % black
        text(3.75, nOfficialParcellations+9.0, 'Gray = inh.', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
             'Color', [0.7 0.7 0.7]); % gray

        % Plot status bars
        
        totalBarLength = 2;
        
        barWidth = 0.5;
        
        mainSourcesCompletedPercentage = nMainSourcesCompleted / nMainSourcesAll;
        
        mainSourcesCompletedPercentageBar = mainSourcesCompletedPercentage * totalBarLength;
        
        %        text(-3, nOfficialParcellations+9.5, strng, ...
        %         'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5);

        text(-1.65, nOfficialParcellations+9.0, '3-point rule', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5);
        
        rectangle('Position',[-1.7, nOfficialParcellations+6.75-totalBarLength, barWidth, totalBarLength], ...
                  'FaceColor', [1 1 1], 'EdgeColor', 'k', 'LineWidth', 0.25);
        
        rectangle('Position',[-1.7, nOfficialParcellations+6.75-mainSourcesCompletedPercentageBar, barWidth, mainSourcesCompletedPercentageBar], ...
                  'FaceColor', 'g', 'EdgeColor', 'g');
        
%         rectangle('Position',[-1.5, nOfficialParcellations+8.0, barWidth, totalBarLength], ...
%                   'FaceColor', [1 1 1], 'EdgeColor', 'k', 'LineWidth', 0.25);
        
%         rectangle('Position',[-1.5, nOfficialParcellations+8.0, barWidth, mainSourcesCompletedPercentageBar], ...
%                   'FaceColor', 'g', 'EdgeColor', 'g');
        
%         text(-1.5, nOfficialParcellations+8.75, '3-point rule', ...
%              'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5);
        
        
    end

    if (isIncludeFlaggedDuplicates && isunix)

        overlapMatrix = CijOverlap';

        overlapStr = num2str(overlapMatrix);

        overlapStrUnique = unique(overlapStr,'rows');

        nRowsUnique = size(overlapStrUnique,1);

        nDuplicates = 0;

        for iRow = 1:nRowsUnique

            overlapDuplicateRows = strmatch(overlapStrUnique(iRow,:),overlapStr);

            if (length(overlapDuplicateRows) > 1)
                
                nDuplicates = nDuplicates + 1;

                for iDups = 1:length(overlapDuplicateRows)

                    %                    text(overlapDuplicateRows(iDups)+0.5, 1, num2str(nDuplicates), ...
                    text(overlapDuplicateRows(iDups)+0.5, 0.8, char(96+nDuplicates), ...
                         'Rotation', 90, 'FontSize', 4);

                end % for iDups

            end % if

        end % for iRow

    end % if isIncludeFlaggedDuplicates


    %% delete old plot with same name and export new one
    if (isunix)
        orient(gcf, 'landscape');
        delete 'Cij_axon-dend.eps';
        print(gcf, '-depsc', '-r800', './Cij_axon-dend.eps'); 
    end

end % plot_axon_dendrite_overlap

