function outputConnToCsv()

    load overlap.mat
    load parcellation.mat
    load Cij.mat Cij CijSpecialConnections cellAbbrevs cellSubregions cellADcodes cellProjecting ...
        cellLabels cellEorIs cellUniqueIds
    load CijKnownClassLinks.mat
    load CijKnownNegClassLinks.mat
    load CijAxonSomaOverlap.mat
    load isInclude.mat
    
    
    %% format potential connectivity matrix AND cell labels for potential & known connectivity matrices %%
    N = size(Cij,1);    
    NewCij = zeros(N,N);
    printableCellLabels = cell(N,1);
    
    for i = 1:N
        cellSubregion = sprintf(deblank(cellSubregions{i}));
        cellLabel = sprintf(deblank(cellLabels{i}));
        cellADcode = sprintf(deblank(cellADcodes{i}));
        cellEorI = sprintf(deblank(cellEorIs{i}));

        if (cellEorI == 'E')
            abbrev_code_cat = [cellSubregion, ': ', cellLabel, ' (+)', cellADcode];
        else %if (cellEorI == 'I')
            abbrev_code_cat = [cellSubregion, ': ', cellLabel, ' (-)', cellADcode];
        end
        
        if strcmpi(cellProjecting{i},'p')
            abbrev_code_cat = [abbrev_code_cat, 'p'];
        end        
        
        printableCellLabels{i,1} = abbrev_code_cat;
      
        
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
    
    NewCij = [zeros(size(NewCij,1),1) NewCij];
    NewCij = [zeros(1,size(NewCij,2)); NewCij];
    printableCellLabels = [{''}; printableCellLabels];
    
    
    %% format known connectivity matrix %%
    % connectivity exceptions file name
    connExceptFile = 'Connectivity exceptions.xlsx';
    srcSubregCol = 1;   
    srcNameCol = 2;
    srcIDcol = 3;
    tgtSubregCol = 4;
    tgtNameCol = 5;
    tgtIDcol = 6;
    tgtLayerCol = 7;
    connValueCol = 8;
    refIDcol = 9;
    
    [num txt raw] = xlsread(connExceptFile);
    clear num txt;
    raw(1,:) = [];
    
    for i=1:numel(raw)
        if ischar(raw{i})
            raw{i} = NaN;
        end
    end    
       
    srcIDs = cell2mat(raw(:,srcIDcol));
    tgtIDs = cell2mat(raw(:,tgtIDcol));
    connValues = cell2mat(raw(:,connValueCol));
    
    srcIDs(isnan(tgtIDs)) = [];
    connValues(isnan(tgtIDs)) = [];
    tgtIDs(isnan(tgtIDs)) = [];


    NewKnownCij = -1 * ones(N,N);
    for i=1:length(srcIDs)
        knownSrcRow = cellUniqueIds==srcIDs(i);
        knownTgtRow = cellUniqueIds==tgtIDs(i);
        
        NewKnownCij(knownSrcRow,knownTgtRow) = connValues(i);
    end
    
    NewKnownCij = [-1*ones(size(NewKnownCij,1),1) NewKnownCij];
    NewKnownCij = [-1*ones(1,size(NewKnownCij,2)); NewKnownCij];
    
    cellUniqueIds = [0; cellUniqueIds];
        
    
    %% write to csv file %%
    
    % Name of the csv potential connectivity file
    potn_filepath = 'C:\Users\Christopher\Documents\George Mason University\_Dissertation\matlab_source\potential_connectivity_matrix_.csv';
    slashPos = strfind(potn_filepath,'\');
    potn_filename = potn_filepath(slashPos(end)+1:length(potn_filepath));
    
    % Name of the csv known connectivity file
    known_filepath = 'C:\Users\Christopher\Documents\George Mason University\_Dissertation\matlab_source\known_connectivity_matrix_.csv';
    slashPos = strfind(known_filepath,'\');
    known_filename = known_filepath(slashPos(end)+1:length(known_filepath));    

    disp_strng = sprintf('\n\nIMPORTANT:  If the following files are open, please close them now for re-writing!  Then press any key to continue.\n\n\t%s\n\t%s\n\n', potn_filepath, known_filepath);
    disp(disp_strng);
    
    if exist(potn_filepath, 'file')
        delete(potn_filepath);
    end
    if exist(known_filepath, 'file')
        delete(known_filepath);
    end               
        
    potn_fid = fopen(potn_filename,'wt');
    known_fid = fopen(known_filename,'wt');
    
    
    for i=1:N+1 %rows      
        for j=1:N+1 %cols
            
            if i==1                
                fprintf(potn_fid, '%d', cellUniqueIds(j));
                fprintf(known_fid, '%d', cellUniqueIds(j));
%                 fprintf(potn_fid, '%s', printableCellLabels{j,1});
%                 fprintf(known_fid, '%s', printableCellLabels{j,1});
            else
                if j==1
                    fprintf(potn_fid, '%d', cellUniqueIds(i));
                    fprintf(known_fid, '%d', cellUniqueIds(i));
%                     fprintf(potn_fid, '%s', printableCellLabels{i,1});
%                     fprintf(known_fid, '%s', printableCellLabels{i,1});
                else
                    fprintf(potn_fid, '%d', NewCij(i,j));
                    fprintf(known_fid, '%d', NewKnownCij(i,j));
                end
            end
            
            if j<N+1
                fprintf(potn_fid, ',');
                fprintf(known_fid, ',');
            else
                fprintf(potn_fid, '\n');
                fprintf(known_fid, '\n');
            end
        end
    end
    
    fclose(potn_fid);
    fclose(known_fid);
    

end
