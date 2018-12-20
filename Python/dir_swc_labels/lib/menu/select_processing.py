def select_processing_function():

    reply = ''
    
    # main loop to display menu choices and accept input
    # terminates when user chooses to exit
    while (not reply):
    
        try:
            print("\033c"); # clear screen
                
            ## display menu ##
            print 'Please select your processing function of interest from the selections below:\n'
                
            print '     1) Conversion of .swc file(s)'
            
            print '     2) Plotting of an .swc file'
            
            print '     3) Creation of a morphology matrix file'
            
            print '     !) Exit'

            reply = raw_input('\nYour selection: ')
                
            ## process input ##
            if reply == '!':
                return('!')
            else:
                num = int(reply)
                if ((num > 0) & (num <= 3)):
                    return(num)
                else:
                    reply = ''
                
        except ValueError:
            print 'Oops! That was not a valid number. Please try again ...'
