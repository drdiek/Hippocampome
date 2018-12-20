function current_parcellation_data(csvFile)

fprintf(1, '\nInitializing parameters...')

load 'connectivityToggles'

    % manually specifies location and type of data in cells
      
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    hippocampomeVersion = csvFile{1,1};

    nMainSourcesAll = 0; %str2double(csvFile{7,11});

    nGiorgioApproved = 0; %str2double(csvFile{1,7});

    nSuspended = 0; %str2double(csvFile{2,7});

    nVirtual = 0; %str2double(csvFile{3,7});

    nBeingReinterpreted = 0; %str2double(csvFile{7,7});

    nUnapprovedMerger = 0; %str2double(csvFile{4,11});

    nEmail = 0; %str2double(csvFile{1,11});
    nEmailSuspended = 0; %str2double(csvFile{2,11});
    nEmailApproved = 0; %str2double(csvFile{3,11});

    nDccVettingActive = 0; %str2double(csvFile{2,2});
    nDccVettingSuspended = 0; %str2double(csvFile{3,2});
    nDccMerging = 0; %str2double(csvFile{4,2});

    nGiorgioVettingQueue = 0; %str2double(csvFile{1,4});
    nGiorgioMergingQueue = 0; %str2double(csvFile{2,4});
    nGiorgioVetting = 0; %str2double(csvFile{3,4});
    nGiorgioMerging = 0; %str2double(csvFile{4,4});
    nGiorgioSplitting = 0; %str2double(csvFile{5,4});
    nGiorgioVettingQueueSuspended = 0; %str2double(csvFile{6,4});
    nGiorgioVettingSuspended = 0; %str2double(csvFile{7,4});
    nGiorgioReferencing = 0; %str2double(csvFile{6,2});
    nGiorgioReferencingQueue = 0; %str2double(csvFile{7,2});
    nGiorgioPostMerging = 0; %str2double(csvFile{4,11});

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
    pclName.Sub = 'SP';   
    pclName.EC = '';%'II'; %% newly added
    
    % indicates order of subregions
    nSubregions = 6;
    ALL = 0;
    DG  = 1;
    CA3 = 2;
    CA2 = 3;
    CA1 = 4;
    Sub = 5;
    EC  = 6;
 
    % specify how many rows and columns contain header data
    rowSkip = 8; % rows to skip
    subregionNamesRowNum = 5;
    parcelNamesRowNum = 7;
    layerIdRowNum = 8;
    
    cellStatusColNum = 1;                % A
    cellIdColNum = 2;                    % B
    uniqueIdColNum = 3;                  % C
    subregionColNum = 4;                 % D
    excitOrInhibColNum = 5;              % E
    AD_patternColNum = 6;                % F
    projectingColNum = 7;                % G
    projPatternColNum = 8;               % H
    labelColNum = 9;                     % I - short name
    abbrevColNum = 10;                   % J
    NIF_ColNum = 11;                     % K - full name
    allInOneColNum = 12;                 % L - intermediate name
    supertypeColNum = 13;                % M
    statusColNum = 14;                   % N - Rank
    singleRefColNum = 15;                % O
    verificationColNum = 16;             % P - ABC ordering
    subclassColNum = 17;                 % Q
    AKA_ColNum = 18;                     % R
    abbrevExpansColNum = 19;             % S
    pcFlagColNum = 20;                   % T
    somaColNum = 21;                     % U
    pclFlagColNum = 22;                  % V
    AD_pclFlagColNum = 23;               % W
    perisomaticTargetingFlagColNum = 24; % X
    backRefColNum = 25;                  % Y
    supplPmidsColNum = 26;               % Z
    axonOrDendriteColNum = 27;           % AA

    colSkip = axonOrDendriteColNum; % cols to skip   

    [nRows, nCols] = size(csvFile);

    nCells(nSubregions) = 0;
    nCellsE(nSubregions) = 0;

    for i = 1:nRows
	
        if ~isempty(csvFile{i,cellIdColNum})

            if ( ( (isIncludeV1p0Rank1to3ActiveTypes)  && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'N')) ) || ...
                 ( (isIncludeV1p0Rank4to5ActiveTypes) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'M')) ) || ...
                 ( (isIncludeV1p0ActiveTypesDisappearingInV2p0) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'O')) ) || ...
                 ( (isIncludeV1p0ActiveTypesWithApprovedActiveAddenda) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'B')) ) || ...
                 ( (isIncludeV1p0ActiveTypesWithUnapprovedActiveAddenda) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'A')) ) || ...
                 ( (isIncludeApprovedV2p0ActiveTypes) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'P')) ) || ...
                 ( (isIncludeUnapprovedV2p0ActiveTypes) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'V')) ) || ...
                 ( (isIncludeV1p0OnholdTypesThatAreNowUnapprovedV2p0ActiveTypes) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'W')) ) || ...
                 ( (isIncludeApprovedV2p0OnholdTypesThatAreNowUnapprovedv2p0Active) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'U')) ) || ...
                 ( (isIncludeUnapprovedV2p0ActiveThatWillSplitOffFromV1p0Active) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'R')) ) || ...
                 ( (isIncludeV1p0OnholdTypes) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'X')) ) || ...
                 ( (isIncludeV1p0OnholdTypesThatWillDisappearInV2p0) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'T')) ) || ...
                 ( (isIncludeApprovedV2p0OnholdTypes) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'Y')) ) || ...
                 ( (isIncludeUnapprovedV2p0OnholdTypes) && ...
                   (strcmp(csvFile{i, cellStatusColNum}, 'S')) ) )

               if (strcmp(csvFile{i,cellIdColNum}(1), '1'))
                    nCells(DG) = nCells(DG) + 1/3;
                    if (strcmp(csvFile{i,excitOrInhibColNum}, 'E'))
                        nCellsE(DG) = nCellsE(DG) + 1/3;
                    end 
                elseif (strcmp(csvFile{i,cellIdColNum}(1), '2'))
                    nCells(CA3) = nCells(CA3) + 1/3;
                    if (strcmp(csvFile{i,excitOrInhibColNum}, 'E'))
                        nCellsE(CA3) = nCellsE(CA3) + 1/3;
                    end 
                elseif (strcmp(csvFile{i,cellIdColNum}(1), '3'))
                    nCells(CA2) = nCells(CA2) + 1/3;
                    if (strcmp(csvFile{i,excitOrInhibColNum}, 'E'))
                        nCellsE(CA2) = nCellsE(CA2) + 1/3;
                    end 
                elseif (strcmp(csvFile{i,cellIdColNum}(1), '4'))
                    nCells(CA1) = nCells(CA1) + 1/3;
                    if (strcmp(csvFile{i,excitOrInhibColNum}, 'E'))
                        nCellsE(CA1) = nCellsE(CA1) + 1/3;
                    end 
                elseif (strcmp(csvFile{i,cellIdColNum}(1), '5'))
                    nCells(Sub) = nCells(Sub) + 1/3;
                    if (strcmp(csvFile{i,excitOrInhibColNum}, 'E'))
                        nCellsE(Sub) = nCellsE(Sub) + 1/3;
                    end 
                else % strcmp(csvFile{i,cellIdColNum}(1), '6'))
                    nCells(EC) = nCells(EC) + 1/3;
                    if (strcmp(csvFile{i,excitOrInhibColNum}, 'E'))
                        nCellsE(EC) = nCellsE(EC) + 1/3;
                    end 
                end % if (strcmp(csvFile{i,cellIdColNum}(1), '1'))

            end % if ((strcmp(csvFile{i,cellStatusColNum}(1), 'N')) ...

        end % if ~isempty(csvFile{i,cellIdColNum})

    end % i loop
    
    nCells(DG) = round(nCells(DG));
    nCells(CA3) = round(nCells(CA3));
    nCells(CA2) = round(nCells(CA2));
    nCells(CA1) = round(nCells(CA1));
    nCells(Sub) = round(nCells(Sub));
    nCells(EC) = round(nCells(EC));
    
    nAllCells = uint16(sum(nCells));

    DGcells = DG*100 + [1:nCells(DG)];
    CA3cells = CA3*100 + [1:nCells(CA3)];
    CA2cells = CA2*100 + [1:nCells(CA2)];
    CA1cells = CA1*100 + [1:nCells(CA1)];
    Subcells = Sub*100 + [1:nCells(Sub)];
    ECcells = EC*100 + [1:nCells(EC)];

    iCellsStart = [1; ...
                   nCells(DG)+1; ...
                   nCells(DG)+nCells(CA3)+1; ...
                   nCells(DG)+nCells(CA3)+nCells(CA2)+1; ...
                   nCells(DG)+nCells(CA3)+nCells(CA2)+nCells(CA1)+1; ...
                   nCells(DG)+nCells(CA3)+nCells(CA2)+nCells(CA1)+nCells(Sub)+1];
               
    iCellsEnd = [nCells(DG); ...
                 nCells(DG)+nCells(CA3); ...
                 nCells(DG)+nCells(CA3)+nCells(CA2); ...
                 nCells(DG)+nCells(CA3)+nCells(CA2)+nCells(CA1); ...
                 nCells(DG)+nCells(CA3)+nCells(CA2)+nCells(CA1)+nCells(Sub); ...
                 nCells(DG)+nCells(CA3)+nCells(CA2)+nCells(CA1)+nCells(Sub)+nCells(EC)];
               
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
                    nParcels(Sub) = nParcels(Sub) + 1;
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
    