from diek_functions import size2x2
from diek_functions import pause

from file_functions import load_csv

from plot_patterns import plot_patterns

print

fileName = "FP_matrix.csv"
#fileName = "test.csv"

fpMatrix = load_csv(fileName)

nAllRows, nAllColumns = size2x2(fpMatrix)

nSkipRows = 1
nSkipColumns = 6
ABCorderingColumnNo = 0
HCorderingColumnNo = 1
cellIDorderingColumnNo = 3
labelColumnNo = 5
patternLabelsRowNo = 0

nCells = nAllRows - nSkipRows # account for header row   
nPatterns = nAllColumns - nSkipColumns # account for header columns

patternLabels = [""] * nPatterns
cellLabelsSorted = [""] * nCells
nPatternOccurrencesSorted = [[None for j in range(nPatterns)] for i in range(nCells)]

#orderingColumnNo = ABCorderingColumnNo
orderingColumnNo = HCorderingColumnNo
#orderingColumnNo = cellIDorderingColumnNo

patternLabels = [fpMatrix[patternLabelsRowNo][j+nSkipColumns] for j in range(nPatterns)]

fpMatrixUnsorted = fpMatrix[1:]
fpMatrixUnsorted.sort(key=lambda row: row[orderingColumnNo:])
fpMatrixSorted = fpMatrixUnsorted

for i in range(nCells):
    cellLabelsSorted[i] = fpMatrixSorted[i][labelColumnNo]
    
    nPatternOccurrencesSorted[i] = [int(fpMatrixSorted[i][j+nSkipColumns]) for j in range(nPatterns)]

plot_patterns(cellLabelsSorted, patternLabels, nPatternOccurrencesSorted)

print "Finis.\n"
