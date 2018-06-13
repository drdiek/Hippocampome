import numpy as np

from file_functions import read_from_csv

from diek_functions import size2x2
from diek_functions import pause

print

fileName = 'FP_matrix.csv'
fileName = 'test.csv'

fpDataFrame = read_from_csv(fileName)

nFpRows, nFpColumns = size2x2(fpDataFrame.values)
print 'nFpRows ', nFpRows
print

nSkipRows = 1

nSkipColumns = 6

ABCorderingColumnNo = 0

HCorderingColumnNo = 1

cellIDorderingColumnNo = 3

labelColumnNo = 5

patternLabelsRowNo = 0


#orderingColumn = 'ABC ordering'
#orderingColumnNo = ABCorderingColumnNo

orderingColumn = 'HC ordering'
#orderingColumnNo = HCorderingColumnNo


nAllCells = nFpRows - nSkipRows # account for header row        
nPatterns = nFpColumns - nSkipColumns # account for header columns

print fpDataFrame.ix[:,['Name']]
print
cellLabelsUnsorted = fpDataFrame[['Name']]
print cellLabelsUnsorted
print
cellLabelsUnsorted = fpDataFrame[nSkipRows:, labelColumnNo]
print cellLabelsUnsorted
print 
pause()

nPatternOccurrencesUnsorted = fpDataFrame[nSkipRows:, nSkipColumns:]


ordering = fpDataFrame[nSkipRows:, orderingColumnNo]

indexArray = np.argsort(ordering)


nPatternsOccurrencesSorted = nPatternOccurrencesUnsorted[indexArray, :]

cellLabelsSorted = cellLabelsUnsorted[indexArray]


patternLabels = fpDataFrame[patternLabelsRowNo, nSkipColumns:]
