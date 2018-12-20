function markerStr = replace_slashes_and_spaces(markerStr)
% This function replaces forward slashes, back slashes, and spaces with
% underscore characters for marker names to be included in the name of
% the output figure file.

    idx = find(markerStr=='/');
    
    if idx
        
        markerStr(idx) = '_';
        
    end

    idx = find(markerStr=='\');
    
    if idx
        
        markerStr(idx) = '_';
        
    end

    idx = find(markerStr==' ');
    
    if idx
        
        markerStr(idx) = '_';
        
    end

end