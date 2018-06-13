from diek_functions import size2x2
from diek_functions import pause

from file_functions import dictRead_from_csv

from plot_patterns import plot_patterns

print

fileName = "FP_matrix.csv"
fileName = "test.csv"

fpDict = dictRead_from_csv(fileName)
	
nAllRows, nAllColumns = size2x2(fpDict)

nSkipRows = 1
nSkipColumns = 6
ABCorderingColumnNo = 0
HCorderingColumnNo = 1
cellIDorderingColumnNo = 3
labelColumnNo = 5
patternLabelsRowNo = 0

#orderingColumn = "ABC ordering"
orderingColumn = "HC ordering"
#orderingColumn = "Cell ID"

nCells = nAllRows   
nPatterns = nAllColumns - nSkipColumns # account for header columns

print [fpDict[i][orderingColumn] for i in range(nCells)]
print
pause()

cellLabelsUnsorted = [""] * nCells
cellLabelsSorted = [""] * nCells
ordering = [""] * nCells
patternLabels = [""] * nPatterns

nPatternOccurrencesUnsorted = [[None for j in range(nPatterns)] for i in range(nCells)]
nPatternOccurrencesSorted = nPatternOccurrencesUnsorted

for i in range(nCells):
    cellLabelsUnsorted[i] = fpMatrix[i+nSkipRows][labelColumnNo]
    ordering[i] = fpMatrix[i+nSkipRows][orderingColumnNo]
    
    nPatternOccurrencesUnsorted[i] = [int(fpMatrix[i+nSkipRows][j+nSkipColumns]) for j in range(nPatterns)]

indices = [index for (value, index) in sorted((value, index) for (index, value) in enumerate(ordering))]

for i in range(nCells):
    cellLabelsSorted[i] = cellLabelsUnsorted[indices[i]]

    nPatternOccurrencesSorted[i] = [nPatternOccurrencesUnsorted[indices[i]][j] for j in range(nPatterns)]

patternLabels = [fpMatrix[patternLabelsRowNo][j+nSkipColumns] for j in range(nPatterns)]
    
plot_patterns(cellLabelsSorted, patternLabels, nPatternOccurrencesSorted)

print "Finis.\n"
