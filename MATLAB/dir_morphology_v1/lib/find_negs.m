function [refIds, negRefIds, nNegRefIds, nNegRefIdsClassLinks, ...
          nNegRefIdsNeuriteLocations, areMixedNeuriteIds, isUnvetted] = find_negs(strng)

    if find(strng == '~')
        isUnvetted = 1;
        quoteStart = 2;
    else
        isUnvetted = 0;
        quoteStart = 1;
    end
      
    if strcmp(strng(quoteStart),'"')

        if strcmp(strng(end),'"')
            refIds = str2num(strng(2:end-1));
        else
            refIds = str2num(strng(2:end));
        end
        
    else       
        refIds = str2num(strng);
    end

    negRefIdsIdx = refIds < 0;
    negRefIds = refIds(negRefIdsIdx);
    nNegRefIds = length(negRefIds);

    posRefIdsIdx = refIds > 0;
    posRefIds = refIds(posRefIdsIdx);
    nPosRefIds = length(posRefIds);

    areMixedNeuriteIds = 0;

    if ((nPosRefIds > 0) && (nNegRefIds > 0))
        areMixedNeuriteIds = 1;
    end

    nNegRefIdsClassLinks = length(find(refIds < -1000000));

    nNegRefIdsNeuriteLocations = nNegRefIds - nNegRefIdsClassLinks;

end % find_negs