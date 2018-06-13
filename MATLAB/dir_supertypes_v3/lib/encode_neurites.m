function neurites = encode_neurites(subregion,pattern,neurites)

    load('./lib/constants.mat');
    
    if strcmp(subregion,'DG')
        neurites{1,DG} = pattern;
    elseif strcmp(subregion,'CA3')
        neurites{1,CA3} = pattern;
    elseif strcmp(subregion,'CA2')
        neurites{1,CA2} = pattern;
    elseif strcmp(subregion,'CA1')
        neurites{1,CA1} = pattern;
    elseif strcmp(subregion,'Sub')
        neurites{1,SUB} = pattern;
    else
        neurites{1,EC} = pattern;
    end

end % encode_neurites()