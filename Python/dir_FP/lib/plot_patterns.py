import sys
import numpy as np
import matplotlib.pyplot as plt

from diek_functions import pause
from diek_functions import time_stamp

from plot_functions import HCcolors as clrs
from plot_functions import make_color_map
from plot_functions import plot_hatch_lines

def plot_patterns(cellLabels, patternLabels, nPatternOccurrences):

    nCells = len(cellLabels)
    nPatterns = len(patternLabels)

    colors = [clrs.WHITE,
              clrs.ORANGE,
              clrs.TEAL,
              clrs.BROWN,
              clrs.GRAY]
              
    nColors = len(colors)
    
    print "Making color map ...\n"
    firingPatternColorMap = make_color_map(colors)
    
    print "Plotting data ...\n"
    fig = plt.figure()
    ax = fig.add_subplot(111)
    
    ax.set_aspect("equal")
    
    plt.pcolormesh(nPatternOccurrences, cmap=firingPatternColorMap)
    
    plt.xlim(0, nPatterns)
    plt.ylim(0, nCells)
    
    plt.gca().invert_yaxis()
    
    print "Plotting hatch lines ...\n"
    plot_hatch_lines(nPatternOccurrences)
    
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
    