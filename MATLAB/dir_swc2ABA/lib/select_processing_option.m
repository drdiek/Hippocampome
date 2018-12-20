function reply = select_processing_option(ids, X, Y, Z, R, pids, ANO, dataFileName)

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select your processing option from the selections below:\n');
        disp(strng);

        disp('    1) Assign parcel values to X,Y,Z coordinates');
        
        disp('    2) Plot parcel values');
        
        disp('    3) Save SWC file parcel values');
        
        disp('    !) Exit');
        
        reply = input('\nYour selection: ', 's');

        
        %% process input %%

        switch reply
            case '1'
                parcels = assign_parcel_values(X, Y, Z, ANO);
                reply = [];
                
            case '2'
                plot_parcel_values(parcels);
                reply = [];
                
            case '3'
                save_parcel_values(ids, parcels, X, Y, Z, R, pids, dataFileName);
                reply = [];
                
            case '!'
                ; % do nothing
                
            otherwise
                reply = [];
                
        end % switch
        
    end % while
    
end % select_processing_option()