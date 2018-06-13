def initialize_variables(fileName):
    # initialize variables for NeuroElectro() ##############################
    import pandas as pd

    print '\nInitializing variables ...'
    
    # data file has already been preprocessed
    # 1) Full database download of csv file from NeuroElectro.org
    # 2) csv file is retagged as a txt file
    # 3) txt file is read into Excel as tab delimited and text qualifier: {none}
    # 4) all " characters are removed from the first column
    # 5) file is saved as an xlsx file
    
    dataFrame = pd.read_excel('./data/{}'.format(fileName))
    
    # Keep data from file from columns "Index" through to "PrepType"
    dataFrame = dataFrame.loc[:, 'Index':'PrepType']
    
    # Remove spurious rows of data by checking for TRUE/FALSE value for "MetadataCurated" column
    N = len(dataFrame.index)
    i = 0
    while (i < N):
        if pd.isnull(dataFrame.loc[i, 'MetadataCurated']) or pd.isnull(dataFrame.loc[i, 'Index']) or pd.isnull(dataFrame.loc[i, 'Title']) or isinstance(dataFrame.loc[i, 'Index'], basestring):
            dataFrame = dataFrame.drop([i])
            N -= 1
        i += 1
    
    dataFrame.insert(loc=7, column='HippocampomeID', value='')
    dataFrame.insert(loc=8, column='ExclusionReason', value='')
            
    return(dataFrame)