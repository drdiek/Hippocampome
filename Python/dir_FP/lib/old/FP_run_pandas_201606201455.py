import numpy as np

from file_functions import read_from_csv

from diek_functions import size2x2
from diek_functions import pause

print

fileName = 'FP_matrix.csv'
fileName = 'test.csv'

fpMatrix = read_from_csv(fileName)

nFpRows, nFpColumns = size2x2(fpMatrix)

nSkipRows = 1

nSkipColumns = 6

ABCorderingColumnNo = 0

HCorderingColumnNo = 1

cellIDorderingColumnNo = 3

labelColumnNo = 5

patternLabelsRowNo = 0


#orderingColumnNo = ABCorderingColumnNo

orderingColumnNo = HCorderingColumnNo


nAllCells = nFpRows - nSkipRows # account for header row        
nPatterns = nFpColumns - nSkipColumns # account for header columns


cellLabelsUnsorted = fpMatrix[nSkipRows:, labelColumnNo]

nPatternOccurrencesUnsorted = fpMatrix[nSkipRows:, nSkipColumns:]


ordering = fpMatrix[nSkipRows:, orderingColumnNo]

indexArray = np.argsort(ordering)


nPatternsOccurrencesSorted = nPatternOccurrencesUnsorted[indexArray, :]

cellLabelsSorted = cellLabelsUnsorted[indexArray]


patternLabels = fpMatrix[patternLabelsRowNo, nSkipColumns:]
