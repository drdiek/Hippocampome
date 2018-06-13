function quantity = menu_plot(neuritesQuantified)

    reply = [];
    
    % main loop to display menu choices and accept input
    % terminates when user chooses to exit
    while (isempty(reply))
        %% display menu %%
        
        clc;
        
        strng = sprintf('Please enter a selection from the menu below ');
        disp(strng);
        
        disp('         1) Total length');
        
        disp('         2) % of neurite tree');
        
        disp('         3) Density');

        disp('         4) Average maximum path length');

        disp('         5) Average mean path length');

        disp('         6) Probabilities');

        disp('         7) Periodic table');

        reply = lower(input('\nYour selection: ', 's'));
        
        switch reply
            
            case '1' % Total length
                quantity.values = neuritesQuantified.totalLength;
                quantity.string = 'Total neurite length (\mum)';
                quantity.plotString = 'Total_Neurite_Length';
                quantity.selection = 1;

            case '2' % % of neurite tree
                quantity.values = neuritesQuantified.percentOfNeuriteTree;
                quantity.string = 'Percent of neurite tree';
                quantity.plotString = 'Percent_of_Neurite_Tree';
                quantity.selection = 2;

            case '3' % Density
                quantity.values = neuritesQuantified.density;
                quantity.string = 'Density';
                quantity.plotString = 'Density';
                quantity.selection = 3;

            case '4' % Average maximum path length
                quantity.values = neuritesQuantified.avgMaxPathLength;
                quantity.string = 'Avg. max path length (\mum)';
                quantity.plotString = 'Avg_Max_Path_Length';
                quantity.selection = 4;

            case '5' % Average mean path length
                quantity.values = neuritesQuantified.avgMeanPathLength;
                quantity.string = 'Avg. mean path length (\mum)';
                quantity.plotString = 'Avg_Mean_Path_Length';
                quantity.selection = 5;

            case '6' % Probabilities
                quantity.values = neuritesQuantified.density;
                quantity.string = 'Probabilities';
                quantity.plotString = 'Probabilities';
                quantity.selection = 6;

            case '7' % Periodic table
                quantity.values = neuritesQuantified.density;
                quantity.string = 'Periodic Table';
                quantity.plotString = 'Periodic_Table';
                quantity.selection = 7;

            case '!' % Exit
                quantity = '!';
                
            otherwise
                reply = [];
                
        end % switch
        
    end % while loop

end % menu_plot()