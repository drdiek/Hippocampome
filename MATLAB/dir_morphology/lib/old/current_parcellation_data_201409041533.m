function current_parcellation_data(csvFile)
load 'connectivityToggles'

    % manually specifies location and type of data in cells
      
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    hippocampomeVersion = csvFile{1,1};

    nMainSourcesAll = str2double(csvFile{7,11});

    nGiorgioApproved = str2double(csvFile{1,7});

    nSuspended = str2double(csvFile{2,7});

    nVirtual = str2double(csvFile{3,7});

    nBeingReinterpreted = str2double(csvFile{7,7});

    nUnapprovedMerger = str2double(csvFile{4,11});

    nEmail = str2double(csvFile{1,11});
    nEmailSuspended = str2double(csvFile{2,11});
    nEmailApproved = str2double(csvFile{3,11});

    nDccVettingActive = str2double(csvFile{2,2});
    nDccVettingSuspended = str2double(csvFile{3,2});
    nDccMerging = str2double(csvFile{4,2});

    nGiorgioVettingQueue = str2double(csvFile{1,4});
    nGiorgioMergingQueue = str2double(csvFile{2,4});
    nGiorgioVetting = str2double(csvFile{3,4});
    nGiorgioMerging = str2double(csvFile{4,4});
    nGiorgioSplitting = str2double(csvFile{5,4});
    nGiorgioVettingQueueSuspended = str2double(csvFile{6,4});
    nGiorgioVettingSuspended = str2double(csvFile{7,4});
    nGiorgioReferencing = str2double(csvFile{6,2});
    nGiorgioReferencingQueue = str2double(csvFile{7,2});
    nGiorgioPostMerging = str2double(csvFile{4,11});

    nActiveAll = nGiorgioApproved; % + nDccVettingActive;
    nSuspendedAll = nSuspended + nDccVettingSuspended;
    %    nActive = nMainSourcesAll - nSuspended - nVirtual;

%     DGclasses = csvFile{2,1};
%     CA3classes = csvFile{3,1};
%     CA1classes = csvFile{4,1};
%     CA2classes = csvFile{5,1};

    pclName.DG = 'SG';
    pclName.CA3 = 'SP';
    pclName.CA2 = 'SP';
    pclName.CA1 = 'SP';
    pclName.SUB = 'SP';   
    pclName.EC = '';%'II'; %% newly added
    
    % indicates order of subregions
    nSubregions = 6;
    ALL = 0;
    DG  = 1;
    CA3 = 2;
    CA2 = 3;
    CA1 = 4;
    SUB = 5;
    EC  = 6;
 
    % specify how many rows and columns contain header data
    rowSkip = 7; % rows to skip
    parcelNamesRowNum = 6;
    layerIdRowNum = 7;
    
    cellStatusColNum = 1;       % A
    cellIdColNum = 2;           % B
    uniqueIdColNum = 3;         % C
    subregionColNum = 4;        % D
    AD_patternColNum = 5;       % E
    projectingColNum = 6;       % F
    projPatternColNum = 7;      % G
    labelColNum = 8;            % H - short name
    abbrevColNum = 9;           % I
    NIF_ColNum = 10;            % J - full name
    allInOneColNum = 11;        % K - intermediate name
    statusColNum = 12;          % L - Rank
    singleRefColNum = 13;       % M
    verificationColNum = 14;    % N - ABC ordering
    subclassColNum = 15;        % O
    AKA_ColNum = 16;            % P
    abbrevExpansColNum = 17;    % Q
    excitOrInhibColNum = 18;    % R
    pcFlagColNum = 19;          % S
    somaColNum = 20;            % T
    pclFlagColNum = 21;         % U
    AD_pclFlagColNum = 22;      % V
    perisomaticTargetingFlagColNum = 23; % W
    backRefColNum = 24;         % X
    supplPmidsColNum = 25;      % Y
    axonOrDendriteColNum = 26;  % Z

    
    if (csvFile{6,1} == '1967') % FAMILI Hippocampome axon-dendrite
        
        rowSkip = 8; % rows to skip
        parcelNamesRowNum = 7;
        layerIdRowNum = 8;

