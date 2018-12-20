import pandas as pd

import sys
sys.path.append('Users/drdiek/Dropbox/Python/lib')

nCells, nLayers, overlapBinaryDF, neuritesQuantifiedDF = initialize_variables()

quantityDF, quantitySelectionsDF = menu_plot(neuritesQuantifiedDF)

if isinstance(quantitySelectionsDF, pd.DataFrame):
    subregionDF = pd.DataFrame([{'selection' : 0}])
    if quantitySelectionsDF.loc[0, 'selection'] != 6:
        subregionDF = menu_subregion(nCells)

    if isinstance(subregionDF, pd.DataFrame):
        meansDF = average_quantity_values(neuritesQuantifiedDF, quantityDF)
        if quantitySelectionsDF.loc[0, 'selection'] > 5: 
            overlapBinaryProbabilityDF, gradedProbabilityDF, tensorARR, axonsDF, dendritesDF = \
                                            calculate_probabilities(overlapBinaryDF, neuritesQuantifiedDF, meansDF)
            if quantitySelectionsDF.loc[0, 'selection'] == 6: # Probabilities
                plot_probabilities(nCells, overlapBinaryDF, overlapBinaryProbabilityDF, gradedProbabilityDF)
            else: # quantitySelectionDF.loc[0, 'selection'] == 7; Periodic table
                plot_periodic_table(nCells, quantityDF, neuritesQuantifiedDF, overlapBinaryDF, subregionDF,
                                    axonsDF, dendritesDF, tensorARR)
        else:
            plot_mean_quantity(nCells, nLayers, overlapBinaryDF, quantitySelectionsDF, meansDF, subregionDF)
