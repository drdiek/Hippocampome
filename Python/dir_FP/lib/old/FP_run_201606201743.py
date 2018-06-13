import numpy as np

from file_functions import load_csv

from diek_functions import size2x2
from diek_functions import pause

print

fileName = 'FP_matrix.csv'
fileName = 'test.csv'

fpMatrix = load_csv(fileName)
	
nAllRows, nAllColumns = size2x2(fpMatrix)

nSkipRows = 1
nSkipColumns = 6
ABCorderingColumnNo = 0
HCorderingColumnNo = 1
cellIDorderingColumnNo = 3
labelColumnNo = 5
patternLabelsRowNo = 0

#orderingColumnNo = ABCorderingColumnNo
orderingColumnNo = HCorderingColumnNo

nCells = nAllRows - nSkipRows # account for header row   
nPatterns = nAllColumns - nSkipColumns # account for header columns

cellLabelsUnsorted = [''] * nCells
cellLabelsSorted = [''] * nCells
ordering = [''] * nCells
patternLabels = []
#patternLabels = [''] * nPatterns
nPatternOccurrencesUnsorted = np.empty((nCells, nPatterns))
nPatternsOccurrencesSorted = np.empty((nCells, nPatterns))

#ordering[2] = '23'
#print ordering
#print
#pause()

for i in range(nCells):
    cellLabelsUnsorted.append(fpMatrix[i+nSkipRows][labelColumnNo])
#    ordering.append(fpMatrix[i+nSkipRows][orderingColumnNo])
    ordering[i] = fpMatrix[i+nSkipRows][orderingColumnNo]
    print ordering
    print
    pause()
    
    for j in range(nPatterns):
        nPatternOccurrencesUnsorted[i][j] = fpMatrix[i+nSkipRows][j+nSkipColumns]

index = np.argsort(ordering)

for i in range(nCells):
    cellLabelsSorted.append(cellLabelsUnsorted[index[i]])

    for j in range(nPatterns):
        nPatternsOccurrencesSorted[i][j] = nPatternOccurrencesUnsorted[index[i]][j]

for j in range(nPatterns):
    patternLabels.append(fpMatrix[patternLabelsRowNo][j+nSkipColumns])