%         allInOneColNum = 10;
%         statusColNum = 11;
%         singleRefColNum = 12;
%         verificationColNum = 13;
%         subclassColNum = 14;
%         AKA_ColNum = 15;
%         abbrevExpansColNum = 16;
%         excitOrInhibColNum = 17;
%         pcFlagColNum = 18;
%         somaColNum = 19;
%         pclFlagColNum = 20;
%         AD_pclFlagColNum = 21;
%         backRefColNum = 22;
%         axonOrDendriteColNum = 23;
        
    end

    

    colSkip = axonOrDendriteColNum; % cols to skip   

    

    [nRows, nCols] = size(csvFile);

    nCells(nSubregions) = 0;
    nCellsE(nSubregions) = 0;


    for i = 1:nRows
	
        if ~isempty(csvFile{i,cellIdColNum})

            if ( ( (isIncludeApprovedClasses)  && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'N')) ) || ...
                 ( (isIncludeSuspendedClasses) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'X')) ) || ...
                 ( (isIncludeVirtualClasses)   && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'V')) ) || ...
                 ( (isIncludeTempUnapprovedActiveClasses) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'T')) ) || ...
                 ( (isIncludePremergerActiveClasses) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'P')) ) || ...
                 ( (isIncludeMergedActiveClasses) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'M')) ) || ...
                 ( (isIncludeTempUnapprovedSuspendedClasses) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'S')) ) )
 
               if (strcmp(csvFile{i,cellIdColNum}(1), '1'))
                    nCells(DG) = nCells(DG) + 0.5;
                    if (strcmp(csvFile{i,excitOrInhibColNum}, 'E'))
                        nCellsE(DG) = nCellsE(DG) + 0.5;
                    end 
                elseif (strcmp(csvFile{i,cellIdColNum}(1), '2'))
                    nCells(CA3) = nCells(CA3) + 0.5;
                    if (strcmp(csvFile{i,excitOrInhibColNum}, 'E'))
                        nCellsE(CA3) = nCellsE(CA3) + 0.5;
                    end 
                elseif (strcmp(csvFile{i,cellIdColNum}(1), '3'))
                    nCells(CA2) = nCells(CA2) + 0.5;
                    if (strcmp(csvFile{i,excitOrInhibColNum}, 'E'))
                        nCellsE(CA2) = nCellsE(CA2) + 0.5;
                    end 
                elseif (strcmp(csvFile{i,cellIdColNum}(1), '4'))
                    nCells(CA1) = nCells(CA1) + 0.5;
                    if (strcmp(csvFile{i,excitOrInhibColNum}, 'E'))
                        nCellsE(CA1) = nCellsE(CA1) + 0.5;
                    end 
                elseif (strcmp(csvFile{i,cellIdColNum}(1), '5'))
                    nCells(SUB) = nCells(SUB) + 0.5;
                    if (strcmp(csvFile{i,excitOrInhibColNum}, 'E'))
                        nCellsE(SUB) = nCellsE(SUB) + 0.5;
                    end 
                else % strcmp(csvFile{i,cellIdColNum}(1), '6'))
                    nCells(EC) = nCells(EC) + 0.5;
                    if (strcmp(csvFile{i,excitOrInhibColNum}, 'E'))
                        nCellsE(EC) = nCellsE(EC) + 0.5;
                    end 
                end % if (strcmp(csvFile{i,cellIdColNum}(1), '1'))

            end % if ((strcmp(csvFile{i,cellStatusColNum}(1), 'N')) ...

        end % if ~isempty(csvFile{i,cellIdColNum})

    end % i loop

    nAllCells = sum(nCells);

    DGcells = DG*100 + [1:nCells(DG)];
    CA3cells = CA3*100 + [1:nCells(CA3)];
    CA2cells = CA2*100 + [1:nCells(CA2)];
    CA1cells = CA1*100 + [1:nCells(CA1)];
    SUBcells = SUB*100 + [1:nCells(SUB)];
    ECcells = EC*100 + [1:nCells(EC)];

    iCellsStart = [1; ...
                   nCells(DG)+1; ...
                   nCells(DG)+nCells(CA3)+1; ...
                   nCells(DG)+nCells(CA3)+nCells(CA2)+1; ...
                   nCells(DG)+nCells(CA3)+nCells(CA2)+nCells(CA1)+1; ...
                   nCells(DG)+nCells(CA3)+nCells(CA2)+nCells(CA1)+nCells(SUB)+1];
               
    iCellsEnd = [nCells(DG); ...
                 nCells(DG)+nCells(CA3); ...
                 nCells(DG)+nCells(CA3)+nCells(CA2); ...
                 nCells(DG)+nCells(CA3)+nCells(CA2)+nCells(CA1); ...
                 nCells(DG)+nCells(CA3)+nCells(CA2)+nCells(CA1)+nCells(SUB); ...
                 nCells(DG)+nCells(CA3)+nCells(CA2)+nCells(CA1)+nCells(SUB)+nCells(EC)];
               
    nParcels(nSubregions) = 0;

    for j = 1:nCols
        if ~isempty(csvFile{layerIdRowNum,j})
            if (strcmp(csvFile{layerIdRowNum,j}(1), 'L'))

                if (strcmp(csvFile{layerIdRowNum,j}(2), '1'))
                    nParcels(DG) = nParcels(DG) + 1;
                elseif (strcmp(csvFile{layerIdRowNum,j}(2), '2'))
                    nParcels(CA3) = nParcels(CA3) + 1;
                elseif (strcmp(csvFile{layerIdRowNum,j}(2), '3'))
                    nParcels(CA2) = nParcels(CA2) + 1;
                elseif (strcmp(csvFile{layerIdRowNum,j}(2), '4'))
                    nParcels(CA1) = nParcels(CA1) + 1;
                elseif (strcmp(csvFile{layerIdRowNum,j}(2), '5'))
                    nParcels(SUB) = nParcels(SUB) + 1;
                else % strcmp(csvFile{layerIdRowNum,j}(2), '6'))
                    nParcels(EC) = nParcels(EC) + 1;
                end % if (strcmp(csvFile{layerIdRowNum,j}(2), '1'))

            end % if (strcmp(csvFile{layerIdRowNum,j}(1), 'L'))
        end % if ~isempty(csvFile{layerIdRowNum,j})

    end % j loop

    nParcellations = sum(nParcels);
    nOfficialParcellations = nParcellations; % all in file are official
    
    notesColNum = axonOrDendriteColNum + nOfficialParcellations + 1;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    clear i j nRows nCols

    save parcellation.mat *
    