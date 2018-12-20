function neuriteFile = select_file(neuriteStr)

    fileDir = sprintf('./data/*%s*.csv', neuriteStr);

    neuriteFiles = dir(fileDir);
    nNeuriteFiles = length(neuriteFiles);

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select your %s .csv file from the selections below:\n', neuriteStr);
        disp(strng);

        for i = 1:nNeuriteFiles
            strng = sprintf('    %2d) %s', i, neuriteFiles(i).name);
            disp(strng);
        end % for i
        
        disp('     !) Exit');
        
        reply = input('\nYour selection: ', 's');

        
        %% process input %%
        
        if strcmp(reply, '!')
            neuriteFile = '!';
        else 
            num = str2double(reply);
            
            if ((num > 0) && (num <= nNeuriteFiles))
                neuriteFile = neuriteFiles(num).name;
            else
                reply = [];
            end % if num
        end
        
    end % while loop

end % select_file()