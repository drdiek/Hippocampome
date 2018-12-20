function [refIds, nBorderlineCalls, areBorderlineCalls] = find_borderline_calls(strng)
    
    if strcmp(strng(1),'"')

        if strcmp(strng(end),'"')
            refIds = str2num(strng(2:end-1));
        else
            refIds = str2num(strng(2:end));
        end
        
    else       
        refIds = str2num(strng);
    end
    
    borderlineCallsIdsIdx = refIds>=20000000;
    borderlineCallsIds = refIds(borderlineCallsIdsIdx);
    nBorderlineCalls = length(borderlineCallsIds);

    areBorderlineCalls = 0;

    if (nBorderlineCalls > 0)
        areBorderlineCalls = 1;
    end

end % find_borderline_calls