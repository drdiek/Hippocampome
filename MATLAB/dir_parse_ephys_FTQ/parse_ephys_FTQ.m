function parse_ephys_FTQ()

    fileName = 'ephys_FTQ.csv';
    
    [cells, isFileLoaded] = load_csvFile(fileName);
    
    N = length(cells)
    
    fid = fopen('FTQ_ID.csv', 'w');
    
    q = char(34); % "
    
    for i = 1:N
       
        strng = sprintf('%s', cells{i});
        
        figLocation = strfind(strng,'Fig');
        
        tabLocation = strfind(strng,'Tab');
        
        if (figLocation > 0)
            
            FTQ_ID = '1';
            
            [iFTQ_strng, iFTQ_substrng] = parse_iFTQ_substring(strng, figLocation);
            
        elseif (tabLocation > 0)
            
            FTQ_ID = '2';

            [iFTQ_strng, iFTQ_substrng] = parse_iFTQ_substring(strng, tabLocation);
            
        else % quotation
            
            FTQ_ID = '3';
            
            iFTQ_strng = '00';
            
            iFTQ_substrng = '00';
            
        end
        
        FTQ_strng(i,:) = sprintf('%s%s%s', FTQ_ID, iFTQ_strng, iFTQ_substrng);

        fprintf(fid, '%s%5s%s\n', q, FTQ_strng(i,1:5), q);
        
    end
    
    fclose(fid);
    
    FTQ_strng(:,:)

    
    
end