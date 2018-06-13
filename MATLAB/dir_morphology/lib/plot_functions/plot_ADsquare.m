function plot_ADsquare(axdeOverlapFilledPercentage, printStart, printEnd, regionCode, isStrippedDown)

    fprintf(1, '\nPlotting overlap matrix...')

    load Cij.mat
    load parcellation.mat
    load overlap.mat
    load notes.mat notes notesUnique notesStrings
    load isInclude.mat
    load status.mat status
    load connectivityToggles
    
    format long;
    
    isDiagonals = 0;
    
    BLACK = [0 0 0];
    BLUE = [0 0 1];
    BLUE_DARK = [0 0 0.5];
    BLUE_MEDIUM = [0 0 192]/255;
    BLUE_LIGHT = [143 172 255]/255;
    BLUE_SKY = [0 204 255]/255;
    BROWN_DG = [91 45 10]/255;
    BROWN_CA3 = [165 131 107]/255;
    GRAY = [0.5 0.5 0.5];
    GRAY_DARK = [0.25 0.25 0.25];
    GRAY_MEDIUM = [0.375 0.375 0.375];
    GRAY_LIGHT = [0.75 0.75 0.75];
    GRAY_ULTRALIGHT = [0.90 0.90 0.90];
    GREEN = [0 0.5 0];
    GREEN_MEDIUM = [0 0.75 0];
    GREEN_BRIGHT = [0 1 0];
    GREEN_EC = [106 149 49]/255;
    GREEN_MEC = [122 187 51]/255;
    GREEN_LEC = [90 111 47]/255;
    ORANGE = [228 108 10]/255;
    ORANGE_LIGHT = [247 156 21]/255;
    ORANGE_CA1 = [217 104 13]/255;
    PURPLE = [0.5 0 0.5];
    PURPLE_LIGHT = [178 128 178]/255;
    RED = [1 0 0];
    RED_LIGHT = [255 178 178]/255;
    TEAL = [0 255 192]/255;
    WHITE = [1 1 1];
    YELLOW = [1 1 0];
    YELLOW_CA2 = [1 1 0];
    YELLOW_Sub = [255 192 0]/255;
    
    regionColor = [BROWN_DG;
                   BROWN_CA3;
                   YELLOW_CA2;
                   ORANGE_CA1;
                   YELLOW_Sub;
                   GREEN_EC];
               

    VETTED_AXON = 1;
    VETTED_DENDRITE = 2;
    VETTED_BOTH = 3;
    UNVETTED_AXON = 4;
    UNVETTED_DENDRITE = 5;
    UNKNOWN_AXON = 6;
    UNKNOWN_DENDRITE = 7;
    UNKNOWN_BOTH = 8;
    UNVETTED_BOTH = 9;
    
    
    somaColor = BLACK;
    somaRadius = 0.175*0.75;
    
    if isAllIn1
        displayFontSize = 6.0;
    else    
        displayFontSize = 5;
    end
    
    if (nAllCells > 125)
        displayFontSize = 3;
    end
    
    if (nAllCells < 50)
        displayFontSize = 15;
    end
    
    if isPlotRegionsSep
        displayFontSize = 10;
    end
    
    if isAllIn1
        shadingLineWidths = 1.0;
    else %~isAllIn1
        shadingLineWidths = 0.5;
    end % if isAllIn1
    
    nOfficialParcels = nOfficialParcellations;
    
