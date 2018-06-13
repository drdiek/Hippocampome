function FP_run()

    clear all;    
    profile on

    path(path,'./menus/');
    path(path,'./diek_lib/');
    path(path,'./plot_functions/');

    fileName = 'FP_matrix.csv';
    

    [cells, isFileLoaded] = load_csv_file(fileName);
    
    if isFileLoaded
       
        [nRows, nColumns] = size(cells);

        skipRows = 1;
        
        skipColumns = 6;
        
        ABCorderingColumnNo = 1;
        
        HCorderingColumnNo = 2;
        
        cellIDorderingColumnNo = 4;
        
        labelColumnNo = 6;
    
        orderingColumnNo = ABCorderingColumnNo;
        
        nAllCells  = nRows - skipRows;
        
        nPatterns = nColumns - skipColumns;
        
        for i = [1:nAllCells] + skipRows
            
            ABCorderingCells{i-skipRows} = cells{i, ABCorderingColumnNo};
            
            HCorderingCells{i-skipRows} = cells{i, HCorderingColumnNo};
            
            cellIDorderingCells{i-skipRows} = cells{i, cellIDorderingColumnNo};
            
            cellLabelsUnsorted{i-skipRows} = cells{i, labelColumnNo};
            
            for j = [1:nPatterns] + skipColumns
                
                nPatternOccurrencesUnsorted(i-skipRows, j-skipColumns) = str2num(cells{i, j});
                
            end % for j
            
        end % for i

        ABCordering = str2double(ABCorderingCells);
        
        HCordering = str2double(HCorderingCells);
        
        cellIDordering = str2double(cellIDorderingCells);
        
        ordering = [ABCordering; HCordering; cellIDordering]';
        
        [orderingSorted, idx] = sort(ordering(:,orderingColumnNo));
        
        for i = 1:nAllCells
            
            cellLabels{i} = cellLabelsUnsorted{idx(i)};
            
            nPatternOccurrencesSorted(i,:) = nPatternOccurrencesUnsorted(idx(i),:);
            
        end % for i
        
            
        for j = [1:nPatterns] + skipColumns
            
            patternLabels{j-skipColumns} = cells{1, j};
            
        end % for j
        

        save parameters.mat nAllCells nPatterns cellLabels nPatternOccurrencesSorted patternLabels
        
        plot_patterns();
        
    end

% end FP_run()