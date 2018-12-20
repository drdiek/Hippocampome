function plot_overlap_csv_matrix

    load parcellation.mat nAllCells nOfficialParcellations

    load overlap.mat layerNames subregionNames CijOverlap

    load Cij.mat cellUniqueIds cellLabels cellAbbrevs cellEorIs
    
    CijOverlap = fliplr(CijOverlap');
    
    subregionNames = fliplr(subregionNames');
    layerNames = fliplr(layerNames');
    
    outputFile = sprintf('./output/overlap_matrix_%s.csv', datestr(now, 'yyyymmdd_HHMMSS'));
    
    fid = fopen(outputFile, 'w');
    
    header = sprintf('UniqueIDs,Names,Abbreviations,EorI');
    
    for j = 1:nOfficialParcellations
    
        header = sprintf('%s,%s:%s', header, subregionNames{1,j}, layerNames{1,j});
        
    end % for j
        
    fprintf(fid, '%s\n', header);
    
    
    for i = 1:nAllCells
        
        lineStr = sprintf('%s,%s,%s,%s', cellUniqueIds{i}, cellLabels{i}, cellAbbrevs{i}, cellEorIs{i});

        for j = [1:nOfficialParcellations] + 1
            
            lineStr = sprintf('%s,%d', lineStr, CijOverlap(i,j));
            
        end % for j
        
        fprintf(fid, '%s\n', lineStr);
        
    end % for i
    
    fclose(fid);
    
end % function plot_overlap_csv_matrix