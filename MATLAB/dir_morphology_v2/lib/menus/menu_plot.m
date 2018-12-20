function [reply] = menu_plot(csvFileName, cells)
% modified 20100917 by Diek W. Wheeler, Ph.D

    load adPCLtoggles
    load Cij.mat
    load CellCounts.mat

    
    isIncludeKnownClassLinks = 1;
    isIncludeKnownNegClassLinks = 1;
    isIncludeAxonSomaOverlap = 1;
    isIncludeSomataLocations = 1;
    isIncludeAxonLocations = 1;
    isIncludeDendriteLocations = 1;
    isIncludeKnownNegNeuriteLocations = 1;
    isIncludeFlaggedDuplicates = 0;
    isIncludeSingleNeuriteDifferences = 0;
    isIncludeDoubleNeuriteDifferences = 0;
    isIncludeAcrossEINeuriteDifferences = 0;
    isIncludeBorderlineCalls = 0;
    isPlotRegionsSep = 0;
    isIncludeVersionHeader = 1;
    isIncludeDateHeader = 1;
    isIncludeNeuritesLegend = 1;
    isIncludeSingleReferenceLegend = 1;
    isIncludeGiorgioStats = 1;
    isIncludeFootnotesLegend = 1;
    isTemporary2Active = 0;
    isMerged2Active = 1;
    isPremerger2Active = 0;
    isTemporary2Suspended = 0;
    isCijSpecialConnections = 1;
    isAllIn1 = 1;
    isIncludeSomaParcelCounts = 0;
    isUnvetted2Vetted = 0;
    isIncludeReferenceCounts = 0;
    isSortByAllRef = 0;
    isSortByMorphRef = 0;
    isConnectivitySums = 0;
    isSubregionSums = 0;
    isIncludeSupertypes = 0;

    if isAllIn1
        isIncludeKnownClassLinks = 0;
        isIncludeKnownNegClassLinks = 0;
        isIncludeAxonSomaOverlap = 0;
        isIncludeSomataLocations = 1;
        isIncludeKnownNegNeuriteLocations = 0;
        isIncludeFlaggedDuplicates = 0;
        isIncludeGiorgioStats = 0;
        isIncludeSingleNeuriteDifferences = 0;
        isIncludeDoubleNeuriteDifferences = 0;
        isIncludeAcrossEINeuriteDifferences = 0;
        isIncludeBorderlineCalls = 0;
        isPlotRegionsSep = 0;
        isIncludeVersionHeader = 0;
        isIncludeDateHeader = 0;
        isIncludeNeuritesLegend = 0;
        isIncludeSingleReferenceLegend = 0;
        isTemporary2Active = 0;
        isMerged2Active = 0;
        isPremerger2Active = 0;
        isTemporary2Suspended = 0;
        isIncludeFootnotesLegend = 0;
        isCijSpecialConnections = 1;
        isIncludeSomaParcelCounts = 0;
        isUnvetted2Vetted = 1;
        isIncludeReferenceCounts = 0;
        isSortByAllRef = 0;
        isSortByMorphRef = 0;
        isIncludeSupertypes = 0;
    end

