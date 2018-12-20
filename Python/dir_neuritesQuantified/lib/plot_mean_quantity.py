def plot_mean_quantity(nCells, nLayers, overlapBinaryDF, quantitySelectionsDF, meansDF, subregionDF):

    import numpy as np

    import matplotlib.pyplot as plt
    import matplotlib.patches as patches

    from diek_functions import pause
    from diek_functions import time_stamp

    from plot_functions import HCcolors as c
    from plot_functions import make_color_map

    nNeurons = len(overlapBinaryDF)
    nRows, nColumns = overlapBinaryDF.shape
    nParcels = nColumns - 4 # account for header columns (UniqueIDs - EorI)
    
    overlapBinaryLayers = overlapBinaryParcels = list(overlapBinaryDF)[4:]
    for j in range(nParcels):
        idx = [pos for pos, char in enumerate(overlapBinaryParcels[j]) if char == ':']
        overlapBinaryLayers[j] = overlapBinaryParcels[j][idx[0]+1:]
    
    regionColors = [c.BROWN_DG,
                    c.BROWN_CA3,
                    c.YELLOW_CA2,
                    c.ORANGE_CA1,
                    c.YELLOW_Sub,
                    c.GREEN_EC]
    DG = 0
    CA3 = 1
    CA2 = 2
    CA1 = 3
    Sub = 4
    EC = 5
    
    START = subregionDF.loc[0, 'start']
    END = subregionDF.loc[0, 'end']
    
    nNeuronsDisplayed = END - START
    
    overlapBinaryColors = [c.WHITE,        # 0
                           c.RED_LIGHT,    # 1
                           c.BLUE_LIGHT,   # 2
                           c.PURPLE_LIGHT] # 3
              
    nOverlapBinaryColors = len(overlapBinaryColors)
    
    print "Making overlap binary color map ..."
    overlapBinaryColorMap = make_color_map(overlapBinaryColors)
    
    print "Plotting overlap binary background data ..."
    fig = plt.figure()
    ax = fig.add_subplot(111)
    
    ax.set_aspect("equal")
    
    ax.axis('off')
    
    overlapBinaryDataDF = overlapBinaryDF.iloc[:,4:]
    CijOverlap = overlapBinaryDataDF.iloc[START:(END+1), :]
    plt.pcolormesh(CijOverlap, cmap=overlapBinaryColorMap, edgecolors=c.BLACK, linewidth=0.1)
    
    vStart = -3
    
    plt.xlim(-12, nParcels)
    plt.ylim(vStart, nNeuronsDisplayed)
    
    plt.gca().invert_yaxis()
    
    # Add hatch lines to the colored squares
