function [reply] = menu_markers(csvFileName, cellsMarkers, somataLoaded)
% modified 20100917 by Diek W. Wheeler, Ph.D

    load mij.mat
    
    isIncludeBrackets = 0;
    isIncludeSpeciesMethods = 1;
    isIncludeSubclassDivisionLines = 0;
    isPrintLegend = 1;
    isPrintMarkerNameKey = 0;
        
    save isIncludeMarkers.mat isIncludeBrackets isIncludeSpeciesMethods isIncludeSubclassDivisionLines isPrintLegend isPrintMarkerNameKey
    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))        
        %% display menu %%
        clc;
        save isIncludeMarkers.mat isIncludeBrackets isIncludeSpeciesMethods isIncludeSubclassDivisionLines isPrintLegend isPrintMarkerNameKey
        
        strng = sprintf('Current csv file is: %s\n', csvFileName);
        disp(strng);
        strng = sprintf('Markers - MAIN MENU\n');
        disp(strng);
        strng = sprintf('Select from the options below:\n');
        disp(strng);    
    
        
        strng = sprintf('    p) Plot markers matrix');
        disp(strng);        
        
%         strng = sprintf('    po8) Plot markers matrix: original 8 and "other"');
%         disp(strng);            
        
        strng = sprintf('    1) Toggle inclusion of species and methods info: %s', bin2str(isIncludeSpeciesMethods));
        disp(strng);

        strng = sprintf('    2) Toggle inclusion of subclass division lines: %s', bin2str(isIncludeSubclassDivisionLines));
        disp(strng);
        
        strng = sprintf('    3) Toggle printing of legend: %s', bin2str(isPrintLegend));
        disp(strng);        
        
%         strng = sprintf('    4) Toggle printing of marker name key: %s', bin2str(isPrintMarkerNameKey));
%         disp(strng);                
        
        
        strng = sprintf('\n    B) Back to top menu');
        disp(strng);
        disp('    !) Exit');
        
        
        %% process input %%
        
        reply = lower(input('\nYour selection: ', 's'));

        switch reply               
            case 'p'
                plot_markers(somataLoaded);                
                reply = []; 

%             case 'po8'
%                 plot_markers_orig8_oth();
%                 reply = []; 
               
            case '1'               
                isIncludeSpeciesMethods = ~isIncludeSpeciesMethods;
                reply = [];
                
            case '2'               
                isIncludeSubclassDivisionLines = ~isIncludeSubclassDivisionLines;
                reply = [];                

            case '3'               
                isPrintLegend = ~isPrintLegend;
                reply = [];   

%             case '4'
%                 isPrintMarkerNameKey = ~isPrintMarkerNameKey;
%                 reply = [];                 
                
            case 'b'
                % exit

            case '!'
                % exit
                
            otherwise
                reply = [];
                
        end % switch
        
    end % while loop
    
end % menu_plot

