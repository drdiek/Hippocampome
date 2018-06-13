def select_data_file(N):

    import os
    import sys
    
    fileNamesAll = os.listdir('./data/')
    
    i = 0
    fileNames = [None] * len(fileNamesAll)
    
    for strng in fileNamesAll:
        if strng.endswith('.xlsx'):
            fileNames[i] = strng
            i += 1
    nFiles = i
    

    reply = ''
    
    while (not reply):
    
        try:
            print("\033c"); # clear screen
                
            if (N == 1):
                ordinalStr = 'first';
            elif (N == 2):
                ordinalStr = 'second';
            else:
                ordinalStr = '';                
                
            print 'Please select your {} Excel file from the selections below:\n'.format(ordinalStr);
                
            for i in range(nFiles):                
                print '        {}) {}'.format(i+1, fileNames[i])
                    
            reply = raw_input('\nYour selection: ')
                
            if reply == '!':
                return('!')
            else:
                reply = int(reply)
                if reply in range(1,nFiles+1): 
                    return(fileNames[reply-1])
                else:
                    reply = ''
                break
                
        except ValueError:
            print 'Oops! That was not a valid number. Please try again ...'
