function [fileName, reply] = get_file_name_PT_neurites()

    fileNames = dir('data/*.xlsx');
    fileNames = fileNames(~strncmpi('~', {fileNames.name}, 1));
    
    nFileNames = length(fileNames);
    for i=1:nFileNames
        allFileNames{i,1} = fileNames(i).name;
    end
    
    if (nFileNames == 1)
        fileName = allFileNames{1,1};
    elseif (nFileNames > 1)
        [fileName, reply] = menu_PT_neurites(allFileNames);
        if strcmp(reply,'!')
            return
        end
    end
    
end % get_file_name_PT_neurites()

