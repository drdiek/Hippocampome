def fetch_old_PMIDs():

    import pandas as pd

    import os
    
    fileNamesAll = os.listdir('./data/')
    
    i = 0
    fileNames = [None] * len(fileNamesAll)
    
    for strng in fileNamesAll:
        if strng.startswith('article') and strng.endswith('.csv'):
            fileNames[i] = strng
            i += 1
    nFiles = i
    

    reply = ''
    
    while (not reply):
    
        try:
            print("\033c"); # clear screen
                
            print 'Please select your csv file from the selections below:\n'
                
            for i in range(nFiles):                
                print '        {}) {}'.format(i+1, fileNames[i])
                    
            reply = raw_input('\nYour selection: ')
                
            if reply == '!':
                return('!')
            else:
                reply = int(reply)
                if reply in range(1,nFiles+1): 
                    fileName = fileNames[reply-1]
                else:
                    reply = ''
                break
                
        except ValueError:
            print 'Oops! That was not a valid number. Please try again ...'

    print "\nFetching old PMIDs ..."
    
    dataFrame = pd.read_csv('./data/{}'.format(fileName))

#     dfPMIDs = dataFrame['pmid_isbn']
    
    return(dataFrame)
