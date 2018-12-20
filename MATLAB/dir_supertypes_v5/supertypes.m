function supertypes()

    clear all;    

    addpath(genpath('lib'),'data');

    dataFile.name = select_data_file();
    if strcmp(dataFile.name, '!')
        return;
    end

    [dataFile.num, dataFile.raw] = read_data_file(dataFile.name);
    
    reply = select_processing_option(dataFile);
    if strcmp(reply, '!')
        return;
    end
    
end % supertypes()