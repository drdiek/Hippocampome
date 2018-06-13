function plot_axon_dendrite_overlap_unix(axdeOverlapFilledPercentage, ...
    printStart, printEnd, regionCode)

    load Cij.mat
    load parcellation.mat
    load overlap.mat
    load notes.mat notes notesUnique notesStrings
    load isInclude.mat
    load status.mat status
    load connectivityToggles

    CijOverlap = CijOverlap(:,printStart:printEnd+1);
    N = size(CijOverlap,2);
    
    cellEorI = cellEorI(printStart:printEnd);
    CijAxonSomaOverlap = CijAxonSomaOverlap(:,printStart:printEnd);
    knownNegAxonLocations = knownNegAxonLocations(:,printStart:printEnd);
    knownNegDendriteLocations = knownNegDendriteLocations(:,printStart:printEnd);
    somataLocations = somataLocations(:,printStart:printEnd);
    knownMixedAxonLocations = knownMixedAxonLocations(:,printStart:printEnd);
    knownMixedDendriteLocations = knownMixedDendriteLocations(:,printStart:printEnd);
    borderlineCallsLocations = borderlineCallsLocations(:,printStart:printEnd);
    notes = notes(:,printStart:printEnd);
    notesUnique = notesUnique(:,printStart:printEnd);
    
    clf; cla;
    figure(1);
    
    scrsz = get(0,'ScreenSize');
    set(gcf, 'OuterPosition', [50 50 scrsz(3)*0.9 scrsz(4)*0.9])
    set(gcf, 'color', 'w');


    %% plot matrix %%
    
    colormap([1 1 1;   ... % no neurites = white
              1 0 0;   ... % axons only = red
              0 0 1;   ... % dendrites only = blue
              .5 0 .5]) ... % axons and dendrites = purple
                            %1 1 0;   ... % partial axons = yellow
                            %0 1 0;   ... % partial dendrites = green
                            %0 0 0])      % partial axons and dendrites = black
    pcolor(CijOverlap)
    
    axis ij
    axis off 

    axis([-10 N+2 -10 nOfficialParcellations+10])

    notesCount = 0;
    notesExtraLines = 0;
    nStatus = 0;
    
    status = status(:,printStart:printEnd);

    % plot labels & shading lines
    for i = 1:printEnd-printStart+1
        cellLabel = deblank(cellLabels{printStart+i-1});
        cellADcode = deblank(cellADcodes{printStart+i-1});
        %label_code_cat = [cellLabel, ' ', cellADcode];
        
        if (cellEorI{i} == 'E')
            labelColor = [0 0 0]; %black
            label_code_cat = [cellLabel, ' (+)', cellADcode];
        elseif (cellEorI{i} == 'I')
            labelColor = [0.5 0.5 0.5]; %gray
            label_code_cat = [cellLabel, ' (-)', cellADcode];
        end        
        
        if ( ( (status(i) > 0) && (status(i) < 0.5) ) || ...
             ( (status(i) > 0.5) && (status(i) < 1.0) ) )
            label_code_cat = ['(t) ', label_code_cat];
        end

        if (status(i) == 0.5)
            label_code_cat = ['(v) ', label_code_cat];
        end

        if (status(i) < 0)
            label_code_cat = ['(x) ', label_code_cat];
        end

