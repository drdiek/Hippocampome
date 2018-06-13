function FP_generate_FP_matrix()

    clear all;    
    profile on

    addpath(genpath('lib'),'data');
    
    namesFileName = 'neuron_type_names.csv';
    [namesCellMatrix, isNamesFileLoaded] = load_csv_file(namesFileName);
    
    if isNamesFileLoaded
    
        nNames = size(namesCellMatrix, 1) - 1; % account for names header row
        namesHeaderRowNo = 1;
        namesCellIdColumnNo = 4;
        nNamesHeaderColumns = 7;
        
        patternsFileName = 'FP_patterns.csv';
        [patternsCellMatrix, isPatternsFileLoaded] = load_csv_file(patternsFileName);
        
        if isPatternsFileLoaded
           
            nPatterns = size(patternsCellMatrix, 2);
            patternsHeaderRowNo = 1;  
            namesByPatternsMatrix = zeros(nNames, nPatterns);
            
            parametersFileName = 'FPparameters.csv';
            [parametersCellMatrix, isParametersFileLoaded] = load_csv_file(parametersFileName)
            pause

            if isParametersFileLoaded
               
                nParameters = size(parametersCellMatrix, 2) - 1; % do not count parameters header column
                parametersUniqueIdRowNo = 3;
                parametersFiringPatternRowNo = 122;
                
                for iNamesRowNo = [1:nNames] + 1 % account for names header row
                    
                    namesCellId = str2num(namesCellMatrix{iNamesRowNo, namesCellIdColumnNo});
                                   
                    for jParametersColumnNo = [1:nParameters] + 1 % account for parameters header column
                        
                        parametersUniqueId = str2num(parametersCellMatrix{parametersUniqueIdRowNo, jParametersColumnNo});
                        
                        parametersFiringPattern = parametersCellMatrix{parametersFiringPatternRowNo, jParametersColumnNo};
                        
                                        
                        if (parametersUniqueId == namesCellId)
                           
                            for jPatternsColumnNo = 1:nPatterns
                               
                                patternsFiringPattern = patternsCellMatrix{patternsHeaderRowNo, jPatternsColumnNo};
                                
                                isSamePattern = strcmp(parametersFiringPattern, patternsFiringPattern);
                                
                                if isSamePattern
                                   
                                    % account for names header row
                                    namesByPatternsMatrix(iNamesRowNo-1, jPatternsColumnNo) = namesByPatternsMatrix(iNamesRowNo-1, jPatternsColumnNo) + 1;
                                    
                                end % if isSamePattern
                                
                            end % for patternsColumnNo
                            
                            
                        end % if (parametersUniqueId == namesCellId)
                        
                        
                    end % for jParametersColumnNo
                    
                    
                end % for iNamesRowNo
                    
                
                outputFileName = sprintf('./output/FP_csv_output/FP_matrix');
                
                outputFileName = sprintf('%s_%s.csv', outputFileName, datestr(now, 'yyyymmddHHMMSS'));
                
                fp = fopen(outputFileName, 'w');
                
                
                for jOutputNamesHeaderColumnNo = 1:nNamesHeaderColumns
                    
                    fprintf(fp, '%s,', namesCellMatrix{namesHeaderRowNo, jOutputNamesHeaderColumnNo});
                    
                end % for jOutputNamesHeaderColumnNo
                    
                for jOutputPatternsHeaderColumnNo = 1:nPatterns
                    
                    fprintf(fp, '%s', patternsCellMatrix{patternsHeaderRowNo, jOutputPatternsHeaderColumnNo});
                    
                    if (jOutputPatternsHeaderColumnNo < nPatterns)
                        
                        fprintf(fp, ',');
                        
                    end
                    
                end % for jOutputPatternsHeaderColumnNo
                
                fprintf(fp, '\n');
                
                
                for iOutputNamesRowNo = 1:nNames
                    
                    for jOutputNamesHeaderColumnNo = 1:nNamesHeaderColumns
                        
                        fprintf(fp, '%s,', namesCellMatrix{iOutputNamesRowNo+1, jOutputNamesHeaderColumnNo}); % account for names header columns
                        
                    end % for jOutputNamesHeaderColumnNo
                    
                    for jOutputPatternsColumnNo = 1:nPatterns
                        
                        fprintf(fp, '%d', namesByPatternsMatrix(iOutputNamesRowNo, jOutputPatternsColumnNo));
                        
                        if (jOutputPatternsColumnNo < nPatterns)
                            
                            fprintf(fp, ',');
                            
                        end
                        
                    end % for jOutputPatternsColumnNo
                                    
                    fprintf(fp, '\n');
                
                end % for iOutputNamesRowNo
                        
                
                fclose(fp);

            end % if isParametersFileLoaded
            
        end % if isPatternsFileLoaded
        
    end % if isNamesFileLoaded
    
end % function FP_generate_FP_matrix()