function [areConverted] = cells2cij_stripped_down(csvFile)
% hippocampome network graphics analysis
% 200904122120 David J. Halimton
%
% adapted from R to MATLAB 20090504 Diek W. Wheeler

    fprintf(1, '\nConverting cells to Cij...')

    % retrieve parcellation data (manually stored in
    % current_parcellation_data)
    load parcellation.mat
    load connectivityToggles

    areConverted = 0;

    % initialize arrays & Cij matrix
    axonsArray = zeros(1,nAllCells);
    dendritesArray = zeros(1,nAllCells);
    somataArray = zeros(1,nAllCells);
    Cij = zeros(nAllCells, nAllCells);
    CijKnownClassLinks = zeros(nAllCells, nAllCells);
    CijKnownNegClassLinks = zeros(nAllCells, nAllCells);
    CijAxonSomaOverlap = zeros(nAllCells, nAllCells);
    CijKnownNegNeuriteLocations = zeros(nAllCells, nAllCells);
    CijSpecialConnections = zeros(nAllCells, nAllCells);
    %CijPartialA = zeros(nAllCells, nAllCells);
    %CijPartialD = zeros(nAllCells, nAllCells);

    notes = zeros(1,nAllCells);
    notesUnique = zeros(1,nAllCells);
    notesCount = 0;
    notesStrings = '';

    isSingleRef = zeros(1,nAllCells);

    foundCells = 0;
    rowLooper = rowSkip + 1;

    % loop over rows in csvFile to find all official cell types and add 
    % that cell's row number to the appropriate list: axons or dendrites
    while foundCells < nAllCells      

        % determine if row is axon or dendrite
        if ~isempty(csvFile{rowLooper,cellIdColNum})     

            if strcmpi(csvFile{rowLooper,axonOrDendriteColNum}, 'axons')
                nPos = strfind(csvFile(rowLooper,cellStatusColNum), 'N');
                vPos = strfind(csvFile(rowLooper,cellStatusColNum), 'V');
                xPos = strfind(csvFile(rowLooper,cellStatusColNum), 'X');
                tPos = strfind(csvFile(rowLooper,cellStatusColNum), 'T');
                sPos = strfind(csvFile(rowLooper,cellStatusColNum), 'S');
                pPos = strfind(csvFile(rowLooper,cellStatusColNum), 'P');
                mPos = strfind(csvFile(rowLooper,cellStatusColNum), 'M');
                oPos = strfind(csvFile(rowLooper,cellStatusColNum), 'O');
                wPos = strfind(csvFile(rowLooper,cellStatusColNum), 'W');
                qPos = strfind(csvFile(rowLooper,cellStatusColNum), 'Q');
                yPos = strfind(csvFile(rowLooper,cellStatusColNum), 'Y');
                zPos = strfind(csvFile(rowLooper,cellStatusColNum), 'Z');

                if (~isIncludeApprovedClasses) && (~isempty(nPos{1}))
                    % do nothing; ignore the approved class

                elseif (~isIncludeVirtualClasses) && (~isempty(vPos{1}))
                    % do nothing; ignore the virtual class
                    
                elseif (~isIncludeSuspendedClasses) && (~isempty(xPos{1}))
                    % do nothing; ignore the suspended class
                    
                elseif (~isIncludeTempUnapprovedActiveClasses) && (~isempty(tPos{1}))
                    % do nothing; ignore the temporary (un-approved) active class
                    
                elseif (~isIncludeTempUnapprovedSuspendedClasses) && (~isempty(sPos{1}))
                    % do nothing; ignore the temporary (un-approved) suspended class
                    
                elseif (~isIncludePremergerActiveClasses) && (~isempty(pPos{1}))
                    % do nothing; ignore the premerger (un-approved) active class
                    
                elseif (~isIncludeMergedActiveClasses) && (~isempty(mPos{1}))
                    % do nothing; ignore the merged (un-approved) active class
                    
                elseif (~isIncludeDisappearingActiveClasses) && (~isempty(oPos{1}))
                    % do nothing; ignore the disappearing active class
                    
                elseif (~isIncludeSwitching1p0OnHoldClasses) && (~isempty(wPos{1}))
                    % do nothing; ignore the disappearing active class
                    
                elseif (~isIncludeSwitching2p0OnHoldClasses) && (~isempty(qPos{1}))
                    % do nothing; ignore the disappearing active class
                    
                elseif (~isInclude2p0ApprovedOnHoldClasses) && (~isempty(yPos{1}))
                    % do nothing; ignore the disappearing active class
                    
                elseif (isIgnoreReinterpretedActiveClasses) && (~isempty(zPos{1}))
                    % do nothing; ignore the reinterpreted (approved) active class
                    
                else

                    axonsArray(foundCells+1) = rowLooper;
                    if ~isempty(csvFile{rowLooper,notesColNum})                   
                        %                    number = str2num(csvFile{rowLooper,notesColNum}); %#ok<ST2NM>
                        number = str2num(csvFile{rowLooper,notesColNum+1}); %#ok<ST2NM>
                        notes(foundCells+1) = number;
                        if find(notesUnique == number)
                            notesUnique(foundCells+1) = -1;
                        else
                            notesUnique(foundCells+1) = number;
                            notesCount = notesCount + 1;
                            %                        notesStrings{notesCount} = csvFile{rowLooper,notesColNum-1};
                            notesStrings{notesCount} = csvFile{rowLooper,notesColNum};
                        end
                    else
                        notes(foundCells+1) = -1;
                        notesUnique(foundCells+1) = -1;
                    end
                end
                    
            elseif strcmpi(csvFile{rowLooper, axonOrDendriteColNum},'dendrites')
                nPos = strfind(csvFile(rowLooper,cellStatusColNum), 'N');
                vPos = strfind(csvFile(rowLooper,cellStatusColNum), 'V');
                xPos = strfind(csvFile(rowLooper,cellStatusColNum), 'X');
                tPos = strfind(csvFile(rowLooper,cellStatusColNum), 'T');
                sPos = strfind(csvFile(rowLooper,cellStatusColNum), 'S');
                pPos = strfind(csvFile(rowLooper,cellStatusColNum), 'P');
                mPos = strfind(csvFile(rowLooper,cellStatusColNum), 'M');
                oPos = strfind(csvFile(rowLooper,cellStatusColNum), 'O');
                wPos = strfind(csvFile(rowLooper,cellStatusColNum), 'W');
                qPos = strfind(csvFile(rowLooper,cellStatusColNum), 'Q');
                yPos = strfind(csvFile(rowLooper,cellStatusColNum), 'Y');
                zPos = strfind(csvFile(rowLooper,cellStatusColNum), 'Z');

                if (~isIncludeApprovedClasses) && (~isempty(nPos{1}))
                    % do nothing; ignore the approved class

                elseif (~isIncludeVirtualClasses) && (~isempty(vPos{1}))
                    % do nothing; ignore the virtual class
                    
                elseif (~isIncludeSuspendedClasses) && (~isempty(xPos{1}))
                    % do nothing; ignore the suspended class

                elseif (~isIncludeTempUnapprovedActiveClasses) && (~isempty(tPos{1}))
                    % do nothing; ignore the temporary
                    % (un-approved) active class
                    
                elseif (~isIncludeTempUnapprovedSuspendedClasses) && (~isempty(sPos{1}))
                    % do nothing; ignore the temporary
                    % (un-approved) suspended class
                    
                elseif (~isIncludePremergerActiveClasses) && (~isempty(pPos{1}))
                    % do nothing; ignore the premerger (un-approved) active class
                    
                elseif (~isIncludeMergedActiveClasses) && (~isempty(mPos{1}))
                    % do nothing; ignore the merged (un-approved) active class
                    
                elseif (~isIncludeDisappearingActiveClasses) && (~isempty(oPos{1}))
                    % do nothing; ignore the disappearing active class
                    
                elseif (~isIncludeSwitching1p0OnHoldClasses) && (~isempty(wPos{1}))
                    % do nothing; ignore the disappearing active class
                    
                elseif (~isIncludeSwitching2p0OnHoldClasses) && (~isempty(qPos{1}))
                    % do nothing; ignore the disappearing active class
                    
                elseif (~isInclude2p0ApprovedOnHoldClasses) && (~isempty(yPos{1}))
                    % do nothing; ignore the disappearing active class
                    
                elseif (isIgnoreReinterpretedActiveClasses) && (~isempty(zPos{1}))
                    % do nothing; ignore the reinterpreted (approved) active class
                    
                else
                    dendritesArray(foundCells+1) = rowLooper;
                end
                
                %pclFlag(foundCells) = strcmp(csvFile{rowLooper,pclFlagColNum},'1');

            elseif strcmpi(csvFile{rowLooper, axonOrDendriteColNum},'somata')
                nPos = strfind(csvFile(rowLooper,cellStatusColNum), 'N');
                vPos = strfind(csvFile(rowLooper,cellStatusColNum), 'V');
                xPos = strfind(csvFile(rowLooper,cellStatusColNum), 'X');
                tPos = strfind(csvFile(rowLooper,cellStatusColNum), 'T');
                sPos = strfind(csvFile(rowLooper,cellStatusColNum), 'S');
                pPos = strfind(csvFile(rowLooper,cellStatusColNum), 'P');
                mPos = strfind(csvFile(rowLooper,cellStatusColNum), 'M');
                oPos = strfind(csvFile(rowLooper,cellStatusColNum), 'O');
                wPos = strfind(csvFile(rowLooper,cellStatusColNum), 'W');
                qPos = strfind(csvFile(rowLooper,cellStatusColNum), 'Q');
                yPos = strfind(csvFile(rowLooper,cellStatusColNum), 'Y');
                zPos = strfind(csvFile(rowLooper,cellStatusColNum), 'Z');

                if (~isIncludeApprovedClasses) && (~isempty(nPos{1}))
                    % do nothing; ignore the approved class

                elseif (~isIncludeVirtualClasses) && (~isempty(vPos{1}))
                    % do nothing; ignore the virtual class
                    
                elseif (~isIncludeSuspendedClasses) && (~isempty(xPos{1}))
                    % do nothing; ignore the suspended class

                elseif (~isIncludeTempUnapprovedActiveClasses) && (~isempty(tPos{1}))
                    % do nothing; ignore the temporary
                    % (un-approved) active class
                    
                elseif (~isIncludeTempUnapprovedSuspendedClasses) && (~isempty(sPos{1}))
                    % do nothing; ignore the temporary
                    % (un-approved) suspended class
                    
                elseif (~isIncludePremergerActiveClasses) && (~isempty(pPos{1}))
                    % do nothing; ignore the premerger (un-approved) active class
                    
                elseif (~isIncludeMergedActiveClasses) && (~isempty(mPos{1}))
                    % do nothing; ignore the merged (un-approved) active class
                    
                elseif (~isIncludeDisappearingActiveClasses) && (~isempty(oPos{1}))
                    % do nothing; ignore the disappearing active class
                    
                elseif (~isIncludeSwitching1p0OnHoldClasses) && (~isempty(wPos{1}))
                    % do nothing; ignore the disappearing active class
                    
                elseif (~isIncludeSwitching2p0OnHoldClasses) && (~isempty(qPos{1}))
                    % do nothing; ignore the disappearing active class
                    
                elseif (~isInclude2p0ApprovedOnHoldClasses) && (~isempty(yPos{1}))
                    % do nothing; ignore the disappearing active class
                    
                elseif (isIgnoreReinterpretedActiveClasses) && (~isempty(zPos{1}))
                    % do nothing; ignore the reinterpreted (approved) active class
                    
                else
                    foundCells = foundCells + 1;
                    somataArray(foundCells) = rowLooper;
                end
                
                %pclFlag(foundCells) = strcmp(csvFile{rowLooper,pclFlagColNum},'1');

            end % if strcmpi(csvFile{rowLooper,axonOrDendriteColNum}, 'axons')

        end % if ~isempty(csvFile{rowLooper,cellIdColNum})

        rowLooper = rowLooper + 1;

    end % while foundCells < nAllCells

    cellIds = csvFile(axonsArray,cellIdColNum);
