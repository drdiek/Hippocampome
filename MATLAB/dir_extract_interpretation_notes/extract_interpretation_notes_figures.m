function extract_interpretation_notes_figures()

    [num,txt,raw] = xlsread('interpretations_figures.xlsx');
    
    nCells = size(raw,1);
    
    interpTextArray{1,1} = 'Interpretation reference ID';

    interpTextArray{1,2} = 'Interpretation notes figures';
    
    for i = 2:nCells

        refIdText = raw{i,1};
        
        locationText = raw{i,2};
        
        if (strfind(locationText, 'Fig') | strfind(locationText, 'Tab'))
            
            cellText = txt{i,3};
            
            ltLocs = strfind(cellText, '<');
            
            gtLocs = strfind(cellText, '>');
            
            nLtLocs = length(ltLocs);
            
            nGtLocs = length(gtLocs);
            
            nInterps = nGtLocs;
            
            if (nLtLocs < nGtLocs)
                
                nInterps = nLtLocs;
                
            end
            
            interpTextArray{i,1} = [];
            
            interpTextArray{i,2} = [];
            
            interpText = [];
            
            if (nInterps > 0)

                preCheckText = cellText(ltLocs(1)+1:gtLocs(1)-1);
                
                postCheckText = checkText(preCheckText);
                
                if (~isempty(postCheckText))
                
                   interpText = sprintf('%s', postCheckText);
    
                end
                   
                for j = 2:nInterps
                    
                    preCheckText = cellText(ltLocs(j)+1:gtLocs(j)-1);
                
                    postCheckText = checkText(preCheckText);
                    
                    if (~isempty(postCheckText))
                
                        interpText = sprintf('%s %s', interpText, postCheckText);
    
                    end
                        
                end
                
            end % if (nInterps > 0)
            
            interpTextArray{i,1} = refIdText;
            
            interpTextArray{i,2} = interpText;
                
            cellText = '';
        
        end % if strfind
            
    end % for i
    
    delete('interpretation_notes_figures.xlsx');
    
    xlswrite('interpretation_notes_figures.xlsx', interpTextArray);

end