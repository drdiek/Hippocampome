function [reply] = menu_connectivity(csvFileName, cells)
% modified 20100917 by Diek W. Wheeler, Ph.D
    
    
   load adPCLtoggles
    
    
    inputsOutputsSavedFlag = 1;
    
    inputsOutputsSavedStr = ['unsaved'; ...
                             'saved  '];
    
    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        clc;
        
        strng = sprintf('Current csv file is: %s\n', csvFileName);
        disp(strng);
        strng = sprintf('Including axons/dendrites CONTINUING in PCL? %s', bin2str(togglePCLcontinuing));
        disp(strng);
        strng = sprintf('Including axons/dendrites TERMINATING in PCL? %s\n', bin2str(togglePCLterminating));
        disp(strng);
        strng = sprintf('Connectivity - MAIN MENU\n');
        disp(strng);
        strng = sprintf('Select from the options below:\n');
        disp(strng);    
        
        disp('    1) Plot menu');
        disp('    2) Brain connectivity toolbox menu');
        disp('    3) Motifs menu');
        disp('    4) Save known and potential connectivity');
        disp('    5) Save connectivity in Graphviz format');
        disp(['    6) Save Inputs-Outputs in Graphviz format (', deblank(inputsOutputsSavedStr(inputsOutputsSavedFlag,:)), ')']);
        disp('    7) Save original FVE diagram in Graphviz format');
        disp('    8) Save data for outputting');    
        
        strng = sprintf('\n    B) Back to top menu');
        disp(strng);
        disp('    !) Exit');
        
        
        %% process input %%
        
        reply = lower(input('\nYour selection: ', 's'));

        switch reply               
            case '1'
                isSubpanels = 0;
                [reply] = menu_plot(csvFileName, cells);
                if ~strcmp(reply, '!')
                    reply = [];
                end            
                
            case '2'
                [reply] = menu_brain_conn(csvFileName);
                if ~strcmp(reply, '!')
                    reply = [];
                end                
                
            case '3'
                [reply] = menu_motifs(csvFileName);
                if ~strcmp(reply, '!')
                    reply = [];
                end                 

            case '4'
                outputConnToCsv();
                reply = [];

            case '5'
                outputConnToGv();
                reply = [];

            case '6'
                allInputsOutputsToGv();
                inputsOutputsSavedFlag = 2;
                reply = [];

            case '7'
                FveToGv();
                reply = [];

            case '8'
                [reply] = menu_save(csvFileName, cells);
                if ~strcmp(reply, '!')
                    reply = [];
                end       
                                
            case 'b'
                % exit

            case '!'
                % exit
                
            otherwise
                reply = [];
                
        end % switch
        
    end % while loop
    
end % menu_plot

