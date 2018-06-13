function counts()

    addpath(genpath('lib'));
    directory = './data/';
    suffix = 'xlsx';
    [fileName, allFileNames] = get_file_name(directory, suffix);
    
    if ~strcmp(fileName, '!')
        
        if strcmp(fileName, 'A') % process all xlsx files
            
            for i = 1:length(allFileNames)
                
                [diameters, runningAvgs, nCount, nFormula, N, header] = load_data_file(allFileNames{i,1});
                index = find_crossover(nCount, nFormula);
                save_crossover_data(allFileNames{i,1}, header, diameters(1:index), runningAvgs(1:index), nCount(1:index), nFormula(1:index));
                
            end % i
            
        else % fileName ~= 'A' so process a single xlsx file
            
            isDataLoaded = 0;
            isDataSaved = 0;
            isCrossoverFound = 0;
            
            nCountCrossover = NaN;
            nFormulaCrossover = NaN;
            
            reply = [];
            
            % main loop to display menu choices and accept input
            % terminates when user chooses to exit
            while (isempty(reply))
                %% display menu %%
                
                clc;
                
                strng = sprintf('Please enter a selection from the menu below:\n');
                disp(strng);
                
                strng = sprintf('         l) data (l)oaded from file %s: %s', fileName, bin2str(isDataLoaded));
                disp(strng);
                
                strng = sprintf('         f) (f)ind the cross-over point: N(count) = %d and N(formula) = %.4f', nCountCrossover, nFormulaCrossover);
                disp(strng);
                
                strng = sprintf('         s) cross-over data (s)aved to file: %s', bin2str(isDataSaved));
                disp(strng);
                
                disp('         !) Exit');
                
                reply = lower(input('\nYour selection: ', 's'));
                
                switch reply
                    
                    case 'l'
                        [diameters, runningAvgs, nCount, nFormula, N, header] = load_data_file(fileName);
                        isDataLoaded = ~isDataLoaded;
                        reply = [];
                        
                    case 'f'
                        if ~isDataLoaded
                            disp(' ');
                            disp('*** no data has been loaded ***');
                            pause
                        else
                            index = find_crossover(nCount, nFormula);
                            nCountCrossover = nCount(index);
                            nFormulaCrossover = nFormula(index);
                            isCrossoverFound = ~isCrossoverFound;
                            figure(1);
                            plot(1:N,nCount);
                            hold on
                            plot(1:N,nFormula,'r');
                        end
                        reply = [];
                        
                    case 's'
                        if ~isCrossoverFound
                            disp(' ');
                            disp('*** the cross-over point has not yet been found ***');
                            pause
                        else
                            save_crossover_data(fileName, header, diameters(1:index), runningAvgs(1:index), nCount(1:index), nFormula(1:index));
                            isDataSaved = ~isDataSaved;
                        end
                        reply = [];
                        
                    case '!'
                        % exit
                        
                    otherwise
                        reply = [];
                        
                end % switch
                
            end % while loop
            
        end % if strcmp(fileName, 'A')
        
    end % if ~strcmp(fileName, '!')
        
    clean_exit()% exit
    
end
