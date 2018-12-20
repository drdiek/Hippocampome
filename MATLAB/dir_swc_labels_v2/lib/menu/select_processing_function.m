function processingFunction = select_processing_function()

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select your processing function of interest from the selections below:\n');
        disp(strng);

        strng = sprintf('     1) Conversion of .swc file(s)');
        disp(strng);

        strng = sprintf('     2) Plotting of an .swc file');
        disp(strng);
        
        strng = sprintf('     3) Creation of a morphology matrix file');
        disp(strng);
                
        strng = sprintf('     4) Creation of an Elastix point list file');
        disp(strng);
                
        strng = sprintf('     5) Write Transformix file to .swc file');
        disp(strng);
                
        disp('     !) Exit');
        
        reply = input('\nYour selection: ', 's');

        
        %% process input %%
        
        if strcmp(reply, '!')
            processingFunction = '!';
        else 
            num = str2double(reply);
            
            if ((num > 0) && (num <= 5))
                processingFunction = num;
            else
                reply = [];
            end % if num
        end
        
    end % while loop

end % select_file()