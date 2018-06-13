function orderingColumnNo = menu_ordering_column(ABCorderingColumnNo,HCorderingColumnNo,cellIDorderingColumnNo)

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please select an ordering method of interest from the menu below\n');
        disp(strng);
        
        strng = sprintf('         1) ABC ordering');
        disp(strng);
        
        strng = sprintf('         2) HC ordering');
        disp(strng);
        
        strng = sprintf('         3) Cell ID ordering');
        disp(strng);
        
        reply = lower(input('\nYour selection: ', 's'));
        
        switch reply
            
            case '1' % ABC ordering
                orderingColumnNo = ABCorderingColumnNo;

            case '2' % HC ordering
                orderingColumnNo = HCorderingColumnNo;

            case '3' % Cell ID ordering
                orderingColumnNo = cellIDorderingColumnNo;

            case '!' % Exit
                orderingColumnNo = '!';
                
            otherwise
                reply = [];
                
        end % switch
        
    end % while

end % menu_ordering_column()