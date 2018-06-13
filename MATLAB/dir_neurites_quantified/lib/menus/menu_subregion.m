function subregion = menu_subregion(nCells)

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select a subregion of interest from the menu below ');
        disp(strng);
        
        strng = sprintf('         1) Dentate Gyrus (DG)');
        disp(strng);
        
        strng = sprintf('         2) CA3');
        disp(strng);
        
        strng = sprintf('         3) CA2');
        disp(strng);

        strng = sprintf('         4) CA1');
        disp(strng);

        strng = sprintf('         5) Subiculum (Sub)');
        disp(strng);

        strng = sprintf('         6) Entorhinal Cortex (EC)');
        disp(strng);

        strng = sprintf('         A) All');
        disp(strng);

        reply = lower(input('\nYour selection: ', 's'));
        
        switch reply
            
            case '1' % DG
                subregion.label = 'DG';
                subregion.code = 1;
                subregion.start = 1;
                subregion.end = nCells.DG;

            case '2' % CA3
                subregion.label = 'CA3';
                subregion.code = 2;
                subregion.start = 1+nCells.DG;
                subregion.end = nCells.DG+nCells.CA3;
                
            case '3' % CA2
                subregion.label = 'CA2';
                subregion.code = 3;
                subregion.start = 1+nCells.DG+nCells.CA3;
                subregion.end = nCells.DG+nCells.CA3+nCells.CA2;

            case '4' % CA1
                subregion.label = 'CA1';
                subregion.code = 4;
                subregion.start = 1+nCells.DG+nCells.CA3+nCells.CA2;
                subregion.end = nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1;

            case '5' % Sub
                subregion.label = 'Sub';
                subregion.code = 5;
                subregion.start = 1+nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1;
                subregion.end = nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1+nCells.Sub;

            case '6' % EC
                subregion.label = 'EC';
                subregion.code = 6;
                subregion.start = 1+nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1+nCells.Sub;
                subregion.end = nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1+nCells.Sub+nCells.EC;

            case 'a' % All
                subregion.label = 'All';
                subregion.code = 0;
                subregion.start = 1;
                subregion.end = nCells.DG+nCells.CA3+nCells.CA2+nCells.CA1+nCells.Sub+nCells.EC;
                
            case '!' % Exit
                subregion = '!';
                
            otherwise
                reply = [];
                
        end % switch
        
    end % while loop

end % menu_subregion()