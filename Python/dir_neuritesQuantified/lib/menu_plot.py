def menu_plot(neuritesQuantifiedDF):
    import pandas as pd
    from diek_functions import clr

    reply = ''
    

    while (not reply):
    
        clr() # print("\033c"); # clear screen
        print "Please enter a selection from the menu below:\n"
        print "        1) Total length"
        print "        2) % of neurite tree"
        print "        3) Density"
        print "        4) Average maximum path length"
        print "        5) Average mean path length"
        print "        6) Probabilities"
        print "        7) Periodic table"
        print "        !) Exit"
        print ""
        reply = raw_input("Your selection: ")
        
        if reply == '1': # Total length
            quantityDF = neuritesQuantifiedDF['Total_length (micron)']
            selections = [{'string'     : 'Total neurite length ($\mu$m)', \
                           'plotString' : 'Total_Neurite_Length', \
                           'selection'  : 1}]            
            quantitySelectionsDF = pd.DataFrame(selections)
        elif reply == '2': # % of neurite tree
            quantityDF = neuritesQuantifiedDF['%_of_neurite_tree']
            selections = [{'string'     : 'Percent of neurite tree', \
                           'plotString' : 'Percent_of_Neurite_Tree', \
                           'selection'  : 2}]            
            quantitySelectionsDF = pd.DataFrame(selections)
        elif reply == '3': # Density
            quantityDF = neuritesQuantifiedDF['Density']
            selections = [{'string'     : 'Density', \
                           'plotString' : 'Density', \
                           'selection'  : 3}]            
            quantitySelectionsDF = pd.DataFrame(selections)
        elif reply == '4': # Average maximum path length
            quantityDF = neuritesQuantifiedDF['Avg_max_path_length (micron)']
            selections = [{'string'     : 'Avg. max path length ($\mu$m)', \
                           'plotString' : 'Avg_Max_Path_Length', \
                           'selection'  : 4}]            
            quantitySelectionsDF = pd.DataFrame(selections)
        elif reply == '5': # Average mean path length
            quantityDF = neuritesQuantifiedDF['Avg_mean_path_length (micron)']
            selections = [{'string'     : 'Avg. mean path length ($\mu$m)', \
                           'plotString' : 'Avg_Mean_Path_Length', \
                           'selection'  : 5}]            
            quantitySelectionsDF = pd.DataFrame(selections)
        elif reply == '6': # Probabilities
            quantityDF = neuritesQuantifiedDF['Density']
            selections = [{'string'     : 'Probabilities', \
                           'plotString' : 'Probabilities', \
                           'selection'  : 6}]            
            quantitySelectionsDF = pd.DataFrame(selections)
        elif reply == '7': # Periodic table
            quantityDF = neuritesQuantifiedDF['Density']
            selections = [{'string'     : 'Periodic table', \
                           'plotString' : 'Periodic_table', \
                           'selection'  : 7}]            
            quantitySelectionsDF = pd.DataFrame(selections)
        elif reply == '!': # quit
            quantityDF = ''
            selections = ''
            quantitySelectionsDF = '!'
        else:
            reply = ''

    return(quantityDF, quantitySelectionsDF)