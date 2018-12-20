function [reply] = menu_save(csvFileName, cells)
% modified 20100917 by Diek W. Wheeler, Ph.D

    load adPCLtoggles
    load Cij.mat
    load CellCounts.mat
    
    baseFileName = 'parcel';
    
    fanmodSavedText = ['unsaved'; 
                       'saved  '];                  
    javaSavedText = ['unsaved';
                     'saved  ']; 
    neuroptikonSavedText = ['unsaved';
                            'saved  '];                 
    areCellsSavedFanmod = 0;
    areCellsSavedJava = 0;
    areCellsSavedNeuroptikon = 0;
    
    
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
        strng = sprintf('Connectivity - SAVE DATA FOR OUTPUT MENU\n');
        disp(strng);
        strng = sprintf('Select from the options below:\n');
        disp(strng);
        
        strng = sprintf('    1) Save presynaptic data in cells to FANMOD format (');
        strng = sprintf('%s%s', strng, deblank(fanmodSavedText(areCellsSavedFanmod+1,:)));            
        strng = sprintf('%s)', strng);
        disp(strng);

        strng = sprintf('    2) Save presynaptic data in cells to JAVA format (');
        strng = sprintf('%s%s', strng, deblank(javaSavedText(areCellsSavedJava+1,:)));            
        strng = sprintf('%s)', strng);
        disp(strng);

        strng = sprintf('    3) Save presynaptic data in cells to Neuroptikon format (');
        strng = sprintf('%s%s', strng, deblank(neuroptikonSavedText(areCellsSavedNeuroptikon+1,:)));            
        strng = sprintf('%s)', strng);
        disp(strng);
                        
        
        strng = sprintf('\n    G) Get/set base name output file {baseFileName} (%s)', baseFileName);
        disp(strng);
        disp('    B) Back to connectivity menu');
        disp('    !) Exit');
        
        
        %% process input %%
                
        reply = lower(input('\nYour selection: ', 's'));

        switch reply               
            case '1'
                [fanmod, cellIds, areCellsSavedFanmod] = cells2fanmod(cells, baseFileName, Cij);
                reply = [];

            case '2'
                [java, cellIds, areCellsSavedJava] = cells2java(cells, cellAbbrevs, baseFileName, Cij); 
                reply = [];
                
            case '3'
                [cellIds, areCellsSavedNeuroptikon] = cells2neuroptikon(cells, cellAbbrevs, Cij);
                reply = [];
            
                
            case 'g'
                baseFileName = get_new_string(baseFileName);
                reply = [];
                
            case 'b'
                % exit

            case '!'
                % exit
                
            otherwise
                reply = [];
                
        end % switch
        
    end % while loop
    
end % menu_save