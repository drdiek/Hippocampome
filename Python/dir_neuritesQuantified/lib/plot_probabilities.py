def plot_probabilities(nCells, overlapBinaryDF, overlapBinaryProbabilityDF, gradedProbabilitiesDF):

    import matplotlib.pyplot as plt
    import matplotlib.patches as patches

    from diek_functions import pause
    from diek_functions import time_stamp

    from plot_functions import HCcolors as c
    from plot_functions import make_color_map

    nNeurons = len(overlapBinaryDF)
    
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
    
    probabilityColors = [c.GRAY_LIGHT,
                         c.WHITE,
                         c.GRAY_DARK]
              
    nProbabilityColors = len(probabilityColors)
    
    print "Making probability color map ..."
    probabilityColorMap = make_color_map(probabilityColors)
    
    print "Plotting probability background data ..."
    fig = plt.figure()
    ax = fig.add_subplot(111)
    
    ax.set_aspect("equal")
    
    ax.axis('off')
    
    plt.pcolormesh(overlapBinaryProbabilityDF.iloc[:,:], cmap=probabilityColorMap)
    
    plt.xlim(-10, nNeurons)
    plt.ylim(-10, nNeurons)
    
    plt.gca().invert_yaxis()
    
    displayFontSize = 0.5
    
    # color-coded tags for the subregions
    ax.add_patch(patches.Rectangle((sum(nCells[:DG]), -1), nCells[DG], 1, edgecolor="none", facecolor=c.BROWN_DG))
    ax.add_patch(patches.Rectangle((sum(nCells[:CA3]), -1), nCells[CA3], 1, edgecolor="none", facecolor=c.BROWN_CA3))
    ax.add_patch(patches.Rectangle((sum(nCells[:CA2]), -1), nCells[CA2], 1, edgecolor="none", facecolor=c.YELLOW_CA2))
    ax.add_patch(patches.Rectangle((sum(nCells[:CA1]), -1), nCells[CA1], 1, edgecolor="none", facecolor=c.ORANGE_CA1))
    ax.add_patch(patches.Rectangle((sum(nCells[:Sub]), -1), nCells[Sub], 1, edgecolor="none", facecolor=c.YELLOW_Sub))
    ax.add_patch(patches.Rectangle((sum(nCells[:EC]), -1), nCells[EC], 1, edgecolor="none", facecolor=c.GREEN_EC))
    
    ax.add_patch(patches.Rectangle((-1, sum(nCells[:DG])), 1, nCells[DG], edgecolor="none", facecolor=c.BROWN_DG))
    ax.add_patch(patches.Rectangle((-1, sum(nCells[:CA3])), 1, nCells[CA3], edgecolor="none", facecolor=c.BROWN_CA3))
    ax.add_patch(patches.Rectangle((-1, sum(nCells[:CA2])), 1, nCells[CA2], edgecolor="none", facecolor=c.YELLOW_CA2))
    ax.add_patch(patches.Rectangle((-1, sum(nCells[:CA1])), 1, nCells[CA1], edgecolor="none", facecolor=c.ORANGE_CA1))
    ax.add_patch(patches.Rectangle((-1, sum(nCells[:Sub])), 1, nCells[Sub], edgecolor="none", facecolor=c.YELLOW_Sub))
    ax.add_patch(patches.Rectangle((-1, sum(nCells[:EC])), 1, nCells[EC], edgecolor="none", facecolor=c.GREEN_EC))

    # parcellation subregion headers
    tab = [sum(nCells[:DG]) + (nCells[DG]+1)/2,
           sum(nCells[:CA3]) + (nCells[CA3]+1)/2,
           sum(nCells[:CA2]) + (nCells[CA2]+1)/2,
           sum(nCells[:CA1]) + (nCells[CA1]+1)/2,
           sum(nCells[:Sub]) + (nCells[Sub]+1)/2,
           sum(nCells[:EC]) + (nCells[EC]+1)/2
          ]
    ax.text(tab[DG], -0.25, "DG", rotation=0, horizontalalignment="center", fontsize=displayFontSize, color=c.WHITE)
    ax.text(tab[CA3], -0.25, "CA3", rotation=0, horizontalalignment="center", fontsize=displayFontSize, color=c.WHITE)
    ax.text(tab[CA2], -0.25, "CA2", rotation=0, horizontalalignment="center", fontsize=displayFontSize, color=c.BLACK)
    ax.text(tab[CA1], -0.25, "CA1", rotation=0, horizontalalignment="center", fontsize=displayFontSize, color=c.WHITE)
    ax.text(tab[Sub], -0.25, "Sub", rotation=0, horizontalalignment="center", fontsize=displayFontSize, color=c.BLACK)
    ax.text(tab[EC], -0.25, "EC", rotation=0, horizontalalignment="center", fontsize=displayFontSize, color=c.WHITE)

    ax.text(-0.5, tab[DG], "DG", rotation=90, verticalalignment="bottom", horizontalalignment="center",
            fontsize=displayFontSize, color=c.WHITE)
    ax.text(-0.5, tab[CA3], "CA3", rotation=90, verticalalignment="bottom", horizontalalignment="center",
            fontsize=displayFontSize, color=c.WHITE)
    ax.text(-0.5, tab[CA2], "CA2", rotation=90, verticalalignment="bottom", horizontalalignment="center",
            fontsize=displayFontSize, color=c.BLACK)
    ax.text(-0.5, tab[CA1], "CA1", rotation=90, verticalalignment="bottom", horizontalalignment="center",
            fontsize=displayFontSize, color=c.WHITE)
    ax.text(-0.5, tab[Sub], "Sub", rotation=90, verticalalignment="bottom", horizontalalignment="center",
            fontsize=displayFontSize, color=c.BLACK)
    ax.text(-0.5, tab[EC], "EC", rotation=90, verticalalignment="bottom", horizontalalignment="center",
            fontsize=displayFontSize, color=c.WHITE)

    for i in range(nNeurons):
        textColor = c.BLACK
        if overlapBinaryDF.loc[i, 'EorI'] == 'I':
            textColor = c.GRAY
        ax.text(i+0.5, -1.25, overlapBinaryDF.loc[i, 'Abbreviations'], rotation=90, horizontalalignment="center",
                verticalalignment="bottom", fontsize=displayFontSize, color=textColor)
        ax.text(-1.25, i+0.5, overlapBinaryDF.loc[i, 'Abbreviations'], rotation=0, horizontalalignment="right",
                verticalalignment="center", fontsize=displayFontSize, color=textColor)

    for i in range(nNeurons):
        for j in range(nNeurons):
            if gradedProbabilityDF.iloc[i, j] > 0:
                strng = '{:.2e}'.format(gradedProbabilityDF.iloc[i, j])
                if overlapBinaryProbabilityDF.iloc[i, j] == 0:
                    textColor = c.BLACK
                    if overlapBinaryDF.loc[i, 'EorI'] == 'I':
                        textColor = c.GRAY
                    ax.text(j+1.5, i+0.5, strng, rotation=0, horizontalalignment="center", fontsize=displayFontSize/2,
                            color=textColor)
                else:
                    faceColor = c.BLACK
                    if overlapBinaryDF.loc[i, 'EorI'] == 'I':
                        faceColor = c.GRAY
                    ax.add_patch(patches.Rectangle((j, i), # (x,y)
                                                   1,             # width
                                                   1,             # height
                                                   edgecolor="none",
                                                   facecolor=faceColor
                                                  )
                                )
                    ax.text(j+1.5, i+0.5, strng, rotation=0, horizontalalignment="center", fontsize=displayFontSize/2,
                            color=c.WHITE)

    plt.show()
    
    # save plot
    outputFileName = "output/probability_matrix_%s.pdf" % time_stamp()
    print "Saving data to pdf file %s ...\n" % outputFileName    
    fig.savefig(outputFileName, dpi=600)
    
    return()
    