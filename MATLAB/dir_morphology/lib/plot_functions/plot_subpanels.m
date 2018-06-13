function plot_subpanels(axdeOverlapFilledPercentage, printStart, printEnd, regionCode)

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

    GRAY = [0.5 0.5 0.5];
    PURPLE = [0.5 0 0.5];

    displayFontSize = 5/2;

    vStart = -2;
    vStartSummary = vStart - 4.5;
    hStart = nOfficialParcellations+2;%+16.5;

    clf; cla;

    figure(1);
    
    zzzEnd = 3;

    panelScale = 1;
    panelSize = [(vStart-2) (N+2) -2 (hStart+2)];
    panelWidth = 1;
    
    for zzz = 1:2:zzzEnd

    line_width = 0.25;

    %    scrsz = get(0,'ScreenSize');
    %set(gcf, 'OuterPosition', [50 50 scrsz(3)*0.9 scrsz(4)*0.9])
    set(gcf, 'color', 'w');

    h = subplot(zzzEnd,1,zzz);

    p = get(h, 'pos')

    p(1) = 0;

    p(4) = panelScale*(1/zzzEnd);

    p(3) = panelWidth;
    
    if (zzz == 1)
        p(2) = 1 - p(4);%p(2) + 0.5;%+ 0.05*zzzEnd;
    else
        p(2) = 0;
    end

    set(h,'pos',p);
