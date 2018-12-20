def select_ARA_or_CCF():

    reply = ''
    
    # main loop to display menu choices and accept input
    # terminates when user chooses to exit
    while (not reply):
    
        try:
            print("\033c"); # clear screen
                
            ## display menu ##
            print 'Please select your file type of interest from the selections below:\n'
                
            print '     1) ARA'
            
            print '     2) CCF'
            
            print '     !) Exit'

            reply = raw_input('\nYour selection: ')
                
            ## process input ##
            if reply == '!':
                return('!')
            else:
                num = int(reply)
                if (num == 1):
                    return(1)
                elif (num == 2):
                    return(0)
                else:
                    reply = ''
                
        except ValueError:
            print 'Oops! That was not a valid number. Please try again ...'