%         if (status(i) >= 1)
%             label_code_cat = ['+', label_code_cat];
%             nStatus = nStatus + 1;
%         end


        text(i+0.5, nOfficialParcellations+2.3, label_code_cat, 'color', labelColor, ...
            'HorizontalAlignment', 'right', 'Rotation', 90, 'FontSize', 5.0, 'Interpreter', 'none')

        if isCellProjecting(i)
            text(i+0.5, nOfficialParcellations+2.3, 'p', 'color', labelColor, ...
            'Rotation', 90, 'FontSize', 5.0, 'Interpreter', 'none')
        end

        if isIncludeKeyAndComments

            if(notes(i) ~= -1)
                text(i+0.5, nOfficialParcellations+1.9, num2str(notes(i)), 'color', [0 0 0], 'Rotation', 90, 'FontSize', 4)
            end

            if (notesUnique(i) ~= -1)
				notesCountThreshold = [5 10];
				notesCount = notesCount + 1;

				strng = sprintf('%d %s', notesCount, notesStrings{notesCount});

                if (notesCount == notesCountThreshold(1)+1 || notesCount == notesCountThreshold(2)+1)
					notesExtraLines = 0;
                end
 
				pcVerticalStepSize = 1;
				pcHorizontalStepSize = round(N/3);%25;
				notesStartPChorz = N+1; %59;
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
      
            if ~isIncludeVirtualClasses
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
            end % if ~isIncludeVirtualClasses

            if isIncludeKnownNegNeuriteLocations
                if knownMixedAxonLocations(j,i)                 
                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', 'k', 'linewidth', 1.0);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', 'k', 'linewidth', 1.0);
                elseif knownNegAxonLocations(j,i)
                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', 'r', 'linewidth', 0.5);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', 'r', 'linewidth', 0.5);
                end
                
                if knownMixedDendriteLocations(j,i)
                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', 'k', 'linewidth', 1.0);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', 'k', 'linewidth', 1.0);
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

            
            if isIncludeVirtualClasses

                if borderlineCallsLocations(j,i) == 1 %borderline
                                                      %axons
                                                      % your code
                                                      % goes here
                    text (i+0.5, j+0.5, 'A', 'color', 'r', 'fontsize', ...
                          9, 'rotation', 90, 'HorizontalAlignment', ...
                          'center', 'FontWeight', 'bold');
                elseif borderlineCallsLocations(j,i) == 2
                                                          %%borderline
                                                          %%dendrites
                                                          % your
                                                          % code
                                                          % goes
                                                          % here
                    text (i+0.5, j+0.5, 'D', 'color', 'b', 'fontsize', ...
                          9, 'rotation', 90, 'HorizontalAlignment', ...
                          'center', 'FontWeight', 'bold');
                elseif borderlineCallsLocations(j,i) == 3
                                                          %%borderline
                                                          %%A&D
                                                          % your
                                                          % code
                                                          % goes
                                                          % here
                    text (i+0.5, j+0.5, 'AD', 'color', [0.5 0 0.5], ...
                          'FontSize', 9, 'rotation', 90, 'HorizontalAlignment', ...
                          'center', 'FontWeight', 'bold');

                end % if borderlineCallsLocations

            end % if isIncludeVirtualClasses

        end % for j
    end % for i

    % parcellation subregion headers
    DGtab = 1 + nOfficialParcellations - nParcels(DG)/2;
    CA3tab = 1 + nOfficialParcellations - nParcels(DG) - nParcels(CA3)/2;
    CA2tab = 1 + nOfficialParcellations - nParcels(DG) - nParcels(CA3) - nParcels(CA2)/2;
    CA1tab = 1 + nOfficialParcellations - nParcels(DG) - nParcels(CA3) - nParcels(CA2) - nParcels(CA1)/2;
    SUBtab = 1 + nOfficialParcellations - nParcels(DG) - nParcels(CA3) - nParcels(CA2) - nParcels(CA1) - nParcels(SUB)/2;
    ECtab = 1 + nOfficialParcellations - nParcels(DG) - nParcels(CA3) - nParcels(CA2) - nParcels(CA1) - nParcels(SUB) - nParcels(EC)/2;

    text(-3.5, DGtab, 'DG', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-3.5, CA3tab, 'CA3', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-3.5, CA2tab, 'CA2', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-3.5, CA1tab, 'CA1', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-3.5, SUBtab, 'SUB', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);
    text(-3.5, ECtab, 'EC', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 6);


    % cell class subregion headers
    if regionCode == ALL || regionCode == DG
        DGstart = 1 + nCells(DG)/2;
        strng = sprintf('DG (%d/{\\color[rgb]{0.5 0.5 0.5}%d})', ...
            nCellsE(DG), nCells(DG)-nCellsE(DG));
        text(DGstart, nOfficialParcellations+9.0, strng, ...
            'HorizontalAlignment', 'center', 'rotation', 180, ...
             'FontSize', 6);
    end
    if regionCode == ALL || regionCode == CA3
        if regionCode == ALL
            CA3start = 1 + nCells(DG) + nCells(CA3)/2;
        else
            CA3start = 1 + nCells(CA3)/2;
        end
        
        strng = sprintf('CA3 (%d/{\\color[rgb]{0.5 0.5 0.5}%d})', ...
                        nCellsE(CA3), nCells(CA3)-nCellsE(CA3));
        text(CA3start, nOfficialParcellations+9.0, strng, ...
             'HorizontalAlignment', 'center', 'rotation', 180, ...
             'FontSize', 6);        
    end
    if regionCode == ALL || regionCode == CA2  

        if regionCode == ALL
            CA2start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2)/ ...
                2;
        else
            CA2start = 1 + nCells(CA2)/2;
        end
        
        strng = sprintf('CA2 (%d/{\\color[rgb]{0.5 0.5 0.5}%d})', ...
            nCellsE(CA2), nCells(CA2)-nCellsE(CA2));
        text(CA2start, nOfficialParcellations+9.0, strng, ...
            'HorizontalAlignment', 'center', 'rotation', 180, ...
             'FontSize', 6);
    end
    if regionCode == ALL || regionCode == CA1
        if regionCode == ALL       
            CA1start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + ...
                nCells(CA1)/2;
        else
            CA1start = 1 + nCells(CA1)/2;
        end
        
        strng = sprintf('CA1 (%d/{\\color[rgb]{0.5 0.5 0.5}%d})', ...
            nCellsE(CA1), nCells(CA1)-nCellsE(CA1));
        text(CA1start, nOfficialParcellations+9.0, strng, ...
            'HorizontalAlignment', 'center', 'rotation', 180, ...
             'FontSize', 6);
    end
    if regionCode == ALL || regionCode == SUB
        if regionCode == ALL   
            SUBstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + ...
                nCells(CA1) + nCells(SUB)/2;
        else
            SUBstart = 1 + nCells(SUB)/2;
        end
        
        strng = sprintf('SUB (%d/{\\color[rgb]{0.5 0.5 0.5}%d})', ...
            nCellsE(SUB), nCells(SUB)-nCellsE(SUB));
        text(SUBstart, nOfficialParcellations+9.0, strng, ...
            'HorizontalAlignment', 'center', 'rotation', 180, ...
             'FontSize', 6);         
    end
    if regionCode == ALL || regionCode == EC
        if regionCode == ALL
            ECstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + ...
                      nCells(CA1) + nCells(SUB) + nCells(EC)/2;
        else
            ECstart = 1 + nCells(EC)/2;
        end
 
        strng = sprintf('EC (%d/{\\color[rgb]{0.5 0.5 0.5}%d})', ...
            nCellsE(EC), nCells(EC)-nCellsE(EC));
        text(ECstart, nOfficialParcellations+9.0, strng, ...
            'HorizontalAlignment', 'center', 'rotation', 180, ...
             'FontSize', 6); 
    end
    


    % thick lines on parcellation axis
    line_width = 1;
    line([-3, N+0], [23, 23], 'linewidth', line_width, 'color', [0 ...
                        0 0]) 
    line([-3, N+0], [18, 18], 'linewidth', line_width, 'color', [0 ...
                        0 0])
    line([-3, N+0], [14, 14], 'linewidth', line_width, 'color', [0 ...
                        0 0])
    line([-3, N+0], [10, 10], 'linewidth', line_width, 'color', [0 ...
                        0 0])
    line([-3, N+0], [7, 7], 'linewidth', line_width, 'color', [0 0 ...
                        0])
    
    % thick lines on cell class axis
    if regionCode == ALL
        DGline = length(DGcells) + 1;
        CA3line = DGline + length(CA3cells);
        CA2line = CA3line + length(CA2cells);
        CA1line = CA2line + length(CA1cells);
        SUBline = CA1line + length(SUBcells);       
 
        line([DGline, DGline], [1, nOfficialParcellations+7], ...
             'linewidth', line_width, 'color', [0 0 0])        
        line([CA3line, CA3line], [1, nOfficialParcellations+7], ...
             'linewidth', line_width, 'color', [0 0 0])
        line([CA2line, CA2line], [1, nOfficialParcellations+7], ...
             'linewidth', line_width, 'color', [0 0 0])        
        line([CA1line, CA1line], [1, nOfficialParcellations+7], ...
             'linewidth', line_width, 'color', [0 0 0])
        line([SUBline, SUBline], [1, nOfficialParcellations+7], ...
             'linewidth', line_width, 'color', [0 0 0])
    end
 

    %% Add title and status bar to top %%

    if isIncludeHeader

        strng = sprintf('Hippocampome %s (%.1f%% filled)', hippocampomeVersion, axdeOverlapFilledPercentage);
        text(-8, nOfficialParcellations+9.5, strng, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5);
        
        strng = sprintf('%s', date);
        text(-8, 0, strng, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5);

    else

        strng = sprintf('Hippocampome');
        text(-3.5, nOfficialParcellations+8.0, strng, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5);
        
    end


    hTab = 9.5;

    if isIncludeApprovedClasses

        strng = sprintf('(n):');
        text(-7, nOfficialParcellations+9.5, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color','r');
        
        hTab = hTab - 1.5;
        
        strng = sprintf('%2d Fully approved', nGiorgioApproved-nGiorgioReferencing);
        text(-7, nOfficialParcellations+hTab, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color','r');
        
        strng = sprintf('%2d Approved Giorgio referencing', nGiorgioReferencing);
        text(-6, nOfficialParcellations+hTab, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color','r');
        
        hTab = hTab - 5.0;
        
    end


    if isIncludeTempUnapprovedClasses

        strng = sprintf('(t):');
        text(-7, nOfficialParcellations+9.5, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color','r');
        
        hTab = hTab - 1.5;

        strng = sprintf('%2d DCC vetting', nDccVettingActive-nEmailDccVettingActive);
        text(-7, nOfficialParcellations+hTab, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color','r');
        
        strng = sprintf('%2d DCC merging', nDccMerging);
        text(-6, nOfficialParcellations+hTab, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color','r');
        
        strng = sprintf('%2d DCC vetting active email', nEmailDccVettingActive);
        text(-6, nOfficialParcellations+hTab, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color','r');
        
        hTab = hTab - 5.0;

        strng = sprintf('%2d Giorgio vetting', nGiorgioVetting);
        text(-7, nOfficialParcellations+hTab, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color','r');
        
        strng = sprintf('%2d Giorgio merging', nGiorgioMerging);
        text(-6, nOfficialParcellations+hTab, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, 'Color','r');
        
        hTab = hTab - 6.5;
        
        strng = sprintf('%2d Giorgio vetting queue', nGiorgioVettingQueue);
        text(-7, nOfficialParcellations+hTab, strng, 'FontName', 'Courier',...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', ...
             5, 'Color', 'r');
        
        strng = sprintf('%2d Giorgio merging queue', nGiorgioMergingQueue);
        text(-6, nOfficialParcellations+hTab, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', ...
             5, 'Color', 'r');
        
        hTab = hTab - 7.5; 
    
    end


    if isIncludeSuspendedClasses

        strng = sprintf('(x):');
        text(-7, nOfficialParcellations+hTab, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', ...
             5, 'Color', [0.5 0.5 0.5]); % gray
        
        hTab = hTab - 1.5;

        strng = sprintf('%d Suspended', nSuspended);
        text(-7, nOfficialParcellations+hTab, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', ...
             5, 'Color', [0.5 0.5 0.5]); % gray
        
        hTab = hTab + 1.5;

    end


    if isIncludeTempUnapprovedSuspendedClasses

        strng = sprintf('(s):');
        text(-7, nOfficialParcellations+hTab, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', ...
             5, 'Color', [0.5 0.5 0.5]); % gray
        
        hTab = hTab - 1.5;

        strng = sprintf('%d DCC vetting frozen email', nEmailDccVettingSuspended);
        text(-7, nOfficialParcellations+hTab, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', ...
             5, 'Color', [0.5 0.5 0.5]); % gray
        
        hTab = hTab + 1.5;

    end


    if isIncludeVirtualClasses

        strng = sprintf('(v):');
        text(-6, nOfficialParcellations+hTab, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', ...
             5, 'Color', 'b');

        hTab = hTab - 1.5;

        strng = sprintf('%d Virtual', nVirtual);
        text(-6, nOfficialParcellations+hTab, strng, 'FontName', 'Courier', ...
             'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', ...
             5, 'Color', 'b');

    end
    

    % print nParcellations
    strng = sprintf('%d parcels', nOfficialParcellations);
    text(-2.5, nOfficialParcellations+7.5, strng, ...
         'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
         'Color', 'k');
    strng = sprintf('%d neuronal classes', printEnd-printStart+1);
    text(-1.5, nOfficialParcellations+7.5, strng, ...
         'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
         'Color', 'k');
    text(-0.5, nOfficialParcellations+7.5, 'Black = exc.', ...
         'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
         'Color', 'k'); % black
    text(-0.5, nOfficialParcellations+4.5, 'Gray = inh.', ...
         'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
         'Color', [0.5 0.5 0.5]); % gray

%     strng = sprintf('+ %d / %d fully approved', nStatus, nActive);
%     text(+0.5, nOfficialParcellations+7.5, strng, ...
%          'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', 5, ...
%          'Color', 'k'); % black


    %% Add legend to the bottom of the matrix %%
    if isIncludeKeyAndComments
        if regionCode == ALL
            legendStart = nAllCells + 2;
        else
            legendStart = nCells(regionCode) + 4;
        end
 
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
                    text(overlapDuplicateRows(iDups)+0.5, 0.9, char(96+nDuplicates), ...
                         'Rotation', 90, 'FontSize', 4);

                end % for iDups
            end % if
        end % for iRow

    end % if isIncludeFlaggedDuplicates

    %% single/double neurite differences %%
    nTabs = zeros(size(CijOverlap,2), 1);
    
    if (isIncludeSingleNeuriteDifferences)

        nTabs = find_single_neurite_differences(CijOverlap', ...
                                                nOfficialParcellations, ...
                                                nTabs, cellLabels, ...
                                                cellADcodes, cellSubregions,...
                                                cellEorI, regionCode, ...
                                                printStart, printEnd);

    end % if isIncludeSingleNeuriteDifferences
    
    if (isIncludeDoubleNeuriteDifferences)

        nTabs = find_double_neurite_differences(CijOverlap', ...
                                                nOfficialParcellations, ...
                                                nTabs, cellLabels, ...
                                                cellADcodes, cellSubregions,...
                                                cellEorI, regionCode, ...
                                                printStart, printEnd);

    end % if isIncludeDoubleNeuriteDifferences


    %% save plots

    plotFileName = sprintf('./Cij_axon-dend');

    switch (regionCode)
      case ALL
        plotFileName = sprintf('%s_ALL', plotFileName);
      case DG
        plotFileName = sprintf('%s_DG', plotFileName);
      case CA3
        plotFileName = sprintf('%s_CA3', plotFileName);
      case CA2
        plotFileName = sprintf('%s_CA2', plotFileName);
      case CA1
        plotFileName = sprintf('%s_CA1', plotFileName);
      case SUB
        plotFileName = sprintf('%s_SUB', plotFileName);
      case EC
        plotFileName = sprintf('%s_EC', plotFileName);
    end

    if isIncludeSingleNeuriteDifferences
        plotFileName = sprintf('%s_single', plotFileName);
    end

    if isIncludeDoubleNeuriteDifferences
        plotFileName = sprintf('%s_double', plotFileName);
    end

    if isIncludeApprovedClasses
        plotFileName = sprintf('%s_n', plotFileName);
    end
    
    if isIncludeTempUnapprovedClasses
        plotFileName = sprintf('%s_t', plotFileName);
    end

    if isIncludeSuspendedClasses
        plotFileName = sprintf('%s_x', plotFileName);
    end

    if isIncludeVirtualClasses
        plotFileName = sprintf('%s_v', plotFileName);
    end

    plotFileName = sprintf('%s.eps', plotFileName);

    orient(gcf, 'landscape');
    print(gcf, '-depsc', '-r800', plotFileName);


end % plot_axon_dendrite_overlap

