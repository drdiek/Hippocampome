import sys
import numpy as np
import matplotlib.pyplot as plt

from diek_functions import pause
from diek_functions import time_stamp

from plot_functions import HCcolors as clrs
from plot_functions import make_color_map
from plot_functions import plot_hatch_lines

def plot_fuzzy_morphology_data(morphologyDataFrame,dataFrame,isPlotSupertypesOnly):
    from lib.constants import *
    
    BLACK             = (   0,   0,   0 )
    BLUE              = (   0,   0, 255 )
    BLUE_DARK         = (   0,   0, 128 )
    BLUE_MEDIUM       = (   0,   0, 192 )
    BLUE_LIGHT        = ( 143, 172, 255 )
    BLUE_SKY          = (   0, 204, 255 )
    BLUE_UBERLIGHT    = ( 227, 233, 255 )
    BLUE_ULTRALIGHT   = ( 199, 214, 255 )
    BROWN             = ( 153, 102,  51 )
    BROWN_DG          = (  91,  45,  10 )
    BROWN_CA3         = ( 165, 131, 107 )
    GRAY              = ( 128, 128, 128 )
    GRAY_DARK         = (  64,  64,  64 )
    GRAY_MEDIUM       = (  96,  96,  96 )
    GRAY_LIGHT        = ( 192, 192, 192 )
    GRAY_ULTRALIGHT   = ( 230, 230, 230 )
    GREEN             = (   0, 255,   0 )
    GREEN_MEDIUM      = (   0, 192,   0 )
    GREEN_BRIGHT      = (   0, 255,   0 )
    GREEN_EC          = ( 106, 149,  49 )
    GREEN_LEC         = (  90, 111,  47 )
    GREEN_MEC         = ( 122, 187,  51 )
    ORANGE            = ( 228, 108,  10 )
    ORANGE_LIGHT      = ( 247, 156,  21 )
    ORANGE_CA1        = ( 217, 104,  13 )
    PURPLE            = ( 128,   0, 128 )
    PURPLE_LIGHT      = ( 178, 128, 178 )
    PURPLE_UBERLIGHT  = ( 236, 224, 236 )
    PURPLE_ULTRALIGHT = ( 217, 192, 217 )
    RED               = ( 255,   0,   0 )
    RED_LIGHT         = ( 255, 178, 178 )
    RED_UBERLIGHT     = ( 255, 236, 236 )
    RED_ULTRALIGHT    = ( 255, 216, 216 )
    TEAL              = (   0, 255, 192 )
    WHITE             = ( 255, 255, 255 )
    YELLOW            = ( 255, 255,   0 )
    YELLOW_CA2        = ( 255, 255,   0 )
    YELLOW_Sub        = ( 255, 192,   0 )

    morphologyDataFrameUnique = morphologyDataFrame.drop_duplicates()
    dataFrameSubset = dataFrame.iloc[0,[SUBREGION_COL,S_DG_COL:SF_D_EC_LVI_COL]]
    dataframeSubsetUnique = dataFrameSubset.drop_duplicates()
    
    nTypes, nParcels = morphologyDataFrameUnique.shape

    nParcellations = (4,5,4,4,3,6);
    
    layerNames = ('SMo','SMi','SG','H',
                  'SLM','SR','SL','SP','SO',
                  'SLM','SR','SP','SO',
                  'SLM','SR','SP','SO',
                  'SM','SP','PL',
                  'I','II','III','IV','V','VI')
                  
    nCells = dataframeSubsetUnique['Subregion'].value_counts()

    displayFontSize = 3
    if (nTypes < 100):
        displayFontSize = 8
    if (nTypes < 50):
        displayFontSize = 10
        
    shadingLineWidths = 1.0

    colors = [WHITE,
              BLUE_ULTRALIGHT,
              BLUE_LIGHT,
              BLUE,
              RED_ULTRALIGHT,
              PURPLE_ULTRALIGHT,
              (RED_ULTRALIGHT+BLUE_LIGHT)/2,
              (RED_ULTRALIGHT+BLUE)/2,
              RED_LIGHT,
              (RED_LIGHT+BLUE_ULTRALIGHT)/2,
              PURPLE_LIGHT,
              RED,
              (RED+BLUE_YULTRALIGHT)/2,
              (RED+BLUE_LIGHT)/2,
              PURPLE]
              
    nColors = len(colors)
    
    regionColors = [BROWN_DG,
                    BROWN_CA3,
                    YELLOW_CA2,
                    ORANGE_CA1,
                    YELLOW_SUB,
                    GREEN_EC]
    
    print "Making color map ...\n"
    morphologyColorMap = make_color_map(colors)
    
    print "Plotting data ...\n"
    fig = plt.figure()
    ax = fig.add_subplot(111)
    
    ax.set_aspect("equal")
    
    plt.pcolormesh(morphologyDataFrameUnique, cmap=morphologyColorMap)
    
    plt.xlim(0, nPatterns)
    plt.ylim(0, nTypes)
    
    plt.gca().invert_yaxis()
        
    nDGcells  = 18
    nCA3cells = 25
    nCA2cells =  5
    nCA1cells = 40
    nSubcells =  3
    nECcells  = 31
    
    line_width = 1.25
    
    DGline = nDGcells
    CA3line = DGline + nCA3cells
    CA2line = CA3line + nCA2cells
    CA1line = CA2line + nCA1cells
    Subline = CA1line + nSubcells
    
    plt.plot([0, nPatterns], [DGline, DGline], "b", linewidth=line_width)
    plt.plot([0, nPatterns], [CA3line, CA3line], "b", linewidth=line_width)
    plt.plot([0, nPatterns], [CA2line, CA2line], "b", linewidth=line_width)
    plt.plot([0, nPatterns], [CA1line, CA1line], "b", linewidth=line_width)
    plt.plot([0, nPatterns], [Subline, Subline], "b", linewidth=line_width)
    
    plt.tick_params(
        axis="x",          # changes apply to the x-axis
        which="both",      # both major and minor ticks are affected
        bottom="off",      # ticks along the bottom edge are off
        top="off",         # ticks along the top edge are off
        labelbottom="off", # labels along the bottom edge are off
        labeltop="off")    # labels along the top edge are off
        
    plt.tick_params(
        axis="y",          # changes apply to the x-axis
        which="both",      # both major and minor ticks are affected
        left="off",        # ticks along the left edge are off
        right="off",       # ticks along the right edge are off
        labelleft="off",   # labels along the left edge are off
        labelright="off")  # labels along the right edge are off
        
    if nCells > 50:
        fontSize = 2.5
    elif nCells > 25:
        fontSize = 5
    else:
        fontSize = 10
        
    print "Labeling axes ...\n"
    for i in range(nCells):
        
        ax.text(-0.5, float(i+1), cellLabels[i], rotation=0, horizontalalignment="right", fontname="Helvetica", fontsize=fontSize)

    for j in range(nPatterns):
        
        ax.text(float(j), -0.5, patternLabels[j], rotation=90, verticalalignment="bottom", fontname="Helvetica", fontsize=fontSize)
    
    ax.text(nPatterns+0.5, 1, "1 occurrence of the pattern", rotation=0, horizontalalignment="left", fontname="Helvetica", fontsize=fontSize,
            color=clrs.ORANGE)
    ax.text(nPatterns+0.5, 2, "2 occurrences of the pattern", rotation=0, horizontalalignment="left", fontname="Helvetica", fontsize=fontSize,
            color=clrs.TEAL)
    ax.text(nPatterns+0.5, 3, "3 occurrences of the pattern", rotation=0, horizontalalignment="left", fontname="Helvetica", fontsize=fontSize,
            color=clrs.BROWN)
    ax.text(nPatterns+0.5, 4, "4 occurrences of the pattern", rotation=0, horizontalalignment="left", fontname="Helvetica", fontsize=fontSize,
            color=clrs.GRAY)
    
    DGlabelPosition = nDGcells/2
    CA3labelPosition = nDGcells + nCA3cells/2
    CA2labelPosition = nDGcells + nCA3cells + nCA2cells/2
    CA1labelPosition = nDGcells + nCA3cells + nCA2cells + nCA1cells/2
    SublabelPosition = nDGcells + nCA3cells + nCA2cells + nCA1cells + nSubcells/2
    EClabelPosition = nDGcells + nCA3cells + nCA2cells + nCA1cells + nSubcells + nECcells/2
        
    ax.text(-12, DGlabelPosition, "DG", rotation=90, verticalalignment="center", fontname="Helvetica", fontsize=fontSize)
    ax.text(-12, CA3labelPosition, "CA3", rotation=90, verticalalignment="center", fontname="Helvetica", fontsize=fontSize)
    ax.text(-12, CA2labelPosition, "CA2", rotation=90, verticalalignment="center", fontname="Helvetica", fontsize=fontSize)
    ax.text(-12, CA1labelPosition, "CA1", rotation=90, verticalalignment="center", fontname="Helvetica", fontsize=fontSize)
    ax.text(-12, SublabelPosition, "Sub", rotation=90, verticalalignment="center", fontname="Helvetica", fontsize=fontSize)
    ax.text(-12, EClabelPosition, "EC", rotation=90, verticalalignment="center", fontname="Helvetica", fontsize=fontSize)
        
    outputFileName = "FP_plot_output/FP_matrix_%s.jpg" % time_stamp()
    print "Saving data to jpg file %s ...\n" % outputFileName    
    fig.savefig(outputFileName, dpi=600)
    
#    plt.show()

    return
    