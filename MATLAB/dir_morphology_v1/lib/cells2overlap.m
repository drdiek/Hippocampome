function cells2overlap(csvFile)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    fprintf(1, '\nConverting to overlap...')

    load Cij.mat axonsArray dendritesArray somataArray
    load parcellation.mat
    load isInclude.mat
    load notes.mat
    load connectivityToggles
    
    cellEorI = csvFile(axonsArray,excitOrInhibColNum);
    
    cellProjecting = csvFile(axonsArray,projectingColNum);
    
    % add 1 to each dimension to enable use of pcolor function
    % (these elements will not be filled or plotted)
    CijOverlap = zeros(nOfficialParcellations+1, nAllCells+1);
    CijAxonSomaOverlap = zeros(nOfficialParcellations+1, nAllCells+1);
    somataLocations = zeros(nOfficialParcellations+1, nAllCells+1);
    knownNegAxonLocations = zeros(nOfficialParcellations+1, nAllCells+1);
    knownNegDendriteLocations = zeros(nOfficialParcellations+1, nAllCells+1);
    knownMixedAxonLocations = zeros(nOfficialParcellations+1, nAllCells+1);
    knownMixedDendriteLocations = zeros(nOfficialParcellations+1, nAllCells+1);
    borderlineCallsLocations = zeros(nOfficialParcellations+1, nAllCells+1);
    
    isUnvettedAxon = zeros(nAllCells+1);
    isUnvettedDendrite = zeros(nAllCells+1);
    isUnvettedNeurite = 0;
    
    subregionNames = cell(nParcellations);
    layerNames = cell(nParcellations);
    isCellProjecting = zeros(nAllCells);