%     save isInclude.mat isIncludeKnownClassLinks isIncludeKnownNegClassLinks ...
%         isIncludeAxonSomaOverlap ...
%         isIncludeSomataLocations isIncludeKnownNegNeuriteLocations ...
%         isIncludeFlaggedDuplicates ... 
%         isIncludeGiorgioStats isIncludeSingleNeuriteDifferences ...
%         isIncludeDoubleNeuriteDifferences ...
%         isIncludeAcrossEINeuriteDifferences ...
%         isIncludeBorderlineCalls isPlotRegionsSep isIncludeVersionHeader isIncludeDateHeader isIncludeNeuritesLegend isIncludeSingleReferenceLegend ...
%         isTemporary2Active isMerged2Active isPremerger2Active ...
%         isTemporary2Suspended isIncludeFootnotesLegend ...
%         isCijSpecialConnections isAllIn1 isIncludeSomaParcelCounts isUnvetted2Vetted isIncludeReferenceCounts ...
%         isSortByAllRef isSortByMorphRef isConnectivitySums isSubregionSums ...
%         isIncludeAxonLocations isIncludeDendriteLocations isIncludeSupertypes

    nCijTotal = size(Cij,1)^2;
    nCijFilled = sum(sum(sign(abs(Cij)))); 
    CijFilledPercentage = 100*nCijFilled/nCijTotal;

    isStrippedDown = 0;
    
    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        clc;
        save isInclude.mat isIncludeKnownClassLinks isIncludeKnownNegClassLinks isIncludeAxonSomaOverlap ...
            isIncludeSomataLocations isIncludeKnownNegNeuriteLocations ...
            isIncludeFlaggedDuplicates ... 
            isIncludeGiorgioStats isIncludeSingleNeuriteDifferences ...
            isIncludeDoubleNeuriteDifferences ...
            isIncludeAcrossEINeuriteDifferences ...
            isIncludeBorderlineCalls isPlotRegionsSep isIncludeVersionHeader isIncludeDateHeader isIncludeNeuritesLegend isIncludeSingleReferenceLegend ...
            isTemporary2Active isMerged2Active isPremerger2Active ...
            isTemporary2Suspended isIncludeFootnotesLegend ...
            isCijSpecialConnections isAllIn1 isIncludeSomaParcelCounts isUnvetted2Vetted isIncludeReferenceCounts ...
            isSortByAllRef isSortByMorphRef isConnectivitySums isSubregionSums ...
            isIncludeAxonLocations isIncludeDendriteLocations isIncludeSupertypes
        
        strng = sprintf('Current csv file is: %s\n', csvFileName);
        disp(strng);
        strng = sprintf('Including axons/dendrites CONTINUING in PCL? %s', bin2str(togglePCLcontinuing));
        disp(strng);
        strng = sprintf('Including axons/dendrites TERMINATING in PCL? %s\n', bin2str(togglePCLterminating));
        disp(strng);
        strng = sprintf('Connectivity - PLOT MENU\n');
        disp(strng);
        strng = sprintf('Select from the options below:\n');
        disp(strng);
        
        
        strng = sprintf('     m) Plot Cij matrix (%.1f%% filled)', CijFilledPercentage);
        disp(strng);

        strng = sprintf('     d) Plot Cij matrix dimers (%.1f%% filled)', 100*sum(sum(abs(Cij)))/(size(Cij,1)^2));
        disp(strng);

        %strng = sprintf('    o) Plot axon-dendrite overlap %.1f%% filled)', axdeOverlapFilledPercentage);
        strng = sprintf('     o) Plot axon-dendrite overlap');
        disp(strng);                        

        strng = sprintf('     c) Plot axon-dendrite overlap csv matrix');
        disp(strng);            
                        
        strng = sprintf('     h) Plot graph on hippocampus image');
        disp(strng);            
                        
        strng = sprintf('     r) Plot reduced overlap');
        disp(strng);                        

        strng = sprintf('     s) Plot stripped-down axon-dendrite overlap with no header, key, legend, or class names');
        disp(strng);                        

        strng = sprintf('     t) Plot periodic table of the elements');
        disp(strng);                        

        disp(' ');
        
        strng = sprintf('     1) Toggle inclusion of known class links: %s', bin2str(isIncludeKnownClassLinks));
        disp(strng);
        
        strng = sprintf('     2) Toggle inclusion of known negative class links: %s', bin2str(isIncludeKnownNegClassLinks));
        disp(strng);

        strng = sprintf('     3) Toggle inclusion of somata locations: %s', bin2str(isIncludeSomataLocations));
        disp(strng);        
        
        strng = sprintf('     3a) Toggle inclusion of axon locations: %s', bin2str(isIncludeAxonLocations));
        disp(strng);        
        
        strng = sprintf('     3b) Toggle inclusion of dendrite locations: %s', bin2str(isIncludeDendriteLocations));
        disp(strng);        
        
        strng = sprintf('     4) Toggle inclusion of potential principal-cell-layer axonal-somatic connections: %s', bin2str(isIncludeAxonSomaOverlap));
        disp(strng);
        
        strng = sprintf('     5) Toggle inclusion of known negative neurite locations: %s', bin2str(isIncludeKnownNegNeuriteLocations));
        disp(strng);
        
        strng = sprintf('     6) Toggle inclusion of flagged duplicates in connectivity and overlap matrices: %s', bin2str(isIncludeFlaggedDuplicates));
        disp(strng);
        
        strng = sprintf('     7) Toggle separate plotting of subregions: %s', bin2str(isPlotRegionsSep));
        disp(strng);

        disp(' ');
        
        strng = sprintf('     8) Toggle inclusion of version header information : %s', bin2str(isIncludeVersionHeader));
        disp(strng);

        strng = sprintf('     9) Toggle inclusion of date header information : %s', bin2str(isIncludeDateHeader));
        disp(strng);

        strng = sprintf('    10) Toggle inclusion of neurites legend : %s', bin2str(isIncludeNeuritesLegend));
        disp(strng);

        strng = sprintf('    11) Toggle inclusion of single reference legend : %s', bin2str(isIncludeSingleReferenceLegend));
        disp(strng);

        strng = sprintf('    12) Toggle inclusion of Giorgio statistics for the overlap matrix: %s', bin2str(isIncludeGiorgioStats));
        disp(strng);
        
        strng = sprintf('    13) Toggle inclusion of footnotes legend : %s', bin2str(isIncludeFootnotesLegend));
        disp(strng);

        strng = sprintf('    14) Toggle inclusion of soma parcel counts : %s', bin2str(isIncludeSomaParcelCounts));
        disp(strng);

        strng = sprintf('    15) Toggle inclusion of reference counts (default sorting) : %s', bin2str(isIncludeReferenceCounts));
        disp(strng);
        
        strng = sprintf('    16) Toggle inclusion of reference counts (sort by all refs) : %s', bin2str(isSortByAllRef));
        disp(strng);
        
        strng = sprintf('    17) Toggle inclusion of reference counts (sort by morph refs): %s', bin2str(isSortByMorphRef));
        disp(strng);        

        disp(' ');
        
        strng = sprintf('    18) Toggle inclusion of single neurite differences in the overlap matrix: %s', bin2str(isIncludeSingleNeuriteDifferences));
        disp(strng);
        
        strng = sprintf('    19) Toggle inclusion of double neurite differences in the overlap matrix: %s', bin2str(isIncludeDoubleNeuriteDifferences));
        disp(strng);   
        
        strng = sprintf('    20) Toggle inclusion of across-EI (single/double) neurite differences: %s', bin2str(isIncludeAcrossEINeuriteDifferences));
        disp(strng);

        strng = sprintf('    21) Toggle inclusion of borderline calls in the overlap matrix: %s', bin2str(isIncludeBorderlineCalls));
        disp(strng);

        disp(' ');
        
        strng = sprintf('    22) Toggle all temporary (T) classes to active (N) classes : %s', bin2str(isTemporary2Active));
        disp(strng);

        strng = sprintf('    23) Toggle all unapproved merged (M) classes to active (N) classes : %s', bin2str(isMerged2Active));
        disp(strng);
        
        strng = sprintf('    24) Toggle all unapproved premerger (P) classes to active (N) classes : %s', bin2str(isPremerger2Active));
        disp(strng);
        
        strng = sprintf('    25) Toggle all unapproved suspended (S) classes to suspended (X) classes : %s', bin2str(isTemporary2Suspended));
        disp(strng);
        
        strng = sprintf('    26) Toggle all unvetted neurite locations to vetted : %s', bin2str(isUnvetted2Vetted));
        disp(strng);
        
        disp(' ');
        
        strng = sprintf('    27) Toggle all axo-axonic and basket special connections : %s', bin2str(isCijSpecialConnections));
        disp(strng);
        
        strng = sprintf('    28) Toggle all-in-1 display format : %s', bin2str(isAllIn1));
        disp(strng);
        
        strng = sprintf('    29) Toggle connectivity matrix row and column sums : %s', bin2str(isConnectivitySums));
        disp(strng);
        
        strng = sprintf('    30) Toggle connectivity matrix subregion row and column sums : %s', bin2str(isSubregionSums));
        disp(strng);
        
        strng = sprintf('    31) Toggle display of supertypes : %s', bin2str(isIncludeSupertypes));
        disp(strng);
        
        disp(' ');
        
        strng = sprintf('     B) Back to connectivity menu');
        disp(strng);
        
        disp('     !) Exit');
        
        
        %% process input %%
        
        reply = lower(input('\nYour selection: ', 's'));
        
        switch reply
            case 'm'
                %cells2overlap(cells);
                plot_Cij_matrix(CijFilledPercentage);
                reply = [];
                
            case 'd'
                plot_Cij_matrix_motifs_2();
                reply = [];
                
            case 'o'
                cells2overlap(cells);
                load overlap.mat
                axdeOverlap = sign(CijOverlap); % + sign(knownNegAxonLocations) + sign(knownNegDendriteLocations);
                nAxdeOverlapTotal = (size(CijOverlap,1)-1)*(size(CijOverlap,2)-1);%nAllCells*nOfficialParcellations;
                nAxdeOverlapFilled = sum(sum(sign(axdeOverlap(1:end-1,1:end-1))));
                axdeOverlapFilledPercentage = 100*nAxdeOverlapFilled/nAxdeOverlapTotal;
                
                if (isPlotRegionsSep)
                    DGstart = 1;
                    DGend = nCells(DG);
                    CA3start = DGend + 1;
                    CA3end = CA3start + nCells(CA3) - 1;
                    CA2start = CA3end + 1;
                    CA2end = CA2start + nCells(CA2) - 1;
                    CA1start = CA2end + 1;
                    CA1end = CA1start + nCells(CA1) - 1;
                    SUBstart = CA1end + 1;
                    SUBend = SUBstart + nCells(Sub) - 1;
                    ECstart = SUBend + 1;
                    ECend = ECstart + nCells(EC) - 1;
                    
                    plot_ADsquare(axdeOverlapFilledPercentage, DGstart, DGend, DG, isStrippedDown);
                    plot_ADsquare(axdeOverlapFilledPercentage, CA3start, CA3end, CA3, isStrippedDown);
                    plot_ADsquare(axdeOverlapFilledPercentage, CA2start, CA2end, CA2, isStrippedDown);
                    plot_ADsquare(axdeOverlapFilledPercentage, CA1start, CA1end, CA1, isStrippedDown);
                    plot_ADsquare(axdeOverlapFilledPercentage, SUBstart, SUBend, Sub, isStrippedDown);
                    plot_ADsquare(axdeOverlapFilledPercentage, ECstart, ECend, EC, isStrippedDown);

                    clf;
                    close all;
                    strng = sprintf('\nIndividual files saved for each subregion; press any key');
                    disp(strng);
                    pause
                    
                else % do not plot the regions separately
                    %                         plot_subpanels(axdeOverlapFilledPercentage, 1, nAllCells, ALL);
                    %                         plot_ADsquare_201204041048(axdeOverlapFilledPercentage, 1, nAllCells, ALL);
                    plot_ADsquare(axdeOverlapFilledPercentage, 1, nAllCells, ALL, isStrippedDown);
                     
                end % if (isPlotRegionsSep)

                reply = [];
                
            case 'c'
                cells2overlap(cells);
                plot_overlap_csv_matrix;
                reply = [];

            case 'r'
                plot_reduced_overlap_unix;
                reply = [];

            case 'h'
                plot_hippo(Cij, cells);
                reply = [];
                
            case 's'
                cells2overlap(cells);
                load overlap.mat
                isStrippedDown = 1;
