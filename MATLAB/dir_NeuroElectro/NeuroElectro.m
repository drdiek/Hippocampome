function NeuroElectro()

    addpath(genpath('lib'));

    dataFileName = select_data_file();
    if strcmp(dataFileName, '!')
        return;
    end
    
    disp(' ');
    [header, data] = initialize_variables(dataFileName);

%    [parsedData] = parse_data(savedData, n);
    
    save_data(header, data, dataFileName);
    
    disp(' ');
    disp('Finis.');
    disp(' ');
end % NeuroElectro()