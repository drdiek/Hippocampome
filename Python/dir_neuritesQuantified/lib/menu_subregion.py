def menu_subregion(nCells):
    from diek_functions import clr

    reply = ''
    
    while (not reply):
    
        clr() # print("\033c"); # clear screen
        print "Please select a subregion of interest from the menu below:\n"
        print "        1) Dentate gyrus (DG)"
        print "        2) CA3"
        print "        3) CA2"
        print "        4) CA1"
        print "        5) Subiculum (Sub)"
        print "        6) Entorhinal cortex (EC)"
        print "        A) All"
        print "        !) Exit"
        print ""
        reply = raw_input("Your selection: ")

        if reply == '1': # Dentate gyrus (DG)
            selections = [{'label' : 'DG', \
                           'code'  : 1, \
                           'start' : 0, \
                           'end'   : sum(nCells[0:1])}]            
            subregionDF = pd.DataFrame(selections)
        elif reply == '2': # CA3
            selections = [{'label' : 'CA3', \
                           'code'  : 2, \
                           'start' : sum(nCells[0:1]), \
                           'end'   : sum(nCells[0:2])}]            
            subregionDF = pd.DataFrame(selections)
        elif reply == '3': # CA2
            selections = [{'label' : 'CA2', \
                           'code'  : 3, \
                           'start' : sum(nCells[0:2]), \
                           'end'   : sum(nCells[0:3])}]            
            subregionDF = pd.DataFrame(selections)
        elif reply == '4': # CA1
            selections = [{'label' : 'CA1', \
                           'code'  : 4, \
                           'start' : sum(nCells[0:3]), \
                           'end'   : sum(nCells[0:4])}]            
            subregionDF = pd.DataFrame(selections)
        elif reply == '5': # Subiculum (Sub)
            selections = [{'label' : 'Sub', \
                           'code'  : 5, \
                           'start' : sum(nCells[0:4]), \
                           'end'   : sum(nCells[0:5])}]            
            subregionDF = pd.DataFrame(selections)
        elif reply == '6': # Entorhinal cortex (EC)
            selections = [{'label' : 'EC', \
                           'code'  : 6, \
                           'start' : sum(nCells[0:5]), \
                           'end'   : sum(nCells[0:6])}]            
            subregionDF = pd.DataFrame(selections)
        elif (reply == 'a' or replay == 'A'): # All
            selections = [{'label' : 'All', \
                           'code'  : 0, \
                           'start' : 0, \
                           'end'   : sum(nCells[0:6])}]            
            subregionDF = pd.DataFrame(selections)
        elif reply == '!':
            subregionDF = '!'
        else:
            reply = ''
            
    return(subregionDF)