%                 axdeOverlap = sign(CijOverlap); % + sign(knownNegAxonLocations) + sign(knownNegDendriteLocations);
%                 nAxdeOverlapTotal = (size(CijOverlap,1)-1)*(size(CijOverlap,2)-1);%nAllCells*nOfficialParcellations;
%                 nAxdeOverlapFilled = sum(sum(sign(axdeOverlap(1:end-1,1:end-1))));
                axdeOverlapFilledPercentage = 0;%100*nAxdeOverlapFilled/nAxdeOverlapTotal;
                
                plot_ADsquare(axdeOverlapFilledPercentage, 1, nAllCells, ALL, isStrippedDown);
                     
                reply = [];
                
            case 't'
                plot_periodic_table;
                reply = [];

            case '1'
                isIncludeKnownClassLinks = ~isIncludeKnownClassLinks;
                reply= [];           
                
            case '2'
                isIncludeKnownNegClassLinks = ~isIncludeKnownNegClassLinks;
                reply= [];

            case '3'
                isIncludeSomataLocations = ~isIncludeSomataLocations;
                reply= [];                
                
            case '3a'
                isIncludeAxonLocations = ~isIncludeAxonLocations;
                reply= [];                
                
            case '3b'
                isIncludeDendriteLocations = ~isIncludeDendriteLocations;
                reply= [];                
                
            case '4'
                isIncludeAxonSomaOverlap = ~isIncludeAxonSomaOverlap;
                reply= [];
                
            case '5'
                isIncludeKnownNegNeuriteLocations = ~isIncludeKnownNegNeuriteLocations;
                reply= [];
                
            case '6'
                isIncludeFlaggedDuplicates = ~isIncludeFlaggedDuplicates;
                reply= [];
                
            case '7'
                isPlotRegionsSep = ~isPlotRegionsSep;         
                reply = [];                
                           
            case '8'
                isIncludeVersionHeader = ~isIncludeVersionHeader;
                reply = [];

            case '9'
                isIncludeDateHeader = ~isIncludeDateHeader;
                reply = [];

            case '10'
                isIncludeNeuritesLegend = ~isIncludeNeuritesLegend;
                reply = [];

            case '11'
                isIncludeSingleReferenceLegend = ~isIncludeSingleReferenceLegend;
                reply = [];

            case '12'
                isIncludeGiorgioStats = ~isIncludeGiorgioStats;
