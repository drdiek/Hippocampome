def read_data_file(dataFileName):

    import pandas as pd
    
    print '\nLoading data file ...'
    dataFrame = pd.read_excel('./data/{}'.format(dataFileName),skiprows=18)
    
    return(dataFrame)