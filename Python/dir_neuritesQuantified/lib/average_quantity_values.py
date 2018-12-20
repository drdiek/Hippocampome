def average_quantity_values(neuritesQuantifiedDF, quantityDF):
    # average quantity values for neurites_quantified()
    print "Averaging quantity values ..."

    import pandas as pd
    from diek_functions import pause
    
    neuritesDF = neuritesQuantifiedDF['Unique_ID'].apply(str) + ':' + neuritesQuantifiedDF['Neurite']
    
    uniqueNeurites = neuritesDF.unique()
    meansDF = pd.DataFrame([{'Factors'   : 0, \
                             'Means'     : 0, \
                             'Neurites'  : 0, \
                             'UniqueIDs' : 0}])
    
    for i in range(len(uniqueNeurites)):
        idx = neuritesDF.index[neuritesDF == uniqueNeurites[i]]
        meansDF.loc[i, 'Factors'] = len(idx)
        meansDF.loc[i, 'UniqueIDs'] = neuritesQuantifiedDF['Unique_ID'].iloc[idx[0]]
        meansDF.loc[i, 'Neurites'] = neuritesQuantifiedDF['Neurite'].iloc[idx[0]]
        lst = list(quantityDF.iloc[idx])
        meansDF.loc[i, 'Means'] = sum(lst)/float(len(lst))
    
    return(meansDF)