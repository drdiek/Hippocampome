% This function defines the entry point for the program.
% As such, it displays a text-based menu, accepts input
% from the user, and calls the appropriate function.

function run()
    clear all;    
    profile on

    addpath(genpath('lib'),'data');

    csvHippFileNames = dir('./data/*.csv');
    nCsvHippFileNames = length(csvHippFileNames);
    for i=1:nCsvHippFileNames
        allHippFileNames{i,1} = csvHippFileNames(i).name;
    end
        
    xlsHippFileNames = dir('./data/*.xls*');
    nXlsHippFileNames = length(xlsHippFileNames);
    for i=1:nXlsHippFileNames
        allHippFileNames{i+nCsvHippFileNames,1} = xlsHippFileNames(i).name;
    end
    
    nAllHippFileNames = length(allHippFileNames);
 
    if (nAllHippFileNames == 1)
        fileName = allHippFileNames{1};
    elseif (nAllHippFileNames > 1)
        [fileName, reply] = menu_file_name(allHippFileNames);
        if strcmp(reply, '!')
            return
        end
    end

    
    togglePCLcontinuing = 1;
    togglePCLterminating = 1;
    isIncludeApprovedClasses = 1;                
    isIncludeVirtualClasses = 0;
    isIncludeSuspendedClasses = 0;
    isIncludeTempUnapprovedActiveClasses = 0;
    isIncludeTempUnapprovedSuspendedClasses = 0;
    isIncludePremergerActiveClasses = 0;
    isIncludeMergedActiveClasses = 0;
    isIncludeDisappearingActiveClasses = 0;
    isIncludeSwitching1p0OnHoldClasses = 0;
    isIncludeSwitching2p0OnHoldClasses = 0;
    isInclude2p0ApprovedOnHoldClasses = 0;
    isIgnoreReinterpretedActiveClasses = 1;

    isIncludeBrackets = 0;
    isIncludeInactiveMarkers_Summary = 1;
    isIncludeInactiveMarkers_All = 0;

    subOrNot = 0;
    automaticModel = 1;
    
    save toggles.mat subOrNot automaticModel    
    

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Current file is: %s\n', fileName);
        disp(strng);
        
        strng = sprintf('Please enter a selection from the menu below\n');
