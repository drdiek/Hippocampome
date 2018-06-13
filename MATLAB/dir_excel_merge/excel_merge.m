function excel_merge()

    clear all;    

    addpath(genpath('lib'),'data');

    dataFile(1).name = select_data_file(1);
    if strcmp(dataFile(1).name, '!')
        return;
    end
    dataFile(2).name = dataFile(1).name;
    
    while strcmp(dataFile(1).name, dataFile(2).name)
        dataFile(2).name = select_data_file(2);
        if strcmp(dataFile(2).name, '!')
            return;
        end
        if strcmp(dataFile(1).name, dataFile(2).name)
            disp('Please select a second file that is different from the first. Hit any key to continue:');
            pause
        end        
    end % while strcmp()
    
    for i = 1:2
        dataFile(i).raw = read_data_file(dataFile(i).name, i);
    end
    
    disp(' ');
    disp('Merging data files ...');
    [dataFileMerged.raw, dataFile(1).HCID, dataFile(2).HCID, dataFileMerged.HCID, ...
        dataFile(1).exclusion, dataFile(2).exclusion, dataFileMerged.exclusion, ...
        dataFile(1).STID, dataFile(2).STID, dataFileMerged.STID] = merge_data_files(dataFile(1).raw, dataFile(2).raw);
  
    disp(' ');
    disp('Writing merged data to file ...');
    dataFileMerged.name = determine_merged_file_name(dataFile(1).name, dataFile(2).name);
    xlswrite(dataFileMerged.name, dataFileMerged.raw);

    add_highlights(dataFileMerged.name, dataFile(1), dataFile(2), dataFileMerged); 
    
    disp(' ');
    disp('Finis.');
    disp(' ');
    
end % excel_merge()