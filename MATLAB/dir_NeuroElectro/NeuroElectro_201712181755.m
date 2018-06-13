function NeuroElectro()

    addpath data lib output

    [header, firstColumn] = initialize_variables();

    n = 0;
    for i = 1:length(firstColumn)
       idx = strfind(firstColumn{i}, 'hippocampus');
       
       if isempty(idx)
           idx = strfind(firstColumn{i}, 'dentate gyrus');
       end
       if isempty(idx)
           idx = strfind(firstColumn{i}, 'subiculum');
       end
       if isempty(idx)
           idx = strfind(firstColumn{i}, 'entorhinal');
       end
       
       if ~isempty(idx)
           n = n + 1;
           savedData(n) = firstColumn(i);
       end
    end % i
    
    [parsedData] = parse_data(savedData, n);
    
    save_data(header, parsedData);
    
end % NeuroElectro()