%     CijOverlap
%     nAxons = size(find(CijOverlap == 1))
%     nDendrites = size(find(CijOverlap == 2))
%     nBoth = size(find(CijOverlap == 3))
%     nSomata = size(find(somataLocations == 1))
%     nNegAxons = size(find(knownNegAxonLocations == 1))
%     nnegDendrites = size(find(knownNegDendriteLocations == 1))
%     pause
%     pause
    
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
    cellSubregions = cellSubregions(printStart:printEnd);
    cellSupertypes = cellSupertypes(printStart:printEnd);

    somataLocationsCountsPerParcel = zeros(nOfficialParcels);
        
    CijOverlapKnown = ones(size(knownNegDendriteLocations));
    CijOverlapKnown = (CijOverlap(:,1:end-1)==VETTED_AXON) + (CijOverlap(:,1:end-1)==VETTED_DENDRITE) + (CijOverlap(:,1:end-1)==VETTED_BOTH);
    
    unknownDendriteLocations = ones(size(knownNegDendriteLocations));
    unknownDendriteLocations = unknownDendriteLocations - knownNegDendriteLocations - CijOverlapKnown;
    unknownDendriteLocations(end,:) = 0;

    unknownAxonLocations = ones(size(knownNegAxonLocations));
    unknownAxonLocations = unknownAxonLocations - knownNegAxonLocations - CijOverlapKnown;
    unknownAxonLocations(end,:) = 0;
        
    VettedColormap = [  WHITE;      ... % 0: no neurites
                        RED;        ... % 1: vetted axons only
                        BLUE;       ... % 2: vetted dendrites only
                        PURPLE;     ... % 3: vetted axons and dendrites
                        RED;        ... % 4: unvetted axons only
                        BLUE;       ... % 5: unvetted dendrites only
                        WHITE;      ... % 6: not used
                        WHITE;      ... % 7: not used
                        WHITE;      ... % 8: not used
                        PURPLE];        % 9: unvetted axons and dendrites
 
    VettedColormapWithNegLocations = [  WHITE;      ... % 0: no neurites
                        RED;        ... % 1: vetted axons only
                        BLUE;       ... % 2: vetted dendrites only
                        PURPLE;     ... % 3: vetted axons and dendrites
                        RED;        ... % 4: unvetted axons only
                        BLUE;       ... % 5: unvetted dendrites only
                        GRAY_ULTRALIGHT;      ... % 6: unknown axon locations
                        GRAY_ULTRALIGHT;      ... % 7: unknown dendrite locations
                        GRAY_ULTRALIGHT;      ... % 8: unknown axon and dendrite locations
                        PURPLE];        % 9: unvetted axons and dendrites
 
    UnvettedColormap = [WHITE;      ... % 0: no neurites
                        RED;        ... % 1: vetted axons only
                        BLUE;       ... % 2: vetted dendrites only
                        PURPLE;     ... % 3: vetted axons and dendrites
                        RED_LIGHT;  ... % 4: unvetted axons only
                        BLUE_LIGHT; ... % 5: unvetted dendrites only
                        WHITE;      ... % 6: not used
                        WHITE;      ... % 7: not used
                        WHITE;      ... % 8: not used
                        PURPLE_LIGHT];  % 9: unvetted axons and dendrites
    
    AxonsOnlyColormap = [WHITE;     ... % 0: no neurites
                        RED;        ... % 1: vetted axons only
                        WHITE;      ... % 2: vetted dendrites only
                        RED;        ... % 3: vetted axons and dendrites
                        RED_LIGHT;  ... % 4: unvetted axons only
                        WHITE;      ... % 5: unvetted dendrites only
                        WHITE;      ... % 6: not used
                        WHITE;      ... % 7: not used
                        WHITE;      ... % 8: not used
                        RED_LIGHT];     % 9: unvetted axons and dendrites
    
    AxonsOnlyColormapWithNegLocations = [WHITE;     ... % 0: no neurites
                        RED;        ... % 1: vetted axons only
                        WHITE;      ... % 2: vetted dendrites only
                        RED;        ... % 3: vetted axons and dendrites
                        RED_LIGHT;  ... % 4: unvetted axons only
                        WHITE;      ... % 5: unvetted dendrites only
                        GRAY_ULTRALIGHT;      ... % 6: unknown axon locations
                        WHITE;      ... % 7: unknown dendrite locations
                        GRAY_ULTRALIGHT;      ... % 8: unknown axon and dendrite locations
                        RED_LIGHT];     % 9: unvetted axons and dendrites
    
    DendritesOnlyColormap = [WHITE;     ... % 0: no neurites
                            WHITE;      ... % 1: vetted axons only
                            BLUE;       ... % 2: vetted dendrites only
                            BLUE;       ... % 3: vetted axons and dendrites
                            WHITE;      ... % 4: unvetted axons only
                            BLUE_LIGHT; ... % 5: unvetted dendrites only
                            WHITE;      ... % 6: not used
                            WHITE;      ... % 7: not used
                            WHITE;      ... % 8: not used
                            BLUE_LIGHT];    % 9: unvetted axons and dendrites
    
    DendritesOnlyColormapWithNegLocations = [WHITE;     ... % 0: no neurites
                            WHITE;      ... % 1: vetted axons only
                            BLUE;       ... % 2: vetted dendrites only
                            BLUE;       ... % 3: vetted axons and dendrites
                            WHITE;      ... % 4: unvetted axons only
                            BLUE_LIGHT; ... % 5: unvetted dendrites only
                            WHITE;      ... % 6: unknown axon locations
                            GRAY_ULTRALIGHT;      ... % 7: unknown dendrite locations
                            GRAY_ULTRALIGHT;      ... % 8: unknown axon and dendrite locations
                            BLUE_LIGHT];    % 9: unvetted axons and dendrites
    
    NoNeuritesColormap = [WHITE; ... % 0: no neurites
                          WHITE; ... % 1: vetted axons only
                          WHITE; ... % 2: vetted dendrites only
                          WHITE; ... % 3: vetted axons and dendrites
                          WHITE; ... % 4: unvetted axons only
                          WHITE; ... % 5: unvetted dendrites only
                          WHITE; ... % 6: not used
                          WHITE; ... % 7: not used
                          WHITE; ... % 8: not used
                          WHITE];    % 9: unvetted axons and dendrites
    
    vStart = -2.5;
    vStartSummary = vStart - 4.5;

    hTabShift = 0;

    
    if isIncludeReferenceCounts
        skipReferenceCountsRows = 1;
        skipReferenceCountsCols = 2;
    
        [referenceCountsInfo, isReferenceCountsFileLoaded] = load_csvFile('reference_counts.csv');
                    
        referenceCountsAll = cellfun(@str2num, referenceCountsInfo(skipReferenceCountsRows+1:skipReferenceCountsRows+nAllCells, skipReferenceCountsCols+1));
        referenceCountsMorphology = cellfun(@str2num, referenceCountsInfo(skipReferenceCountsRows+1:skipReferenceCountsRows+nAllCells, skipReferenceCountsCols+2));
            
        hTabShift = -4;
        
        if isSortByAllRef || isSortByMorphRef                   
            if isSortByAllRef
                refValuesToSortBy = referenceCountsAll;
            elseif isSortByMorphRef
                refValuesToSortBy = referenceCountsMorphology;
            end
            
            EtoItransitions = 1;
            for t=2:nAllCells
                if cellEorI{t} ~= cellEorI{t-1}
                    EtoItransitions(length(EtoItransitions)+1) = t;
                end
            end  
            
            [sortedTempMatrix, DGplusPosIndex] = sort(refValuesToSortBy(EtoItransitions(1):EtoItransitions(2)-1),'descend');
            [sortedTempMatrix, DGminusPosIndex] = sort(refValuesToSortBy(EtoItransitions(2):EtoItransitions(3)-1),'descend');

            [sortedTempMatrix, CA3plusPosIndex] = sort(refValuesToSortBy(EtoItransitions(3):EtoItransitions(4)-1),'descend');
            [sortedTempMatrix, CA3minusPosIndex] = sort(refValuesToSortBy(EtoItransitions(4):EtoItransitions(5)-1),'descend');
            [sortedTempMatrix, CA2plusPosIndex] = sort(refValuesToSortBy(EtoItransitions(5):EtoItransitions(6)-1),'descend');
            [sortedTempMatrix, CA2minusPosIndex] = sort(refValuesToSortBy(EtoItransitions(6):EtoItransitions(7)-1),'descend');
            [sortedTempMatrix, CA1plusPosIndex] = sort(refValuesToSortBy(EtoItransitions(7):EtoItransitions(8)-1),'descend');
            [sortedTempMatrix, CA1minusPosIndex] = sort(refValuesToSortBy(EtoItransitions(8):EtoItransitions(9)-1),'descend');
            [sortedTempMatrix, SubplusPosIndex] = sort(refValuesToSortBy(EtoItransitions(9):EtoItransitions(10)-1),'descend');
            [sortedTempMatrix, SubminusPosIndex] = sort(refValuesToSortBy(EtoItransitions(10):EtoItransitions(11)-1),'descend');
            [sortedTempMatrix, ECplusPosIndex] = sort(refValuesToSortBy(EtoItransitions(11):EtoItransitions(12)-1),'descend');
            [sortedTempMatrix, ECminusPosIndex] = sort(refValuesToSortBy(EtoItransitions(12):nAllCells),'descend');
            
            DGminusPosIndex = DGminusPosIndex + length(DGplusPosIndex);
            CA3plusPosIndex = CA3plusPosIndex + length(DGplusPosIndex)+length(DGminusPosIndex);
            CA3minusPosIndex = CA3minusPosIndex + length(DGplusPosIndex)+length(DGminusPosIndex)+length(CA3plusPosIndex);
            CA2plusPosIndex = CA2plusPosIndex + length(DGplusPosIndex)+length(DGminusPosIndex)+length(CA3plusPosIndex)+length(CA3minusPosIndex);
            CA2minusPosIndex = CA2minusPosIndex + length(DGplusPosIndex)+length(DGminusPosIndex)+length(CA3plusPosIndex)+length(CA3minusPosIndex)+length(CA2plusPosIndex);
            CA1plusPosIndex = CA1plusPosIndex + length(DGplusPosIndex)+length(DGminusPosIndex)+length(CA3plusPosIndex)+length(CA3minusPosIndex)+length(CA2plusPosIndex)+length(CA2minusPosIndex);
            CA1minusPosIndex = CA1minusPosIndex + length(DGplusPosIndex)+length(DGminusPosIndex)+length(CA3plusPosIndex)+length(CA3minusPosIndex)+length(CA2plusPosIndex)+length(CA2minusPosIndex)+length(CA1plusPosIndex);
            SubplusPosIndex = SubplusPosIndex + length(DGplusPosIndex)+length(DGminusPosIndex)+length(CA3plusPosIndex)+length(CA3minusPosIndex)+length(CA2plusPosIndex)+length(CA2minusPosIndex)+length(CA1plusPosIndex)+length(CA1minusPosIndex);
            SubminusPosIndex = SubminusPosIndex + length(DGplusPosIndex)+length(DGminusPosIndex)+length(CA3plusPosIndex)+length(CA3minusPosIndex)+length(CA2plusPosIndex)+length(CA2minusPosIndex)+length(CA1plusPosIndex)+length(CA1minusPosIndex)+length(SubplusPosIndex);
            ECplusPosIndex = ECplusPosIndex + length(DGplusPosIndex)+length(DGminusPosIndex)+length(CA3plusPosIndex)+length(CA3minusPosIndex)+length(CA2plusPosIndex)+length(CA2minusPosIndex)+length(CA1plusPosIndex)+length(CA1minusPosIndex)+length(SubplusPosIndex)+length(SubminusPosIndex);
            ECminusPosIndex = ECminusPosIndex + length(DGplusPosIndex)+length(DGminusPosIndex)+length(CA3plusPosIndex)+length(CA3minusPosIndex)+length(CA2plusPosIndex)+length(CA2minusPosIndex)+length(CA1plusPosIndex)+length(CA1minusPosIndex)+length(SubplusPosIndex)+length(SubminusPosIndex)+length(ECplusPosIndex);
            
            allPosIndex = cat(1, DGplusPosIndex, DGminusPosIndex, CA3plusPosIndex, CA3minusPosIndex, CA2plusPosIndex, CA2minusPosIndex, ...
                CA1plusPosIndex, CA1minusPosIndex, SubplusPosIndex, SubminusPosIndex, ECplusPosIndex, ECminusPosIndex);
            
            % sort all arrays and matrices
            referenceCountsInfo = referenceCountsInfo(allPosIndex,:);
            referenceCountsAll = referenceCountsAll(allPosIndex,:);
            referenceCountsMorphology = referenceCountsMorphology(allPosIndex,:);            
            cellADcodes = cellADcodes(allPosIndex,:);
            cellAllInOneLabels = cellAllInOneLabels(allPosIndex,:);
            cellLabels = cellLabels(allPosIndex,:);
            isCellProjecting = isCellProjecting(allPosIndex,:);
            isSingleRef = isSingleRef(:,allPosIndex);
            CijOverlap(:,1:nAllCells) = CijOverlap(:,allPosIndex);
            cellEorI = cellEorI(allPosIndex,:);
            somaInfo = somaInfo(allPosIndex,:);
            CijAxonSomaOverlap = CijAxonSomaOverlap(:,allPosIndex);
            knownNegAxonLocations = knownNegAxonLocations(:,allPosIndex);
            knownNegDendriteLocations = knownNegDendriteLocations(:,allPosIndex);
            unknownDendriteLocations = unknownDendriteLocations(:,allPosIndex);
            unknownAxonLocations = unknownAxonLocations(:,allPosIndex);
            somataLocations = somataLocations(:,allPosIndex);
            knownMixedAxonLocations = knownMixedAxonLocations(:,allPosIndex);
            knownMixedDendriteLocations = knownMixedDendriteLocations(:,allPosIndex);
            borderlineCallsLocations = borderlineCallsLocations(:,allPosIndex);
            notes = notes(:,allPosIndex);
            notesUnique = notesUnique(:,allPosIndex);       
            cellSubregions = cellSubregions(allPosIndex);
        end
    end

    
    newplot
    clf('reset'); cla('reset');
    figure(1);
    
    set(gcf, 'color', 'w');

    set(gcf, 'PaperUnits', 'inches');
    set(gcf, 'PaperSize', [13 11]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 13 11]);
 
    set(gca, 'Position', get(gca, 'OuterPosition') - get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]/3);

    if isStrippedDown
        hStart = nOfficialParcels+2;
        hLineEnd = 1.75;
