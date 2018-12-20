def select_file_nrrd():
    import os
    
    fileDir = './data/'   
    
    fileNames = os.listdir(fileDir)
    
    nrrdFileNames = [ fileName for fileName in fileNames if fileName.endswith('.nrrd') ]
        
    nNrrdFiles = len(nrrdFileNames)   

    reply = ''
    
    while (not reply):
    
        while True:
        
            try:
                print("\033c"); # clear screen
                
                print 'Please select your .nrrd file of interest from the selections below:\n'
                
                for i in range(nNrrdFiles):
                
                    print '        {}) {}'.format(i+1, nrrdFileNames[i])
                    
                reply = raw_input('\nYour selection: ')
                
                ## process input ##
                if reply == '!':
                    return('!')
                else:
                    reply = int(reply)
                    if reply in range(1,nNrrdFiles+1):
                        nrrdFileNameSelected = nrrdFileNames[reply-1]
                    else:
                        reply = ''
                    break
                    
            except ValueError:
                print 'Oops! That was not a valid number. Please try again ...'
        
    return(nrrdFileNameSelected)