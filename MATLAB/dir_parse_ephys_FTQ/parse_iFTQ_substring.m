function [iFTQ_strng, iFTQ_substrng] = parse_iFTQ_substring(strng, FTQlocation)

    iFTQ_substrng = '00';

    supplFlag = 0;
    
    iFTQ_strng = sprintf('%s', strng(FTQlocation+3:end));
    
    if (strcmp(iFTQ_strng(1),'S'))
        
        iFTQ_strng = iFTQ_strng(2:end);
        
        supplFlag = 1;
        
    end
        
    hyphenIdx = strfind(iFTQ_strng,'-');
    
    if (hyphenIdx > 0)
        
        iFTQ_strng = iFTQ_strng(1:hyphenIdx-1);
        
    end
    
    semicolonIdx = strfind(iFTQ_strng,';');
    
    if (semicolonIdx > 0)
        
        iFTQ_strng = iFTQ_strng(1:semicolonIdx-1);
        
    end
    
    commaIdx = strfind(iFTQ_strng,',');
    
    if (commaIdx > 0)
        
        iFTQ_strng = iFTQ_strng(1:commaIdx-1);
        
    end
    
    spaceIdx = strfind(iFTQ_strng,' ');
    
    if (spaceIdx > 0)
        
        iFTQ_strng = iFTQ_strng(1:spaceIdx-1);
        
    end
    
    len = length(iFTQ_strng);
            
    if (len == 1) % e.g. 2
                
        iFTQ_strng = strcat('0',iFTQ_strng);
        
    elseif (len == 2) % e.g. 12 or 4c
        
        iFTQ_ascii = double(iFTQ_strng(2));
        
        if (iFTQ_ascii > 57) % '9' e.g. 4c
            
            iFTQ_substrng = parse_panel(iFTQ_strng(2));
            
            iFTQ_strng = strcat('0',iFTQ_strng(1));
            
        else % e.g. 12
            
            iFTQ_strng = iFTQ_strng(1:2);
            
            iFTQ_substrng = '00';
            
        end
               
    elseif (len > 2) % e.g. 12d or 4A2
        
        iFTQ_ascii = double(iFTQ_strng(2));
        
        if (iFTQ_ascii > 57) % '9' e.g. A in 4A2
            
            iFTQ_substrng = parse_panel(iFTQ_strng(2));
            
            iFTQ_strng = strcat('0',iFTQ_strng(1));
            
        else % e.g. 12d
            
            iFTQ_substrng = parse_panel(iFTQ_strng(3));
            
            iFTQ_strng = iFTQ_strng(1:2);
            
        end
        
    end
    
    if supplFlag
        
        iFTQ_ascii = double(iFTQ_strng(1)); % e.g. 49 = '1'
        
        iFTQ_strng(1) = char(iFTQ_ascii+5); % e.g. '6' = 49+5 = 54
        
        iFTQ_strng = iFTQ_strng(1:2);
        
    end
    
end