%         h = subplot(3,1,1);
%         set(gca, 'Position', get(gca, 'OuterPosition') - get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]/3);
        %displayFontSize = 5/3;
    else
        hStart = nOfficialParcels+11;
        hLineEnd = 7.0+4.25;
%         set(gca, 'Position', get(gca, 'OuterPosition') - get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    end
    
    %% plot matrix %%

    maxNeuriteEncoding = max(max(CijOverlap)) + 1;
    
    if (isIncludeAxonLocations && ~isIncludeDendriteLocations)
        
        if isIncludeKnownNegNeuriteLocations
            
            CijOverlap(unknownAxonLocations==1) = UNKNOWN_AXON;
            maxNeuriteEncoding = UNKNOWN_AXON + 1;
            colormap(AxonsOnlyColormapWithNegLocations(1:maxNeuriteEncoding,:));
            
        else
            
            colormap(AxonsOnlyColormap(1:maxNeuriteEncoding,:));
            
        end
        
    elseif (isIncludeDendriteLocations && ~isIncludeAxonLocations)
        
        if isIncludeKnownNegNeuriteLocations
            
            CijOverlap(unknownDendriteLocations==1) = UNKNOWN_DENDRITE;
            maxNeuriteEncoding = UNKNOWN_DENDRITE + 1;
            colormap(DendritesOnlyColormapWithNegLocations(1:maxNeuriteEncoding,:));
            
        else
        
            colormap(DendritesOnlyColormap(1:maxNeuriteEncoding,:));
            
        end
    
    elseif (isIncludeAxonLocations && isIncludeDendriteLocations)
    
        if (isUnvettedNeurite && ~isUnvetted2Vetted)
            
            colormap(UnvettedColormap(1:maxNeuriteEncoding,:));
            
        else
            
            if isIncludeKnownNegNeuriteLocations
                
                CijOverlapInverse = ones(size(unknownAxonLocations)) - sign(CijOverlap(:,1:end-1));
                CijOverlap((CijOverlapInverse.*unknownAxonLocations)==1) = UNKNOWN_AXON;
                CijOverlap((CijOverlapInverse.*unknownDendriteLocations)==1) = UNKNOWN_DENDRITE;
                CijOverlap(CijOverlap==UNKNOWN_AXON+UNKNOWN_DENDRITE) = UNKNOWN_BOTH;
                maxNeuriteEncoding = UNKNOWN_BOTH + 1;
                colormap(VettedColormapWithNegLocations(1:maxNeuriteEncoding,:));
                
            else
        
                colormap(VettedColormap(1:maxNeuriteEncoding,:));
                
            end
            
        end
        %1 1 0;   ... % partial axons = yellow
        %0 1 0;   ... % partial dendrites = green
        %0 0 0])      % partial axons and dendrites = black
   
    else % omit neurite locations
        
        colormap(NoNeuritesColormap(1:maxNeuriteEncoding,:));
        
    end
    
    pcolor(CijOverlap)
    
    axis ij
    axis equal
    axis off 

    axis([vStart (N+1) (-1+hTabShift) hStart+1+25])
%     axis([vStart (N+1) (-1+hTabShift) hStart])
%     axis([vStart (N+1) -1 hStart])

    hold on

