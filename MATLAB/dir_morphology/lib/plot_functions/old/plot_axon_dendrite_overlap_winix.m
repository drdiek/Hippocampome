function plot_axon_dendrite_overlap_winix(axdeOverlapFilledPercentage)

    load Cij.mat cellLabels cellADcodes
    load parcellation.mat
    load overlap.mat cellEorI CijOverlap CijAxonSomaOverlap knownNegAxonLocations knownNegDendriteLocations ...
        layerNames somataLocations knownMixedAxonLocations knownMixedDendriteLocations
    load notes.mat notes notesUnique notesStrings
    load isInclude.mat

    N = nAllCells;
    
    clf; cla;
    figure(1);
    
    scrsz = get(0,'ScreenSize');
    set(gcf, 'OuterPosition', [50 50 scrsz(3)*0.9 scrsz(4)*0.9])
    set(gcf, 'color', 'w');

    
    %% plot matrix %%
    
    colormap([1 1 1; 1 0 0; 0 0 1; .5 0 .5;])
    pcolor(CijOverlap)
    
    axis ij
    axis off 

    axis([-10 nAllCells+2 -10 nOfficialParcellations+10])

    notesCount = 0;
    notesExtraLines = 0;


    % plot labels & shading lines
    for i = 1:nAllCells       
        cellLabel = deblank(cellLabels{i});
        cellADcode = deblank(cellADcodes{i});
        label_code_cat = [cellLabel, ' ', cellADcode];
        
        if (cellEorI{i} == 'E')
            labelColor = [0 0 0]; %black
        elseif (cellEorI{i} == 'I')
            labelColor = [0.7 0.7 0.7]; %gray
        end        
        
        text(i+0.5, nOfficialParcellations+2.3, label_code_cat, 'color', labelColor, ...
            'HorizontalAlignment', 'right', 'Rotation', 90, 'FontSize', 5.0, 'Interpreter', 'none')

        if(notes(i) ~= -1)
            text(i+0.5, nOfficialParcellations+2, num2str(notes(i)), 'color', [0 0 0], 'Rotation', 90, 'FontSize', 4)
        end

        if isIncludeKeyAndComments
            if (notesUnique(i) ~= -1)
				notesCountThreshold = [4 8];
				notesCount = notesCount + 1;

				strng = sprintf('%d %s', notesCount, notesStrings{notesCount});

                if (notesCount == notesCountThreshold(1)+1 || notesCount == notesCountThreshold(2)+1)
					notesExtraLines = 0;
                end
 
				pcVerticalStepSize = 1;
				pcHorizontalStepSize = 25;
				notesStartPChorz = 59;
				notesStartPCvert = -0+pcVerticalStepSize;

            
                if (notesCount <= notesCountThreshold(1))
					notesVerticalPositionPC = notesStartPCvert-pcVerticalStepSize*(notesCount+notesExtraLines);
					notesHorizontalPositionPC = notesStartPChorz;

            	elseif ((notesCount > notesCountThreshold(1)) && (notesCount <= notesCountThreshold(2)))
					notesVerticalPositionPC = notesStartPCvert-pcVerticalStepSize*(notesCount-notesCountThreshold(1)+notesExtraLines);
					notesHorizontalPositionPC = notesStartPChorz-pcHorizontalStepSize;

				else % notesCount > notesCountThreshold
					notesVerticalPositionPC = notesStartPCvert-pcVerticalStepSize*(notesCount-notesCountThreshold(2)+notesExtraLines);
					notesHorizontalPositionPC = notesStartPChorz-2*pcHorizontalStepSize;

                end % if notesCount

				semicolonIdx = strfind(strng, ';');

                for semiCount = 1:2
                    if (semicolonIdx > 25)
						text(notesHorizontalPositionPC, notesVerticalPositionPC, strng(1:semicolonIdx), ...
							'HorizontalAlignment', 'left', 'Rotation', 180, 'FontSize', 5, ...
							'Color', 'k');

		                notesExtraLines = notesExtraLines + 1;
		                notesVerticalPositionPC = notesVerticalPositionPC-pcVerticalStepSize*(1);	
		                strng = sprintf('      %s', strng(semicolonIdx+2:end));
                    end % if (semicolonIdx > 25)

					semicolonIdx = strfind(strng, ';');
                end


                text(notesHorizontalPositionPC, notesVerticalPositionPC, strng, ...
                     'HorizontalAlignment', 'left', 'Rotation', 180, 'FontSize', 5, ...
                     'Color', 'k');

            end % if (notesUnique(i) ~= -1)

        end % if isIncludeKeyAndComments


        for j = 1:nOfficialParcellations
            if (i == 1)
                text(0, j+0.5, layerNames{j}, 'rotation', 180, 'FontSize', 6)
            end

            if (somataLocations(j,i) && isIncludeSomataLocations)
				line ([i+0.05, i+0.95], [j+0.05, j+0.05], 'color', 'y', 'linewidth', 0.5);
				line ([i+0.05, i+0.95], [j+0.95, j+0.95], 'color', 'y', 'linewidth', 0.5);
				line ([i+0.05, i+0.05], [j+0.05, j+0.95], 'color', 'y', 'linewidth', 0.5);
				line ([i+0.95, i+0.95], [j+0.05, j+0.95], 'color', 'y', 'linewidth', 0.5);
            end
      
            if (CijAxonSomaOverlap(j,i) && isIncludeAxonSomaOverlap)
                line ([i+0.05, i+0.95], [j+0.05, j+0.05], 'color', 'g', 'linewidth', 0.5);
                line ([i+0.05, i+0.95], [j+0.95, j+0.95], 'color', 'g', 'linewidth', 0.5);
                line ([i+0.05, i+0.05], [j+0.05, j+0.95], 'color', 'g', 'linewidth', 0.5);
                line ([i+0.95, i+0.95], [j+0.05, j+0.95], 'color', 'g', 'linewidth', 0.5);
            end
      
            % plot shading lines
            switch (CijOverlap(j,i))
                % axons are blue and get horizontal lines (after graph rotation)
                case 1
                    line ([i+0.5, i+0.5], [j+0.05, j+0.95], 'color', [1 1 1], 'linewidth', 0.5)                    

                % dendrites are red and get vertical lines (after graph rotation)
                case 2
                    line ([i+0.05, i+0.95], [j+0.5, j+0.5], 'color', [1 1 1], 'linewidth', 0.5)
                    
                % both are purple and get horizontal & vertical lines
                % (after graph rotation)
                case 3
                    line ([i+0.5, i+0.5], [j+0.05, j+0.95], 'color', [1 1 1], 'linewidth', 0.5)    
                    line ([i+0.05, i+0.95], [j+0.5, j+0.5], 'color', [1 1 1], 'linewidth', 0.5)                     
                
                otherwise
                    % do nothing

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

                if knownMixedNeuriteLocations(j,i) == 1
                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', 'k', 'linewidth', 0.5);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', 'k', 'linewidth', 0.5);
                elseif (knownNegNeuriteLocations(j,i) == 2)
                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', [0.5 0 0.5], 'linewidth', 0.5);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', [0.5 0 0.5], 'linewidth', 0.5);
                end

            end % if isIncludeKnownNegNeuriteLocations
        end % for j
    end % for i

    % parcellation subregion headers
    DGtab = 1 + nOfficialParcellations - nParcels(DG)/2;
    CA3tab = 1 + nOfficialParcellations - nParcels(DG) - nParcels(CA3)/2;
    CA2tab = 1 + nOfficialParcellations - nParcels(DG) - nParcels(CA3) - nParcels(CA2)/2;
    CA1tab = 1 + nOfficialParcellations - nParcels(DG) - nParcels(CA3) - nParcels(CA2) - nParcels(CA1)/2;
    SUBtab = 1 + nOfficialParcellations - nParcels(DG) - nParcels(CA3) - nParcels(CA2) - nParcels(CA1) - nParcels(SUB)/2;
    ECtab = 1 + nOfficialParcellations - nParcels(DG) - nParcels(CA3) - nParcels(CA2) - nParcels(CA1) - nParcels(SUB) - nParcels(EC)/2;

    text(-2.5, DGtab, 'DG', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-2.5, CA3tab, 'CA3', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-2.5, CA2tab, 'CA2', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-2.5, CA1tab, 'CA1', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-2.5, SUBtab, 'SUB', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-2.5, ECtab, 'EC', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);

    % cell class subregion headers
    DGstart = 1 + nCells(DG)/2;
    CA3start = 1 + nCells(DG) + nCells(CA3)/2;
    CA2start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2)/2;
    CA1start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1)/2 + 1; % fudge factor to avoid long class name
    SUBstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(SUB)/2;
    ECstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(SUB) + nCells(EC)/2;

    text(DGstart, nOfficialParcellations+9.5, 'DG', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
    text(CA3start, nOfficialParcellations+9.5, 'CA3', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
    text(CA2start, nOfficialParcellations+9.5, 'CA2', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
    text(CA1start, nOfficialParcellations+9.5, 'CA1', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
    text(SUBstart, nOfficialParcellations+9.5, 'SUB', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
    text(ECstart, nOfficialParcellations+9.5, 'EC', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);

    DGline = length(DGcells) + 1;
    CA3line = DGline + length(CA3cells);
    CA2line = CA3line + length(CA2cells);
    CA1line = CA2line + length(CA1cells);
    SUBline = CA1line + length(SUBcells);
    %ECline = SUBline + length(ECcells);
    
	line_width = 2;

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


	%% Add title and status  bar to top %%
    strng = sprintf('%s (%.1f%% filled)', hippocampomeVersion, axdeOverlapFilledPercentage);
    text(-6, nOfficialParcellations+9.5, strng, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5);

%{       
    % Plot status bars
    totalBarLength = 2;
    barWidth = 0.5;
    mainSourcesCompletedPercentage = nMainSourcesCompleted / nMainSourcesAll;
    mainSourcesCompletedPercentageBar = mainSourcesCompletedPercentage * totalBarLength;

    %        text(-3, nOfficialParcellations+9.5, strng, ...
    %         'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5);

    text(-4.85, nOfficialParcellations+7.5, '3-point rule', ...
		'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5);
   
    rectangle('Position',[-4.85, nOfficialParcellations+3.75-totalBarLength, barWidth, totalBarLength], ...
		'FaceColor', [1 1 1], 'EdgeColor', 'k', 'LineWidth', 0.25);
    
    rectangle('Position',[-4.85, nOfficialParcellations+3.75-mainSourcesCompletedPercentageBar, barWidth, mainSourcesCompletedPercentageBar], ...
		'FaceColor', 'g', 'EdgeColor', 'g');
%}
    
	% print status of lit search
	text(-5.0, nOfficialParcellations+9.5, DGclasses, ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color', 'k');
        text(-4.5, nOfficialParcellations+9.5, CA3classes, ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color', 'k');
        text(-4.0, nOfficialParcellations+9.5, CA1classes, ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color', 'k');
        text(-3.5, nOfficialParcellations+9.5, CA2classes, ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color', 'k');
%  	text(-5.0, nOfficialParcellations+9.5, '6/8 primary, 0/4 secondary DG classes', ...
%          'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color', 'k');
%     text(-4.5, nOfficialParcellations+9.5, '5/10 primary, 0/9 secondary CA3 classes', ...
%          'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color', 'k');
%     text(-4.0, nOfficialParcellations+9.5, '8/13 primary, 5/15 secondary CA1 classes', ...
%          'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color', 'k');
     
    % print nParcellations
    strng = sprintf('%d parcellations', nOfficialParcellations);
    text(-2.5, nOfficialParcellations+7.5, strng, ...
		'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
		'Color', 'k');
    strng = sprintf('%d neuronal classes', nAllCells);
    text(-2.0, nOfficialParcellations+7.5, strng, ...
		'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
		'Color', 'k');
    text(-1.0, nOfficialParcellations+7.5, 'Black = exc.', ...
		'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
		'Color', 'k'); % black
    text(-0.5, nOfficialParcellations+7.5, 'Gray = inh.', ...
		'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
		'Color', [0.7 0.7 0.7]); % gray


	%% Add legend to the bottom of the matrix %%
    if isIncludeKeyAndComments
		legendStart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(SUB) + nCells(EC) + 1;

		tabShift = 1.0;

		if isIncludeKnownNegNeuriteLocations
			text(legendStart, nOfficialParcellations+tabShift, 'Red = axon/X', ...
				'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
				'Color', 'r');

			tabShift = tabShift - 4.6;
			text(legendStart, nOfficialParcellations+tabShift, 'Blue = dendrite/X', ...
				'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ... 
				'Color', 'b');

			tabShift = tabShift - 5.6;
			text(legendStart, nOfficialParcellations+tabShift, 'Purple = both/X', ...
				'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
				'Color', [0.5 0 0.5]);

			tabShift = tabShift - 5.5;
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

			tabShift = 1.0;
		end

		if (isIncludeFlaggedDuplicates)
			text(legendStart+1, nOfficialParcellations+tabShift, 'a,b,... = identical patterns', ...
				'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ... 
				'Color', 'k');
		end % if isIncludeFlaggedDuplicate

    end % if isIncludeKeyAndComments


    %% flag duplicates %%
    if (isIncludeFlaggedDuplicates)
        CijOverlap = CijOverlap(1:size(CijOverlap,1)-1,1:size(CijOverlap,2)-1);
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
                    % text(overlapDuplicateRows(iDups)+0.5, 1, num2str(nDuplicates), ...
                    text(overlapDuplicateRows(iDups)+0.5, 0.8, char(96+nDuplicates), ...
                         'Rotation', 90, 'FontSize', 4);

                end % for iDups
            end % if
        end % for iRow
    end % if isIncludeFlaggedDuplicates


    %% delete old plot with same name and export new one
	orient(gcf, 'landscape');
	delete 'Cij_axon-dend.eps';
	print(gcf, '-depsc', '-r800', './Cij_axon-dend.eps'); 

end % plot_axon_dendrite_overlap

