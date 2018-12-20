function neurites = expand_neurites(data)

    load('./lib/constants.mat');
    
    nParcels = length([DG_SMO:EC_LVI]);
    
    nDigitsPerSubregion = [(DG_H-DG_SMO)+1 ...
                           (CA3_SO-CA3_SLM)+1 ...
                           (CA2_SO-CA2_SLM)+1 ...
                           (CA1_SO-CA1_SLM)+1 ...
                           (SUB_PL-SUB_SM)+1 ...
                           (EC_LVI-EC_LI)+1];
    
    c = 1;
    for i = DG:EC
        digitsStr = sprintf('%d', cell2mat(data(i)));
        nDigitsData = numel(digitsStr);
        strng = '';
        for j = 1:nDigitsPerSubregion(i)-nDigitsData
            strng = sprintf('%s0', strng);
        end % j
        strng = sprintf('%s%s', strng, digitsStr);
        
        for j = 1:nDigitsPerSubregion(i)
            if strcmp(strng(j),'0')
                neurites(c) = 0;
                neurites(c+nParcels) = 0;
            elseif strcmp(strng(j),'1')
                neurites(c) = 1;
                neurites(c+nParcels) = 0;
            elseif strcmp(strng(j),'2')
                neurites(c) = 0;
                neurites(c+nParcels) = 1;
            else % strng(j) == '3'
                neurites(c) = 1;
                neurites(c+nParcels) = 1;
            end % if strcmp()
            c = c + 1;
        end % j
    end % i

end % expand_neurites()