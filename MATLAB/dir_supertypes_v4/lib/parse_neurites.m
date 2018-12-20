function neuritesParsed = parse_neurites(subregion,adPattern,projectionPattern)
    
    load('./lib/constants.mat');
    
    neuritesParsed = {0000 00000 0000 0000 000 000000};
    neuritesParsed = encode_neurites(subregion,adPattern,neuritesParsed);
    if ~isempty(projectionPattern)
        idxUnderscores = strfind(projectionPattern,'_');
        idxHyphens = strfind(projectionPattern,'-');
        lenIdxUnderscores = length(idxUnderscores);
        idxStart = 1;
        for i = 1:lenIdxUnderscores
            if (i > 1)
                idxStart = idxHyphens(i-1)+1;
            end
            if (i == lenIdxUnderscores)
                idxStop = length(projectionPattern);
            else
                idxStop = idxHyphens(i)-1;
            end
            projectionSubregion = projectionPattern(idxStart:idxUnderscores(i)-1);
            projectionSubregionPattern = projectionPattern(idxUnderscores(i)+1:idxStop);
            neuritesParsed = encode_neurites(projectionSubregion,str2num(projectionSubregionPattern),neuritesParsed);
        end % i
    end % if ~isempty(projectionPattern)
end % parse_neurites()