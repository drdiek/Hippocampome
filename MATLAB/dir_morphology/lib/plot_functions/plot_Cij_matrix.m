function plot_Cij_matrix(CijFilledPercentage)
         
    load overlap.mat
    load parcellation.mat
    load Cij.mat Cij CijSpecialConnections cellAbbrevs cellADcodes ...
        cellLabels cellEorIs cellAllInOneLabels
    load CijKnownClassLinks.mat
    load CijKnownNegClassLinks.mat
    load CijAxonSomaOverlap.mat
    load isInclude.mat
    
    newplot
    clf('reset'); cla('reset');
    figure(1);
    
    set(gca, 'Position', get(gca, 'OuterPosition') - get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    set(gcf, 'PaperUnits', 'inches');
    set(gcf, 'PaperSize', [9 11]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 9 11]);
    
    
    %% plot matrix %%
    N = size(Cij,1);

%     allCij = abs(Cij) + CijSpecialConnections + CijAxonSomaOverlap;
%     signCij = sign(allCij);
%     sumInputs = sum(signCij,1);
%     sumOutputs = sum(signCij,2);
%     fidd = fopen('sumInputs.txt', 'w')
%     for i = 1:N
%           fprintf(fidd, '%d\t%d\n', i, sumInputs(i));
%     end
%     fclose(fidd);
%     fido = fopen('sumOutputs.txt', 'w');
%     for i = 1:N
%           fprintf(fido, '%d\t%d\n', i, sumOutputs(i));
%     end
%     fclose(fido);
%     signCij(1:20,1:20)
%     pause
    
    % create new matrix equal to Cij but with a blank row & col at end
    % (used for pcolor function)

    
    NewCij = zeros(N+1,N+1);
    for i = 1:N
        for j = 1:N
            if (CijKnownNegClassLinks(i,j) ~= 0)
                %NewCij(i,j) = 0;
            else
                if isCijSpecialConnections
                    if CijSpecialConnections(i,j) > 1
                        NewCij(i,j) = CijSpecialConnections(i,j);
                    else
                        NewCij(i,j) = Cij(i,j);
                    end
                else
                    if CijSpecialConnections(i,j) == 4
                        NewCij(i,j) = 4;
                    else
                        NewCij(i,j) = Cij(i,j);
                    end
                end
            end
        end
    end

    uniqueCijElements = unique(NewCij);

    if isAllIn1
        cmap = ([0.7 0.7 0.7;   ... %gray (inhib)
                 1.0 1.0 1.0;   ... %white (no connection)
                 0.0 0.0 0.0]); ... %black (excit)
    elseif ismember(4, uniqueCijElements)
        cmap = ([0.7 0.7 0.7; ... %gray (inhib)
            1 1 1; ... %white (no connection)
            0 0 0; ... %black (excit)
            0.55 0.85 0.90; ... %lt blue (axo-axonic)
            0 0 0.5; ... %dk blue (basket)
            1 0.55 0;]); %orange (connection ONLY in PCL)
    else
        cmap = ([0.7 0.7 0.7; ... %gray (inhib)
            1 1 1; ... %white (no connection)
            0 0 0; ... %black (excit)
            0.55 0.85 0.90; ... %lt blue (axo-axonic)            
            0 0 0.5;]); %dk blue (basket)
%     else
%         cmap = ([0.7 0.7 0.7; ... %gray (inhib)
%             1 1 1; ... %white (no connection)
%             0 0 0; ... %black (excit)
%             1 0 0]);   %red (flag)
    end
   
    
    
    axisVector = 0:10:10*N;  
    pcolor(axisVector, axisVector, NewCij);
    colormap(cmap);
    

    axis ij
    axis equal
    axis off
    hold on
    axis([-160 (10*N)+10 -160 (10*N)+200])

    for i = 1:N  
%         if isAllIn1
%             cellLabel = deblank(cellAllInOneLabels{i});
%         else
            cellLabel = deblank(cellAbbrevs{i});
