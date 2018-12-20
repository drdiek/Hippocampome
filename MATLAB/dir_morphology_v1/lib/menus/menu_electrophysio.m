function [reply] = menu_electrophysio(fileName)
% modified 20100917 by Diek W. Wheeler, Ph.D

    load eij.mat Eij
    nEijTotal = size(Eij,1)*size(Eij,2);
    nEijFilled = sum(sum(sign(Eij))); 
    EijFilledPercentage = 100*nEijFilled/nEijTotal;
                
    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        clc;
        
        strng = sprintf('Current csv file is: %s\n', fileName);
        disp(strng);
        strng = sprintf('Electrophysiological data - MAIN MENU\n');
        disp(strng);
        strng = sprintf('Select from the options below:\n');
        disp(strng);    
        
        strng = sprintf('    1) Plot Eij matrix (%d / %d = %.1f%% filled)', ...
            nEijFilled, nEijTotal, EijFilledPercentage);
        disp(strng);
        
        strng = sprintf('\n    B) Back to top menu');
        disp(strng);
        disp('    !) Exit');
        
        
        %% process input %%
        
        reply = lower(input('\nYour selection: ', 's'));

        switch reply               
            case '1'               
                plot_electrophysio();
                reply = []; 
                
            case 'b'
                % exit

            case '!'
                % exit
                
            otherwise
                reply = [];
                
        end % switch
        
    end % while loop
    
end % menu_plot

