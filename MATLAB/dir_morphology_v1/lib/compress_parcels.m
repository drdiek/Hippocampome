function outValue = compress_parcels(inArray)

    outValue = 0; % default is no cross-regional neurites

    isBoth = find(inArray == 3);
    
    if isBoth
        
        outValue = 3;
        
    else % check for dendrites and axons
    
        isDendrite = find(inArray == 2);
        
        if isDendrite
            
            outValue = outValue + 2;
            
        end % if isDendrite

        isAxon = find(inArray == 1);
        
        if isAxon
            
            outValue = outValue + 1;
                
        end % if isAxon

    end % if isBoth
    
end % function compress_parcels