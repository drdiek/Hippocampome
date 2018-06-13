function plot_Cij_matrix_win(CijFilledPercentage)
         
    load parcellation.mat
    load Cij.mat Cij CijSpecialConnections cellAbbrevs cellADcodes
    load CijKnownClassLinks.mat
    load CijKnownNegClassLinks.mat
    load CijAxonSomaOverlap.mat
    load isInclude.mat

    
    clf; cla;
    figure(1);
    
    % properties for figure 1
    scrsz = get(0,'ScreenSize');
    set(gcf, 'OuterPosition', [50 50 scrsz(3)*0.9 scrsz(4)*0.9])
    set(gcf, 'color', 'w');

    
    %% plot matrix %%
    
    N = size(Cij,1);
    
    % create new matrix equal to Cij but with a blank row & col at end
    % (used for pcolor function)
    NewCij = zeros(N+1,N+1);
    for i = 1:N
        for j = 1:N
            if (CijKnownNegClassLinks(i,j) ~= 0)
                NewCij(i,j) = 0;
            else
                NewCij(i,j) = Cij(i,j) + CijSpecialConnections(i,j);
            end
        end
    end
    
    uniqueCijElements = unique(NewCij);
    
    cmap = ([0.7 0.7 0.7; ... %gray (inhib)
            0.55 0.85 0.90; ... %dk blue (basket)
            1 1 1; ... %white (no connection)
            0 0 0.5; ... %lt blue (axo-axonic)
            0 0 0;]);   %black (excit)
        
    if ismember(1.5, uniqueCijElements)
        cmap(length(cmap)+1,:) = [1 0 0]; %red (connection ONLY in PCL)
    end
    
    axisVector = 0:10:10*N;  
    pcolor(axisVector, axisVector, NewCij);
    colormap(cmap);

    axis ij
    axis square
    axis off
    hold on
    figureAxis = [-100 (N+1)*10 -120 (N+20)*10];
    axis(figureAxis)
    
    for i = 1:N       
        cellAbbrev = deblank(cellAbbrevs{i});
        cellADcode = deblank(cellADcodes{i});
        abbrev_code_cat = [cellAbbrev, ' ', cellADcode];
        
        text((i-1)*10+5, -5, abbrev_code_cat, 'rotation', 90, 'FontSize', 3, 'Interpreter', 'none')
        text(-5, (i-1)*10+5, abbrev_code_cat, 'HorizontalAlignment', 'right', 'FontSize', 3, 'Interpreter', 'none')
    end % i loop
    

    %% process flags %%
    if isIncludeKnownClassLinks
        for i = 1:N
            for j = 1:N
                if CijKnownClassLinks(j,i)
                    line([10*i-5, 10*i-5], [10*j-9, 10*j-1], 'linewidth', 0.25, 'color', [255 153 0]/255); % orange
                    line([10*i-9, 10*i-1], [10*j-5, 10*j-5], 'linewidth', 0.25, 'color', [255 153 0]/255); % orange
                end % if CijKnownClassLinks
            end % for j
        end % for i
    end % if isIncludeKnownClassLinks
    
    if isIncludeKnownNegClassLinks
        for i = 1:N
            for j = 1:N
                if CijKnownNegClassLinks(j,i)
                    line([10*i-8, 10*i-2], [10*j-8, 10*j-2], 'linewidth', 0.25, 'color', 'magenta');
                    line([10*i-8, 10*i-2], [10*j-2, 10*j-8], 'linewidth', 0.25, 'color', 'magenta');
                end % if CijKnownNegClassLinks
            end % for j
        end % for i
    end % if isIncludeKnownNegClassLinks

    if isIncludeAxonSomaOverlap
        for i = 1:N
            for j = 1:N
                if (CijAxonSomaOverlap(j,i) == 10)
                    line([10*i-9.5, 10*i-1], [10*j-9.5, 10*j-9.5], 'linewidth', 0.5, 'color', [0 0.5 0]); % dark green
                    line([10*i-9.5, 10*i-1], [10*j-1, 10*j-1], 'linewidth', 0.5, 'color', [0 0.5 0]); % dark green
                    line([10*i-9.5, 10*i-9.5], [10*j-9.5, 10*j-1], 'linewidth', 0.5, 'color', [0 0.5 0]); % dark green
                    line([10*i-1, 10*i-1], [10*j-9.5, 10*j-1], 'linewidth', 0.5, 'color', [0 0.5 0]); % dark green
                end % if CijAxonSomaOverlap
            end % for j
        end % for i
    end % if isIncludeAxonSomaOverlap
    
    commentLinesToSkip = 0;

    if (isIncludeFlaggedDuplicates)
        NewCij = NewCij(1:size(NewCij,1)-1,1:size(NewCij,2)-1);
        NewCijStr = num2str(NewCij);
        NewCijStrUnique = unique(NewCijStr,'rows');
        nRowsUnique = size(NewCijStrUnique,1);
        nDuplicates = 0;

        for iRow = 1:nRowsUnique
            NewCijDuplicateRows = strmatch(NewCijStrUnique(iRow,:),NewCijStr);
            if (length(NewCijDuplicateRows) > 1)
                nDuplicates = nDuplicates + 1;

                for iDups = 1:length(NewCijDuplicateRows)
                    text((nAllCells)*10+7, (NewCijDuplicateRows(iDups)-1)*10+5, char(96+nDuplicates), ...
                         'HorizontalAlignment', 'center', 'FontSize', 3);
                end % for iDups
            end % if
        end % for iRow

        NewCijStr = num2str(NewCij');
        NewCijStrUnique = unique(NewCijStr,'rows');
        nColsUnique = size(NewCijStrUnique,1);
        nDuplicates = 0;

        for iCol = 1:nColsUnique
            NewCijDuplicateCols = strmatch(NewCijStrUnique(iCol,:),NewCijStr);
            if (length(NewCijDuplicateCols) > 1)               
                nDuplicates = nDuplicates + 1;

                for iDups = 1:length(NewCijDuplicateCols)
                    text((NewCijDuplicateCols(iDups)-1)*10+5, (nAllCells)*10+5, char(96+nDuplicates), ...
                         'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 3);
                end % for iDups
            end % if
        end % for iCol

        commentLinesToSkip = 1;

    end % if isIncludeFlaggedDuplicates
   

    %% title, subregion labels, horizontal lines %%
    strng = sprintf('%s\n(%.1f%% filled)', hippocampomeVersion, CijFilledPercentage);

    text(-90, -85, strng, 'HorizontalAlignment', 'left', 'FontSize', 5);
    %text(-90, -60, 'Black = excitatory', 'HorizontalAlignment', 'left', 'FontSize', 5, 'Color', 'k');
    %text(-90, -50, 'Gray = inhibitory', 'HorizontalAlignment', 'left', 'FontSize', 5, 'Color', [0.7 0.7 0.7]);
    
    DGstart = nCells(DG)/2 - 1; % fudge to eliminate overlap with long class name
    CA3start = nCells(DG) + nCells(CA3)/2;
    CA2start = nCells(DG) + nCells(CA3) + nCells(CA2)/2;
    CA1start = nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1)/2;
    SUBstart = nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(SUB)/2;
    ECstart = nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(SUB) + nCells(EC)/2;


    text(-90, 10*DGstart, 'DG', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 5);
    text(-90, 10*CA3start, 'CA3', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 5);
    text(-90, 10*CA2start, 'CA2', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 5);
    text(-90, 10*CA1start, 'CA1', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 5);
    text(-90, 10*SUBstart, 'SUB', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 5);
    text(-90, 10*ECstart, 'EC', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 5);

    text(10*DGstart, -90, 'DG', 'HorizontalAlignment', 'center', 'FontSize', 5);
    text(10*CA3start, -90, 'CA3', 'HorizontalAlignment', 'center', 'FontSize', 5);
    text(10*CA2start, -90, 'CA2', 'HorizontalAlignment', 'center', 'FontSize', 5);
    text(10*CA1start, -90, 'CA1', 'HorizontalAlignment', 'center', 'FontSize', 5);
    text(10*SUBstart, -90, 'SUB', 'HorizontalAlignment', 'center', 'FontSize', 5);
    text(10*ECstart, -90, 'EC', 'HorizontalAlignment', 'center', 'FontSize', 5);
    
    
    line_width = 2;
    
    DGline = 10*length(DGcells);
    CA3line = DGline + 10*length(CA3cells);
    CA2line = CA3line + 10*length(CA2cells);
    CA1line = CA2line + 10*length(CA1cells);
    SUBline = CA1line + 10*length(SUBcells);
    %ECline = SUBline + 10*length(ECcells);
	
    line([-65, 10*N], [DGline, DGline], 'linewidth', line_width);
    line([DGline, DGline], [-65, 10*N], 'linewidth', line_width);
    line([-65, 10*N], [CA3line, CA3line], 'linewidth', line_width);
    line([CA3line, CA3line], [-65, 10*N], 'linewidth', line_width);
    line([-65, 10*N], [CA2line, CA2line], 'linewidth', line_width);
    line([CA2line, CA2line], [-65, 10*N], 'linewidth', line_width);
    line([-65, 10*N], [CA1line, CA1line], 'linewidth', line_width);
    line([CA1line, CA1line], [-65, 10*N], 'linewidth', line_width);
    line([-65, 10*N], [SUBline, SUBline], 'linewidth', line_width);
    line([SUBline, SUBline], [-65, 10*N], 'linewidth', line_width);
    %line([-65, 10*N], [ECline, ECline], 'linewidth', line_width);
    %line([ECline, ECline], [-65, 10*N], 'linewidth', line_width);


    %% legend %%
    tabShift = 0;
    legendStart = 10*(N+2);
    
    fill([tabShift,tabShift+5,tabShift+5,tabShift], [legendStart,legendStart,legendStart+5,legendStart+5], 'k');
    tabShift = tabShift + 5;
    text(tabShift, legendStart+3, '  / ', 'HorizontalAlignment', 'left', 'FontSize', 4, 'Color', [0 0 0]);
    tabShift = tabShift + 5;
    fill([tabShift,tabShift+5,tabShift+5,tabShift], [legendStart,legendStart,legendStart+5,legendStart+5], [0.7 0.7 0.7]);
    tabShift = tabShift + 10;
    text(tabShift, legendStart+3, '- excit/ inhib connection in non-PCL layers', 'HorizontalAlignment', 'left', 'FontSize', 4, ...
             'Color', [0 0 0]);            
         
    tabShift = N*10*(1/3);
    fill([tabShift,tabShift+5,tabShift+5,tabShift], [legendStart,legendStart,legendStart+5,legendStart+5], [0 0 0.5]);
    tabShift = tabShift + 5;
    text(tabShift, legendStart+3, '  / ', 'HorizontalAlignment', 'left', 'FontSize', 4, 'Color', [0 0 0]);
    tabShift = tabShift + 5;
    fill([tabShift,tabShift+5,tabShift+5,tabShift], [legendStart,legendStart,legendStart+5,legendStart+5], [0.66 0.85 0.90]);
    tabShift = tabShift + 10;
    text(tabShift, legendStart+3, '- perisomatic region/ AIS connection', 'HorizontalAlignment', 'left', 'FontSize', 4, ...
             'Color', [0 0 0]);
         
    tabShift = N*10*(2/3);
    fill([tabShift,tabShift+5,tabShift+5,tabShift], [legendStart,legendStart,legendStart+5,legendStart+5], 'r');
    tabShift = tabShift + 10;
    text(tabShift, legendStart+3, '- connect in PCL only', 'HorizontalAlignment', 'left', 'FontSize', 4, ...
             'Color', [0 0 0]);    
         
         
    legendStart = 10*(N+4);    
    
    if isIncludeKnownClassLinks
        text(0, legendStart, '+ = known connection', ...
             'HorizontalAlignment', 'left', 'FontSize', 4, ...
             'Color', [255 153 0]/255); % orange
    end
    if isIncludeKnownNegClassLinks
        %if (sum(sum(CijKnownNegClassLinks)) > 0)
            text(N*10*(1/4), legendStart, 'X = known non-connection', ...
                 'HorizontalAlignment', 'left', 'FontSize', 4, ... 
                 'Color', 'magenta');
        %end
    end
    if isIncludeAxonSomaOverlap
        text(N*10*(2/4), legendStart, ' ', ...
             'HorizontalAlignment', 'left', 'FontUnits', 'pixels', 'FontSize', 1, ... 
             'Color', 'w', 'EdgeColor', [0 0.5 0]); % green
        text((N+2)*10*(2/4), legendStart, '= axon-soma overlap in principal cell layer', ...
             'HorizontalAlignment', 'left', 'FontSize', 4, ... 
             'Color', [0 0.5 0]); % green
    end
    if (isIncludeFlaggedDuplicates)
        text((N+5)*10*(3/4), legendStart, 'a,b,... = identical patterns', ...
             'HorizontalAlignment', 'left', 'FontSize', 4, ... 
             'Color', 'k');
    end % if isIncludeFlaggedDuplicate


    %% cell counts %%
    
    load 'CellCounts.mat' % nInhib nExcit nInhibEdges nExcitEdges
                          % nSelfEdges nInhibSelfEdges
                          % nExcitSelfEdges nInhib2InhibEdges nExcit2ExcitEdges

    clear strng

    strng = sprintf(['Number of cell types: %d (%d inhibitory / %d ' ...
                     'excitatory)'], N, nInhib, nExcit);
    strng = sprintf(['%s\nNumber of self-connections: %d (%d inhibitory ' ...
                     '/ %d excitatory)'], strng, nSelfEdges, nInhibSelfEdges, ...
                    nExcitSelfEdges);
    strng = sprintf(['%s\nTOTAL number of connections: %d (%d inhibitory ' ...
                     '/ %d excitatory)'], strng, nInhibEdges+nExcitEdges, nInhibEdges, ...
                    nExcitEdges);
    strng = sprintf('%s\n(%d I->I / %d E->E)', strng, nIIedges, nEEedges);
    strng = sprintf('%s\n(%d I->E / %d E->I)', strng, nInhibEdges-nIIedges, nExcitEdges-nEEedges);

    
    text(-80, 10*(N+15), strng, 'HorizontalAlignment', 'left', 'FontName', 'Times', ...
    	'Fontsize', 6, 'Color', 'k');

    %% crop image %%
    
    %I = figure(1);
    %I2 = imcrop(I, figureAxis);
    %imshow(I2);
    
end % plot_Cij_matrix
