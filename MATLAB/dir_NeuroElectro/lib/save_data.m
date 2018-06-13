function save_data(header, data, fileName)
    % saving data for NeuroElectro() %%%%%%%%%%%%%%%%%
    disp('saving data ...');
    
    dataFileName = sprintf('./output/%s_filtered_%s.xlsx', fileName(1:end-5), datestr(now, 'yyyymmddHHMMSS'));
    
    size(header)
    size(data)
    
    data2File = [header; data];
    
    xlswrite(dataFileName, data2File);
    
end % save_data()