%         strng = sprintf('%s(current values in parentheses): \n', strng);
        disp(strng);

        
        disp('    c) Convert matrix of cells to Cij matrix');

        strng = sprintf('         1) Toggle inclusion of axons/dendrites CONTINUING in PCL: %s', bin2str(togglePCLcontinuing));
        disp(strng);

        strng = sprintf('         2) Toggle inclusion of axons/dendrites TERMINATING in PCL: %s\n', bin2str(togglePCLterminating));
        disp(strng);

        strng = sprintf('         3) Toggle inclusion of approved/(v1.0 Rank 1-3 active) classes (N): %s', bin2str(isIncludeApprovedClasses));
        disp(strng);

        strng = sprintf('         4) Toggle inclusion of unapproved active classes (T): %s', bin2str(isIncludeTempUnapprovedActiveClasses));
        disp(strng);

        strng = sprintf('         5) Toggle inclusion of unapproved merged/(v1.0 Rank 4-5 active) classes (M): %s', bin2str(isIncludeMergedActiveClasses));
        disp(strng);

        strng = sprintf('         6) Toggle inclusion of premerger/(v2.0 approved active) classes (P): %s\n', bin2str(isIncludePremergerActiveClasses));
        disp(strng);

        strng = sprintf('         7) Toggle inclusion of unapproved suspended/(v2.0 unapproved on-hold) classes (S): %s', bin2str(isIncludeTempUnapprovedSuspendedClasses));
        disp(strng);

        strng = sprintf('         8) Toggle inclusion of suspended/(v1.0 on-hold) classes (X): %s\n', bin2str(isIncludeSuspendedClasses));
        disp(strng);

        strng = sprintf('         9) Toggle inclusion of virtual/(v2.0 unapproved active) classes (V): %s\n', bin2str(isIncludeVirtualClasses));
        disp(strng);

        strng = sprintf('        10) Toggle inclusion of (v1.0 disappearing active) classes (O): %s\n', bin2str(isIncludeDisappearingActiveClasses));
        disp(strng);

        strng = sprintf('        11) Toggle inclusion of (v1.0 on-hold classes becoming unapproved active) classes (W): %s', bin2str(isIncludeSwitching1p0OnHoldClasses));
        disp(strng);

        strng = sprintf('        12) Toggle inclusion of (v2.0 on-hold classes becoming unapproved active) classes (Q): %s\n', bin2str(isIncludeSwitching2p0OnHoldClasses));
        disp(strng);

        strng = sprintf('        13) Toggle inclusion of (v2.0 approved on-hold) classes (Y): %s\n', bin2str(isInclude2p0ApprovedOnHoldClasses));
        disp(strng);

        strng = sprintf('    L) Load a different csv file (');
        strng = sprintf('%s%s', strng, deblank(fileName));
        strng = sprintf('%s)', strng);
        disp(strng);
        
        disp(' ');
        disp('    !) Exit');
        
        %% process input %%
        
        reply = lower(input('\nYour selection: ', 's'));

        switch reply
            case 'c'
                [cells, isFileLoaded] = load_csvFile(fileName);
                if isFileLoaded
                    if isIncludeApprovedClasses || ...
                            isIncludeVirtualClasses || ...
                            isIncludeSuspendedClasses || ...
                            isIncludeTempUnapprovedActiveClasses || ...
                            isIncludeTempUnapprovedSuspendedClasses || ...
                            isIncludePremergerActiveClasses || ...
                            isIncludeDisappearingActiveClasses || ...
                            isIncludeSwitching1p0OnHoldClasses || ...
                            isIncludeSwitching2p0OnHoldClasses || ...
                            isInclude2p0ApprovedOnHoldClasses || ...
                            isIncludeMergedActiveClasses

                        save 'connectivityToggles' togglePCLcontinuing ...
                                                   togglePCLterminating ...
                                                   isIncludeApprovedClasses ...
                                                   isIncludeVirtualClasses ...
                                                   isIncludeSuspendedClasses ...
                                                   isIncludeTempUnapprovedActiveClasses ...
                                                   isIncludeTempUnapprovedSuspendedClasses ...
                                                   isIncludePremergerActiveClasses ...
                                                   isIncludeMergedActiveClasses ...
                                                   isIncludeDisappearingActiveClasses ...
                                                   isIncludeSwitching1p0OnHoldClasses ...
                                                   isIncludeSwitching2p0OnHoldClasses ...
                                                   isInclude2p0ApprovedOnHoldClasses ...
                                                   isIgnoreReinterpretedActiveClasses

                        save 'adPCLtoggles' togglePCLcontinuing togglePCLterminating
                    
                        current_parcellation_data(cells);
                        
                        cells2cij(cells);
                        
                        reply = menu_connectivity(fileName, cells);
                        if ~strcmp(reply, '!')
                            reply = [];
                        end
                    else
                        disp('Please toggle on at least one class type for analysis.  Press any key.');
                        pause
                        reply = [];
                    end

                else
                    disp('Error: file not loaded!');
                    reply = [];
                end
                
            case '1'
                togglePCLcontinuing = ~togglePCLcontinuing;
                reply = [];
                
            case '2'
                togglePCLterminating = ~togglePCLterminating;
                reply = [];

            case '3'
                isIncludeApprovedClasses = ~isIncludeApprovedClasses;
                reply = [];
                
            case '4'
                isIncludeTempUnapprovedActiveClasses = ~isIncludeTempUnapprovedActiveClasses;
                reply = [];                
                
            case '5'
                isIncludeMergedActiveClasses = ~isIncludeMergedActiveClasses;
                reply = [];                
                
            case '6'
                isIncludePremergerActiveClasses = ~isIncludePremergerActiveClasses;
                reply = [];                
                
            case '7'
                isIncludeTempUnapprovedSuspendedClasses = ~isIncludeTempUnapprovedSuspendedClasses;
                reply = [];                
                
            case '8'
                isIncludeSuspendedClasses = ~isIncludeSuspendedClasses;
                reply = [];
                
            case '9'
                isIncludeVirtualClasses = ~isIncludeVirtualClasses;
                reply = [];

            case '10'
                isIncludeDisappearingActiveClasses = ~isIncludeDisappearingActiveClasses;
                reply = [];

            case '11'
                isIncludeSwitching1p0OnHoldClasses = ~isIncludeSwitching1p0OnHoldClasses;
                reply = [];

            case '12'
                isIncludeSwitching2p0OnHoldClasses = ~isIncludeSwitching2p0OnHoldClasses;
                reply = [];

            case '13'
                isInclude2p0ApprovedOnHoldClasses = ~isInclude2p0ApprovedOnHoldClasses;
                reply = [];
                
            case 'l'
                csvHippFileNames = dir('*.csv');
                nCsvHippFileNames = length(csvHippFileNames);
                for i=1:nCsvHippFileNames
                    allHippFileNames{i,1} = csvHippFileNames(i).name;
                end

                xlsHippFileNames = dir('*.xls*');
                nXlsHippFileNames = length(xlsHippFileNames);
                for i=1:nXlsHippFileNames
                    allHippFileNames{i+nCsvHippFileNames,1} = xlsHippFileNames(i).name;
                end
                
                [fileName, reply] = menu_file_name(allHippFileNames);
                if ~strcmp(reply, '!')
                    reply = [];
                end
                
            % exit; save profile
            case '$'
                p = profile('info');
                profsave(p,'profile_results');
                
            % exit; don't save profile
            case '!'
                %exit
                
            otherwise
                reply = [];
        
        end % switch
        
    end % while loop
    
    clean_exit()% exit
    
end % run