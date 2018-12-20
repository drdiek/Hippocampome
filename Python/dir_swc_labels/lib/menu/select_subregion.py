def select_source_subregion():
    subregions = ['DG', \
                  'CA3', \
                  'CA2', \
                  'CA1', \
                  'SUB', \
                  'EC']
                  
    reply = ''
    
    # main loop to display menu choices and accept input
    # terminates when user chooses to exit
    while (not reply):
    
        try:
            print("\033c"); # clear screen
                
            ## display menu ##
            print 'Please select your subregion of interest from the selections below:\n'
                
            print '     1) Dentate Gyrus (DG)'
            
            print '     2) CA3'
            
            print '     3) CA2'
            
            print '     4) CA1'
            
            print '     5) Subiculum (SUB)'
            
            print '     6) Entorhinal Cortex (EC)'
            
            print '     a) All subregions'
            
            print '     !) Exit'

            reply = raw_input('\nYour selection: ')
                
            ## process input ##
            if reply == '!':
                return('!')
            elif reply == 'a':
                return('All')
            else:
                num = int(reply)
                if ((num > 0) & (num <= 6)):
                    return(subregions[num-1])
                else:
                    reply = ''
                
        except ValueError:
            print 'Oops! That was not a valid number. Please try again ...'