%                 if (isIncludeKey == 1)
%                     isIncludeSingleNeuriteDifferences = 0;
%                 end
                reply= [];
                
            case '13'
                isIncludeFootnotesLegend = ~isIncludeFootnotesLegend;
                reply = [];

            case '14'
                isIncludeSomaParcelCounts = ~isIncludeSomaParcelCounts;
                if (isIncludeSomaParcelCounts == 1)
                    isIncludeSomataLocations = 1;
                end
                reply = [];

            case '15'
                isIncludeReferenceCounts = ~isIncludeReferenceCounts;                
                reply = [];

            case '16'
                isSortByAllRef = ~isSortByAllRef;
                isIncludeReferenceCounts = 1;
                isSortByMorphRef = 0;
                reply = [];
                
            case '17'
                isSortByMorphRef = ~isSortByMorphRef;
                isIncludeReferenceCounts = 1;
                isSortByAllRef = 0;                
                reply = [];
                
                
            case '18'
                isIncludeSingleNeuriteDifferences = ~isIncludeSingleNeuriteDifferences;
%                 if (isIncludeSingleNeuriteDifferences == 1)
%                     isIncludeKeyAndComments = 0;
%                 end
                reply= [];
                
            case '19'
                isIncludeDoubleNeuriteDifferences = ~ ...
                    isIncludeDoubleNeuriteDifferences;
