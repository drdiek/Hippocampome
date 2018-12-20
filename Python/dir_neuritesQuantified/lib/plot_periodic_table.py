def plot_periodic_table(nCells, quantityDF, neuritesQuantifiedDF, overlapBinaryDF, subregionDF, axonsDF,
                        dendritesDF, tensorARR):
    import numpy as np

    import matplotlib.pyplot as plt
    import matplotlib.patches as patches

    from diek_functions import pause
    from diek_functions import time_stamp

    from plot_functions import HCcolors as c
    from plot_functions import make_color_map

    print "Plotting periodic table ..."
    
    DG = 0
    CA3 = 1
    CA2 = 2
    CA1 = 3
    Sub = 4
    EC = 5
    
    nNeurons = len(overlapBinaryDF)
    nRows, nColumns = overlapBinaryDF.shape
    nParcels = nColumns - 4 # account for header columns (UniqueIDs - EorI)
    
    # reverse order of the parcels to SO appears at the bottom of the Z-axis and SLM at the top
    for iNeuron in range(nNeurons):
        axonsDF.iloc[iNeuron, :] = axonsDF.iloc[iNeuron, ::-1]
        dendritesDF.iloc[iNeuron, :] = dendritesDF.iloc[iNeuron, ::-1]
        
    if (subregionDF.loc[0, 'label'] == 'DG'):
        neuronStart = sum(nCells[:DG])
        neuronEnd = nCells[DG]
    elif (subregionDF.loc[0, 'label'] == 'CA3'):
        neuronStart = sum(nCells[:CA3])
        neuronEnd = nCells[CA3]
    elif (subregionDF.loc[0, 'label'] == 'CA2'):
        neuronStart = sum(nCells[:CA2])
        neuronEnd = nCells[CA2]
    elif (subregionDF.loc[0, 'label'] == 'CA1'):
        neuronStart = sum(nCells[:CA1])
        neuronEnd = nCells[CA1]
    elif (subregionDF.loc[0, 'label'] == 'Sub'):
        neuronStart = sum(nCells[:Sub])
        neuronEnd = nCells[Sub]
    elif (subregionDF.loc[0, 'label'] == 'EC'):
        neuronStart = sum(nCells[:EC])
        neuronEnd = nCells[EC]
    else:
        neuronStart = 0
        neuronEnd = nNeurons
        
    # scale connection probabilities from 1 to nProbabilityColors for mapping to colormap colors
    maximum = np.amax(tensorARR)
    nonZeroMinimum = np.amin(tensorARR[np.nonzero(tensorARR)])
    nProbabilityColors = int((maximum / nonZeroMinimum) + 0.5)
    if nProbabilityColors > 1024:
        nProbabilityColors = 1024
    tensorScaledARR = ((tensorARR / nonZeroMinimum) + 0.5) // nProbabilityColors
    
    overlapColors = [c.GRAY,
                     c.BLACK]

    redStart = 1.0
    redEnd = 0.5
    redStep = (redStart - redEnd) / nProbabilityColors
    greenStart = 0.75
    greenEnd = 0.0
    greenStep = (greenStart - greenEnd) / nProbabilityColors
    blueStart = 1.0
    blueEnd = 0.5
    blueStep = (blueStart - blueEnd) / nProbabilityColors
    
    tensorColors = np.zeros(shape=(nProbabilityColors+1, 3))
    for i in range(nProbabilityColors+1):
        tensorColors[i,:] = [redStart-i*redStep, greenStart-i*greenStep, blueStart-i*blueStep]
        

