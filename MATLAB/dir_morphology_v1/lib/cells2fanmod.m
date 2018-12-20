function [fanmod, cellIds, areSaved] = cells2fanmod(csvFile, baseFileName, Cij)
% hippocampome network graphics analysis
% 200904122120 David J. Halimton
%
% adapted from R to MATLAB 20090504 Diek W. Wheeler
%
% outputs Cij to 5 column format: 
% 1. from cell
% 2. to cell
% 3. type of from cell (e/i)
% key: 0=inhib(no self) 1=excit(no self), 2=inhib(self), 3=excit(self)
% 4. type of to cell (e/i)
% key: 0=inhib(no self) 1=excit(no self), 2=inhib(self), 3=excit(self)
% 5. type of connection (e/i)
% key: 1=inhib, 2=excit



    areSaved = 0;
    fprintf(1, '\nSaving ...')

%    [nParcellations, nOfficialParcellations, DGcells, CA3cells, CA2cells, CA1cells, SUBcells, ECcells...
%        nCells, nAllCells, DG, CA3, CA2, CA1, SUB, EC, rowSkip, colSkip, cellIdColNum, ...
%        labelColNum, axonOrDendriteColNum, excitOrInhibColNum, overlapNotesColNum, parcelNamesRowNum, version] = current_parcellation_data(csvFile);

    load parcellation.mat   
    
    axonsArray = zeros(1,nAllCells);
    dendritesArray = zeros(1,nAllCells);
    
    
    foundCells = 0;
    rowLooper = rowSkip + 1;
    while foundCells < nAllCells
        if ~isempty(csvFile{rowLooper,cellIdColNum})          
            if strcmpi(csvFile{rowLooper,axonOrDendriteColNum},'axons')
                axonsArray(foundCells+1) = rowLooper;
            elseif strcmpi(csvFile{rowLooper,axonOrDendriteColNum},'dendrites')
                foundCells = foundCells + 1;
                dendritesArray(foundCells) = rowLooper;
            end
        end      
        rowLooper = rowLooper + 1;
    end


    % retrieve cellIds from first column of input file and convert from
    % string to number
    cellIds = csvFile(axonsArray,cellIdColNum);
    cellIds = cellfun(@(cellIds) cellIds(2:end), cellIds, 'uni',false);
    cellIds = str2num(cell2mat(cellIds));    
    
    
    cellIdx = 0;
    rowSums = sum(Cij,2);

    % loop over rows (cell types)
    for iCell = 1:nAllCells  
        % check for self-connection
        if (Cij(iCell,iCell) == 0)
            selfConnection = 0;
        else
            selfConnection = 1;
        end % check for self-connection
        
        ithRowSum = rowSums(iCell);

        if ~selfConnection
            % if it's inhibitory
            if (ithRowSum < 0)
                fromSgn = 0;
                edgeSgn = 1;
            % excitatory
            elseif (ithRowSum > 0)
                fromSgn = 1;
                edgeSgn = 2;
            end
        else
            % inibitory
            if (ithRowSum < 0)
                fromSgn = 2;
                edgeSgn = 1;
            % excitatory
            elseif (ithRowSum > 0)
                fromSgn = 3;
                edgeSgn = 2;
            end
        end % ~selfConnection

        for jCell = 1:nAllCells % pst
            % check for self-connection
            if (Cij(jCell,jCell) == 0)
                jSelfConnection = 0;
            else
                jSelfConnection = 1;
            end % check for self-connection
        
            jthRowSum = rowSums(jCell);
            
            if ~jSelfConnection
                % inhibitory
                if (jthRowSum < 0)
                    toSgn = 0;
                % excitatory
                elseif (jthRowSum > 0)
                    toSgn = 1;
                end
            else
                if (jthRowSum < 0)
                    toSgn = 2;
                elseif (jthRowSum > 0)
                    toSgn = 3;
                end
            end % ~jSelfConnection

            if (Cij(iCell,jCell))
                cellIdx = cellIdx + 1;

                fanmod(1:5, cellIdx) = [(iCell-1) (jCell-1) ... %(floor(fromId/100)-1) (floor(toId/100)-1) ...
                                    fromSgn toSgn edgeSgn]; % start node labeling from zero;-1 -> 2, 1 -> 1

                mdraw(1:3, cellIdx) = [iCell jCell edgeSgn]; % start node labeling from zero; -1(inhib) -> 2, 1(excit) -> 1                      

                if (~isempty(find(ECcells == cellIds(iCell), 1)) && ~isempty(find(ECcells == cellIds(jCell), 1)))                            
                    parcellation(cellIdx) = EC;                        
                elseif (~isempty(find(DGcells == cellIds(iCell), 1)) && ~isempty(find(DGcells == cellIds(jCell), 1)))                            
                    parcellation(cellIdx) = DG;                      
                elseif (~isempty(find(CA3cells == cellIds(iCell), 1)) && ~isempty(find(CA3cells == cellIds(jCell), 1)))                            
                    parcellation(cellIdx) = CA3;
                elseif (~isempty(find(CA2cells == cellIds(iCell), 1)) && ~isempty(find(CA2cells == cellIds(jCell), 1)))                            
                    parcellation(cellIdx) = CA2;
                elseif (~isempty(find(CA1cells == cellIds(iCell), 1)) && ~isempty(find(CA1cells == cellIds(jCell), 1)))                            
                    parcellation(cellIdx) = CA1;
                elseif (~isempty(find(SUBcells == cellIds(iCell), 1)) && ~isempty(find(SUBcells == cellIds(jCell), 1)))                            
                    parcellation(cellIdx) = SUB;                            
                else % originating and destination cells
                     % are in different areas of the
                     % hippocampal formation                            
                    parcellation(cellIdx) = 0;                            
                end % if find
            end % if Cij(i,j)
        end % jCell loop
    end % iCell

    
    saveVcAll = sprintf('fanmod_output/%s_vertex-color_ALL.txt', baseFileName);
    saveAll = sprintf('fanmod_output/%s_ALL.txt', baseFileName);
    saveDG = sprintf('fanmod_output/%s_DG.txt', baseFileName);
    saveCA3 = sprintf('fanmod_output/%s_CA3.txt', baseFileName);
    saveCA2 = sprintf('fanmod_output/%s_CA2.txt', baseFileName);
    saveCA1 = sprintf('fanmod_output/%s_CA1.txt', baseFileName);
    saveEC = sprintf('fanmod_output/%s_EC.txt', baseFileName);
    saveSUB = sprintf('fanmod_output/%s_SUB.txt', baseFileName);
    saveTBA = sprintf('fanmod_output/%s_TBA.txt', baseFileName);
    saveMdrawAll = sprintf('fanmod_output/mdraw_ALL.txt');

    
    
    fidVcAll = fopen(saveVcAll, 'w');   
    fidAll = fopen(saveAll, 'w');   
    fidDG = fopen(saveDG, 'w');    
    fidCA3 = fopen(saveCA3, 'w');    
    fidCA2 = fopen(saveCA2, 'w');    
    fidCA1 = fopen(saveCA1, 'w');    
    fidEC = fopen(saveEC, 'w');    
    fidSUB = fopen(saveSUB, 'w');
    fidTBA = fopen(saveTBA, 'w');
    fidMdrawAll = fopen(saveMdrawAll, 'w');
    
    fprintf(fidVcAll, '%d\t%d\t%d\t%d\t%d\n', fanmod);    
    fprintf(fidAll, '%d\t%d\t%d\t%d\t%d\n', fanmod([1 2 3 4 5],:));    
    
    
    
    for i = 1:cellIdx
        
        switch parcellation(i)
            case EC
                fprintf(fidEC, '%d\t%d\t%d\t%d\t%d\n', fanmod(1,i), fanmod(2,i), fanmod(3,i), fanmod(4,i), fanmod(5,i));
                
            case DG
                fprintf(fidDG, '%d\t%d\t%d\t%d\t%d\n', fanmod(1,i), fanmod(2,i), fanmod(3,i), fanmod(4,i), fanmod(5,i));
    
            case CA3
                fprintf(fidCA3, '%d\t%d\t%d\t%d\t%d\n', fanmod(1,i), fanmod(2,i), fanmod(3,i), fanmod(4,i), fanmod(5,i));
    
            case CA2
                fprintf(fidCA2, '%d\t%d\t%d\t%d\t%d\n', fanmod(1,i), fanmod(2,i), fanmod(3,i), fanmod(4,i), fanmod(5,i));
    
            case CA1
                fprintf(fidCA1, '%d\t%d\t%d\t%d\t%d\n', fanmod(1,i), fanmod(2,i), fanmod(3,i), fanmod(4,i), fanmod(5,i));
    
            case SUB
                fprintf(fidSUB, '%d\t%d\t%d\t%d\t%d\n', fanmod(1,i), fanmod(2,i), fanmod(3,i), fanmod(4,i), fanmod(5,i));
    
            otherwise % originating and destination cells are in
                      % different areas of the hippocampal formation
                fprintf(fidTBA, '%d\t%d\t%d\t%d\t%d\n', fanmod(1,i), fanmod(2,i), fanmod(3,i), fanmod(4,i), fanmod(5,i));
    
        end % switch parcellation   
    end % i loop
    
    fprintf(fidMdrawAll, '%d\t%d\t%d\n', mdraw([1 2 3],:));

    
    fclose(fidVcAll);   
    fclose(fidAll);    
    fclose(fidDG);    
    fclose(fidCA3);
    fclose(fidCA2);    
    fclose(fidCA1);    
    fclose(fidEC);    
    fclose(fidSUB);    
    fclose(fidTBA);    
    fclose(fidMdrawAll);
    
    areSaved = 1;
    
end % cells2fanmod
