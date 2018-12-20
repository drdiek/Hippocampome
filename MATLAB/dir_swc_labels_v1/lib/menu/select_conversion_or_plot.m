function isConversion = select_conversion_or_plot()
    addpath('./lib/menu');
    
        reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select your processing option from the selections below:\n');
        disp(strng);

        strng = sprintf('    1) Conversion of .swc file(s)');
        disp(strng);

        strng = sprintf('    2) Plotting of an .swc file');
        disp(strng);
        
        disp('    !) Exit');
        
        reply = input('\nYour selection: ', 's');
        
        %% process input %%
        
        if strcmp(reply, '!')
            isConversion = '!';
        else 
            num = str2double(reply);
            
            if (num == 1)
                isConversion = 1;
            elseif (num == 2)
                isConversion = 0;
            else
                reply = [];
            end % if num
        end
        
    end % while loop

end % select_conversion_or_plot()