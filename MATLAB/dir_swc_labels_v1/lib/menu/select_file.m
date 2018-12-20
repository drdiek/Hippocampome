function dataFile = select_file(suffix, isARA)

    if strcmp(suffix, '.swc')
        if isARA
            fileDir = sprintf('./data/ARA/*%s', suffix);
        else
            fileDir = sprintf('./data/CCF/*%s', suffix);
        end
    else % suffix == '.nrrd'
        if isARA
            fileDir = sprintf('./data/*ara*%s', suffix);
        else
            fileDir = sprintf('./data/*ccf*%s', suffix);
        end
    end
    dataFiles = dir(fileDir);
    nDataFiles = length(dataFiles);

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select your %s file from the selections below:\n', suffix);
        disp(strng);

        for i = 1:nDataFiles
            strng = sprintf('    %2d) %s', i, dataFiles(i).name);
            disp(strng);
        end % for i
        
        strng = sprintf('     a) All files');
        disp(strng);
        
        disp('     !) Exit');
        
        reply = input('\nYour selection: ', 's');

        
        %% process input %%
        
        if strcmp(reply, '!')
            dataFile = '!';
        elseif strcmp(reply, 'a')
            dataFile = dataFiles;
        else 
            num = str2double(reply);
            
            if num <= nDataFiles
                dataFile(1).name = dataFiles(num).name;
            else
                reply = [];
            end % if num
        end
        
    end % while loop

end % select_file()