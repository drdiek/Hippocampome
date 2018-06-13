def read_data_file(dataFileName, i):

    import pandas as pd
    
    print '\nLoading data file #{} ...'.format(i+1)
    dataFrame = pd.read_excel('./data/{}'.format(dataFileName))
    
    # third column is NMO ID
    dataFrame.sort_values(by=['neuron_id'])
    
    return(dataFrame)