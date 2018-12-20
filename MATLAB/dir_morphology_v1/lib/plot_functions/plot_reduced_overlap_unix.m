function plot_reduced_overlap_unix

    load Cij.mat cellLabels cellADcodes
    load parcellation.mat
    load overlap.mat cellEorI CijOverlap CijAxonSomaOverlap knownNegAxonLocations knownNegDendriteLocations ...
        layerNames somataLocations knownMixedAxonLocations knownMixedDendriteLocations
    load notes.mat notes notesUnique notesStrings
    load isInclude.mat
    load status.mat status

    N = nAllCells;

    fprintf(1, '\nConverting to reduced overlap...')
    
    nReducedParcellations = 5;

    CijOverlap = CijOverlap';
    tmpOverlap = CijOverlap(:,1:nOfficialParcellations);
    CijOverlap(:,1:nOfficialParcellations) = fliplr(tmpOverlap);
    CijOverlap(:,nOfficialParcellations+1) = 0;
    CijReducedOverlap = zeros(N+1, nReducedParcellations+1);

    crossRegionalParcels(DG,:) = [5:nOfficialParcellations 5]; % + filler
    crossRegionalParcels(CA3,:) = [1:4 10:nOfficialParcellations 1:2];
    crossRegionalParcels(CA2,:) = [1:9 14:nOfficialParcellations 1];
    crossRegionalParcels(CA1,:) = [1:13 18:nOfficialParcellations 1];
    crossRegionalParcels(SUB,:) = [1:17 21:nOfficialParcellations];
    crossRegionalParcels(EC,:) = [1:20 1:3];

    mark = 0;
    cellRange(DG,1:2) = [mark+1 mark+nCells(DG)];
    mark = mark + nCells(DG);
    cellRange(CA3, 1:2) = [mark+1 mark+nCells(CA3)];
    mark = mark + nCells(CA3);
    cellRange(CA2, 1:2) = [mark+1 mark+nCells(CA2)];
    mark = mark + nCells(CA2);
    cellRange(CA1, 1:2) = [mark+1 mark+nCells(CA1)];
    mark = mark + nCells(CA1);
    cellRange(SUB, 1:2) = [mark+1 mark+nCells(SUB)];
    mark = mark + nCells(SUB);
    cellRange(EC, 1:2) = [mark+1 mark+nCells(EC)];

    mark = 0;
    parcelRange(DG,1:2) = [mark+1 mark+nParcels(DG)];
    mark = mark + nParcels(DG);
    parcelRange(CA3,1:2) = [mark+1 mark+nParcels(CA3)];
    mark = mark + nParcels(CA3);
    parcelRange(CA2,1:2) = [mark+1 mark+nParcels(CA2)];
    mark = mark + nParcels(CA2);
    parcelRange(CA1,1:2) = [mark+1 mark+nParcels(CA1)];
    mark = mark + nParcels(CA1);
    parcelRange(SUB,1:2) = [mark+1 mark+nParcels(SUB)];
    mark = mark + nParcels(SUB);
    parcelRange(EC,1:2) = [mark+1 mark+nParcels(EC)];


    for iRegion = [DG CA3 CA2 CA1 SUB EC]

        for iCell = cellRange(iRegion,1):cellRange(iRegion,2)

            if ((iRegion == DG) | (iRegion == CA2) | (iRegion == CA1))
            
                CijReducedOverlap(iCell,1:4) = CijOverlap(iCell, ...
                                                  [parcelRange(iRegion,1):parcelRange(iRegion,2)]);

            elseif (iRegion == CA3)

                CijReducedOverlap(iCell,[1:2 4]) = CijOverlap(iCell, ...
                                                      [parcelRange(CA3,1):parcelRange(CA3,1)+1 ...
                                                       parcelRange(CA3,2)]);

                CijReducedOverlap(iCell,3) = compress_parcels(CijOverlap(iCell,...
                                                                  [parcelRange(CA3,1)+2: ...
                                                                   parcelRange(CA3,1)+3]));
                
            elseif (iRegion == SUB)

                CijReducedOverlap(iCell,1:4) = CijOverlap(iCell, ...
                                                          [parcelRange(SUB,1) ...
                                                           parcelRange(SUB,1): ...
                                                           parcelRange(SUB,2)]);

            else % iRegion = EC

                CijReducedOverlap(iCell,[2:4]) = CijOverlap(iCell, ...
                                                            [parcelRange(EC,1)+2:-1:...
                                                             parcelRange(EC,1)]);

                CijReducedOverlap(iCell,1) = compress_parcels(CijOverlap(iCell, ...
                                                                  [parcelRange(EC,1)+3: ...
                                                                   parcelRange(EC,2)]));
                
            end % if iRegion

            CijReducedOverlap(iCell,5) = compress_parcels(CijOverlap(iCell, ...
                                                              [crossRegionalParcels(iRegion,:)]));

        end % for iCell

    end % for iRegion

    nOfficialParcellations = nReducedParcellations;
    CijOverlap = zeros(nOfficialParcellations+1, N+1);
    tmpOverlap = '';
    tmpOverlap = CijReducedOverlap(1:N,1:nReducedParcellations);
    tmpOverlap = fliplr(tmpOverlap);
    tmpOverlap = tmpOverlap';
    CijOverlap(1:nOfficialParcellations,1:N) = tmpOverlap;

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
    nStatus = 0;

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
        
        if (status(i) >= 1)
            label_code_cat = ['+', label_code_cat];
            nStatus = nStatus + 1;
        end

        classSubregionClassNameTab = 1.3;
        text(i+0.5, nOfficialParcellations+classSubregionClassNameTab, label_code_cat, 'color', labelColor, ...
            'HorizontalAlignment', 'right', 'Rotation', 90, 'FontSize', 5.0, 'Interpreter', 'none')

        layerNames = {'Cross-regional', 'H/SO/PL/I', 'SG/SP/II', 'SMi/SR/III', 'SMo/SLM/V'};

        for j = 1:nOfficialParcellations

            if (i == 1)
                text(0, j+0.5, layerNames{j}, 'rotation', 180, 'FontSize', 6)
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

        end % for j

    end % for i

    % cell class subregion headers
    DGstart = 1 + nCells(DG)/2;
    CA3start = 1 + nCells(DG) + nCells(CA3)/2;
    CA2start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2)/2;
    CA1start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1)/2 + 1; % fudge factor to avoid long class name
    SUBstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(SUB)/2;
    ECstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(SUB) + nCells(EC)/2;

    classSubregionNameTab = 5.0;
    text(DGstart, nOfficialParcellations+classSubregionNameTab, 'DG', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
    text(CA3start, nOfficialParcellations+classSubregionNameTab, 'CA3', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
    text(CA2start, nOfficialParcellations+classSubregionNameTab, 'CA2', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
    text(CA1start, nOfficialParcellations+classSubregionNameTab, 'CA1', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
    text(SUBstart, nOfficialParcellations+classSubregionNameTab, 'SUB', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);
    text(ECstart, nOfficialParcellations+classSubregionNameTab, 'EC', 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', 6);

    DGline = length(DGcells) + 1;
    CA3line = DGline + length(CA3cells);
    CA2line = CA3line + length(CA2cells);
    CA1line = CA2line + length(CA1cells);
    SUBline = CA1line + length(SUBcells);
    %ECline = SUBline + length(ECcells);
    
    line_width = 1.25;


    % draw lines between subregion along the class name axis
    classSubregionLineTab = 3;
    line([DGline, DGline], [1, nOfficialParcellations+ ...
                        classSubregionLineTab], 'linewidth', line_width, 'color', [0 0 0])
    line([CA3line, CA3line], [1, nOfficialParcellations+ ...
                        classSubregionLineTab], 'linewidth', line_width, 'color', [0 0 0])
    line([CA2line, CA2line], [1, nOfficialParcellations+ ...
                        classSubregionLineTab], 'linewidth', line_width, 'color', [0 0 0])
    line([CA1line, CA1line], [1, nOfficialParcellations+ ...
                        classSubregionLineTab], 'linewidth', line_width, 'color', [0 0 0])
    line([SUBline, SUBline], [1, nOfficialParcellations+ ...
                        classSubregionLineTab], 'linewidth', line_width, 'color', [0 0 0])


    %% flag duplicates %%
    isIncludeFlaggedDuplicates = 1;

    if (isIncludeFlaggedDuplicates)

        CijOverlap = CijOverlap(1:size(CijOverlap,1)-1,1:size(CijOverlap,2)-1);
        overlapMatrix = fliplr(CijOverlap');

        % 5 parcels
        overlapUnique5 = flipud(unique(overlapMatrix,'rows'));
        overlapStr = num2str(overlapMatrix);
        overlapStrUnique = unique(overlapStr,'rows');
        nRowsUnique = size(overlapStrUnique,1);
        nDuplicates = 0;

        for iRow = 1:nRowsUnique
            overlapDuplicateRows = strmatch(overlapStrUnique(iRow,:),overlapStr);

            if (length(overlapDuplicateRows) > 1)
                nDuplicates = nDuplicates + 1;

                for iDups = 1:length(overlapDuplicateRows)
                    text(overlapDuplicateRows(iDups)+0.5, 0.9, char(64+nDuplicates), ...
                         'Rotation', 90, 'FontSize', 4, 'color', 'k');

                end % for iDups
            end % if
        end % for iRow

        nUniqueClasses = nRowsUnique;


        % 4 parcels
        overlapUnique4 = flipud(unique(overlapMatrix(:,1:4),'rows'));
        overlapStr = num2str(overlapMatrix(:,1:4));
        overlapStrUnique = unique(overlapStr,'rows');
        nRowsUnique = size(overlapStrUnique,1);
        nDuplicates = 0;

        for iRow = 1:nRowsUnique
            overlapDuplicateRows = strmatch(overlapStrUnique(iRow,:),overlapStr);

            if (length(overlapDuplicateRows) > 1)
                nDuplicates = nDuplicates + 1;

                for iDups = 1:length(overlapDuplicateRows)
                    text(overlapDuplicateRows(iDups)+0.5, 0.7, char(96+nDuplicates), ...
                         'Rotation', 90, 'FontSize', 4, 'color', 'b');

                end % for iDups
            end % if
        end % for iRow

        nUniqueIntraregionalClasses = nRowsUnique;

    end % if isIncludeFlaggedDuplicates


    line([-9, N+1], [2, 2], 'linewidth', line_width, 'color', [0 0 0])    

    
    %% Add title and status  bar to top %%
%     strng = sprintf(['%s\n%s\n%d neuronal classes\n%d unique 5-parcel classes\n%d ' ...
%                      'unique 4-parcel classes'], hippocampomeVersion, ...
%                     date, nAllCells, nUniqueClasses, nUniqueIntraregionalClasses);
    strng = sprintf('%s\n%s\n%d neuronal classes', hippocampomeVersion, ...
                    date, nAllCells);
    text(-6, nOfficialParcellations+5, strng, 'HorizontalAlignment', ...
         'left', 'Rotation', 90, 'FontSize', 5);


    %% delete old plot with same name and export new one
    orient(gcf, 'landscape');
    print(gcf, '-depsc', '-r800', './Cij_reduced_A-D.eps'); 
    
    
    % 5 parcels    
    clf; cla;
    figure(2);
    
    scrsz = get(0,'ScreenSize');
    set(gcf, 'OuterPosition', [50 50 scrsz(3)*0.9 scrsz(4)*0.9])
    set(gcf, 'color', 'w');

    %% plot matrix %%
    
    overlapUnique5(:,end+1) = 0;
    overlapUnique5(end+1,:) = 0;
    colormap([1 1 1; 1 0 0; 0 0 1; .5 0 .5;])
    pcolor(overlapUnique5)
    
    axis ij
    axis off 

    %    axis([-10 nAllCells+2 -10 5+10])

    print(gcf, '-depsc', '-r800', './Cij_reduced_5-parcel.eps'); 

    
    % 4 parcels
    clf; cla;
    figure(3);
    
    scrsz = get(0,'ScreenSize');
    set(gcf, 'OuterPosition', [50 50 scrsz(3)*0.9 scrsz(4)*0.9])
    set(gcf, 'color', 'w');

    
    %% plot matrix %%

    overlapUnique4(:,end+1) = 0;
    overlapUnique4(end+1,:) = 0;
    colormap([1 1 1; 1 0 0; 0 0 1; .5 0 .5;])
    pcolor(overlapUnique4)
    
    axis ij
    axis off 

    %    axis([-10 nAllCells+2 -10 nOfficialParcellations+10])

    print(gcf, '-depsc', '-r800', './Cij_reduced_4-parcel.eps'); 

end % plot_axon_dendrite_overlap

