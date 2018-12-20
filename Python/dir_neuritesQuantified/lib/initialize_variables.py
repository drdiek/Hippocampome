def initialize_variables():
    # initialize variables for neurites_quantified()
    print "Initializing variables ..."
    
    import pandas as pd
    
    nCells = [0, 0, 0, 0, 0, 0]
    nLayers = [4, 5, 4, 4, 3, 6]
    
    try:
        overlapBinaryDF = pd.read_csv('data/overlap_matrix.csv')
    except IOError:
        print "The file {} does not exist.".format('data/overlap_matrix.csv')
    try:
        neuritesQuantifiedDF = pd.read_excel('data/neurites_quantified_v1.0.xlsx')
    except IOError:
        print "The file {} does not exist.".format('neurites_quantified_v1.0.xlsx')
        
    nCells[0] = len(overlapBinaryDF.loc[overlapBinaryDF['UniqueIDs'] < 2000])
    nCells[1] = len(overlapBinaryDF.loc[overlapBinaryDF['UniqueIDs'] < 3000]) - sum(nCells[0:1])
    nCells[2] = len(overlapBinaryDF.loc[overlapBinaryDF['UniqueIDs'] < 4000]) - sum(nCells[0:2])
    nCells[3] = len(overlapBinaryDF.loc[overlapBinaryDF['UniqueIDs'] < 5000]) - sum(nCells[0:3])
    nCells[4] = len(overlapBinaryDF.loc[overlapBinaryDF['UniqueIDs'] < 6000]) - sum(nCells[0:4])
    nCells[5] = len(overlapBinaryDF.loc[overlapBinaryDF['UniqueIDs'] > 5999])
    
    return(nCells, nLayers, overlapBinaryDF, neuritesQuantifiedDF)