%     cellLabels = csvFile(axonsArray,allInOneColNum);
    cellLabels = csvFile(axonsArray,labelColNum);
%     cellAbbrevs = csvFile(axonsArray,allInOneColNum);   
    cellAbbrevs = csvFile(axonsArray,abbrevColNum);   
    cellADcodes = csvFile(axonsArray,AD_patternColNum);
    cellSubregions = csvFile(axonsArray,subregionColNum);
    cellEorIs = csvFile(axonsArray, excitOrInhibColNum);
%     cellAllInOneLabels = csvFile(axonsArray,allInOneColNum);
    cellAllInOneLabels = csvFile(axonsArray,labelColNum);
    cellProjecting = csvFile(axonsArray,projectingColNum);
    cellUniqueIds = csvFile(axonsArray,uniqueIdColNum);
    cellSupertypes = csvFile(axonsArray,supertypeColNum);
    
    for h = 1:nAllCells
        cellSubregionCode = str2double(cellIds{h}(1));
        cellADcode = deblank(cellADcodes{h});
        while length(cellADcode) < nParcels(cellSubregionCode)
            cellADcode = ['0', cellADcode]; %#ok<AGROW>
        end
        cellADcodes{h} = cellADcode;
    end
    
    status = zeros(nAllCells);
    % loop over rows (looking at axons)
    for iCell = 1:nAllCells    
        from = axonsArray(iCell);
        fromRegion = csvFile(from,subregionColNum);
        fromRegion = fromRegion{1};
        synapseSgn = strcmpi(csvFile{from,excitOrInhibColNum},'E')*2 - 1;

        %        status(iCell) = (strcmp(csvFile{from,statusColNum},'1.5') | strcmp(csvFile{from,statusColNum},'2'));
        status(iCell) = str2double(csvFile{from,statusColNum});
        
        isSingleRef(iCell) = str2double(csvFile{from,singleRefColNum});
        
        % loop over columns (parcellations)
        for P = (1:nParcellations) + colSkip
            
            % if matrix cell is not empty, determine whether it is
            % inhibitory (-1) or excitatory (1)
            if ~isempty(csvFile{from,P})
                axonIdsString = csvFile{from,P};               
                [axonIds, negAxonIds, nNegAxonIds, nNegAxonIdsClassLinks, ...
                    nNegAxonIdsNeuriteLocations, areMixedNeuriteIds, isUnvettedAxon] = find_negs(axonIdsString);
                
                if (nNegAxonIdsNeuriteLocations == 0)
                    
                    % loop over rows (looking at post-synaptic connections)
                    for jCell = 1:nAllCells % pst
                        
                        to = dendritesArray(jCell);
                        
                        % consider connection to dendrites
                        
                        % if pst at current row and P (parcellation) column is
                        % NOT empty, enter this connection into Cij and mark as
                        % inhibitory or excitatory
                        if ~isempty(csvFile{to,P})
                            
                            dendriteIdsString = csvFile{to,P};
                            [dendriteIds, negDendriteIds, nNegDendriteIds, ...
                                nNegDendriteIdsClassLinks, nNegDendriteIdsNeuriteLocations, areMixedNeuriteIds, isUnvettedDendrite] = find_negs(dendriteIdsString);
                            
                            if (nNegDendriteIdsNeuriteLocations == 0)
                                Cij(iCell,jCell) = synapseSgn;
                            end % if (nNegDendriteIdsNeuriteLocations == 0)
                            
                        end % if ~isempty(csvFile{to,P})
                        
                    end % jCell loop
                    
                end % if nNegAxonIdsNeuriteLocations == 0
                
            end % if ~isempty(csvFile{from,P})
            
        end % P loop  
        
    end % iCell loop
        
    CijNonZero = double(Cij~=0);
    CijUndirected = double(Cij+Cij' > 0);    
    
    nInhibSelfEdges = length(find(diag(Cij)<0));
    nExcitSelfEdges = length(find(diag(Cij)>0));
    nSelfEdges = nInhibSelfEdges + nExcitSelfEdges;
    nInhibEdges = length(find(Cij<0));
    nExcitEdges = length(find(Cij>0));

    nIIedges = 0;
    nEEedges = 0;
    
    rowSums = sum(Cij,2);

    nInhib = length(find(rowSums < 0));
    nExcit = length(find(rowSums > 0));

    for i=1:length(Cij)
        for j=1:length(Cij)
            if (Cij(i,j) < 0) && (rowSums(j) < 0)
                nIIedges = nIIedges + 1;
            elseif (Cij(i,j) > 0) && (rowSums(j) > 0)
                nEEedges = nEEedges + 1;
            end
        end
    end

    areConverted = 1;
    
    save 'status.mat' status

    save 'Cij.mat' Cij CijNonZero CijUndirected CijSpecialConnections ...
        cellIds cellLabels cellAbbrevs cellADcodes cellSubregions ...
        cellEorIs cellAllInOneLabels cellSupertypes...
        axonsArray ...
        dendritesArray somataArray nAllCells nCells ALL DG CA3 CA2 CA1 Sub EC isSingleRef cellUniqueIds cellProjecting

    save 'CellCounts.mat' nInhib nExcit nInhibEdges nExcitEdges nSelfEdges nInhibSelfEdges nExcitSelfEdges nEEedges nIIedges
    
    save 'CijKnownClassLinks.mat' CijKnownClassLinks
    save 'CijKnownNegClassLinks.mat' CijKnownNegClassLinks
    save 'CijAxonSomaOverlap.mat' CijAxonSomaOverlap
    save 'notes.mat' notes notesUnique notesCount notesStrings

end % cells2cij
