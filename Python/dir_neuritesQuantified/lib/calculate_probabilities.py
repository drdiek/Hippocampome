def calculate_probabilities(overlapBinaryDF, neuritesQuantifiedDF, meansDF):
    # calculate probabilities for neurites_quantified()
    
    import math
    import numpy as np
    import pandas as pd
    from diek_functions import pause
    
    overlapBinaryDataDF = overlapBinaryDF.iloc[:,4:]
    
    axonsDF = (overlapBinaryDataDF == 1) | (overlapBinaryDataDF == 3).astype(int)
    dendritesDF = (overlapBinaryDataDF == 2) | (overlapBinaryDataDF == 3).astype(int)
    
    nNeurons = len(overlapBinaryDF)
    nRows, nColumns = overlapBinaryDF.shape
    nParcels = nColumns - 4 # account for header columns (UniqueIDs - EorI)
    
    overlapBinaryProbabilityDF = pd.DataFrame(np.zeros(shape=(nNeurons, nNeurons)))
    
    print "Calculating overlapBinary probabilities ..."
    for i in range(nNeurons):
        for j in range(nNeurons):
            overlapBinaryProbabilityDF.iloc[i, j] = (2*(overlapBinaryDF.loc[i, 'EorI'] == 'E')-1) * \
                                                     np.sign(sum(axonsDF.iloc[i, :] & dendritesDF.iloc[j, :]))
    overlapBinaryProbabilityDF = overlapBinaryProbabilityDF.astype(int)
    
    axonsDF = dendritesDF = pd.DataFrame(np.zeros(shape=(nNeurons, nParcels)))
    
    for k in range(len(meansDF)):
        i = overlapBinaryDF['UniqueIDs'].index[overlapBinaryDF['UniqueIDs'] == meansDF.loc[k, 'UniqueIDs']]
        neuriteStr = meansDF.loc[k, 'Neurites']
        idx = [pos for pos, char in enumerate(neuriteStr) if char == ':']
        parcel = neuriteStr[:idx[1]]
        j = parcel_lookup(parcel)
        neurite = neuriteStr[idx[1]+1:]
        if neurite == 'A':
            if math.isnan(meansDF.loc[k, 'Means']):
                axonsDF.iloc[i, j] = 0
            else:
                axonsDF.iloc[i, j] = meansDF.loc[k, 'Means']
        else:
            if math.isnan(meansDF.loc[k, 'Means']):
                dendritesDF.iloc[i, j] = 0
            else:
                dendritesDF.iloc[i, j] = meansDF.loc[k, 'Means']

    gradedProbabilityDF = pd.DataFrame(np.zeros(shape=(nNeurons, nNeurons)))
    tensorARR = np.zeros(shape=(nNeurons, nNeurons, nParcels))
    
    print "Calculating graded probabilities and tensors ..."
    for i in range(nNeurons):
        for j in range(nNeurons):
            axonsLST = list(axonsDF.iloc[i, :])
            dendritesLST = list(dendritesDF.iloc[j, :])
            gradedProbabilityDF.iloc[i, j] = sum([a*b for a,b in zip(axonsLST, dendritesLST)])
            for k in range(nParcels):
                tensorARR[i, j, k] = axonsDF.iloc[i, k] * dendritesDF.iloc[j, k]
    
    return(overlapBinaryProbabilityDF, gradedProbabilityDF, tensorARR, axonsDF, dendritesDF)