%         end
        cellADcode = deblank(cellADcodes{i});
        cellEorI = deblank(cellEorIs{i});

        if (cellEorI == 'E')
            abbrev_code_cat = [cellLabel, ' (+)', cellADcode];
        else %if (cellEorI == 'I')
            abbrev_code_cat = [cellLabel, ' (-)', cellADcode];
        end        

        font_size = 4;
        
        if isCellProjecting(i)
            text((i-1)*10+5, -5, [abbrev_code_cat,'p'], 'rotation', 90, 'FontSize', font_size, 'Interpreter', 'none')
        else
            text((i-1)*10+5, -5, abbrev_code_cat, 'rotation', 90, 'FontSize', font_size, 'Interpreter', 'none')
        end
        
        text(-15, (i-1)*10+5, abbrev_code_cat, 'HorizontalAlignment', 'right', 'FontSize', font_size, 'Interpreter', 'none')
        if isCellProjecting(i)
            text(-15, (i-1)*10+5, 'p', 'HorizontalAlignment', 'left', 'FontSize', font_size, 'Interpreter', 'none')
        end

    end % i loop
    

    %% process flags %%
    if isIncludeKnownClassLinks
        for i = 1:N
            for j = 1:N
                if CijKnownClassLinks(j,i)
                    line([10*i-5, 10*i-5], [10*j-9, 10*j-1], 'linewidth', 0.25, 'color', [0 1 0]);
                    line([10*i-9, 10*i-1], [10*j-5, 10*j-5], 'linewidth', 0.25, 'color', [0 1 0]);
                end % if CijKnownClassLinks
            end % for j
        end % for i
    end % if isIncludeKnownClassLinks
    
    if isIncludeKnownNegClassLinks
        for i = 1:N
            for j = 1:N
                if CijKnownNegClassLinks(j,i)
                    line([10*i-8, 10*i-2], [10*j-8, 10*j-2], 'linewidth', 0.25, 'color', 'r');
                    line([10*i-8, 10*i-2], [10*j-2, 10*j-8], 'linewidth', 0.25, 'color', 'r');
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
    if ~isAllIn1
        strng = sprintf('%s\n(%.1f%% filled)', hippocampomeVersion, CijFilledPercentage);
    
%     text(-130, -130, strng, 'HorizontalAlignment', 'left', 'FontSize', 5);
    %text(-90, -60, 'Black = excitatory', 'HorizontalAlignment', 'left', 'FontSize', 5, 'Color', 'k');
    %text(-90, -50, 'Gray = inhibitory', 'HorizontalAlignment', 'left', 'FontSize', 5, 'Color', [0.7 0.7 0.7]);

    end
    
    DGstart = nCells(DG)/2 - 1; % fudge to eliminate overlap with long class name
    CA3start = nCells(DG) + nCells(CA3)/2;
    CA2start = nCells(DG) + nCells(CA3) + nCells(CA2)/2;
    CA1start = nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1)/2;
    Substart = nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(Sub)/2;
    ECstart = nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(Sub) + nCells(EC)/2;

    % label origination subregions
%     text(-170, 10*nAllCells/2, 'PRE-SYNAPTIC NEURON TYPES', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 6, 'FontWeight', 'bold');
    text(-145, 10*DGstart, 'DG', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 5);
    text(-145, 10*CA3start, 'CA3', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 5);
    text(-145, 10*CA2start, 'CA2', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 5);
    text(-145, 10*CA1start, 'CA1', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 5);
    text(-145, 10*Substart, 'Sub', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 5);
    text(-145, 10*ECstart, 'EC', 'HorizontalAlignment', 'center', 'rotation', 90, 'FontSize', 5);

    % label destination subregions
%     text(10*nAllCells/2, -170, 'POST-SYNAPTIC NEURON TYPES', 'HorizontalAlignment', 'center', 'FontSize', 6, 'FontWeight', 'bold');
    text(10*DGstart, -135, 'DG', 'HorizontalAlignment', 'center', 'FontSize', 5);
    text(10*CA3start, -135, 'CA3', 'HorizontalAlignment', 'center', 'FontSize', 5);
    text(10*CA2start, -135, 'CA2', 'HorizontalAlignment', 'center', 'FontSize', 5);
    text(10*CA1start, -135, 'CA1', 'HorizontalAlignment', 'center', 'FontSize', 5);
    text(10*Substart, -135, 'Sub', 'HorizontalAlignment', 'center', 'FontSize', 5);
    text(10*ECstart, -135, 'EC', 'HorizontalAlignment', 'center', 'FontSize', 5); 
    
    nDG = nCells(DG);
    nCA3 = nDG + nCells(CA3);
    nCA2 = nCA3 + nCells(CA2);
    nCA1 = nCA2 + nCells(CA1);
    nSub = nCA1 + nCells(Sub);
    nEC = nSub + nCells(EC);
    
    NewCij(1:N,1:N) = NewCij(1:N,1:N) + 10*CijKnownClassLinks;% + 100*CijAxonSomaOverlap;
    
