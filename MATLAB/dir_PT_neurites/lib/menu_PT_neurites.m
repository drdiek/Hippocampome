function [fileName, reply] = menu_PT_neurites(allFileNames)

    nFileNames = length(allFileNames);

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select an XLSX file from the selections below.');
        disp(strng);

        for i = 1:nFileNames
            strng = sprintf('    %d) %s', i, allFileNames{i});
            disp(strng);
        end % for i
        
        disp('    @) Use UI to select file');
        disp('    !) Exit');
        
        reply = input('\nYour selection: ', 's');

        
        %% process input %%
        
        num = str2double(reply);

        if num <= nFileNames
            fileName = allFileNames{num};             
        
        else
            switch reply               
                case '@'
                    [fileName filePath] = uigetfile( '*.xlsx', 'Select XLSX file' );
                    
                    if isequal(fileName, 0)
                        disp(' !! NO VALID XLSX FILE SELECTED !! ');
                        pause
                        reply = [];

                    else
                        dotLocats = strfind(fileName, '.');
                        extension = fileName(dotLocats(end):length(fileName));
                        
                        if ~(isequal(extension, '.xlsx'))
                            disp(' !! PLEASE SELECT A FILE WITH .xlsx EXTENSION !! ');
                            pause
                            reply = [];
                        end
                        
                    end
                    
                case '!'
                    fileName = '!';
                    
                otherwise
                    reply = [];
                
            end % switch
            
        end % if num

    end % while loop
    
end % menu_PT_neurites()