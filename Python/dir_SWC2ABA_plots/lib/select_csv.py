def select_file_csv():
    import os
    
    fileDir = './data/'   
    
    fileNames = os.listdir(fileDir)
    
    csvFileNames = [ fileName for fileName in fileNames if fileName.endswith('.csv') ]
        
    nCsvFiles = len(csvFileNames)   

    reply = ''
    
    while (not reply):
    
        while True:
        
            try:
                print("\033c"); # clear screen
                
                print 'Please select your .csv file of interest from the selections below:\n'
                
                for i in range(nCsvFiles):
                
                    print '        {}) {}'.format(i+1, csvFileNames[i])
                    
                reply = raw_input('\nYour selection: ')
                
                ## process input ##
                if reply == '!':
                    return('!')
                else:
                    num = int(reply)
                    if num in range(1,nCsvFiles+1):
                        csvFileNameSelected = './data/' + csvFileNames[num-1]
                    else:
                        reply = ''
                    break
                    
            except ValueError:
                print 'Oops! That was not a valid number. Please try again ...'
        
    return(csvFileNameSelected)