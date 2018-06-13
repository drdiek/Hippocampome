function reply = select_processing_option(data)

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select your processing option from the selections below:\n');
        disp(strng);

        disp('    1) Plot "fuzzy" morphology matrix by supertypes');
        
        disp('    2) Plot "fuzzy" morphology matrix by superfamilies');
        
        disp('    3) Plot "fuzzy" markers matrix');

        disp('    4) Determine supertypes of cell types');

        disp('    !) Exit');
        
        reply = input('\nYour selection: ', 's');

        
        %% process input %%

        switch reply
            case '1'
                define_constants();
                isPlotSupertypesOnly = 1;
                isPlotSuperfamiliesOnly = 0;
                morphologyMatrix = preprocess_fuzzy_morphology_data(data.num,isPlotSupertypesOnly,isPlotSuperfamiliesOnly);
                plot_fuzzy_morphology_matrix(morphologyMatrix,data.raw,isPlotSupertypesOnly,isPlotSuperfamiliesOnly);
                reply = [];
                
            case '2'
                define_constants();
                isPlotSupertypesOnly = 0;
                isPlotSuperfamiliesOnly = 1;
                morphologyMatrix = preprocess_fuzzy_morphology_data(data.num,isPlotSupertypesOnly,isPlotSuperfamiliesOnly);
                plot_fuzzy_morphology_matrix(morphologyMatrix,data.raw,isPlotSupertypesOnly,isPlotSuperfamiliesOnly);
                reply = [];
                
            case '3'
                markersMatrix = preprocess_fuzzy_markers_data(data.num);
                plot_fuzzy_markers_matrix(markersMatrix,data.raw);
                reply = [];
                
            case '4'
                determine_supertypes(data.raw,data.num);
                reply = [];
                
            case '!'
                ; % do nothing
                
            otherwise
                reply = [];
                
        end % switch
        
    end % while
    
end % select_processing_option()