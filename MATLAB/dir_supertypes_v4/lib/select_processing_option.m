function reply = select_processing_option(data)

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select your processing option from the selections below:\n');
        disp(strng);

        disp('    1) Plot "fuzzy" morphology matrix by types');
        
        disp('    2) Plot "fuzzy" morphology matrix by supertypes');
        
        disp('    3) Plot "fuzzy" morphology matrix by superfamilies');
        
        disp('    4) Plot "fuzzy" markers matrix');

        disp('    !) Exit');
        
        reply = input('\nYour selection: ', 's');

        
        %% process input %%

        switch reply
            case '1'
                define_constants();
                isPlotSupertypesOnly = 0;
                isPlotSuperfamiliesOnly = 0;
                [morphologyMatrix,subregionsMatrix,labelsMatrix,eoriMatrix,nSubGrouping] = ...
                    preprocess_fuzzy_morphology_data(data.raw,isPlotSupertypesOnly,isPlotSuperfamiliesOnly);
                plot_fuzzy_morphology_matrix(morphologyMatrix,subregionsMatrix,labelsMatrix,eoriMatrix,data.raw,...
                                             isPlotSupertypesOnly,isPlotSuperfamiliesOnly,nSubGrouping);
                reply = [];
                
            case '2'
                define_constants();
                isPlotSupertypesOnly = 1;
                isPlotSuperfamiliesOnly = 0;
                [morphologyMatrix,subregionsMatrix,labelsMatrix,eoriMatrix,nSubGrouping] = ...
                    preprocess_fuzzy_morphology_data(data.raw,isPlotSupertypesOnly,isPlotSuperfamiliesOnly);
                plot_fuzzy_morphology_matrix(morphologyMatrix,subregionsMatrix,labelsMatrix,eoriMatrix,data.raw,...
                                             isPlotSupertypesOnly,isPlotSuperfamiliesOnly,nSubGrouping);
                reply = [];
                
            case '3'
                define_constants();
                isPlotSupertypesOnly = 0;
                isPlotSuperfamiliesOnly = 1;
                [morphologyMatrix,subregionsMatrix,labelsMatrix,eoriMatrix,nSubgrouping] = ...
                    preprocess_fuzzy_morphology_data(data.raw,isPlotSupertypesOnly,isPlotSuperfamiliesOnly);
                plot_fuzzy_morphology_matrix(morphologyMatrix,subregionsMatrix,labelsMatrix,eoriMatrix,data.raw,...
                                             isPlotSupertypesOnly,isPlotSuperfamiliesOnly,nSubgrouping);
                reply = [];
                
            case '4'
                define_constants();
                markersMatrix = preprocess_fuzzy_markers_data(data.num);
                plot_fuzzy_markers_matrix(markersMatrix,data.raw);
                reply = [];
                
            case '!'
                ; % do nothing
                
            otherwise
                reply = [];
                
        end % switch
        
    end % while
    
end % select_processing_option()