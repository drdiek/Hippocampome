function subregion = select_subregion()

    subregions = { 'DG', ...
                   'CA3', ...
                   'CA2', ...
                   'CA1', ...
                   'SUB', ...
                   'EC' };

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select your subregion of interest from the selections below:\n');
        disp(strng);

        strng = sprintf('     1) Dentate Gyrus (DG)');
        disp(strng);
        
        strng = sprintf('     2) CA3');
        disp(strng);
        
        strng = sprintf('     3) CA2');
        disp(strng);
        
        strng = sprintf('     4) CA1');
        disp(strng);
        
        strng = sprintf('     5) Subiculum (SUB)');
        disp(strng);
        
        strng = sprintf('     6) Entorhinal Cortex (EC)');
        disp(strng);
        
        strng = sprintf('     a) All subregions');
        disp(strng);
        
        disp('     !) Exit');
        
        reply = input('\nYour selection: ', 's');

        
        %% process input %%
        
        if strcmp(reply, '!')
            subregion = '!';
        elseif strcmp(reply, 'a')
            subregion = 'All';
        else 
            num = str2double(reply);
            
            if ((num > 0) && (num <= 6))
                subregion = subregions{num};
            else
                reply = [];
            end % if num
        end
        
    end % while loop

end % select_file()