function dataFile = select_data_file()

    swcFiles = dir('./data/*.swc');
    nSwcFiles = length(swcFiles);

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select your SWC file from the selections below:\n');
        disp(strng);

        for i = 1:nSwcFiles
            strng = sprintf('    %d) %s', i, swcFiles(i).name);
            disp(strng);
        end % for i
        
        disp('    !) Exit');
        
        reply = input('\nYour selection: ', 's');

        
        %% process input %%
        
        if strcmp(reply, '!')
            dataFile = '!';
        else 
            num = str2double(reply);
            
            if num <= nSwcFiles
                dataFile = swcFiles(num).name;
            else
                reply = [];
            end % if num
        end
        
    end % while loop

end % select_data_file()