pp = get(h,'pos')
%pause
        
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
    axis equal
    axis off 

    axis(panelSize)

    hold on

    line([panelSize(1)+(panelSize(2)-panelSize(1))/2,panelSize(1)+(panelSize(2)-panelSize(1))/2], [panelSize(3),panelSize(4)], 'linewidth', 5, 'color', 'g');
    line([panelSize(1),panelSize(2)], [panelSize(3)+(panelSize(4)-panelSize(3))/2,panelSize(3)+(panelSize(4)-panelSize(3))/2], 'linewidth', 5, 'color', 'b');
    %line([((N+2)-(vStart-2))/2,((N+2)-(vStart-2))/2], [-2,(hStart+2)], 'linewidth', 5, 'color', 'g');
    %line([(vStart-2),(N+2)], [((hStart+2)-(-2))/2,((hStart+2)-(-2))/2], 'linewidth', 5, 'color', 'b');

    for i = 1:printEnd-printStart+1

        text(i+0.5, nOfficialParcellations+3, 'p', 'color', 'w', ...
             'Rotation', 90, 'FontSize', displayFontSize, 'Interpreter', 'none')
            
        for j = 1:nOfficialParcellations
            if (i == 1) % *****
                text(0.7, j+0.5, layerNames{j}, 'rotation', 180, 'FontSize', displayFontSize);
            end

            if (somataLocations(j,i) && isIncludeSomataLocations)
				line ([i+0.05, i+0.95], [j+0.05, j+0.05], 'color', 'y', 'linewidth', line_width);
				line ([i+0.05, i+0.95], [j+0.95, j+0.95], 'color', 'y', 'linewidth', line_width);
				line ([i+0.05, i+0.05], [j+0.05, j+0.95], 'color', 'y', 'linewidth', line_width);
				line ([i+0.95, i+0.95], [j+0.05, j+0.95], 'color', 'y', 'linewidth', line_width);
            end
      
            if (CijAxonSomaOverlap(j,i) && isIncludeAxonSomaOverlap)
                line ([i+0.05, i+0.95], [j+0.05, j+0.05], 'color', 'g', 'linewidth', line_width);
                line ([i+0.05, i+0.95], [j+0.95, j+0.95], 'color', 'g', 'linewidth', line_width);
                line ([i+0.05, i+0.05], [j+0.05, j+0.95], 'color', 'g', 'linewidth', line_width);
                line ([i+0.95, i+0.95], [j+0.05, j+0.95], 'color', 'g', 'linewidth', line_width);
            end
      
            if ~isIncludeVirtualClasses
                % plot shading lines
                switch (CijOverlap(j,i))
                    % axons are blue and get horizontal lines (after graph rotation)
                  case 1
                    line ([i+0.5, i+0.5], [j+0.05, j+0.95], 'color', [1 1 1], 'linewidth', line_width)                    
                    
                    % dendrites are red and get vertical lines (after graph rotation)
                  case 2
                    line ([i+0.05, i+0.95], [j+0.5, j+0.5], 'color', [1 1 1], 'linewidth', line_width)
                    
                    % both are purple and get horizontal & vertical lines
                    % (after graph rotation)
                  case 3
                    line ([i+0.5, i+0.5], [j+0.05, j+0.95], 'color', [1 1 1], 'linewidth', line_width)    
                    line ([i+0.05, i+0.95], [j+0.5, j+0.5], 'color', [1 1 1], 'linewidth', line_width)                     
                    
                  otherwise
                    % do nothing
                    
                end % switch
            end % if ~isIncludeVirtualClasses

            if isIncludeKnownNegNeuriteLocations
                if knownMixedAxonLocations(j,i)                 
                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', 'k', 'linewidth', line_width);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', 'k', 'linewidth', line_width);
                elseif knownNegAxonLocations(j,i)
                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', 'r', 'linewidth', line_width);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', 'r', 'linewidth', line_width);
                end
                
                if knownMixedDendriteLocations(j,i)
                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', 'k', 'linewidth', line_width);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', 'k', 'linewidth', line_Width);
                elseif knownNegDendriteLocations(j,i)
                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', 'b', 'linewidth', line_width);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', 'b', 'linewidth', line_width);
                end

                knownNegNeuriteLocations = knownNegAxonLocations + knownNegDendriteLocations;
                knownMixedNeuriteLocations = knownMixedAxonLocations + knownMixedDendriteLocations;

                if knownMixedNeuriteLocations(j,i) == 1
                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', 'k', 'linewidth', line_width);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', 'k', 'linewidth', line_width);
                elseif (knownNegNeuriteLocations(j,i) == 2)
                    line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', [0.5 0 0.5], 'linewidth', line_width);
                    line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', [0.5 0 0.5], 'linewidth', line_width);
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

    vTab = vStart;
    region_color_box(vTab+1, 27, 23, DG);
    text(vTab, DGtab, 'DG', 'HorizontalAlignment', 'center', ...
         'Rotation', 90, 'FontSize', displayFontSize, 'color', 'k');
    region_color_box(vTab+1, 23, 18, CA3);
    text(vTab, CA3tab, 'CA3', 'HorizontalAlignment', 'center', ...
         'Rotation', 90, 'FontSize', displayFontSize, 'color', 'k');
    region_color_box(vTab+1, 18, 14, CA2);
    text(vTab, CA2tab, 'CA2', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize, 'color', 'k');
    region_color_box(vTab+1, 14, 10, CA1);
    text(vTab, CA1tab, 'CA1', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize, 'color', 'k');
    region_color_box(vTab+1, 10, 7, SUB);
    text(vTab, SUBtab, 'SUB', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize, 'color', 'k');
    region_color_box(vTab+1, 7, 1, EC);
    text(vTab, ECtab, 'EC', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize, 'color', 'k');

    hTab = nOfficialParcellations+2;

    if (zzz == zzzEnd)

        % cell class subregion headers
        if regionCode == ALL || regionCode == DG
            DGstart = 1 + nCells(DG)/2;
            %strng = sprintf('DG (%d/{\\color[rgb]{0.5 0.5 0.5}%d})', ...
            strng = sprintf('DG (%d/{\\color[rgb]{GRAY}%d})', ...
                            nCellsE(DG), nCells(DG)-nCellsE(DG));
            text(DGstart, hTab, strng, ...
                 'HorizontalAlignment', 'center', 'rotation', 180, ...
                 'FontSize', displayFontSize);
            
        end
        if regionCode == ALL || regionCode == CA3
            if regionCode == ALL
                CA3start = 1 + nCells(DG) + nCells(CA3)/2;
            else
                CA3start = 1 + nCells(CA3)/2;
            end
            
            strng = sprintf('CA3 (%d/{\\color[rgb]{GRAY}%d})', ...
                            nCellsE(CA3), nCells(CA3)-nCellsE(CA3));
            text(CA3start, hTab, strng, ...
                 'HorizontalAlignment', 'center', 'rotation', 180, ...
                 'FontSize', displayFontSize);
        end
        if regionCode == ALL || regionCode == CA2  

            if regionCode == ALL
                CA2start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2)/2;
            else
                CA2start = 1 + nCells(CA2)/2;
            end
            
            strng = sprintf('CA2 (%d/{\\color[rgb]{GRAY}%d})', ...
                            nCellsE(CA2), nCells(CA2)-nCellsE(CA2));
            text(CA2start, hTab, strng, ...
                 'HorizontalAlignment', 'center', 'rotation', 180, ...
                 'FontSize', displayFontSize);
        end
        if regionCode == ALL || regionCode == CA1
            if regionCode == ALL       
                CA1start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + ...
                    nCells(CA1)/2;
            else
                CA1start = 1 + nCells(CA1)/2;
            end
            
            strng = sprintf('CA1 (%d/{\\color[rgb]{GRAY}%d})', ...
                            nCellsE(CA1), nCells(CA1)-nCellsE(CA1));
            text(CA1start, hTab, strng, ...
                 'HorizontalAlignment', 'center', 'rotation', 180, ...
                 'FontSize', displayFontSize);
        end
        if regionCode == ALL || regionCode == SUB
            if regionCode == ALL   
                SUBstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + ...
                    nCells(CA1) + nCells(SUB)/2;
            else
                SUBstart = 1 + nCells(SUB)/2;
            end
            
            strng = sprintf('SUB (%d/{\\color[rgb]{GRAY}%d})', ...
                            nCellsE(SUB), nCells(SUB)-nCellsE(SUB));
            text(SUBstart, hTab, strng, ...
                 'HorizontalAlignment', 'center', 'rotation', 180, ...
                 'FontSize', displayFontSize);         
        end
        if regionCode == ALL || regionCode == EC
            if regionCode == ALL
                ECstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + ...
                          nCells(CA1) + nCells(SUB) + nCells(EC)/2;
            else
                ECstart = 1 + nCells(EC)/2;
            end
            
            strng = sprintf('EC (%d/{\\color[rgb]{GRAY}%d})', ...
                            nCellsE(EC), nCells(EC)-nCellsE(EC));
            text(ECstart, hTab, strng, ...
                 'HorizontalAlignment', 'center', 'rotation', 180, ...
                 'FontSize', displayFontSize); 
        end
    
        %        drawnow;

    end % if (zzz == zzzEnd)


    % thick lines on parcellation axis
    line_width = 1;
    vLine = [vStart, N];
    line(vLine, [23, 23], 'linewidth', line_width, 'color', 'k');
    line(vLine, [18, 18], 'linewidth', line_width, 'color', 'k');
    line(vLine, [14, 14], 'linewidth', line_width, 'color', 'k');
    line(vLine, [10, 10], 'linewidth', line_width, 'color', 'k');
    line(vLine, [7, 7], 'linewidth', line_width, 'color', 'k');
    
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
 

    %    end % zzz