%    rectangle('Position',[29.05, 19.05, 0.9, 0.9], 'EdgeColor', 'None', 'FaceColor', PURPLE);

    notesCount = 0;
    notesExtraLines = 0;
    nStatus = 0;
    
    status = status(:,printStart:printEnd);

    isSingleRef = isSingleRef(:,printStart:printEnd);
    
    % parcellation subregion headers
    DGtab = 1 + nOfficialParcels - nParcels(DG)/2;
    CA3tab = 1 + nOfficialParcels - nParcels(DG) - nParcels(CA3)/2;
    CA2tab = 1 + nOfficialParcels - nParcels(DG) - nParcels(CA3) - nParcels(CA2)/2;
    CA1tab = 1 + nOfficialParcels - nParcels(DG) - nParcels(CA3) - nParcels(CA2) - nParcels(CA1)/2;
    Subtab = 1 + nOfficialParcels - nParcels(DG) - nParcels(CA3) - nParcels(CA2) - nParcels(CA1) - nParcels(Sub)/2;
    ECtab = 1 + nOfficialParcels - nParcels(DG) - nParcels(CA3) - nParcels(CA2) - nParcels(CA1) - nParcels(Sub) - nParcels(EC)/2;

    vTab = vStart + 1.0;
    
    %%% color-coded tags for the subregions
    rectangle('Position',[vStart+0.5, 23, 2.98, 4], 'EdgeColor', 'None', 'FaceColor', regionColor(DG,:));
    rectangle('Position',[vStart+0.5, 18, 2.98, 5], 'EdgeColor', 'None', 'FaceColor', regionColor(CA3,:));
    rectangle('Position',[vStart+0.5, 14, 2.98, 4], 'EdgeColor', 'None', 'FaceColor', regionColor(CA2,:));
    rectangle('Position',[vStart+0.5, 10, 2.98, 4], 'EdgeColor', 'None', 'FaceColor', regionColor(CA1,:));
    rectangle('Position',[vStart+0.5, 7, 2.98, 3], 'EdgeColor', 'None', 'FaceColor', regionColor(Sub,:));
    rectangle('Position',[vStart+0.5, 1, 2.98, 6], 'EdgeColor', 'None', 'FaceColor', regionColor(EC,:));
    
    text(vTab, DGtab, 'DG', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize, 'color', WHITE);
    text(vTab, CA3tab, 'CA3', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize, 'color', WHITE);
    text(vTab, CA2tab, 'CA2', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize, 'color', BLACK);
    text(vTab, CA1tab, 'CA1', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize, 'color', WHITE);
    text(vTab, Subtab, 'Sub', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize, 'color', BLACK);
    text(vTab, ECtab, 'EC', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', displayFontSize, 'color', WHITE);    
    
    if isIncludeReferenceCounts         
         if isSortByAllRef
             rectangle('Position',[vStart, -2.25, nAllCells+1+abs(vStart), 1.5], 'EdgeColor', [0 0.3 0], 'FaceColor', [0.5 1 0.5]);
         elseif isSortByMorphRef
             rectangle('Position',[vStart, -0.75, nAllCells+1+abs(vStart), 1.5], 'EdgeColor', [0 0.3 0], 'FaceColor', [0.5 1 0.5]);
         end
         
         text(0.7, 0, 'Morph.', 'rotation', 180, 'FontSize', displayFontSize, 'color', BLUE_DARK);
         text(0.7, -1.5, 'All Art.', 'rotation', 180, 'FontSize', displayFontSize);         
    end
    
    for j = 1:nOfficialParcels
        
        %%% column labels
        if (sum([1 2 3 4 5 6 10 11 12 13 18 19 20 21 22 23 24 25 26] == j))
            text(0.7, j+0.5, layerNames{j}, 'rotation', 180, 'FontSize', displayFontSize, 'color', WHITE);
        else
            text(0.7, j+0.5, layerNames{j}, 'rotation', 180, 'FontSize', displayFontSize, 'color', BLACK);
        end
        
        for i = 1.0:double(printEnd)-double(printStart)+1.0
                            
            if isIncludeKnownNegNeuriteLocations
            
                if (isIncludeAxonLocations && (unknownAxonLocations(j,i) == 1))
                    
                    if isDiagonals
                        line ([i+0.1, i+0.9], [j+0.1, j+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                    else
                        % axons are red/light red and get horizontal lines (after graph rotation)
                        line ([i+0.5, i+0.5], [j+0.1, j+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                    end
                    
                end
                
                if(isIncludeDendriteLocations && (unknownDendriteLocations(j,i) == 1))
                    
                    if isDiagonals
                        line ([i+0.9, i+0.1], [j+0.1, j+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                    else
                        % dendrites are blue/light blue and get vertical lines (after graph rotation)
                        line ([i+0.1, i+0.9], [j+0.5, j+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
                    end
                    
                end
           
            end % if isIncludeKnownNegNeuriteLocations
            
            %%% plot shading lines
            if ((CijOverlap(j,i)== VETTED_AXON) || (CijOverlap(j,i)== UNVETTED_AXON))
                
                if isDiagonals
                    line ([i+0.1, i+0.9], [j+0.1, j+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                else
                    % axons are red/light red and get horizontal lines (after graph rotation)
                    line ([i+0.5, i+0.5], [j+0.1, j+0.9], 'color', WHITE, 'linewidth', shadingLineWidths)
                end
                
            elseif ((CijOverlap(j,i)== VETTED_DENDRITE) || (CijOverlap(j,i)== UNVETTED_DENDRITE))
                
                if isDiagonals
                    line ([i+0.9, i+0.1], [j+0.1, j+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                else
                    % dendrites are blue/light blue and get vertical lines (after graph rotation)
                    line ([i+0.1, i+0.9], [j+0.5, j+0.5], 'color', WHITE, 'linewidth', shadingLineWidths)
                end
                
            elseif ((CijOverlap(j,i)== VETTED_BOTH) || (CijOverlap(j,i)== UNVETTED_BOTH))
                
                % both are purple/light purple and get horizontal & vertical lines (after graph rotation)
                if ~isIncludeDendriteLocations
                    if isDiagonals
                        line ([i+0.1, i+0.9], [j+0.1, j+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                    else
                        line ([i+0.5, i+0.5], [j+0.1, j+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                    end
                elseif ~isIncludeAxonLocations
                    if isDiagonals
                        line ([i+0.9, i+0.1], [j+0.1, j+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                    else
                        line ([i+0.1, i+0.9], [j+0.5, j+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
                    end
                else
                    if isDiagonals
                        line ([i+0.1, i+0.9], [j+0.1, j+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                        line ([i+0.9, i+0.1], [j+0.1, j+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                    else
                        line ([i+0.5, i+0.5], [j+0.1, j+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
                        line ([i+0.1, i+0.9], [j+0.5, j+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
                    
%                         % kluge for missing lines!!!
%                         iii = 29;
%                         jjj = 19;
%                         line ([iii+0.5, iii+0.5], [jjj+0.1, jjj+0.9], 'color', WHITE, 'linewidth', shadingLineWidths);
%                         line ([iii+0.1, iii+0.9], [jjj+0.5, jjj+0.5], 'color', WHITE, 'linewidth', shadingLineWidths);
                    end
                end
                
            end % if ((CijOverlap(j,i)== 1) || (CijOverlap(j,i)== 4))
                
        end % for i
        
    end % for j = 1:nOfficialParcels
    
    
    %%% thick vertical lines on parcellation axis
    line_width = 1;

    vLine = [vStart+0.5, N];

    line(vLine, [23, 23], 'linewidth', line_width, 'color', BLACK);
    line(vLine, [18, 18], 'linewidth', line_width, 'color', BLACK);
    line(vLine, [14, 14], 'linewidth', line_width, 'color', BLACK);
    line(vLine, [10, 10], 'linewidth', line_width, 'color', BLACK);
    line(vLine, [7, 7], 'linewidth', line_width, 'color', BLACK);
    
    
    %%%% thick horizontal lines on cell class axis
    if regionCode == ALL
        DGline = 1+ nCells(DG);
        CA3line = DGline + nCells(CA3);
        CA2line = CA3line + nCells(CA2);
        CA1line = CA2line + nCells(CA1);
        Subline = CA1line + nCells(Sub);
        
        line([DGline,  DGline],  [1, nOfficialParcels+hLineEnd], 'linewidth', line_width, 'color', BLACK)        
        line([CA3line, CA3line], [1, nOfficialParcels+hLineEnd], 'linewidth', line_width, 'color', BLACK)
        line([CA2line, CA2line], [1, nOfficialParcels+hLineEnd], 'linewidth', line_width, 'color', BLACK)        
        line([CA1line, CA1line], [1, nOfficialParcels+hLineEnd], 'linewidth', line_width, 'color', BLACK)
        line([Subline, Subline], [1, nOfficialParcels+hLineEnd], 'linewidth', line_width, 'color', BLACK)
    end
    
    
    hTab = hStart+3.5; % *****
    hCorrection = 7.5;%1.5;
    hCorrectionShift = 2; %-1.25; % 100 cell types %-2.75;%-1.75;%-0.75;%-2.0;%-6.5;
    
    %%% cell class subregion headers
    if regionCode == ALL || regionCode == DG
        DGstart = 1 + nCells(DG)/2;
        
        vCorrection = 0;
        
        if isAllIn1
        
            strng = sprintf('DG');
            vCorrection = +0.0;
            hCorrection = hCorrectionShift;
            
        else
            
            strng = sprintf('DG (%d/{\\color[rgb]{GRAY}%d})', uint16(nCellsE(DG)), uint16(nCells(DG)-nCellsE(DG)));
            
        end
        
        text(DGstart+vCorrection, hTab+hCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    end
    
    if regionCode == ALL || regionCode == CA3
        if regionCode == ALL
            CA3start = 1 + nCells(DG) + nCells(CA3)/2;
        else
            CA3start = 1 + nCells(CA3)/2;
        end
        
        vCorrection = -1;
        
        if isAllIn1
        
            strng = sprintf('CA3');
            vCorrection = 0.0;
            hCorrection = hCorrectionShift;
            
        else
            
            strng = sprintf('CA3 (%d/{\\color[rgb]{GRAY}%d})', uint16(nCellsE(CA3)), uint16(nCells(CA3)-nCellsE(CA3)));
            
        end
        
        text(CA3start+vCorrection, hTab+hCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    end
    
    if regionCode == ALL || regionCode == CA2  

        if regionCode == ALL
            CA2start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2)/2;
        else
            CA2start = 1 + nCells(CA2)/2;
        end
        
        if isAllIn1
        
            strng = sprintf('CA2');
            vCorrection = 0.0;
            hCorrection = hCorrectionShift;

        else
            
            strng = sprintf('CA2 (%d/{\\color[rgb]{GRAY}%d})', uint16(nCellsE(CA2)), uint16(nCells(CA2)-nCellsE(CA2)));
            
        end
        
        text(CA2start, hTab+hCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    end
    
    if regionCode == ALL || regionCode == CA1
        if regionCode == ALL       
            CA1start = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1)/2;
        else
            CA1start = 1 + nCells(CA1)/2;
        end
        
        vCorrection = 0;
        
        if isAllIn1
        
            strng = sprintf('CA1');
            vCorrection = -2.0; % 0.0 % 100 cell types
            hCorrection = hCorrectionShift;

        else
            
            strng = sprintf('CA1 (%d/{\\color[rgb]{GRAY}%d})', uint16(nCellsE(CA1)), uint16(nCells(CA1)-nCellsE(CA1)));
            
        end
        
        text(CA1start+vCorrection, hTab+hCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', displayFontSize, 'FontWeight', 'bold');
    end
    
    if regionCode == ALL || regionCode == Sub
        if regionCode == ALL   
            Substart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + nCells(CA1) + nCells(Sub)/2;
        else
            Substart = 1 + nCells(Sub)/2;
        end
        
        if isAllIn1
        
            strng = sprintf('Sub');
            vCorrection = 0.0;
            hCorrection = hCorrectionShift;

        else
            
            strng = sprintf('Sub (%d/{\\color[rgb]{GRAY}%d})', uint16(nCellsE(Sub)), uint16(nCells(Sub)-nCellsE(Sub)));
            
        end
        
        text(Substart, hTab+hCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', displayFontSize, 'FontWeight', 'bold');         
    end
    
    if regionCode == ALL || regionCode == EC
        if regionCode == ALL
            ECstart = 1 + nCells(DG) + nCells(CA3) + nCells(CA2) + ...
                      nCells(CA1) + nCells(Sub) + nCells(EC)/2;
        else
            ECstart = 1 + nCells(EC)/2;
        end
        
        vCorrection = -0.5;
        
        if isAllIn1
        
            strng = sprintf('EC');
            vCorrection = 0.5;
            hCorrection = hCorrectionShift;
            
        else
            
            strng = sprintf('EC (%d/{\\color[rgb]{GRAY}%d})', uint16(nCellsE(EC)), uint16(nCells(EC)-nCellsE(EC)));
            
        end
        
        text(ECstart+vCorrection, hTab+hCorrection, strng, 'HorizontalAlignment', 'center', 'rotation', 180, 'FontSize', displayFontSize, 'FontWeight', 'bold'); 
    end
    
    
    if ~isStrippedDown
    
        %% Add title and status bar to top %%
        
        vTab = vStart + 0.5;
        hTab = hStart;
        
        if isIncludeVersionHeader
            
            strng = sprintf('Hippocampome %s', hippocampomeVersion);
            text(vTab, hTab, strng, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', displayFontSize);
            
            % print nParcellations
            vTab = vTab + 1;
            
            strng = sprintf('%d neuronal types', printEnd-printStart+1);
            text(vTab, hTab, strng, 'HorizontalAlignment', 'left', 'Rotation', ...
                90, 'FontSize', displayFontSize, 'Color', BLACK);
            
            vTab = vTab + 1;
            
            strng = sprintf('%d parcels', nOfficialParcels);
            text(vTab, hTab, strng, 'HorizontalAlignment', 'left', 'Rotation', ...
                90, 'FontSize', displayFontSize, 'Color', BLACK);
            
        end % isIncludeVersionHeader
        
        if isIncludeDateHeader
            
            vTab = vStart + 1.0;
            hTab = 0 + hTabShift;
            
            strng = sprintf('%s', date);
            text(vTab, hTab, strng, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', displayFontSize);
            
            vTab = vTab + 1;
            
            strng = sprintf('(%.1f%% filled)', axdeOverlapFilledPercentage);
            text(vTab, hTab, strng, 'HorizontalAlignment', 'left', 'Rotation', 90, 'FontSize', displayFontSize);
            
        end % isIncludeDateHeader
        
        if isIncludeNeuritesLegend

            vTab = 1.5;
            hTab = 0 + hTabShift;
            
            text(vTab, hTab, 'Black (e) = excitatory', 'HorizontalAlignment', 'left', ...
                'Rotation', 90, 'FontSize', displayFontSize, 'Color', BLACK); % black
            
            vTab = vTab + 1;
            
            text(vTab, hTab, 'Gray (i) = inhibitory', 'HorizontalAlignment', 'left', ...
                'Rotation', 90, 'FontSize', displayFontSize, 'Color', GRAY); % gray
            
            vTab = vTab + 2;
            
            text(vTab, hTab, 'p = projecting neuron', 'HorizontalAlignment', 'left', ...
                'Rotation', 90, 'FontSize', displayFontSize, 'Color', BLACK); % black
            
            vTab = vTab + 2;
            
            hold on;
            %    vTab = 4;
            
            if (isIncludeAxonLocations)
                xx = [vTab vTab (vTab+1) (vTab+1)];
                yy = [(hTab-1) hTab hTab (hTab-1)];
                fill(xx,yy,'r');
                line([vTab+0.5, vTab+0.5], [hTab-0.9, hTab-0.1], 'linewidth', shadingLineWidths, 'color', 'w');
                vTab = vTab + 0.5;
                hTab = hTab - 1.5;
                text(vTab, hTab, '= axons present', 'HorizontalAlignment', 'left', ...
                    'Rotation', 90, 'FontSize', displayFontSize, 'Color', 'r');
            end
            
            if (isIncludeDendriteLocations)
                if (isIncludeAxonLocations)
                    vTab = vTab + 0.5;
                    hTab = hTab + 1.5;
                end
                xx = [vTab vTab (vTab+1) (vTab+1)];
                yy = [(hTab-1) hTab hTab (hTab-1)];
                fill(xx,yy,'b');
                line([vTab+0.1, vTab+0.9], [hTab-0.5, hTab-0.5], 'linewidth', shadingLineWidths, 'color', 'w');
                vTab = vTab + 0.5;
                hTab = hTab - 1.5;
                text(vTab, hTab, '= dendrites present', 'HorizontalAlignment', 'left', ...
                    'Rotation', 90, 'FontSize', displayFontSize, 'Color', 'b');
            end
            
            if (isIncludeAxonLocations  && isIncludeDendriteLocations)                
                vTab = vTab + 0.5;
                hTab = hTab + 1.5;
                xx = [vTab vTab (vTab+1) (vTab+1)];
                yy = [(hTab-1) hTab hTab (hTab-1)];
                fill(xx,yy,PURPLE);
                line([vTab+0.5, vTab+0.5], [hTab-0.9, hTab-0.1], 'linewidth', shadingLineWidths, 'color', 'w');
                line([vTab+0.1, vTab+0.9], [hTab-0.5, hTab-0.5], 'linewidth', shadingLineWidths, 'color', 'w');
                vTab = vTab + 0.5;
                hTab = hTab - 1.5;
                text(vTab, hTab, '= both present', 'HorizontalAlignment', 'left', ...
                    'Rotation', 90, 'FontSize', displayFontSize, 'Color', PURPLE);
            end
            
            if isIncludeKnownNegNeuriteLocations
                
                vTabShift = 0.5;
                
                if (isIncludeAxonLocations)
                    vTab = vTab + 0.5 + vTabShift;
                    hTab = hTab + 1.5;
                    xx = [vTab vTab (vTab+1) (vTab+1)];
                    yy = [(hTab-1) hTab hTab (hTab-1)];
                    fill(xx,yy,GRAY_LIGHT);
                    line([vTab+0.5, vTab+0.5], [hTab-0.95, hTab-0.05], 'linewidth', shadingLineWidths, 'color', 'w');
                    vTab = vTab + 0.5;
                    hTab = hTab - 1.5;
                    text(vTab, hTab, '= axons unknown', 'HorizontalAlignment', 'left', ...
                        'Rotation', 90, 'FontSize', displayFontSize, 'Color', GRAY_LIGHT);
                    vTabShift = 0.0;
                end
                
                if (isIncludeDendriteLocations)
                    vTab = vTab + 0.5 + vTabShift;
                    hTab = hTab + 1.5;
                    xx = [vTab vTab (vTab+1) (vTab+1)];
                    yy = [(hTab-1) hTab hTab (hTab-1)];
                    fill(xx,yy,GRAY_LIGHT);
                    line([vTab+0.05, vTab+0.95], [hTab-0.5, hTab-0.5], 'linewidth', shadingLineWidths, 'color', 'w');
                    vTab = vTab + 0.5;
                    hTab = hTab - 1.5;
                    text(vTab, hTab, '= dendrites unknown', 'HorizontalAlignment', 'left', ...
                        'Rotation', 90, 'FontSize', displayFontSize, 'Color', GRAY_LIGHT);
                    vTabShift = 0.0;
                end
                            
                if (isIncludeAxonLocations  && isIncludeDendriteLocations)
                    vTab = vTab + 0.5 + vTabShift;
                    hTab = hTab + 1.5;
                    xx = [vTab vTab (vTab+1) (vTab+1)];
                    yy = [(hTab-1) hTab hTab (hTab-1)];
                    fill(xx,yy,GRAY_LIGHT);
                    line([vTab+0.5, vTab+0.5], [hTab-0.95, hTab-0.05], 'linewidth', shadingLineWidths, 'color', 'w');
                    line([vTab+0.05, vTab+0.95], [hTab-0.5, hTab-0.5], 'linewidth', shadingLineWidths, 'color', 'w');
                    vTab = vTab + 0.5;
                    hTab = hTab - 1.5;
                    text(vTab, hTab, '= both unknown', 'HorizontalAlignment', 'left', ...
                        'Rotation', 90, 'FontSize', displayFontSize, 'Color', GRAY_LIGHT);
                end % if (isIncludeAxonLocations && isIncludeDendriteLocations)
                
            end % if isIncludeKnownNegNeuriteLocations

            if isIncludeSomataLocations
            
                vTab = vTab + 1.0;
                hTab = hTab + 0.5;
%                 gradient_rectangle(vTab+0.05,hTab+0.05,0.9,0.9,BLUE_MEDIUM,GREEN_BRIGHT,10)
%                 rectangle('Position', [vTab+0.5-r hTab+0.5-r 2*r 2*r], 'Curvature',[1,1], 'EdgeColor', GRAY_LIGHT, 'FaceColor', GRAY_LIGHT);
                rectangle('Position', [vTab+0.5-somaRadius hTab+0.5-somaRadius 2*somaRadius 2*somaRadius], 'Curvature',[1,1], 'EdgeColor', somaColor, 'FaceColor', somaColor);
%                 rectangle('Position', [vTab+0.05 hTab+0.05 0.9 0.9], 'EdgeColor', GREEN, 'FaceColor', WHITE);    
                vTab = vTab + 0.5;
                hTab = hTab - 0.5;
                text(vTab, hTab, '= soma location', 'HorizontalAlignment', 'left', ...
                    'Rotation', 90, 'FontSize', displayFontSize, 'Color', somaColor);%GREEN);
                
            end % isIncludeSomataLocations
            
        end % isIncludeNeuritesLegend

        if isIncludeSingleReferenceLegend
        
            vTab = vTab + 2;
            hTab = hTab + 1.5;
            
            text(vTab, hTab, '* = single reference packet', 'HorizontalAlignment', 'left', ...
                'Rotation', 90, 'FontSize', displayFontSize, 'Color', BLACK); % black
            
        end % isIncludeSingleReferenceLegend
            
        if isIncludeFlaggedDuplicates
            
            vTab = vTab + 1.5;
            hTab = 0 + hTabShift;
            text(vTab, hTab, 'a,b,c,... = label identical patterns', 'HorizontalAlignment', 'left', ...
                'Rotation', 90, 'FontSize', displayFontSize, 'Color', BLACK);
            
        end

        if isIncludeGiorgioStats & ~(isIncludeSingleNeuriteDifferences | isIncludeDoubleNeuriteDifferences)
            
%             vTab = 1.5;
%             hTab = 0;
            
%             [vTab, hTab] = create_legend(vTab, hTab, displayFontSize, line_width, isIncludeNeuritesLegend, isIncludeSingleReferenceLegend, ...
%                 isIncludeKnownNegNeuriteLocations, isIncludeFlaggedDuplicates);
            
            
            vTab = vTab + 2;
            hTab = 0 + hTabShift;
            
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
                hTab = 0 + hTabShift;
                
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
                
                
                strng = sprintf('(m):%s%2d Giorgio post-merging', spacingStr, nGiorgioPostMerging);
                text(vTab, hTab, strng, 'FontName', 'Courier', ...
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
                
                strng = sprintf('    %s%2d Giorgio splitting', spacingStr, nGiorgioSplitting);
                text(vTab, hTab, strng, 'FontName', 'Courier', ...
                    'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);
                
                vTab = vTab + 1;
                
                strng = sprintf('    %s%2d Giorgio merging queue', spacingStr, ...
                    nGiorgioMergingQueue);
                text(vTab, hTab, strng, 'FontName', 'Courier', ...
                    'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);
                
                
                vTab = vTab + 2;
                hTab = 0 + hTabShift;
                
            end
            
            
            if isIncludeSuspendedClasses
                
                strng = sprintf('(x):%s%d Suspended', spacingStr, nSuspended);
                text(vTab, hTab, strng, 'FontName', 'Courier', ...
                    'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);%GRAY); % gray
                
                vTab = vTab + 2;
                hTab = 0 + hTabShift;
                
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
                hTab = 0 + hTabShift;
                
            end
            
            
            if isIncludeVirtualClasses
                
                strng = sprintf('(v):%s%2d Virtual', spacingStr, nVirtual);
                text(vTab, hTab, strng, 'FontName', 'Courier', ...
                    'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', 'r', 'FontSize', displayFontSize);
                
                vTab = vTab + 2;
                hTab = 0 + hTabShift;
                
            end
                        
        end % if isIncludeGiorgioStats
        
        if isSortByAllRef
             text(vTab, hTab, 'Sorted by number of [all] references', 'FontName', 'Courier', ...
                    'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', [0.2 1 0.2], 'FontSize', displayFontSize);
        elseif isSortByMorphRef
             text(vTab, hTab, 'Sorted by number of [morphology] references', 'FontName', 'Courier', ...
                    'HorizontalAlignment', 'left', 'Rotation', 90, 'Color', [0.2 1 0.2], 'FontSize', displayFontSize);
        end
        
        
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
                nOfficialParcels, ...
                nTabs, cellLabels, ...
                cellADcodes, cellSubregions,...
                cellEorI, regionCode, ...
                printStart, printEnd, ...
                vStart+2, 0);
            
        end % if isIncludeSingleNeuriteDifferences
        

        if (isIncludeDoubleNeuriteDifferences)
            
            nTabs = find_double_neurite_differences(CijOverlap', ...
                nOfficialParcels, ...
                nTabs, cellLabels, ...
                cellADcodes, cellSubregions,...
                cellEorI, regionCode, ...
                printStart, printEnd, ...
                vStart+3, 0);
            
        end % if isIncludeDoubleNeuriteDifferences

        
        if isIncludeFootnotesLegend && ~(isIncludeSingleNeuriteDifferences || isIncludeDoubleNeuriteDifferences)

            footnotes = csv2cell('./data/footnotes.csv','fromfile');
    
            nFootnotes = size(footnotes,1);
            
%             vTab = (N+0.5) - nFootnotes; %N - 9.5;
%             hTab = 0 + hTabShift;
% 
%             for ii = 1:size(footnotes,1)
% 
%                 strng = sprintf('%2s %s', footnotes{ii,2}, footnotes{ii,1});
% 
%                 text(vTab, hTab, strng, 'HorizontalAlignment', 'left', 'FontName', 'Courier', ...
%                      'Rotation', 90, 'FontSize', displayFontSize, 'Color', BLACK); % black
% 
%                 vTab = vTab + 1;
% 
%             end
%             
%             for i = 1:printEnd-printStart+1
%                 if(notes(i) ~= -1) % ****
%                     text(i+0.5, nOfficialParcels+1.1, num2str(notes(i)), ...
%                         'color', [0 0 0], 'HorizontalAlignment', 'right', ...
%                         'Rotation', 90, 'FontSize', displayFontSize-2)
%                 end
%             end % for i
                
            vTab = N;
            hTab = 0 + hTabShift;
            
            halfWay = round(nFootnotes/2);

            for ii = 1:nFootnotes
                
                if (ii == halfWay+1)
                    vTab = vTab - 30; % also need to reset hTab
                    hTab = 0 + hTabShift;
                end
                
                strng = sprintf('%2s %s', footnotes{ii,2}, footnotes{ii,1});

                text(vTab, hTab, strng, 'HorizontalAlignment', 'left', 'FontName', 'Courier', ...
                     'Rotation', 180, 'FontSize', displayFontSize, 'Color', BLACK); % black

                hTab = hTab - 1;

            end
            
            for i = 1.0:double(printEnd)-double(printStart)+1.0
                if(notes(i) ~= -1) % ****
                    text(i+0.5, nOfficialParcels+1.1, num2str(notes(i)), ...
                        'Color', BLACK, 'HorizontalAlignment', 'right', ...
                        'Rotation', 90, 'FontSize', displayFontSize-2);
                end
            end % for i

        end % if isIncludeFootnotesLegend

        
        %     end % if ~isStrippedDown
        %
        %
        % %%%%% new subpanel if needed
        %
        % %     if isStrippedDown
        % %         h = subplot(3,1,2);
        % %         set(gca, 'Position', get(gca, 'OuterPosition') - get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]/3);
        % %         displayFontSize = 5/3;
        % %         axis ij
        % %         axis equal
        % %         axis off
        % %
        % %         axis([vStart (N+1) -1 hStart])
        % %
        % %         hold on
        % %     end
        %
        % if ~isStrippedDown

        % plot labels & shading lines
        oldSupertypeTag = ' ';
        
        for i = 1.0:double(printEnd)-double(printStart)+1.0
            
            if isIncludeReferenceCounts
                hTab = -0.5;
                
%                 referenceCountsAll = referenceCountsInfo{skipReferenceCountsRows+i,skipReferenceCountsCols+1};
%                 referenceCountsMorphology = referenceCountsInfo{skipReferenceCountsRows+i,skipReferenceCountsCols+2};                

                if (referenceCountsAll(i) <= 9)
                    referenceCountsAllStr = strcat('  ', num2str(referenceCountsAll(i)));
                else
                    referenceCountsAllStr = num2str(referenceCountsAll(i));tic
                end
                
                if (referenceCountsMorphology(i) <= 9)
                    referenceCountsMorphologyStr = strcat('  ', num2str(referenceCountsMorphology(i)));
                else
                    referenceCountsMorphologyStr = num2str(referenceCountsMorphology(i));
                end
                                       
            
                text(i+0.5, hTab, referenceCountsMorphologyStr, 'HorizontalAlignment', 'right', ...
                    'Rotation', 90, 'FontSize', displayFontSize, 'Color', BLUE_DARK);
         
                text(i+0.5, hTab-1.5, referenceCountsAllStr, 'HorizontalAlignment', 'right', ...
                    'Rotation', 90, 'FontSize', displayFontSize, 'Color', BLACK);

            end % if isIncludeReferenceCounts
                            
            hTab = nOfficialParcels+3;

            cellADcode = deblank(cellADcodes{printStart+i-1});
            
            labelColor = BLACK;
            if (cellEorI{i} == 'I')
                labelColor = GRAY_MEDIUM;
            end
            
            if isAllIn1
            
                cellLabel = deblank(cellAllInOneLabels{printStart+i-1});

                if isIncludeSupertypes
                    
                    cellSupertype = cellSupertypes{printStart+i-1};
                    
                    colonIdx = find(cellSupertype == ':');
                    
                    cellSupertypeTag = cellSupertype(colonIdx(end)+1:end);
                    
                    if ~strcmp(cellSupertypeTag, oldSupertypeTag)
                        line([i, i], [1, nOfficialParcels+15], 'linewidth', line_width/4, 'color', BLACK)
                        if ~strcmp(cellSupertypeTag, 'blank')
                            text(i+0.5, hTab+15, cellSupertypeTag, 'color', labelColor, ...
                                'HorizontalAlignment', 'right', 'Rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold', 'Interpreter', 'none');
                        end
                    end
                    
                    oldSupertypeTag = cellSupertypeTag;
                        
                end % if isIncludeSupertypes
                    
                hTab = nOfficialParcels+1.25;
%                 hTab = nOfficialParcels+1.75;
                
                label_code_cat = [cellLabel];

                label_code_cat = [label_code_cat, ' [', num2str(i), ']'];
                
            else % ~isAllIn1
                
                cellLabel = deblank(cellLabels{printStart+i-1});
                
                if isIncludeSupertypes
                
                    cellSupertype = cellSupertypes{printStart+i-1};
                    
                    colonIdx = find(cellSupertype == ':');
                    
                    cellSupertypeTag = cellSupertype(colonIdx(1)+1:end);
                    
                    if strcmp(cellSupertypeTag, oldSupertypeTag)
                        if strcmp(cellSupertypeTag, 'blank')
                            text(i+0.5, hTab, cellSupertypeTag, 'color', labelColor, ...
                                'HorizontalAlignment', 'right', 'Rotation', 90, 'FontSize', displayFontSize, 'FontWeight', 'bold', 'Interpreter', 'none');
                            cellLabel = sprintf('\t%s', cellLabel);
                        end
                    end
                    
                    oldSupertypeTag = cellSupertypeTag;
                        
                end % if isIncludeSupertypes
                    
                if (cellEorI{i} == 'E')
                    label_code_cat = [cellLabel, ' (e)', cellADcode];
                else % cellEorI{i} == 'I'
                    label_code_cat = [cellLabel, ' (i)', cellADcode];
                end
                
                if (isSingleRef(i) && isIncludeSingleReferenceLegend)
                    label_code_cat = ['*', label_code_cat];
                end
                
                if ( ( (0.0 < status(i)) && (status(i) < 0.2) ) || ... % do not count unapproved active mergers
                        ( (-0.1 < status(i)) && (status(i) < -0.3) ) || ... % do not count unapproved suspended mergers
                        ( (0.3 < status(i)) && (status(i) < 0.5) ) || ... % do not count virtual classes
                        ( (0.5 < status(i)) && (status(i) < 0.8) ) || ... % do not count premerger classes
                        ( (0.9 < status(i)) && (status(i) < 1.0) ) ) % do not count presplit classes
                    if ~isTemporary2Active
                        label_code_cat = ['(t) ', label_code_cat];
                    end
                end
                
                if (status(i) == 0.5) % virtual classes
                    label_code_cat = ['(v) ', label_code_cat];
                end
                
                if ( ((status(i) == 0.3) || status(i) == 0.8) || (status(i) == 0.9) || (status(i) == 0.95) ) % premerger classes
                    if ~isPremerger2Active
                        label_code_cat = ['(p) ', label_code_cat];
                    end
                end
                
                if (status(i) == 0.2) % unapproved active merger classes
                    if ~isMerged2Active
                        label_code_cat = ['(m) ', label_code_cat];
                    end
                end
                
                if (status(i) == -0.2) % unapproved suspended merger classes
                    if ~isMerged2Active
                        label_code_cat = ['(w) ', label_code_cat];
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
                
            end % if ~isAllIn1
            
            FontNameStr = 'Helvetica';
            
            text(i+0.5, hTab, label_code_cat, 'color', labelColor, ...
                'HorizontalAlignment', 'right', 'Rotation', 90, 'FontSize', displayFontSize, 'Interpreter', 'none');
            
            if ~isAllIn1
            
                if isCellProjecting(i)
                    text(i+0.5, hTab-0.1, 'p', 'color', labelColor, ...
                        'Rotation', 90, 'FontSize', displayFontSize, 'Interpreter', 'none')
                end
            
            end % if ~isAllIn1
            
            for j = 1:nOfficialParcels
                
                if isAllIn1
                    somaLineWidth = 1.0;
                else
                    somaLineWidth = 0.5;
                end
                
                if (somataLocations(j,i) && isIncludeSomataLocations)
%                     rectangle('Position', [i+0.5-r j+0.5-r 2*r 2*r], 'Curvature',[1,1], 'EdgeColor', GRAY_LIGHT, 'FaceColor', GRAY_LIGHT);
                    rectangle('Position', [i+0.5-somaRadius j+0.5-somaRadius 2*somaRadius 2*somaRadius], 'Curvature',[1,1], 'EdgeColor', somaColor, 'FaceColor', somaColor);
%                     rectangle('Position', [i+0.1 j+0.1 0.8 0.8], 'EdgeColor', GREEN, 'LineWidth', somaLineWidth);
%                     rectangle('Position', [i+0.05 j+0.05 0.9 0.9], 'EdgeColor', GREEN, 'LineWidth', somaLineWidth);
                end
                
                if (CijAxonSomaOverlap(j,i) && isIncludeAxonSomaOverlap)
                    rectangle('Position', [i+0.05 j+0.05 0.9 0.9], 'EdgeColor', YELLOW, 'LineWidth', somaLineWidth);
                end
                
                if ~isIncludeVirtualClasses
                end % if ~isIncludeVirtualClasses
                
                if (1==0)%isIncludeKnownNegNeuriteLocations
                    if (isIncludeAxonLocations)
                        if knownMixedAxonLocations(j,i)
                            line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', BLACK, 'linewidth', 1.0);
                            line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', BLACK, 'linewidth', 1.0);
                        elseif knownNegAxonLocations(j,i)
                            rectangle('Position', [i+0.05 j+0.05 0.9 0.9], 'FaceColor', WHITE);
                        end
                    end
                    
                    if (isIncludeDendriteLocations)
                        
                        if knownMixedDendriteLocations(j,i)
                            line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', BLACK, 'linewidth', 1.0);
                            line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', BLACK, 'linewidth', 1.0);
                        elseif knownNegDendriteLocations(j,i)                            
                            rectangle('Position', [i+0.05 j+0.05 0.9 0.9], 'FaceColor', WHITE);
                        end
                    end
                    
                    knownNegNeuriteLocations = knownNegAxonLocations + knownNegDendriteLocations;
                    knownMixedNeuriteLocations = knownMixedAxonLocations + knownMixedDendriteLocations;
                    
                    if (isIncludeAxonLocations && ~isIncludeDendriteLocations)
                        if knownMixedNeuriteLocations(j,i) == 1
                            line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', BLACK, 'linewidth', 0.5);
                            line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', BLACK, 'linewidth', 0.5);
                        elseif (knownNegNeuriteLocations(j,i) == 2)
                            line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', RED, 'linewidth', 0.5);
                            line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', RED, 'linewidth', 0.5);
                        end                        
                    elseif (~isIncludeAxonLocations && isIncludeDendriteLocations)
                        if knownMixedNeuriteLocations(j,i) == 1
                            line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', BLACK, 'linewidth', 0.5);
                            line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', BLACK, 'linewidth', 0.5);
                        elseif (knownNegNeuriteLocations(j,i) == 2)
                            line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', BLUE, 'linewidth', 0.5);
                            line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', BLUE, 'linewidth', 0.5);
                        end
                    else
                        if knownMixedNeuriteLocations(j,i) == 1
                            line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', BLACK, 'linewidth', 0.5);
                            line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', BLACK, 'linewidth', 0.5);
                        elseif (knownNegNeuriteLocations(j,i) == 2)
                            line ([i+0.05, i+0.95], [j+0.05, j+0.95], 'color', PURPLE, 'linewidth', 0.5);
                            line ([i+0.05, i+0.95], [j+0.95, j+0.05], 'color', PURPLE, 'linewidth', 0.5);
                        end
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
        
        if isIncludeSomataLocations
            
            if isIncludeSomaParcelCounts
                
                somataLocationsCountsPerParcel = sum(somataLocationsInfo,1);
                
                for iParcel = 1:nOfficialParcels
                    
                    text(N+0.5, nOfficialParcels+1.5-iParcel, num2str(somataLocationsCountsPerParcel(iParcel)), 'rotation', 90, 'HorizontalAlignment', 'center', 'FontSize', displayFontSize-1);
                    
                end
                
            end % if isIncludeSomaParcelCounts
        
        end % if isIncludeSomataLocations
            
    end % if isStrippedDown

%%%% save plots

    plotFileName = sprintf('./output/Cij_axon-dend');

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
      case Sub
        plotFileName = sprintf('%s_Sub', plotFileName);
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

    if isIncludeDisappearingActiveClasses
        plotFileName = sprintf('%s_o', plotFileName);
    end

    if isIncludeSwitching1p0OnHoldClasses
        plotFileName = sprintf('%s_w', plotFileName);
    end

    if isIncludeSwitching2p0OnHoldClasses
        plotFileName = sprintf('%s_q', plotFileName);
    end

    plotFileName = sprintf('%s.eps', plotFileName);

    orient(gcf, 'landscape');
    orient rotated;
    print(gcf, '-depsc', '-r800', plotFileName);

end % plot_axon_dendrite_overlap