%                 if (isIncludeDoubleNeuriteDifferences == 1)
%                     isIncludeKeyAndComments = 0;
%                 end
                reply = [];
 
            case '20'
                isIncludeAcrossEINeuriteDifferences = ~ ...
                    isIncludeAcrossEINeuriteDifferences;
%                 if (isIncludeAcrossEINeuriteDifferences == 1)
%                     isIncludeKeyAndComments = 0;
%                 end
                reply = [];                

            case '21'
                isIncludeBorderlineCalls = ~isIncludeBorderlineCalls;
                reply = [];

            case '22'
                isTemporary2Active = ~isTemporary2Active;
                reply = [];

            case '23'
                isMerged2Active = ~isMerged2Active;
                reply = [];

            case '24'
                isPremerger2Active = ~isPremerger2Active;
                reply = [];

            case '25'
                isTemporary2Suspended = ~isTemporary2Suspended;
                reply = []; 

            case '26'
                isUnvetted2Vetted = ~isUnvetted2Vetted;
                reply = []; 

            case '27'
                isCijSpecialConnections = ~isCijSpecialConnections;
                reply = [];

            case '28'
                isAllIn1 = ~isAllIn1;
                if isAllIn1
                    isIncludeKnownClassLinks = 0;
                    isIncludeKnownNegClassLinks = 0;
                    isIncludeAxonSomaOverlap = 0;
                    isIncludeSomataLocations = 0;
                    isIncludeKnownNegNeuriteLocations = 0;
                    isIncludeFlaggedDuplicates = 0;
                    isIncludeGiorgioStats = 0;
                    isIncludeSingleNeuriteDifferences = 0;
                    isIncludeDoubleNeuriteDifferences = 0;
                    isIncludeAcrossEINeuriteDifferences = 0;
                    isIncludeBorderlineCalls = 0;
                    isPlotRegionsSep = 0;
                    isIncludeVersionHeader = 0;
                    isIncludeDateHeader = 0;
                    isIncludeNeuritesLegend = 0;
                    isIncludeSingleReferenceLegend = 0;
                    isTemporary2Active = 0;
                    isMerged2Active = 0;
                    isPremerger2Active = 0;
                    isTemporary2Suspended = 0;
                    isIncludeFootnotesLegend = 0;
                    isCijSpecialConnections = 1;
                    isIncludeSomaParcelCounts = 0;
                    isUnvetted2Vetted = 1;
                    isIncludeReferenceCounts = 0;
                    isSortByAllRef = 0;
                    isSortByMorphRef = 0;
                    isIncludeSupertypes = 1;
                end
                reply = [];
                
            case '29'
                isConnectivitySums = ~isConnectivitySums;
                if isConnectivitySums
                    isSubregionSums = 0;
                end
                reply = [];

            case '30'
                isSubregionSums = ~isSubregionSums;
                if isSubregionSums
                    isConnectivitySums = 0;
                end
                reply = [];

            case '31'
                isIncludeSupertypes = ~isIncludeSupertypes;
                reply = [];

            case 'b'
                % exit

            case '!'
                % exit
                
            otherwise
                reply = [];
                
        end % switch
        
    end % while loop
    
end % menu_plot

