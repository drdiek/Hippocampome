function [areConverted] = cells2cij(csvFile)
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
                    
                elseif (isIgnoreReinterpretedActiveClasses) && (~isempty(zPos{1}))
                    % do nothing; ignore the reinterpreted (approved) active class
                    
                else
                    foundCells = foundCells + 1;
                    dendritesArray(foundCells) = rowLooper;
                end
                
                %pclFlag(foundCells) = strcmp(csvFile{rowLooper,pclFlagColNum},'1');

            end % if strcmpi(csvFile{rowLooper,axonOrDendriteColNum}, 'axons')

        end % if ~isempty(csvFile{rowLooper,cellIdColNum})

        rowLooper = rowLooper + 1;

    end % while foundCells < nAllCells

    cellIds = csvFile(axonsArray,cellIdColNum);
    cellUniqueIds = csvFile(axonsArray,uniqueIdColNum);
    cellLabels = csvFile(axonsArray,labelColNum);
    cellAbbrevs = csvFile(axonsArray,abbrevColNum);   
    cellADcodes = csvFile(axonsArray,AD_patternColNum);
    cellProjecting = csvFile(axonsArray,projectingColNum);
    cellSubregions = csvFile(axonsArray,subregionColNum);
    cellEorIs = csvFile(axonsArray, excitOrInhibColNum);
    cellAllInOneLabels = csvFile(axonsArray,allInOneColNum);
    
    for h = 1:nAllCells
        cellSubregionCode = str2double(cellIds{h}(1));
        cellADcode = deblank(cellADcodes{h});
        while length(cellADcode) < nParcels(cellSubregionCode)
            cellADcode = ['0', cellADcode]; %#ok<AGROW>
        end
        cellADcodes{h} = cellADcode;
    end
    
    
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
                    
                    ignoreA = 0;
                    % check if axon is in a PCL (in any region) and whether to ignore it
                    if strcmp(csvFile{parcelNamesRowNum,P},pclName.(fromRegion))
                        aInPCL = 1;

                        % check if regions are the same
                        if strcmp(fromRegion,csvFile{1,P})
                            %                        A_PCL_flag = str2double(csvFile{from,AD_pclFlagColNum});
                            A_PCL_flag = str2num(csvFile{from,AD_pclFlagColNum});

                            % ignore axon if flag is 0 OR 1 (and toggle off) OR
                            % 2 (and toggle off)
                            if ((A_PCL_flag == 0) || (A_PCL_flag == 1 && ~togglePCLcontinuing) || (A_PCL_flag == 2 && ~togglePCLterminating))
                                %ignoreA = 1;
                            end
                        end
                    else
                        aInPCL = 0;
                    end
                    
                    
                    % if ignoring, replace PCL A/D code with '_'
                    if ignoreA
                        %cellADcodes{iCell} = [cellADcodes{iCell}(1:length(cellADcodes{iCell})-2), '_', cellADcodes{iCell}(length(cellADcodes{iCell}))];
                    else
                        isAISLinkA = ~isempty(find(axonIds >= 5000000 & axonIds < 10000000, 1));% && ~isempty(find(axonIds < 10000000, 1)); % for axo-axonic cells
                        isPerisomaticLinkA = ~isempty(find(axonIds >= 10000000 & axonIds < 20000000, 1));
                        % for basket cells
                        
                        %                        cellPartialA(iCell,jCell) = ~isempty(find(axonIds ...
                        %                                         >= 20000000, 1))*;
                        if isAISLinkA
                            AIS = 1
                            pause
                        end
                        if isPerisomaticLinkA
                            Peri = 1
                            pause
                        end
                        
                        % loop over rows (looking at post-synaptic connections)
                        for jCell = 1:nAllCells % pst                            
                            to = dendritesArray(jCell); 
                            toRegion = csvFile(to,subregionColNum);
                            toRegion = toRegion{1};

                            % consider connection to soma
                            % is the from axon in a principal cell layer?
                            if aInPCL
                                % is the 'to' soma in the principal cell
                                % layer?
                                if (strcmp(csvFile{to,pclFlagColNum},'1'))
                                    % are the to soma and the current principal cell layer in the same region? 
                                    if (strcmp(csvFile{to,cellIdColNum}(1), csvFile{layerIdRowNum,P}(2)))
                                        CijAxonSomaOverlap(iCell,jCell) = 10;

                                        D_PC_flag = str2double(csvFile{to,pcFlagColNum});

                                        if isAISLinkA && D_PC_flag %axo-axonic     
                                            cellIds(jCell)
                                            cellLabels(jCell)
                                            pause
                                            
                                            Cij(iCell,jCell) = synapseSgn;
                                            CijSpecialConnections(iCell,jCell) = 2;
                                        elseif isPerisomaticLinkA && D_PC_flag %basket
                                            Cij(iCell,jCell) = synapseSgn;
                                            CijSpecialConnections(iCell,jCell) = 3;
                                        end % if isPerisomaticLinkA

                                    end % if (strcmp(csvFile{to,pclFlagColNum},'1'))
                                end % if (strcmp(csvFile{to,pclFlagColNum},'1'))
                            end % if ((strcmp(csvFile{parcelNamesRowNum,P},pclName.DG))  || ...

                            % consider connection to dendrites

                            % if pst at current row and P (parcellation) column is
                            % NOT empty, enter this connection into Cij and mark as
                            % inhibitory or excitatory
                            if ~isempty(csvFile{to,P}) && ~isPerisomaticLinkA && ~isAISLinkA
                                dendriteIdsString = csvFile{to,P};
                                [dendriteIds, negDendriteIds, nNegDendriteIds, ...
                                    nNegDendriteIdsClassLinks, nNegDendriteIdsNeuriteLocations, areMixedNeuriteIds, isUnvettedDendrite] = find_negs(dendriteIdsString);

                                if (isUnvettedAxon || isUnvettedDendrite)
                                    
                                    isUnvetted(iCell,jCell) = 1;
                                    
                                end
                                
                                if (nNegDendriteIdsNeuriteLocations == 0)
                                    
                                    ignoreD = 0;                    
                                    % check if dendrite is in a PCL (in any subregion) and whether to ignore it
                                    if strcmp(csvFile{parcelNamesRowNum,P},pclName.(toRegion))
                                        dInPCL = 1;
                                        
                                        % check if regions are the same
                                        if strcmp(toRegion,csvFile{1,P})
                                            D_PCL_flag = str2double(csvFile{to,AD_pclFlagColNum});
                                            
                                            % ignore dendrite if flag is 0, 1 (and toggle off), 2 (and toggle off)
                                            if ((D_PCL_flag == 0) || (D_PCL_flag == 1 && ~togglePCLcontinuing) || (D_PCL_flag == 2 && ~togglePCLterminating))
                                                %ignoreD = 1;
                                            end
                                        end
                                    else
                                        dInPCL = 0;
                                    end


                                    
                                    % if ignoring, replace PCL A/D code with '_'
                                    if ignoreD
                                        %cellADcodes{jCell} = [cellADcodes{jCell}(1:length(cellADcodes{jCell})-2), '_', cellADcodes{jCell}(length(cellADcodes{jCell}))];
                                    
                                    else
                                        % flag those connections that ONLY occur in the PCL
                                        
                              
                                        
                                        % if ~ignoreD && not a perisomatic region connection
                                        if ((CijSpecialConnections(iCell,jCell) ~= 2) && (CijSpecialConnections(iCell,jCell) ~= 3))
                                            if ~dInPCL
                                                CijSpecialConnections(iCell,jCell) = 0;
                                            elseif (dInPCL && (Cij(iCell,jCell) == 0))
                                                CijSpecialConnections(iCell,jCell) = 4;
                                            end
                                            Cij(iCell,jCell) = synapseSgn;
                                        end
                                          

                                        isKnownAxonClassLinks = ~isempty(find(axonIds >= 1000000, 1)) && ~isempty(find(axonIds < 5000000, 1)); 
                                        isKnownDendriteClassLinks = ~isempty(find(dendriteIds >= 1000000, 1)) && ~isempty(find(dendriteIds < 5000000, 1));

                                        %                                        cellPartialD(iCell,jCell) = ...
                                        ~isempty(find(dendriteIds >= 20000000, 1));

                                        % at least one reference ID > 1000000
                                        if isKnownAxonClassLinks && isKnownDendriteClassLinks
                                            for i = 1:length(axonIds)
                                                if find(dendriteIds == axonIds(i))
                                                    CijKnownClassLinks(iCell,jCell) = 1;
                                                end
                                            end % for i
                                        end % if isKnownDendriteClassLinks

                                        if ((nNegAxonIdsClassLinks > 0) && (nNegDendriteIdsClassLinks > 0))
                                            for i = 1:length(axonIds)                                  
                                                if find(dendriteIds == axonIds(i))
                                                    if (axonIds(i) < -1000000)
                                                        CijKnownNegClassLinks(iCell,jCell) = 1;
                                                    end % if (axonIds(i) < -1000000)
                                                end % if find(dendriteIds == axonIds(i))
                                            end % for i
                                        end % if ((nNegAxonIdsClassLinks > 0) & (nNegDendriteIdsClassLinks > 0))

                                    end % ignoreD
                                    

                                    
                                end % if (nNegDendriteIdsNeuriteLocations == 0)
                            end % if ~isempty(csvFile{to,P})

                        end % jCell loop
                    end % if ~ignoreA && nNegAxon...
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

    
    
    %% load known connectivity file %%
    fileName = 'Connectivity exceptions.xlsx';
    fileFid = fopen(fileName, 'r');

    if (fileFid == -1)
        disp(' ');
        disp('****Connectivity Exceptions file not found.  Proceeding.');
        pause
        isFileLoaded = 0;
        KCdata = zeros(1,3);

    else
        status = fclose(fileFid);
        
        [num, txt, raw] = xlsread(fileName);
        num(:,5) = [];
        num(:,2:3) = [];
        KCdata = num;
        
        cellUniqueIds = str2double(cellUniqueIds);
        
        CijKnownClassLinks = zeros(nAllCells,nAllCells);
        CijKnownNegClassLinks = zeros(nAllCells,nAllCells);

        for i=1:size(KCdata,1)
            if ~isnan(KCdata(i,1)) && ~isnan(KCdata(i,2))
                fromPos = find(cellUniqueIds == KCdata(i,1));
                toPos = find(cellUniqueIds == KCdata(i,2));

                if KCdata(i,3) == 1
                    CijKnownClassLinks(fromPos,toPos) = 1;
                elseif KCdata(i,3) == 0
                    CijKnownNegClassLinks(fromPos,toPos) = 1;
                end
            end
        end
                
        isFileLoaded = 1;

    end % if (fileFid == -1)
    

    areConverted = 1;        
    

    save 'status.mat' status

    save 'Cij.mat' Cij CijNonZero CijUndirected CijSpecialConnections ...
        cellIds cellUniqueIds cellLabels cellAbbrevs cellADcodes cellProjecting cellSubregions ...
        cellEorIs cellAllInOneLabels...
        axonsArray ...
        dendritesArray nAllCells nCells ALL DG CA3 CA2 CA1 SUB EC isSingleRef isUnvettedAxon isUnvettedDendrite

    save 'CellCounts.mat' nInhib nExcit nInhibEdges nExcitEdges nSelfEdges nInhibSelfEdges nExcitSelfEdges nEEedges nIIedges
    
    save 'CijKnownClassLinks.mat' CijKnownClassLinks
    save 'CijKnownNegClassLinks.mat' CijKnownNegClassLinks
    save 'CijAxonSomaOverlap.mat' CijAxonSomaOverlap
    save 'notes.mat' notes notesUnique notesCount notesStrings

end % cells2cij
