function csvFileName = select_file_csv()

    fileDir = sprintf('./data/*.csv');
    
    csvFiles = dir(fileDir);
    nCsvFiles = length(csvFiles);

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select your .csv file from the selections below:\n');
        disp(strng);

        for i = 1:nCsvFiles
            strng = sprintf('    %2d) %s', i, csvFiles(i).name);
            disp(strng);
        end % for i
        
        disp('     !) Exit');
        
        reply = input('\nYour selection: ', 's');

        
        %% process input %%
        
        if strcmp(reply, '!')
            csvFileName = '!';
        else 
            num = str2double(reply);
            
            if num <= nCsvFiles
                csvFileName = sprintf('./data/%s', csvFiles(num).name);
            else
                reply = [];
            end % if num
        end
        
    end % while loop

end % select_file_csv()