%     cellSubregions = cell(nAllCells);    
    
    % loop over rows (cell types)   
    for iCell = 1:nAllCells         

        axonRow = axonsArray(iCell);
        dendriteRow = dendritesArray(iCell);
        somaRow = somataArray(iCell);

        isCellProjecting(iCell) = strcmpi(cellProjecting(iCell),'p');

        if strcmpi(csvFile(axonRow,cellIdColNum),csvFile(dendriteRow,cellIdColNum))
            CijOFFICIALColCounter = nOfficialParcellations+1;
            
            % loop over columns (parcellations)            
            for P = (1:nParcellations) + colSkip;
                
                % ensure it's an official parcellation
                
                CijOFFICIALColCounter = CijOFFICIALColCounter - 1;
                
                subregionNames(CijOFFICIALColCounter) = cellstr(csvFile{subregionNamesRowNum,P});
                layerNames(CijOFFICIALColCounter) = cellstr(csvFile{parcelNamesRowNum,P});
                
                % store axons as 1, dendrites as 2, both as 3
                if ~isempty(csvFile{axonRow,P})
                    aRegion = csvFile(axonRow,subregionColNum);
                    aRegion = aRegion{1};
                    
                    cellSubregions{iCell} = aRegion;
                    
                    axonIdsString = csvFile{axonRow,P};
                    
                    % check if axon is in PCL
                    ignoreA = 0;
                    if strcmp(csvFile{parcelNamesRowNum,P},pclName.(aRegion))
                        
                        if strcmp(aRegion,csvFile{1,P})
                            A_PCL_flag = str2double(csvFile{axonRow,AD_pclFlagColNum});
                            
                            % ignore axon if flag is 0 OR 1 (and toggle off) OR 2 (and toggle off)
                            if (A_PCL_flag == 0) || (A_PCL_flag == 1 && ~togglePCLcontinuing) || (A_PCL_flag == 2 && ~togglePCLterminating)
                                ignoreA = 1;
                            end
                        end
                    end
                    
                    [axonIds, negAxonIds, nNegAxonIds, ...
                        nNegAxonIdsClassLinks, nNegAxonIdsNeuriteLocations, areMixedNeuriteIds, isUnvettedAxon(iCell)] = find_negs(axonIdsString);
                    
                    if (areMixedNeuriteIds) && ~ignoreA
                        knownMixedAxonLocations(CijOFFICIALColCounter, iCell) = 1;
                    end
                    
                    if (nNegAxonIdsNeuriteLocations == 0) && ~ignoreA
                        CijOverlap(CijOFFICIALColCounter, iCell) = CijOverlap(CijOFFICIALColCounter, iCell) + 1;
                    elseif (nNegAxonIdsNeuriteLocations ~= 0) && ~ignoreA
                        knownNegAxonLocations(CijOFFICIALColCounter, iCell) = 1;
                    end
                    
                    [refIds, nBorderlineCalls, areBorderlineCalls] ...
                        = find_borderline_calls(axonIdsString);
                    
                    if (areBorderlineCalls && ~ignoreA && isIncludeBorderlineCalls)
                        borderlineCallsLocations(CijOFFICIALColCounter, ...
                            iCell) = ...
                            borderlineCallsLocations(CijOFFICIALColCounter, iCell) + 1;
                        CijOverlap(CijOFFICIALColCounter, iCell) ...
                            = CijOverlap(CijOFFICIALColCounter, ...
                            iCell) - 1;
                    end
                    
                    if isUnvettedAxon(iCell)
                        CijOverlap(CijOFFICIALColCounter, iCell) = CijOverlap(CijOFFICIALColCounter, iCell) + 3;
                        isUnvettedNeurite = 1;
                    end
                
                end% if ~isempty(csvFile{axonRow,P})
                
                
                if ~isempty(csvFile{dendriteRow,P})
                    dRegion = csvFile(dendriteRow,subregionColNum);
                    dRegion = dRegion{1};
                    ignoreD = 0;
                    
                    % check if dendrite is in PCL
                    if (strcmp(csvFile{parcelNamesRowNum,P},pclName.(dRegion)))
                        
                        if strcmp(dRegion,csvFile{1,P})
                            D_PCL_flag = str2double(csvFile{dendriteRow,AD_pclFlagColNum});
                            
                            % ignore dendrite if flag is 0, 1 (and toggle off), 2 (and toggle off)
                            if (D_PCL_flag == 0) || (D_PCL_flag == 1 && ~togglePCLcontinuing) || (D_PCL_flag == 2 && ~togglePCLterminating)
                                ignoreD = 1;
                            end
                        end
                    end
                    
                    dendriteIdsString = csvFile{dendriteRow,P};
                    
                    [dendriteIds, negDendriteIds, nNegDendriteIds, ...
                        nNegDendriteIdsClassLinks, nNegDendriteIdsNeuriteLocations, areMixedNeuriteIds, isUnvettedDendrite(iCell)] = find_negs(dendriteIdsString);
                    
                    if (areMixedNeuriteIds) && ~ignoreD
                        knownMixedDendriteLocations(CijOFFICIALColCounter, iCell) = 1;
                    end
                    
                    if (nNegDendriteIdsNeuriteLocations == 0) && ~ignoreD
                        CijOverlap(CijOFFICIALColCounter, iCell) = CijOverlap(CijOFFICIALColCounter, iCell) + 2;
                    elseif (nNegDendriteIdsNeuriteLocations ~= 0) && ~ignoreD
                        knownNegDendriteLocations(CijOFFICIALColCounter, iCell) = 1;
                    end
                    
                    [refIds, nBorderlineCalls, areBorderlineCalls] ...
                        = ...
                        find_borderline_calls(dendriteIdsString);
                    
                    if (areBorderlineCalls && ~ignoreD && isIncludeBorderlineCalls)
                        borderlineCallsLocations(CijOFFICIALColCounter, ...
                            iCell) = ...
                            borderlineCallsLocations(CijOFFICIALColCounter, iCell) + 2;
                        CijOverlap(CijOFFICIALColCounter, iCell) ...
                            = CijOverlap(CijOFFICIALColCounter, iCell) - 2;
                    end
                    
                    if isUnvettedDendrite(iCell)
                        CijOverlap(CijOFFICIALColCounter, iCell) = CijOverlap(CijOFFICIALColCounter, iCell) + 3;
                        isUnvettedNeurite = 1;
                    end
                
                end % if ~isempty(csvFile{dendriteRow,P})
                

                if ~isempty(csvFile{somaRow,P})
                    
                    somataLocations(CijOFFICIALColCounter, iCell) = 1;
                
                end % if ~isempty(csvFile{somaRow,P})
                

                if (strcmp(csvFile{axonRow,pclFlagColNum},'1') && ...
                        ((strcmp(csvFile{parcelNamesRowNum,P},pclName.DG)) || ...
                        (strcmp(csvFile{parcelNamesRowNum,P},pclName.CA3)) || ...
                        (strcmp(csvFile{parcelNamesRowNum,P},pclName.CA2)) || ...
                        (strcmp(csvFile{parcelNamesRowNum,P},pclName.CA1)) || ...
                        (strcmp(csvFile{parcelNamesRowNum,P},pclName.Sub))))
                    
                    if (strcmp(csvFile{axonRow,cellIdColNum}(1), csvFile{layerIdRowNum,P}(1)))
                        CijAxonSomaOverlap(CijOFFICIALColCounter, iCell) = 1;
                    end
%                 else
%                     if (strcmp(csvFile{axonRow,pclFlagColNum},'0'))
%                         % do nothing
%                     else
%                         if (strcmp(csvFile{parcelNamesRowNum,P},pclName.DG))
%                             somaLocation = csvFile{axonRow,pclFlagColNum};
%                             % somaLocation = somaLocation(end:-1:1);
%                             
%                             location = 0;
%                             
%                             for iDigit = 1:length(somaLocation)
%                                 location = location + str2num(somaLocation(iDigit))*(2^(iDigit-1));
%                                 
%                                 if strcmp(somaLocation(iDigit),'1')
%                                     somataLocations(nOfficialParcellations+1-iDigit, iCell) = 1;
%                                 end
%                             end % for iDigit
%                             
%                             % somataLocations(CijOFFICIALColCounter, iCell) = location;
%                             
%                         end % if (strcmp(csvFile{parcelNamesRowNum,P},pclName.DG))
%                         
%                     end % if (strcmp(csvFile{axonRow,pclFlagColNum},'0'))
                    
                end % if (strcmp(csvFile{axonRow,pclFlagColNum},'1') && ...
                
            end % P loop
            
        end % if axonArray ID = dendritesArray iD
        
    end % iCell loop

    save overlap.mat axonsArray dendritesArray cellEorI CijOverlap ...
        CijAxonSomaOverlap knownNegAxonLocations knownNegDendriteLocations ...
        layerNames subregionNames somataLocations cellSubregions knownMixedAxonLocations ...
        knownMixedDendriteLocations borderlineCallsLocations isCellProjecting isUnvettedNeurite

    
end % cells2overlap

