function swcFile = select_file_swc(isARA, subregion)

    if isARA
        fileDir = sprintf('./data/ARA/*.swc');
    else
        if strcmp(subregion, 'DG')
            fileDir = sprintf('./data/CCF/*DG*.swc');
        elseif strcmp(subregion, 'CA3')
            fileDir = sprintf('./data/CCF/*CA3*.swc');
        elseif strcmp(subregion, 'CA2')
            fileDir = sprintf('./data/CCF/*CA2*.swc');
        elseif strcmp(subregion, 'CA1')
            fileDir = sprintf('./data/CCF/*CA1*.swc');
        elseif strcmp(subregion, 'SUB')
            fileDir = sprintf('./data/CCF/*SUB*.swc');
        elseif strcmp(subregion, 'EC')
            fileDir = sprintf('./data/CCF/*EC*.swc');
        else % subregion == 'All'
            fileDir = sprintf('./data/CCF/*.swc');
        end % if (subregion)
    end
    
    swcFiles = dir(fileDir);
    nSwcFiles = length(swcFiles);

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select your .swc file from the selections below:\n');
        disp(strng);

        for i = 1:nSwcFiles
            strng = sprintf('    %2d) %s', i, swcFiles(i).name);
            disp(strng);
        end % for i
        
        strng = sprintf('     a) All files');
        disp(strng);
        
        disp('     !) Exit');
        
        reply = input('\nYour selection: ', 's');

        
        %% process input %%
        
        if strcmp(reply, '!')
            swcFile = '!';
        elseif strcmp(reply, 'a')
            swcFile = swcFiles(1:nSwcFiles);
        else 
            num = str2double(reply);
            
            if ((num > 0) && (num <= nSwcFiles))
                swcFile(1).name = swcFiles(num).name;
            else
                reply = [];
            end % if num
        end
        
    end % while loop

end % select_file()