%     CijAxonSomaOverlap(1:18,1:18)
%     CijSpecialConnections(1:18,1:18)
%     CijKnownClassLinks(1:18,1:18)
%     pause
    
    if isConnectivitySums
        rowSums = zeros(N);
        for iRow = 1:N
            idx = find(NewCij(iRow,1:N) ~= 0);
            idxNeg = find(CijKnownNegClassLinks(iRow,1:N) ~= 0);
            rowSum = length(idx);% - length(idxNeg);
            strng = sprintf('%3d', rowSum);
            text(10*N+10, 10*(iRow-1)+5, strng, 'HorizontalAlignment', 'center', 'FontSize', font_size);
            rowSums(iRow) = rowSum;
        end
        colSums = zeros(N);
        for iCol = 1:N
            idx = find(NewCij(1:N,iCol) ~= 0);
            idxNeg = find(CijKnownNegClassLinks(1:N,iCol) ~= 0);
            colSum = length(idx);% - length(idxNeg);
            strng = sprintf('%3d', colSum);
            text(10*(iCol-1)+5, 10*N+10, strng, 'HorizontalAlignment', 'center', 'rotation', -90, 'FontSize', font_size);
            colSums(iCol) = colSum;
        end
    end
    
    if isSubregionSums
        rowSums = zeros(N);
        for iRow = 1:N
            if (iRow <= nDG)
                idx = find(NewCij(iRow,1:nDG) ~= 0);
                idxNeg = find(CijKnownNegClassLinks(iRow,1:nDG) ~= 0);
            elseif (iRow <= nCA3) 
                idx = find(NewCij(iRow,nDG+1:nCA3) ~= 0);
                idxNeg = find(CijKnownNegClassLinks(iRow,nDG+1:nCA3) ~= 0);
            elseif (iRow <= nCA2) 
                idx = find(NewCij(iRow,nCA3+1:nCA2) ~= 0);
                idxNeg = find(CijKnownNegClassLinks(iRow,nCA3+1:nCA2) ~= 0);
            elseif (iRow <= nCA1) 
                idx = find(NewCij(iRow,nCA2+1:nCA1) ~= 0);
                idxNeg = find(CijKnownNegClassLinks(iRow,nCA2+1:nCA1) ~= 0);
            elseif (iRow <= nSub) 
                idx = find(NewCij(iRow,nCA1+1:nSub) ~= 0);
                idxNeg = find(CijKnownNegClassLinks(iRow,nCA1+1:nSub) ~= 0);
            else % (iRow <= nEC) 
                idx = find(NewCij(iRow,nSub+1:nEC) ~= 0);
                idxNeg = find(CijKnownNegClassLinks(iRow,nSub+1:nEC) ~= 0);
            end
            rowSum = length(idx);% - length(idxNeg);
            strng = sprintf('%3d', rowSum);
            text(10*N+10, 10*(iRow-1)+5, strng, 'HorizontalAlignment', 'center', 'FontSize', font_size);
            rowSums(iRow) = rowSum;
        end
        colSums = zeros(N);
        for iCol = 1:N
            if (iCol <= nDG)
                idx = find(NewCij(1:nDG,iCol) ~= 0);
                idxNeg = find(CijKnownNegClassLinks(1:nDG,iCol) ~= 0);
            elseif (iCol <= nCA3) 
                idx = find(NewCij(nDG+1:nCA3,iCol) ~= 0);
                idxNeg = find(CijKnownNegClassLinks(nDG+1:nCA3,iCol) ~= 0);
            elseif (iCol <= nCA2) 
                idx = find(NewCij(nCA3+1:nCA2,iCol) ~= 0);
                idxNeg = find(CijKnownNegClassLinks(nCA3+1:nCA2,iCol) ~= 0);
            elseif (iCol <= nCA1) 
                idx = find(NewCij(nCA2+1:nCA1,iCol) ~= 0);
                idxNeg = find(CijKnownNegClassLinks(nCA2+1:nCA1,iCol) ~= 0);
            elseif (iCol <= nSub) 
                idx = find(NewCij(nCA1+1:nSub,iCol) ~= 0);
                idxNeg = find(CijKnownNegClassLinks(nCA1+1:nSub,iCol) ~= 0);
            else % (iCol <= nEC) 
                idx = find(NewCij(nSub+1:nEC,iCol) ~= 0);
                idxNeg = find(CijKnownNegClassLinks(nSub+1:nEC,iCol) ~= 0);
            end
            colSum = length(idx);% - length(idxNeg);
            strng = sprintf('%3d', colSum);
            text(10*(iCol-1)+5, 10*N+10, strng, 'HorizontalAlignment', 'center', 'rotation', -90, 'FontSize', font_size);
            colSums(iCol) = colSum;
        end
    end
    
    line_width = 1;
    
    DGline = 10*length(DGcells);
    CA3line = DGline + 10*length(CA3cells);
    CA2line = CA3line + 10*length(CA2cells);
    CA1line = CA2line + 10*length(CA1cells);
    Subline = CA1line + 10*length(Subcells);
    %ECline = Subline + 10*length(ECcells);
	
    line([-100, 10*N], [DGline, DGline], 'linewidth', line_width);
    line([DGline, DGline], [-100, 10*N], 'linewidth', line_width);
    line([-100, 10*N], [CA3line, CA3line], 'linewidth', line_width);
    line([CA3line, CA3line], [-100, 10*N], 'linewidth', line_width);
    line([-100, 10*N], [CA2line, CA2line], 'linewidth', line_width);
    line([CA2line, CA2line], [-100, 10*N], 'linewidth', line_width);
    line([-100, 10*N], [CA1line, CA1line], 'linewidth', line_width);
    line([CA1line, CA1line], [-100, 10*N], 'linewidth', line_width);
    line([-100, 10*N], [Subline, Subline], 'linewidth', line_width);
    line([Subline, Subline], [-100, 10*N], 'linewidth', line_width);
    %line([-65, 10*N], [ECline, ECline], 'linewidth', line_width);
    %line([ECline, ECline], [-65, 10*N], 'linewidth', line_width);


    %% legend %%
    tabShift = 0;
    legendStart = 10*(N+2);
    
    if isAllIn1
    
        fill([tabShift,tabShift+5,tabShift+5,tabShift], [legendStart,legendStart,legendStart+5,legendStart+5], 'k');
        tabShift = tabShift + 5;
        text(tabShift, legendStart+3, '  / ', 'HorizontalAlignment', 'left', 'FontSize', 4, 'Color', [0 0 0]);
        tabShift = tabShift + 10;
        fill([tabShift,tabShift+5,tabShift+5,tabShift], [legendStart,legendStart,legendStart+5,legendStart+5], [0.7 0.7 0.7]);
        tabShift = tabShift + 10;
        text(tabShift, legendStart+3, '- excitatory / inhibitory connection', 'HorizontalAlignment', 'left', 'FontSize', 4, ...
            'Color', [0 0 0]);
            
    else
        
        fill([tabShift,tabShift+5,tabShift+5,tabShift], [legendStart,legendStart,legendStart+5,legendStart+5], 'k');
        tabShift = tabShift + 5;
        text(tabShift, legendStart+3, '  / ', 'HorizontalAlignment', 'left', 'FontSize', 4, 'Color', [0 0 0]);
        tabShift = tabShift + 10;
        fill([tabShift,tabShift+5,tabShift+5,tabShift], [legendStart,legendStart,legendStart+5,legendStart+5], [0.7 0.7 0.7]);
        tabShift = tabShift + 10;
        text(tabShift, legendStart+3, '- excit / inhib connection in non-PCL layers', 'HorizontalAlignment', 'left', 'FontSize', 4, ...
            'Color', [0 0 0]);
        
        tabShift = N*10*(1/3);
        fill([tabShift,tabShift+5,tabShift+5,tabShift], [legendStart,legendStart,legendStart+5,legendStart+5], [0 0 0.5]);
        tabShift = tabShift + 5;
        text(tabShift, legendStart+3, '  / ', 'HorizontalAlignment', 'left', 'FontSize', 4, 'Color', [0 0 0]);
        tabShift = tabShift + 10;
        fill([tabShift,tabShift+5,tabShift+5,tabShift], [legendStart,legendStart,legendStart+5,legendStart+5], [0.66 0.85 0.90]);
        tabShift = tabShift + 10;
        text(tabShift, legendStart+3, '- perisomatic region / AIS connection', 'HorizontalAlignment', 'left', 'FontSize', 4, ...
            'Color', [0 0 0]);
        
        tabShift = N*10*(2/3);
        fill([tabShift,tabShift+5,tabShift+5,tabShift], [legendStart,legendStart,legendStart+5,legendStart+5], [1 0.55 0]);
        tabShift = tabShift + 10;
        text(tabShift, legendStart+3, '- connect in PCL only', 'HorizontalAlignment', 'left', 'FontSize', 4, ...
            'Color', [0 0 0]);

    end
         
    legendStart = 10*(N+4);    
    
    if isIncludeKnownClassLinks
        text(0, legendStart, '+ = known connection', ...
             'HorizontalAlignment', 'left', 'FontSize', 4, ...
             'Color', [0 1 0]);
    end
    if isIncludeKnownNegClassLinks
        %if (sum(sum(CijKnownNegClassLinks)) > 0)
            text(N*10*(1/4), legendStart, 'X = known non-connection', ...
                 'HorizontalAlignment', 'left', 'FontSize', 4, ... 
                 'Color', 'r');
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

    if ~isAllIn1
        strng = sprintf(['Number of cell types: %d (%d inhibitory / %d ' ...
            'excitatory)'], N, nInhib, nExcit);
        strng = sprintf(['%s          Number of self-connections: %d (%d inhibitory ' ...
            '/ %d excitatory)'], strng, nSelfEdges, nInhibSelfEdges, ...
            nExcitSelfEdges);
        strng = sprintf('%s          (%d I->I / %d E->E)', strng, nIIedges, nEEedges);
        strng = sprintf('%s          (%d I->E / %d E->I)', strng, nInhibEdges-nIIedges, nExcitEdges-nEEedges);
        strng = sprintf(['%s\nTOTAL number of connections: %d (%d inhibitory ' ...
            '/ %d excitatory)'], strng, nInhibEdges+nExcitEdges, nInhibEdges, ...
            nExcitEdges);
    
        text(0, 10*(N+7), strng, 'HorizontalAlignment', 'left', 'FontName', 'Times', ...
            'Fontsize', 6, 'Color', 'k');
        
        if (isConnectivitySums || isSubregionSums)
            strng = sprintf('DG: %d inputs and %d outputs', sum(colSums(1:nDG)), sum(rowSums(1:nDG)));
            text(0, 10*(N+10), strng, 'HorizontalAlignment', 'left', 'FontName', 'Times', 'Fontsize', 6);
            strng = sprintf('CA3: %d inputs and %d outputs', sum(colSums(nDG+1:nCA3)), sum(rowSums(nDG+1:nCA3)));
            text(0, 10*(N+12), strng, 'HorizontalAlignment', 'left', 'FontName', 'Times', 'Fontsize', 6);
            strng = sprintf('CA2: %d inputs and %d outputs', sum(colSums(nCA3+1:nCA2)), sum(rowSums(nCA3+1:nCA2)));
            text(0, 10*(N+14), strng, 'HorizontalAlignment', 'left', 'FontName', 'Times', 'Fontsize', 6);
            strng = sprintf('CA1: %d inputs and %d outputs', sum(colSums(nCA2+1:nCA1)), sum(rowSums(nCA2+1:nCA1)));
            text(0, 10*(N+16), strng, 'HorizontalAlignment', 'left', 'FontName', 'Times', 'Fontsize', 6);
            strng = sprintf('Sub: %d inputs and %d outputs', sum(colSums(nCA1+1:nSub)), sum(rowSums(nCA1+1:nSub)));
            text(0, 10*(N+18), strng, 'HorizontalAlignment', 'left', 'FontName', 'Times', 'Fontsize', 6);
            strng = sprintf('EC: %d inputs and %d outputs', sum(colSums(nSub+1:nEC)), sum(rowSums(nSub+1:nEC)));
            text(0, 10*(N+20), strng, 'HorizontalAlignment', 'left', 'FontName', 'Times', 'Fontsize', 6);
            strng = sprintf('TOTAL: %d inputs and %d outputs', sum(colSums(1:nEC)), sum(rowSums(1:nEC)));
            text(0, 10*(N+22), strng, 'HorizontalAlignment', 'left', 'FontName', 'Times', 'Fontsize', 6);
        end
    end

    %% crop image %%
    
    %I = figure(1);
    %I2 = imcrop(I, figureAxis);
    %imshow(I2);
    
    % delete old plot with same name and export new one
    %    delete 'Cij_plot.eps';
    orient(gcf, 'tall');
    print(gcf, '-depsc', '-r800', './output/Cij_plot.eps');

end % plot_Cij_matrix