#    shadingLineWidths = 0.2
#    for i in range(nNeuronsDisplayed):
#        for j in range(nParcels):
#            if ((CijOverlap.iloc[i,j] == 1) or (CijOverlap.iloc[i,j] == 3)): # axons
#                plt.plot([j+0.5, j+0.5], [i+0.1, i+0.9], color=c.WHITE, linewidth=shadingLineWidths)
#            if ((CijOverlap.iloc[i,j] == 2) or (CijOverlap.iloc[i,j] == 3)): # dendrites
#                plt.plot([j+0.1, j+0.9], [i+0.5, i+0.5], color=c.WHITE, linewidth=shadingLineWidths)
    
    # color-coded tags for the subregions
    ax.add_patch(patches.Rectangle((sum(nLayers[:DG]), vStart), nLayers[DG], 3, edgecolor="none",
                                   facecolor=c.BROWN_DG))
    ax.add_patch(patches.Rectangle((sum(nLayers[:CA3]), vStart), nLayers[CA3], 3, edgecolor="none",
                                   facecolor=c.BROWN_CA3))
    ax.add_patch(patches.Rectangle((sum(nLayers[:CA2]), vStart), nLayers[CA2], 3, edgecolor="none",
                                   facecolor=c.YELLOW_CA2))
    ax.add_patch(patches.Rectangle((sum(nLayers[:CA1]), vStart), nLayers[CA1], 3, edgecolor="none",
                                   facecolor=c.ORANGE_CA1))
    ax.add_patch(patches.Rectangle((sum(nLayers[:Sub]), vStart), nLayers[Sub], 3, edgecolor="none",
                                   facecolor=c.YELLOW_Sub))
    ax.add_patch(patches.Rectangle((sum(nLayers[:EC]), vStart), nLayers[EC], 3, edgecolor="none",
                                   facecolor=c.GREEN_EC))
    
    hTab = -9

    # add title label to plot
    if (subregionDF.loc[0, 'label'] == 'All'):
        displayFontSize = 1
    else:
        displayFontSize = 5
    ax.text(hTab, -1.5, quantitySelectionsDF.loc[0, 'string'], rotation=0, horizontalalignment="left",
            fontsize=displayFontSize, color=c.BLACK)

    # parcellation subregion headers
    tab = [sum(nLayers[:DG]) + (nLayers[DG]+1)/2,
           sum(nLayers[:CA3]) + (nLayers[CA3]+0.5)/2,
           sum(nLayers[:CA2]) + (nLayers[CA2]+1)/2,
           sum(nLayers[:CA1]) + (nLayers[CA1]+1)/2,
           sum(nLayers[:Sub]) + (nLayers[Sub]+0.5)/2,
           sum(nLayers[:EC]) + (nLayers[EC]+1)/2
          ]
    ax.text(tab[DG], -2, "DG", rotation=0, horizontalalignment="center", fontsize=displayFontSize, color=c.WHITE)
    ax.text(tab[CA3], -2, "CA3", rotation=0, horizontalalignment="center", fontsize=displayFontSize, color=c.WHITE)
    ax.text(tab[CA2], -2, "CA2", rotation=0, horizontalalignment="center", fontsize=displayFontSize, color=c.BLACK)
    ax.text(tab[CA1], -2, "CA1", rotation=0, horizontalalignment="center", fontsize=displayFontSize, color=c.WHITE)
    ax.text(tab[Sub], -2, "Sub", rotation=0, horizontalalignment="center", fontsize=displayFontSize, color=c.BLACK)
    ax.text(tab[EC], -2, "EC", rotation=0, horizontalalignment="center", fontsize=displayFontSize, color=c.WHITE)

    for j in range(sum(nLayers)):
        ax.text(j+0.5, -0.1, overlapBinaryLayers[j], rotation=90, horizontalalignment="center", 
                verticalalignment="bottom", fontsize=displayFontSize, color=c.WHITE)
    for j in range(sum(nLayers[:CA2]), sum(nLayers[:CA1])):
        ax.text(j+0.5, -0.1, overlapBinaryLayers[j], rotation=90, horizontalalignment="center", 
                verticalalignment="bottom", fontsize=displayFontSize, color=c.BLACK)
    for j in range(sum(nLayers[:Sub]), sum(nLayers[:EC])):
        ax.text(j+0.5, -0.1, overlapBinaryLayers[j], rotation=90, horizontalalignment="center", 
                verticalalignment="bottom", fontsize=displayFontSize, color=c.BLACK)

    # cell type subregion headers
    strng = 'DG'
    vCorrection = 0.0
    if ((subregionDF.loc[0, 'label'] == 'DG') or (subregionDF.loc[0, 'label'] == 'All')):
        DGstart = nCells[DG]/2
        ax.text(hTab, DGstart+vCorrection, strng, horizontalalignment="center", rotation=90,
                fontsize=displayFontSize, color=c.BLACK)
    strng = 'CA3'
    vCorrection = 0.0
    if (subregionDF.loc[0, 'label'] == 'CA3'):
        CA3start = nCells[CA3]/2
        ax.text(hTab, CA3start+vCorrection, strng, horizontalalignment="center", rotation=90,
                fontsize=displayFontSize, color=c.BLACK)
    elif (subregionDF.loc[0, 'label'] == 'All'):
        CA3start = sum(nCells[:CA3]) + nCells[CA3]/2
        ax.text(hTab, CA3start+vCorrection, strng, horizontalalignment="center", rotation=90,
                fontsize=displayFontSize, color=c.BLACK)
    strng = 'CA2'
    vCorrection = 0.0
    if (subregionDF.loc[0, 'label'] == 'CA2'):
        CA2start = nCells[CA2]/2
        ax.text(hTab, CA2start+vCorrection, strng, horizontalalignment="center", rotation=90,
                fontsize=displayFontSize, color=c.BLACK)
    elif (subregionDF.loc[0, 'label'] == 'All'):
        CA2start = sum(nCells[:CA2]) + nCells[CA2]/2
        ax.text(hTab, CA2start+vCorrection, strng, horizontalalignment="center", rotation=90,
                fontsize=displayFontSize, color=c.BLACK)
    strng = 'CA1'
    vCorrection = 0.0
    if (subregionDF.loc[0, 'label'] == 'CA1'):
        CA1start = nCells[CA1]/2
        ax.text(hTab, CA1start+vCorrection, strng, horizontalalignment="center", rotation=90,
                fontsize=displayFontSize, color=c.BLACK)
    elif (subregionDF.loc[0, 'label'] == 'All'):
        CA1start = sum(nCells[:CA1]) + nCells[CA1]/2
        ax.text(hTab, CA1start+vCorrection, strng, horizontalalignment="center", rotation=90,
                fontsize=displayFontSize, color=c.BLACK)
    strng = 'Sub'
    vCorrection = 0.0
    if (subregionDF.loc[0, 'label'] == 'Sub'):
        Substart = nCells[Sub]/2
        ax.text(hTab, Substart+vCorrection, strng, horizontalalignment="center", rotation=90,
                fontsize=displayFontSize, color=c.BLACK)
    elif (subregionDF.loc[0, 'label'] == 'All'):
        Substart = sum(nCells[:Sub]) + nCells[Sub]/2
        ax.text(hTab, Substart+vCorrection, strng, horizontalalignment="center", rotation=90,
                fontsize=displayFontSize, color=c.BLACK)
    strng = 'EC'
    vCorrection = 0.0
    if (subregionDF.loc[0, 'label'] == 'EC'):
        ECstart = nCells[EC]/2
        ax.text(hTab, ECstart+vCorrection, strng, horizontalalignment="center", rotation=90,
                fontsize=displayFontSize, color=c.BLACK)
    elif (subregionDF.loc[0, 'label'] == 'All'):
        ECstart = sum(nCells[:EC]) + nCells[EC]/2
        ax.text(hTab, ECstart+vCorrection, strng, horizontalalignment="center", rotation=90,
                fontsize=displayFontSize, color=c.BLACK)

    # thick horizontal lines on cell type axis
    if (subregionDF.loc[0, 'label'] == 'All'):
        lineWidth = 0.2
        CA3line = sum(nCells[:CA3])
        CA2line = sum(nCells[:CA2])
        CA1line = sum(nCells[:CA1])
        Subline = sum(nCells[:Sub])
        ECline = sum(nCells[:EC])
        
        ax.plot([hTab, nParcels], [CA3line, CA3line], linewidth=lineWidth, color=c.BLACK)
        ax.plot([hTab, nParcels], [CA2line, CA2line], linewidth=lineWidth, color=c.BLACK)
        ax.plot([hTab, nParcels], [CA1line, CA1line], linewidth=lineWidth, color=c.BLACK)
        ax.plot([hTab, nParcels], [Subline, Subline], linewidth=lineWidth, color=c.BLACK)
        ax.plot([hTab, nParcels], [ECline, ECline], linewidth=lineWidth, color=c.BLACK)

    # plot labels
    for i in range(START, END):
        hTab = -0.5
        labelCode = "{0:s} ({1:d})".format(overlapBinaryDF.loc[i, 'Names'], int(meansDF.loc[i, 'Factors']))
        labelColor = c.BLACK
        if overlapBinaryDF.loc[i, 'EorI'] == 'I':
            labelColor = c.GRAY
        ax.text(hTab, i-START+0.5, labelCode, rotation=0, horizontalalignment="right", verticalalignment="center",
                fontsize=displayFontSize, color=labelColor)
        
    nMeanValues = len(meansDF)
    
    print "Plotting mean quantity values ..."

    for i in range(nMeanValues):
        vTab = int(overlapBinaryDF['UniqueIDs'].index[overlapBinaryDF['UniqueIDs'] ==
                                                      meansDF.loc[i, 'UniqueIDs']].tolist() - START)
        neuriteStr = meansDF.loc[i, 'Neurites']
        idx = [pos for pos, char in enumerate(neuriteStr) if char == ':']
        parcel = neuriteStr[:idx[1]]
        hTab = parcel_lookup(parcel)
        neurite = neuriteStr[idx[1]+1:]
        
        if (np.isnan(meansDF.loc[i, 'Means'])):
            strng = '?'
        else:
            value = meansDF.loc[i, 'Means']
            if (quantitySelectionsDF.loc[0, 'selection'] == 1): # total neurite length
                strng = "{0:.0f}".format(value)
            elif (quantitySelectionsDF.loc[0, 'selection'] == 2): # percent of neurite tree
                strng = "{0:.2f}".format(value)
            elif (quantitySelectionsDF.loc[0, 'selection'] == 3): # density
                strng = "{0:.4f}".format(value)
            elif (quantitySelectionsDF.loc[0, 'selection'] == 4): # average maximum path length
                strng = "{0:.0f}".format(value)
            else: # (quantitySelectionsDF.loc[0, 'selection'] == 2): # average mean path length
                strng = "{0:.0f}".format(value)

        if (((meansDF.loc[i, 'UniqueIDs'] // 1000) == subregionDF.loc[0, 'code']) or
            (subregionDF.loc[0, 'code'] == 0)):
            if (neurite == 'A'):
                if (overlapBinaryDataDF.iloc[vTab+START, hTab] == 1): # axons only
                    ax.add_patch(patches.Rectangle((hTab+0.02, vTab+0.02), 0.96, 0.48, edgecolor="none",
                                   facecolor=c.RED))
                    ax.add_patch(patches.Rectangle((hTab+0.02, vTab+0.5), 0.96, 0.48, edgecolor="none",
                                   facecolor=c.WHITE))
                    if ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] >= 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.25, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.WHITE)
                    elif ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] < 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.25, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.YELLOW)
                    else:
                        ax.text(hTab+0.5, vTab+0.25, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.WHITE)
                elif (overlapBinaryDataDF.iloc[vTab+START, hTab] == 3): # axons from axons and dendrites
                    ax.add_patch(patches.Rectangle((hTab+0.02, vTab+0.02), 0.96, 0.48, edgecolor="none",
                                   facecolor=c.RED))
                    if ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] >= 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.25, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.WHITE)
                    elif ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] < 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.25, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.YELLOW)
                    else:
                        ax.text(hTab+0.5, vTab+0.25, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.WHITE)
                elif (overlapBinaryDataDF.iloc[vTab+START, hTab] == 2): # dendrites only
                    ax.add_patch(patches.Rectangle((hTab+0.02, vTab+0.02), 0.96, 0.48, edgecolor="none",
                                   facecolor=c.WHITE))
                    if ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] >= 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.25, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.BLACK)
                    elif ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] < 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.25, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.GREEN)
                    else:
                        ax.text(hTab+0.5, vTab+0.25, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.BLACK)
                else: # (overlapBinaryDataDF.iloc[vTab+START, hTab] == 0): # no axons or dendrites
                    if ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] >= 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.25, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.RED)
                    elif ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] < 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.25, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.GREEN)
                    else:
                        ax.text(hTab+0.5, vTab+0.25, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.BLACK)
                    ax.plot([hTab, hTab+1], [vTab+0.5, vTab+0.5], linewidth=0.1, color=c.BLACK) # diving line
            if (neurite == 'D'):
                if (overlapBinaryDataDF.iloc[vTab+START, hTab] == 2): # dendrites only
                    ax.add_patch(patches.Rectangle((hTab+0.02, vTab+0.5), 0.96, 0.48, edgecolor="none",
                                   facecolor=c.BLUE))
                    ax.add_patch(patches.Rectangle((hTab+0.02, vTab+0.02), 0.96, 0.48, edgecolor="none",
                                   facecolor=c.WHITE))
                    if ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] >= 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.75, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.WHITE)
                    elif ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] < 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.75, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.YELLOW)
                    else:
                        ax.text(hTab+0.5, vTab+0.75, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.WHITE)
                elif (overlapBinaryDataDF.iloc[vTab+START, hTab] == 3): # dendrites from axons and dendrites
                    ax.add_patch(patches.Rectangle((hTab+0.02, vTab+0.5), 0.96, 0.48, edgecolor="none",
                                   facecolor=c.BLUE))
                    if ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] >= 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.75, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.WHITE)
                    elif ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] < 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.75, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.YELLOW)
                    else:
                        ax.text(hTab+0.5, vTab+0.75, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.WHITE)
                elif (overlapBinaryDataDF.iloc[vTab+START, hTab] == 1): # axons only
                    ax.add_patch(patches.Rectangle((hTab+0.02, vTab+0.5), 0.96, 0.48, edgecolor="none",
                                   facecolor=c.WHITE))
                    if ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] >= 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.75, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.BLACK)
                    elif ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] < 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.75, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.GREEN)
                    else:
                        ax.text(hTab+0.5, vTab+0.75, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.BLACK)
                else: # (overlapBinaryDataDF.iloc[vTab+START, hTab] == 0): # no axons or dendrites
                    if ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] >= 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.75, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.BLUE)
                    elif ((quantitySelectionsDF.loc[0, 'selection'] == 2) and meansDF.loc[i, 'Means'] < 15): # % of neurite tree
                        ax.text(hTab+0.5, vTab+0.75, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.GREEN)
                    else:
                        ax.text(hTab+0.5, vTab+0.75, strng, horizontalalignment="center", rotation=0,
                                verticalalignment="center", fontsize=displayFontSize/2.0, color=c.BLACK)
                    ax.plot([hTab, hTab+1], [vTab+0.5, vTab+0.5], linewidth=0.1, color=c.BLACK) # diving line
    plt.show()
    
    # save plot
    outputFileName = "output/{0:s}_matrix_{1:s}.pdf".format(quantitySelectionsDF.loc[0, 'plotString'], time_stamp())
    print "Saving data to pdf file %s ...\n" % outputFileName    
    fig.savefig(outputFileName, dpi=600)
   
    return

