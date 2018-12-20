function isARA = select_ARA_or_CCF()
    addpath('./lib/menu');
    
        reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select your file type from the selections below:\n');
        disp(strng);

        strng = sprintf('    1) ARA');
        disp(strng);

        strng = sprintf('    2) CCF');
        disp(strng);
        
        disp('    !) Exit');
        
        reply = input('\nYour selection: ', 's');
        
        %% process input %%
        
        if strcmp(reply, '!')
            isARA = '!';
        else 
            num = str2double(reply);
            
            if (num == 1)
                isARA = 1;
            elseif (num == 2)
                isARA = 0;
            else
                reply = [];
            end % if num
        end
        
    end % while loop

end % select_ARA_or_CCF()