if (zzz == 1)

    %    ax = axes('visible','off');

    %ax = axes('position',[0,0,N,nOfficialParcellations],'visible','off');
    %tx = text(0.05,0.6,'This is the Header','HorizontalAlignment', 'center', 'rotation', 90);
    %set(tx,'fontweight','bold','color','r');

    h = subplot(zzzEnd,1,2);
    p = get(h, 'pos')

    p(1) = 0;

    p(4) = panelScale*(1/zzzEnd);

    p(3) = panelWidth;

    p(2) = 1 - 2*p(4) - ((1 - 3*p(4))/2);

    set(h,'pos',p);
pp = get(h,'pos')
%pause
        
    axis ij
    axis equal
    axis off
    axis(panelSize); % panelSize = [(vStart-2) (N+2) -2 (hStart+2)];
    hold on;
    
ps = panelSize
%pause

    %line([55.25,55.25],[-2,44.5], 'linewidth', 5, 'color', 'k');
    
    line([panelSize(1)+(panelSize(2)-panelSize(1))/2,panelSize(1)+(panelSize(2)-panelSize(1))/2], [panelSize(3),panelSize(4)], 'linewidth', 5, 'color', 'r');
    line([panelSize(1),panelSize(2)], [panelSize(3)+(panelSize(4)-panelSize(3))/2,panelSize(3)+(panelSize(4)-panelSize(3))/2], 'linewidth', 5, 'color', 'b');
    %line([((N+2)-(vStart-2))/2,((N+2)-(vStart-2))/2], [-2,(hStart+2)], 'linewidth', 5, 'color', 'r');
    %line([(vStart-2),(N+2)], [((hStart+2)-(-2))/2,((hStart+2)-(-2))/2], 'linewidth', 5, 'color', 'b');
    

    notesCount = 0;
    notesExtraLines = 0;
    nStatus = 0;
    
    status = status(:,printStart:printEnd);

    isSingleRef = isSingleRef(:,printStart:printEnd);

    % plot labels & shading lines
    for i = 1:printEnd-printStart+1
        cellLabel = deblank(cellLabels{printStart+i-1});
        cellADcode = deblank(cellADcodes{printStart+i-1});
        %label_code_cat = [cellLabel, ' ', cellADcode];
        
        if (cellEorI{i} == 'E')
            labelColor = [0 0 0]; %black
            label_code_cat = [cellLabel, ' (+)', cellADcode];
        elseif (cellEorI{i} == 'I')
            labelColor = GRAY;
            label_code_cat = [cellLabel, ' (-)', cellADcode];
        end        
        
        if isSingleRef(i)
            label_code_cat = ['*', label_code_cat];
        end

        if ( ( (0.0 < status(i)) && (status(i) < 0.2) ) || ... % do not count unapproved mergers
             ( (0.3 < status(i)) && (status(i) < 0.5) ) || ... % do not count virtual classes
             ( (0.5 < status(i)) && (status(i) < 0.8) ) ) % do not count premerger classes
            if ~isTemporary2Active
                label_code_cat = ['(t) ', label_code_cat];
            end
        end
        
        if (status(i) == 0.5) % virtual classes
            label_code_cat = ['(v) ', label_code_cat];
        end

        if ( ((status(i) == 0.3) || status(i) == 0.8) || (status(i) == 0.9) ) % premerger classes
            if ~isPremerger2Active
                label_code_cat = ['(p) ', label_code_cat];
            end
        end

        if (status(i) == 0.2) % unapproved merger classes
            if ~isMerged2Active
                label_code_cat = ['(m) ', label_code_cat];
            end
        end

        if ( ( (-0.5 < status(i)) && (status(i) < 0) ) ) % temporary suspended classes
            if isTemporary2Suspended
                label_code_cat = ['(x) ', label_code_cat];
            else
                label_code_cat = ['(s) ', label_code_cat];
            end
        end

        if (status(i) <= -0.5) % approved suspended classes
            label_code_cat = ['(x) ', label_code_cat];
        end
        
        hTab = nOfficialParcellations+3;
        hTab = nOfficialParcellations/2;
        text(i+0.5, hTab, label_code_cat, 'color', labelColor, ...
            'HorizontalAlignment', 'right', 'Rotation', 90, 'FontSize', displayFontSize, 'Interpreter', 'none');

        if isCellProjecting(i)
            text(i+0.5, hTab, 'p', 'color', labelColor, ...
            'Rotation', 90, 'FontSize', displayFontSize, 'Interpreter', 'none')
        end

        if isIncludeKeyAndComments

            footnotes = csv2cell('./data/footnotes.csv','fromfile');

            vTab = N - 9.5;
            hTab = 0;

            for ii = 1:size(footnotes,1)

                %strng = sprintf('%2d %s', str2num(footnotes{ii,2}), footnotes{ii,1});
                strng = sprintf('%2s %s', footnotes{ii,2}, footnotes{ii,1});

                text(vTab, hTab, strng, 'HorizontalAlignment', 'left', ...
                     'FontName', 'Courier', ...
                     'Rotation', 90, 'FontSize', displayFontSize, 'Color', 'k'); % black

                vTab = vTab + 1;

            end
            

            if(notes(i) ~= -1) % ****
                text(i+0.5, nOfficialParcellations+1.1, num2str(notes(i)), ...
                     'color', [0 0 0], 'HorizontalAlignment', 'right', ...
                     'Rotation', 90, 'FontSize', displayFontSize-2)
            end

        end % if isIncludeKeyAndComments


    end % for i


    %% Add title and status bar to top %%

    vTab = vStart;
    hTab = hStart;

    if isIncludeHeader
        
        strng = sprintf('Hippocampome %s', hippocampomeVersion);
        text(vTab, hTab, strng, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', displayFontSize);
    
    else

        strng = sprintf('Hippocampome');
        text(vTab, hTab, strng, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', displayFontSize);
        
    end

    % print nParcellations
    vTab = vTab + 1;

    strng = sprintf('%d neuronal classes', printEnd-printStart+1);
    text(vTab, hTab, strng, 'HorizontalAlignment', 'left', 'Rotation', ...
         90, 'FontSize', displayFontSize, 'Color', 'k');

    vTab = vTab + 1;

    strng = sprintf('%d parcels', nOfficialParcellations);
    text(vTab, hTab, strng, 'HorizontalAlignment', 'left', 'Rotation', ...
         90, 'FontSize', displayFontSize, 'Color', 'k');

    
    vTab = vStart;
    hTab = 0;

    if isIncludeHeader

        strng = sprintf('%s', date);
        text(vTab, hTab, strng, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', displayFontSize);

        vTab = vTab + 1;

        strng = sprintf('(%.1f%% filled)', axdeOverlapFilledPercentage);
        text(vTab, hTab, strng, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', displayFontSize);
        
    end

    
    if isIncludeKeyAndComments

        vTab = 1.5;

        [vTab, hTab] = create_legend(vTab, hTab, displayFontSize, line_width, ...
                                     isIncludeKnownNegNeuriteLocations, isIncludeFlaggedDuplicates);


        vTab = vTab + 2;
        hTab = 0;

        spacingStr = ' '; % default is 1 space;

        if isIncludeApprovedClasses

            nFullyApproved = nGiorgioApproved - nGiorgioReferencing - nGiorgioReferencingQueue;
            strng = sprintf('(n): %2d Fully approved', nFullyApproved);
            text(vTab, hTab, strng, 'FontName', 'Courier', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);

            vTab = vTab + 1;

            if (nFullyApproved > 99)
                spacingStr = '  '; % increase to 2 spaces to keep digits aligned
            end

            strng = sprintf('    %s%2d Giorgio referencing', spacingStr, nGiorgioReferencing);
            text(vTab, hTab, strng, 'FontName', 'Courier', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);
            
            vTab = vTab + 1;

            strng = sprintf('    %s%2d Giorgio referencing queue', spacingStr, ...
                            nGiorgioReferencingQueue);
            text(vTab, hTab, strng, 'FontName', 'Courier', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);
            
            vTab = vTab + 2;
            hTab = 0;
            
        end


        if isIncludeTempUnapprovedActiveClasses

            strng = sprintf('(t):%s%2d DCC vetting', spacingStr, nDccVettingActive);
            text(vTab, hTab, strng, 'FontName', 'Courier', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);
            
            vTab = vTab + 1;

            strng = sprintf('    %s%2d Giorgio vetting', spacingStr, nGiorgioVetting);
            text(vTab, hTab, strng, 'FontName', 'Courier', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);
            
            vTab = vTab + 1;

            strng = sprintf('    %s%2d Giorgio vetting queue', spacingStr, nGiorgioVettingQueue);
            text(vTab, hTab, strng, 'FontName', 'Courier',...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);
            
            vTab = vTab + 2;


            strng = sprintf('(p):%s%2d DCC merging', spacingStr, nDccMerging);
            text(vTab, hTab, strng, 'FontName', 'Courier', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);
            
            vTab = vTab + 1;

            strng = sprintf('    %s%2d Giorgio merging', spacingStr, nGiorgioMerging);
            text(vTab, hTab, strng, 'FontName', 'Courier', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);
            
            vTab = vTab + 1;
            
            strng = sprintf('    %s%2d Giorgio merging queue', spacingStr, ...
                            nGiorgioMergingQueue);
            text(vTab, hTab, strng, 'FontName', 'Courier', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);


            vTab = vTab + 2;
            hTab = 0;
            
        end


        if isIncludeSuspendedClasses

            strng = sprintf('(x):%s%d Suspended', spacingStr, nSuspended);
            text(vTab, hTab, strng, 'FontName', 'Courier', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);%GRAY); % gray
            
            vTab = vTab + 2;
            hTab = 0;

        end


        if isIncludeTempUnapprovedSuspendedClasses

            strng = sprintf('(s):%s%2d DCC vetting suspended', spacingStr, ...
                            nDccVettingSuspended);
            text(vTab, hTab, strng, 'FontName', 'Courier', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);
            
            vTab = vTab + 1;

            strng = sprintf('    %s%2d Giorgio vetting suspended', ...
                            spacingStr, nGiorgioVettingSuspended);
            text(vTab, hTab, strng, 'FontName', 'Courier', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);
            
            vTab = vTab + 1;

            strng = sprintf('    %s%2d Giorgio vetting queue suspended', ...
                            spacingStr, nGiorgioVettingQueueSuspended);
            text(vTab, hTab, strng, 'FontName', 'Courier', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);
            
            vTab = vTab + 2;
            hTab = 0;

        end


        if isIncludeVirtualClasses

            strng = sprintf('(v):%s%2d Virtual', spacingStr, nVirtual);
            text(vTab, hTab, strng, 'FontName', 'Courier', ...
                 'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);

            vTab = vTab + 2;
            hTab = 0;

        end
        

        %% Add legend to the bottom of the matrix %%

        if regionCode == ALL
            legendStart = nAllCells + 2;
        else
            legendStart = nCells(regionCode) + 4;
        end
        
        tabShift = 1.0;
        
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
                         'Rotation', 90, 'FontSize', displayFontSize-1);

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
                                                printStart, printEnd, ...
                                                vStart+2, 0);

    end % if isIncludeSingleNeuriteDifferences
    
    if (isIncludeDoubleNeuriteDifferences)

        nTabs = find_double_neurite_differences(CijOverlap', ...
                                                nOfficialParcellations, ...
                                                nTabs, cellLabels, ...
                                                cellADcodes, cellSubregions,...
                                                cellEorI, regionCode, ...
                                                printStart, printEnd, ...
                                                vStart+3, 0);

    end % if isIncludeDoubleNeuriteDifferences

end % if (3 == 4)

    end % zzz


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
    
    if isIncludeTempUnapprovedActiveClasses
        plotFileName = sprintf('%s_t', plotFileName);
    end

    if isIncludePremergerActiveClasses
        plotFileName = sprintf('%s_p', plotFileName);
    end

    if isIncludeMergedActiveClasses
        plotFileName = sprintf('%s_m', plotFileName);
    end

    if isIncludeTempUnapprovedSuspendedClasses
        plotFileName = sprintf('%s_s', plotFileName);
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

