function nrrdFileName = select_file_nrrd(isARA)

    if isARA
        fileDir = sprintf('./data/*ara*.nrrd');
    else
        fileDir = sprintf('./data/*ccf*.nrrd');
    end
    fileDir = sprintf('./data/*.nrrd');
    
    nrrdFiles = dir(fileDir);
    nNrrdFiles = length(nrrdFiles);

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select your .nrrd file from the selections below:\n');
        disp(strng);

        for i = 1:nNrrdFiles
            strng = sprintf('    %2d) %s', i, nrrdFiles(i).name);
            disp(strng);
        end % for i
        
        disp('     !) Exit');
        
        reply = input('\nYour selection: ', 's');

        
        %% process input %%
        
        if strcmp(reply, '!')
            nrrdFileName = '!';
        else 
            num = str2double(reply);
            
            if num <= nNrrdFiles
                nrrdFileName = sprintf('./data/%s', nrrdFiles(num).name);
            else
                reply = [];
            end % if num
        end
        
    end % while loop

end % select_file()