function dataFile = select_data_file(N)

    xlsxFiles = dir('./data/*.xlsx');
    nXlsxFiles = length(xlsxFiles);

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        if (N == 1)
            ordinalStr = 'first';
        elseif (N == 2)
            ordinalStr = 'second';
        else
            ordinalStr = '';
        end
        
        strng = sprintf('Please select your %s Excel file from the selections below:\n', ordinalStr);
        disp(strng);

        for i = 1:nXlsxFiles
            strng = sprintf('    %d) %s', i, xlsxFiles(i).name);
            disp(strng);
        end % for i
        
        disp('    !) Exit');
        
        reply = input('\nYour selection: ', 's');

        
        %% process input %%
        
        if strcmp(reply, '!')
            dataFile = '!';
        else 
            num = str2double(reply);
            
            if num <= nXlsxFiles
                dataFile = xlsxFiles(num).name;
            else
                reply = [];
            end % if num
        end
        
    end % while loop

end % select_data_file()