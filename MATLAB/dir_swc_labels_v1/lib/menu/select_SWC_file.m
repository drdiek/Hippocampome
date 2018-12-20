function SWCFile = select_SWC_file()

    SWCFiles = dir('../../data/*.swc');
    nSWCFiles = length(SWCFiles);

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select your SWC file from the selections below:\n');
        disp(strng);

        for i = 1:nSWCFiles
            strng = sprintf('    %d) %s', i, SWCFiles(i).name);
            disp(strng);
        end % for i
        
        disp('    !) Exit');
        
        reply = input('\nYour selection: ', 's');

        
        %% process input %%
        
        if strcmp(reply, '!')
            SWCFile = '!';
        else 
            num = str2double(reply);
            
            if num <= nSWCFiles
                SWCFile = SWCFiles(num).name;
            else
                reply = [];
            end % if num
        end
        
    end % while loop

end % select_SWC_file()